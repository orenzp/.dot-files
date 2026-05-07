function kubectl_status
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color white)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color white)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'

  set -l short_ctx (string replace -r -- '-cluster-admin$' '' $ctx | string sub -l 20)

  echo (set_color red)"($short_ctx$KUBECTL_PROMPT_SEPARATOR$ns)"
end

function az_status
  if not type -q az
    return
  end

  set -l sub (az account show --query name -o tsv 2>/dev/null)
  if [ $status -ne 0 ]; or [ -z "$sub" ]
    echo (set_color red)"logged out"
    return
  end

  set -l short_sub (string sub -l 20 -- $sub)

  echo (set_color --bold 50E6FF)"($short_sub)"
end

function fish_right_prompt
  echo (kubectl_status) (az_status)
end
