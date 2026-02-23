function git-rebase-main --description "Fetch origin and rebase current branch onto origin/main"
    # Stash any uncommitted changes so the rebase can proceed cleanly
    set stashed 0
    if not git diff --quiet || not git diff --cached --quiet
        echo "Stashing uncommitted changes..."
        git stash push -m "git-rebase-main auto-stash"
        and set stashed 1
    end

    # Fetch latest from remote and rebase
    echo "Fetching origin..."
    git fetch origin
    or begin
        echo "fetch failed — aborting"
        test $stashed -eq 1; and git stash pop
        return 1
    end

    echo "Rebasing onto origin/main..."
    git rebase origin/main
    or begin
        echo "Rebase failed — resolve conflicts, then run: git rebase --continue"
        echo "To abort the rebase: git rebase --abort"
        return 1
    end

    # Pop the stash if we created one
    if test $stashed -eq 1
        echo "Restoring stashed changes..."
        git stash pop
    end

    echo "Done."
end
