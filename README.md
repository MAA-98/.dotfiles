# Set up from factory

## Clone .dotfiles

```bash
xcode-select --install
cd ~
git clone https://github.com/MAA-98/.dotfiles
```

## Run debloat0.sh script

```bash
cd .dotfiles/scripts
chmod +x debloat0.sh
./debloat0.sh
```

## Run setup0.sh script

```bash
chmod +x setup0.sh
./setup0.sh
```

## Suggested Next Steps

### System Settings

Rebind Caps Lock to Escape:
*System Settings>Keyboard>Keyboard Shortcuts…>Modifier Keys>Caps Lock Key>Escape*

For apps (e.g. Alacritty) to open new windows with cmd+n, not new tabs:
*System Settings>Desktop & Dock>Windows - Prefer tabs when opening documents>Never*

Download SF Mono for use in terminal at [Apple](https://developer.apple.com/fonts/).

### Apps

Download Homebrew from [official repo](https://brew.sh):
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Download Alacritty, Neovim, GitHub's `gh` CLIs:
```shell
brew install alacritty
brew install neovim
brew install gh
```
Set up SSH keys and PATs and save to ~/.my_secrets.

