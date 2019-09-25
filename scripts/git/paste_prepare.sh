for hook in */.git/hooks/
    do cp prepare-commit-msg $hook
done
