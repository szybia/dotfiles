file_name=prepare-commit-msg
for hook in */.git/hooks/
    do ln -sf "$(pwd)/${file_name}" "$(pwd)/${hook}${file_name}"
done
