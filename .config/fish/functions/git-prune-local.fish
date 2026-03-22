function git-prune-local --description "Remove local branches whose remote tracking branch has been deleted"
    git fetch --prune

    set branches (git branch -vv | grep ': gone]' | awk '{print $1}')

    if test (count $branches) -eq 0
        echo "No stale branches to remove."
        return 0
    end

    echo "Branches to delete:"
    for branch in $branches
        echo "  $branch"
    end

    read --prompt-str "Delete these branches? [y/N] " confirm
    if test "$confirm" = y -o "$confirm" = Y
        for branch in $branches
            git branch -d $branch
            or git branch -D $branch
        end
    else
        echo "Aborted."
    end
end
