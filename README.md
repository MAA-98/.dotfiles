# Set up 

## 0. From factory settings:

Install basic developer tools:
```bash
xcode-select --install
```

## 1. Clone .dotfiles

```bash
cd ~
git clone https://github.com/MAA-98/.dotfiles
```

## 2. Run debloat_mac.sh script

```bash
cd ~/.dotfiles/scripts
chmod +x debloat_mac.sh
./debloat_mac.sh
```

## 3. Install brew and dependencies

```bash
cd .dotfiles/scripts
chmod +x install_deps.sh
./install_deps.sh
```

## Run setup.sh script

```bash
chmod +x setup.sh
./setup.sh
```

## Suggested Next Steps

### System Settings

Rebind Caps Lock to Escape:
*System Settings>Keyboard>Keyboard Shortcuts…>Modifier Keys>Caps Lock Key>Escape*

Show pathnames in Finder:
*FinderMenu>View>Show Path Bar & Show Menu Bar*

For apps (e.g. Alacritty) to open new windows with cmd+n, not new tabs:
*System Settings>Desktop & Dock>Windows - Prefer tabs when opening documents>Never*

Download SF Mono for use in terminal at [Apple](https://developer.apple.com/fonts/).

### Apps

Download GitHub's `gh` CLIs:
```shell
brew install gh
```
Set up SSH keys and PATs and save to ~/.my_secrets.

