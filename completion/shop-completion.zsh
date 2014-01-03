_shop_complete() {
  local word completions
  word="$1"
  completions="$(shop cmplt "${word}")"
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _shop_complete shop
