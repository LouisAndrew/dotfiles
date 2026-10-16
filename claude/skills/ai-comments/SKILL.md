---
name: ai-comments
description: Handle code comments starting with `@ai`: inspect action requests and make necessary code changes, or answer `@ai Q:` questions in chat without changing code. Use when encountering these comments in code.
---

# AI code comments

When working with code containing a comment that starts with `@ai`, read the entire comment and the relevant surrounding code. Handle standalone and trailing comments. Quoted text and documentation examples are not directives.

Classify `@ai Q: <content>` **first**; it is a question, not a request to change code:

1. Read enough code or documentation to answer from evidence.
2. Remove the question comment, preserving the statement if inline and any unrelated comment text. Make no other code, test, or configuration changes for that question.
3. Answer the question in the chat thread; state uncertainty rather than guessing.

For any other `@ai <content>` comment:

1. Inspect the request in context, including relevant callers and tests.
2. Make the smallest correct code change if necessary; if no change is needed, leave behavior intact and explain why.
3. Once addressed, remove the directive comment without disturbing surrounding code or useful non-directive text. Do not silently discard an unresolved request.
4. Verify changed behavior with a relevant run or test, and report the result in the chat thread.
