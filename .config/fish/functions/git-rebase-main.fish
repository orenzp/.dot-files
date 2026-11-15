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

    # Show how the branch now compares to its upstream and flag any divergence.
    # A rebase rewrites your commits, so the branch often diverges from its
    # remote tracking branch even though the work is the same.
    set upstream (git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
    if test -n "$upstream"
        set counts (git rev-list --left-right --count "HEAD...$upstream" 2>/dev/null | string split \t)
        set ahead $counts[1]
        set behind $counts[2]

        echo
        git status -sb | head -n 1

        if test -n "$ahead" -a -n "$behind" -a "$ahead" -gt 0 -a "$behind" -gt 0
            echo
            echo "Your branch has diverged from $upstream (ahead $ahead, behind $behind)."
            echo "This is expected after a rebase — it rewrote your commits."
            read -l -P "Push with 'git push --force-with-lease'? [y/N] " answer
            if test "$answer" = y -o "$answer" = Y
                git push --force-with-lease
            else
                echo "Skipped. When ready, run: git push --force-with-lease"
            end
        end
    end
end
