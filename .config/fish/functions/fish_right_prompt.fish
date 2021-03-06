function kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'


  if test -e (which az)
    set AZ (az account show --query name -o tsv 2>/dev/null)
    [ -z $AZ ]; and set AZ 'AZ Logout'
  else
    set AZ 'AZ Missing'
  end
  echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color red)"($ctx$KUBECTL_PROMPT_SEPARATOR$ns)"  (set_color green)"($AZ)"
end

function fish_right_prompt
  echo (kubectl_status)
end
