_shop_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions="$(shop cmplt "$word")"
  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -F _shop_complete shop
