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
    set -l git_branch $yellow(_git_branch_name)
    if [ (_is_git_dirty) ]
      set git_info ":($git_branch$red!$blue)"
    else
      set git_info ":($git_branch$blue)"
    end
  end

  set -l ruby_version (rbenv version-name)

  echo -s "$xxx $ruby_version $cwd$git_info $normal"
end

function fish_right_prompt
  set -l last_status $status
  if [ $last_status -ne 0 ]
    echo -s (set_color red) "#" $last_status (set_color normal)
  end
end
