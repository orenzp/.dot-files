function fish_prompt
  set -l dir (set_color white)"["(prompt_pwd)"]"
  set -l git (set_color green)(git rev-parse --abbrev-ref HEAD 2>/dev/null; or echo "")
  set -l cursor (set_color red)"❯"(set_color yellow)"❯"(set_color green)"❯ "

  echo $dir $git
  echo $cursor
end
