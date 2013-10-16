# Shop completion

To add autocompletion to Shop, copy the file `shop-completion.bash` to `~/.shop-completion.bash` then add the path to your `.bash_profile` by adding this:

    if [ -f ~/.shop-completion.bash ]; then
      . ~/.shop-completion.bash
    fi
