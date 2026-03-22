function pull-kv-secret
    set subscription $argv[1]
    set keyvault $argv[2]
    set secret $argv[3]

    if test -z "$subscription"
        set subscription (az account list --query '[].name' -o tsv 2>/dev/null | fzf --prompt "subscription> " --height 40%)
        test -z "$subscription"; and return 1
    end

    if test -z "$keyvault"
        set keyvault (az keyvault list --subscription $subscription --query '[].name' -o tsv 2>/dev/null | fzf --prompt "keyvault> " --height 40%)
        test -z "$keyvault"; and return 1
    end

    if test -z "$secret"
        set secret (az keyvault secret list --subscription $subscription --vault-name $keyvault --query '[].name' -o tsv 2>/dev/null | fzf --prompt "secret> " --height 40%)
        test -z "$secret"; and return 1
    end

    set output (az keyvault secret show \
        --subscription $subscription \
        --vault-name $keyvault \
        --name $secret \
        --query value \
        --output tsv 2>&1)

    if test $status -ne 0
        echo "Error: secret '$secret' was not found in keyvault '$keyvault' (subscription: '$subscription')" >&2
        return 1
    end

    echo $output
end
