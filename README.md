# dotfiles

My personal environment settings and machine setup.

## Prerequisites

* Xcode or Xcode CLT
* SSH key installed and registered on GitHub

## Installation

```
bash < <(curl -fsSL https://raw.githubusercontent.com/timblair/dotfiles/master/install.sh)
```

## Details

* Makes sure [Xcode CLT][clt] is installed.
* Installs [Homebrew][brew].
* Sets up my [Vim configuration][vim].
* Installs [Oh My Zsh][omz] and changes user shell to zsh.
* Sets up dotfiles, managed by [rcm][rcm].
* Installs apps defined in [Brewfile](Brewfile) via [Homebrew Bundle][bundle].
* Installs the latest version of Ruby and sets it as the global default.
    * Installs an [rbenv plugin][brew-ssl] on El Capitan to get around the lack
      of a linkable version of OpenSSL for Ruby to build against.

[clt]: https://developer.apple.com/library/ios/technotes/tn2339/_index.html
[brew]: http://brew.sh
[vim]: https://github.com/timblair/vimfiles
[omz]: http://ohmyz.sh/
[rcm]: https://github.com/thoughtbot/rcm
[bundle]: https://github.com/Homebrew/homebrew-bundle
[brew-ssl]: https://github.com/timblair/rbenv-homebrew-openssl
