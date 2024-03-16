# check if the $POST_SSH_HOOK variable is set and equal to "acorn-talk"
if [ -z "$POST_SSH_HOOK" ] || [ "$POST_SSH_HOOK" = "acorn-talk" ]; then
    echo "Running post ssh hook ($POST_SSH_HOOK)..."
    source ~/src/acorn/talk/scripts/post-ssh-hook.sh
fi
