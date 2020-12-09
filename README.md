## Inspired from:

- Original: https://github.com/holman/dotfiles
- Others:
    + http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/
    + https://github.com/ryanb/dotfiles
    + https://github.com/mathiasbynens/dotfiles
- Tutorials:
    + http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/


## Setups:

1. Setup [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
2. Clone this repo `my-dot-files` --> cd to `00-scripts` folder --> run script `/bootstrap.sh`. `/bootstrap.sh` will create sympolic link between `*.symlink` files in this repo to your homefolder `~/*`
3. ... I am sure there are still a lot of steps to make this shit done.

## Clean all history commits

Because I may commit some credential keys accidentally and this is my personal repo, not intend to be collaborated in this repo and for safety reason, I usually run `00-scripts/remove_all_git_history.sh` to clean all history of this repo.

## Contributing

This is a personal repo to store my stuff. I am not going to collaborate on this repo. Please fork this repo and make your own changes.

## Features

- You should have a secret folder, e.g. `03_secret` or `secret`. So that you can store some sensitive scripts (such as installing private NPM registery, token variables...) in that folder.
- Regularly, run this script `git_remove_all_commits.sh` to clean all git history to make sure there is no commit which may contains a secret stuff.
- All scripts inside `./bin` folder can be accessed in global.
- Setup my-dot-files to create file links in user home folder (is always ~/) for all `*.symlink` in my-dot-files. `00-scripts/bootstrap.sh`
- Install all apps from fresh computer: `00-scripts/install_apps.sh`
- Updates all apps in computer `00-scripts/update_apps.sh`
- Almost global paths concentrate into a unique place: `system/path.zsh`
- `ohmy.zsh` is settings for your `oh-my-zsh`. Where you can update themes and plugins of `oh-my-zsh`

### Global vars

- `$ZSH`: file path of `oh-my-zsh` in local computer.
- `$ZSH_DF`: file path of my-dot-files in local computer.
- `$EDITOR`: "$ZSH_DF/bin/subl"
- `$VISUAL`: "$ZSH_DF/bin/subl"
- `$GIT_GUI`: file path of source tree app.
- `02_global` is a folder containing global vars or functions which are loaded before others.

## Notes

- In the past, I used to place many large settings/binaries, example settings of Atom and Sublime, in this repo. Now I think it is not a good way to store in git. You should use other file cloud services to do that like Dropbox.
