" Dumb af plugin management using native Vim packages
" Only supports git repositories

if exists("g:loaded_micropack")
  finish
endif
let g:loaded_micropack = 1

let s:cpo_save = &cpo
set cpo&vim

function! micropack#init(packdir, plugins)
  let s:packdir = join([a:packdir, 'start'], '/')
  let s:plugins = a:plugins
  let shouldrestart = 0

  silent execute '!mkdir -p ' . s:packdir

  for plugin in s:plugins
    let basename = fnamemodify(plugin, ':t')
    let clonedir = join([s:packdir, basename], '/')

    if empty(glob(clonedir))
      echom 'micropack: Installing' plugin
      echom ''
      silent execute join([
       \ '!git clone --quiet https://github.com/',
       \ plugin,
       \ ' ',
       \ clonedir,
       \], '')
      let shouldrestart = 1
    endif
  endfor

  if shouldrestart
    echom 'micropack: Packages installed, please launch Vim again'
    quit
  endif

  command! -nargs=0 MicropackUpdate call micropack#update()
endfunction

function! micropack#update()
  echom "Not implemented yet"
  " let installed = split(globpath(s:packdir, '*'), '\n')

  " for plugin in installed
  "   echom plugin
  " endfor
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
