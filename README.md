# micropack.vim

Lightweight Vim package manager based on the native Vim package system.

This README is a WIP with very basic instructions.

## Install

Put the `micropack.vim` file in your `.vim/autoload/` folder.

## Use

At the top of your `.vimrc` add a call to the `micropack#init` function,
passing it the location of your local package and a list of plugins to install:

```vimscript
call micropack#init('~/.vim/pack/madx', [
  \ 'mileszs/ack.vim',
  \ 'kien/ctrlp.vim',
  \ 'editorconfig/editorconfig-vim',
  \ 'tpope/vim-surround',
  \ 'tomtom/tcomment_vim',
  \ 'Raimondi/delimitMate',
  \ 'chriskempson/base16-vim',
\ ])
```
