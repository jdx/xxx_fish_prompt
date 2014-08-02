function fish_prompt
  if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end
  end

  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l normal (set_color normal)

  set -l xxx "$red✗✗✗"
  set -l cwd $cyan(prompt_pwd)

  if [ (_git_branch_name) ]
    set -l git_branch $red(_git_branch_name)
    set git_info "$bluegit$blue:($git_branch$blue)"

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  echo -s $xxx ' ' $cwd $git_info $normal ' ' $red $last_status_output $normal
end

function fish_right_prompt
  set -l last_status $status
  if [ $last_status -ne 0 ]
    echo -s (set_color red) "#" $last_status (set_color normal)
  end
end
