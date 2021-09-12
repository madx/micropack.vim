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

  call system('mkdir -p ' . s:packdir)

  for plugin in s:plugins
    let basename = fnamemodify(plugin, ':t')
    let clonedir = join([s:packdir, basename], '/')

    if empty(glob(clonedir))
      echom 'micropack: Installing' plugin
      echom ''
      call system(join([
       \ 'git clone --quiet',
       \ plugin,
       \ clonedir,
       \], ' '))
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
  let installed = split(globpath(s:packdir, '*'), '\n')
  let pluginBasenames = mapnew(s:plugins, "fnamemodify(v:val, ':t')")

  let updated = 0
  for plugin in installed
    let basename = fnamemodify(plugin, ':t')
    if index(pluginBasenames, basename) < 0
      call system('rm -rf ' . plugin)
      echon 'micropack: '
      \ | echohl WarningMsg
      \ | echon basename . ' removed'
      \ | echohl None
      \ | echom ''
      continue
    endif

    execute 'cd' plugin
    call system('git remote update')
    let local = system('git rev-parse @')
    let remote = system('git rev-parse @{u}')
    if local != remote
      call system('git pull')
      echon 'micropack: '
      \ | echohl Todo
      \ | echon basename . ' updated ('. local[0:8] . '..' . remote[0:8] .')'
      \ | echohl None
    else
      echon 'micropack: '
      \ | echohl Comment
      \ | echon basename . ' already up to date'
      \ | echohl None
    endif
    echom ''
    cd -
  endfor
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
