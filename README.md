# micropack.vim

Micropack is a tool to ease the installation and upgrade of your Vim/Neovim
plugins. It is built on top of the native package system that is available in
Vim 8/Neovim.

It makes a couple assumptions:

* You use Git to clone and update your plugins 
* Managing your plugins isn't something you'll be doing every day but that you
  want it to require as few interactions as possible.

Here's what you get with Micropack:

* Automatic installation of missing plugins on startup
* A command to pull changes and remove unused plugins
* Configuration with a single function call in your `.vimrc`

## Install

Put the `micropack.vim` file in your `.vim/autoload` folder:

```shell
$ mkdir -p ~/.vim/autoload
$ ln -s $(pwd)/micropack.vim ~/.vim/autoload/micropack.vim
```

## Setup

At the top of your `.vimrc` add a call to the `micropack#init` function,
passing it the location of your local package and a list of plugins to install:

```viml
call micropack#init('~/.vim/pack/madx', [
  \ 'https://github.com/mileszs/ack.vim',
  \ 'https://github.com/kien/ctrlp.vim',
  \ 'https://github.com/editorconfig/editorconfig-vim',
  \ 'https://github.com/tpope/vim-surround',
  \ 'https://github.com/tomtom/tcomment_vim',
  \ 'https://github.com/Raimondi/delimitMate',
  \ 'https://github.com/chriskempson/base16-vim',
\ ])
```

## Updating plugins

To update your plugins run `:MicropackUpdate` from within Vim, it will
automatically pull changes and remove plugins that are no longer defined in
your `micropack#init` call.

If you want to inspect changes, Micropack will output the commit range that you
should look at when using `git log`.
