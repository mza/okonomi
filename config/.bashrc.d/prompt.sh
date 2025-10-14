# Custom bash prompt
# Add your PS1 customization here
# https://bash-prompt-generator.org/

PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\W \[\e[2m\]${PS1_CMD1}\[\e[0m\] > '
PROMPT_COMMAND='echo "";'
