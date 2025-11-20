PROMPT_ICON=""
export FZF_DEFAULT_OPTS="--layout reverse --bind 'ctrl-/:toggle-preview,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' --no-bold"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color=fg:#9a9a9a,fg+:#ffffff,bg:$BG_COLOR,bg+:$BG_COLOR
  --color=hl:#678CB1,hl+:#97CCF1,info:#afaf87,marker:#aeaeae
  --color=prompt:#aeaeae,spinner:#af5fff,pointer:#aeaeae,header:#87afaf
  --color=border:$BORDER_COLOR,preview-fg:-1,label:#aeaeae,query:#d9d9d9
  --preview-window=\"border-rounded\" --padding=\"1\" --prompt=\"$PROMPT_ICON \" --marker=\"◆\"
  --pointer=\"\" --separator=\"\" --scrollbar=\"│\""

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export BAT_THEME="minimalfedu"
