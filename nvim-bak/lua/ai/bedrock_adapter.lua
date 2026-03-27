local function parse_bedrock_stream(chunk)
	local decoded_chunks = {}
	for bedrock_data_match in chunk:gmatch("event(%b{})") do
		local ok, json_data = pcall(vim.json.decode, bedrock_data_match)
		if ok and json_data.bytes then
			local decoded_data = vim.base64.decode(json_data.bytes)
			table.insert(decoded_chunks, decoded_data)
		end
	end
	return decoded_chunks
end

return function()
	local anthropic = require("codecompanion.adapters.anthropic")

	---@class Bedrock.Adapter: CodeCompanion.Adapter
	return require("codecompanion.adapters").extend("anthropic", {
		name = "bedrock",
		formatted_name = "Bedrock",
		url = "https://bedrock-runtime.${aws_region}.amazonaws.com/model/${model}/${endpoint}",
		opts = { stream = true },
		env = {
			aws_access_key_id = "AWS_ACCESS_KEY",
			aws_region = "schema.region.default",
			aws_secret_access_key = "AWS_SECRET_KEY",
			aws_session_token = "AWS_SESSION_TOKEN",
			endpoint = function(self)
				if self.opts.stream then
					return "invoke-with-response-stream"
				else
					return "invoke"
				end
			end,
			model = "schema.model.default",
		},
		headers = {
			["x-amz-security-token"] = "${aws_session_token}",
		},
		raw = {
			"--aws-sigv4",
			"aws:amz:${aws_region}:bedrock",
			"--user",
			"${aws_access_key_id}:${aws_secret_access_key}",
		},
		handlers = {
			setup = function(_)
				return true
			end,
			tokens = function(self, data)
				local total_tokens = 0
				if self.opts.stream then
					for _, message in ipairs(parse_bedrock_stream(data)) do
						total_tokens = total_tokens + (anthropic.handlers.tokens(self, message) or 0)
					end
				else
					total_tokens = anthropic.handlers.tokens(self, data)
				end
				return total_tokens
			end,
			chat_output = function(self, data)
				if self.opts.stream then
					local output = { role = nil, reasoning = nil, content = nil }
					for _, message in ipairs(parse_bedrock_stream(data)) do
						local part = anthropic.handlers.chat_output(self, message)
						if part then
							if part.status ~= "success" then
								return {
									status = part.status,
									output = output,
								}
							else
								output.role = output.role or part.output.role
								if output.reasoning or (part.output.reasoning and part.output.reasoning ~= "") then
									output.reasoning = (output.reasoning or "") .. (part.output.reasoning or "")
								end
								if output.content or (part.output.content and part.output.content ~= "") then
									output.content = (output.content or "") .. (part.output.content or "")
								end
							end
						end
					end
					return {
						status = "success",
						output = output,
					}
				else
					return anthropic.handlers.chat_output(self, data)
				end
			end,
		},
		schema = {
			model = {
				mapping = "temp",
				default = "eu.anthropic.claude-3-7-sonnet-20250219-v1:0",
				choices = {
					["eu.anthropic.claude-3-7-sonnet-20250219-v1:0"] = { opts = { can_reason = true } },
					"anthropic.claude-3-5-sonnet-20241022-v2:0",
					"anthropic.claude-3-5-haiku-20241022-v1:0",
				},
			},
			region = {
				type = "string",
				default = "eu-central-1",
				desc = "AWS region",
				choices = {
					"eu-central-1",
				},
			},
			anthropic_version = {
				mapping = "parameters",
				type = "string",
				optional = false,
				default = "bedrock-2023-05-31",
				desc = "Bedrock anthropic API version",
			},
		},
	})
end
