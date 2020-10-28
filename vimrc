set encoding=utf-8
" Leader
nnoremap <SPACE> <Nop>

let mapleader=" "
let g:tmux_navigator_no_mappings = 1

" Softtabs, 2 spaces
set tabstop=2
set scrolloff=10
set shiftwidth=2
set shiftround
set expandtab

" Numbers
set number
set numberwidth=5

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set nocompatible " We're running Vim, not Vi!

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

"   " When editing a file, always jump to the last known cursor position.
"   " Don't do it for commit messages, when the position is invalid, or when
"   " inside an event handler (happens when dropping a file on gvim).
"   autocmd BufReadPost *
"     \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal g`\"" |
"     \ endif
"
"   " Set syntax highlighting for specific file types
"   autocmd BufRead,BufNewFile *.md set filetype=markdown
"   autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
"   autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
"   autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
"   autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
"   autocmd BufRead,BufNewFile vimrc.local set filetype=vim
" augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
" let g:is_posix = 1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --hidden --no-ignore -l "" -g "!{log,.git,.terragrunt-cache}/" -g "!tmp/cache" -g "!*.{jpg,png,svg,cache,min.css,min.js,min.scss}"'
elseif executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" Find:
nmap <Leader>f :Rg<SPACE>

command! -bang -nargs=* RGrails
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.{rb,erb,js,es6,css,sass,scss,yml,rake,haml}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGmodel
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/models/*.rb" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGcontroller
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/controllers/*.rb" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/views/*.{html,erb}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGruby
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.rb" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGstyle
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.{css,sass,scss}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGjs
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.{js,es6}" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RGblueprint
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/blueprints/*_blueprint.rb" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap fa :RGrails <C-R><C-W><CR>
nmap fm :RGmodel <C-R><C-W><CR>
nmap fv :RGview <C-R><C-W><CR>
nmap fc :RGcontroller <C-R><C-W><CR>
nmap fs :RGstyle <C-R><C-W><CR>
nmap fj :RGjs <C-R><C-W><CR>
nmap fr :RGruby <C-R><C-W><CR>
nmap fb :RGblueprint <C-R><C-W><CR>
nmap <Leader>fa :RGrails<SPACE>
nmap <Leader>fm :RGmodel<SPACE>
nmap <Leader>fv :RGview<SPACE>
nmap <Leader>fc :RGcontroller<SPACE>
nmap <Leader>fs :RGstyle<SPACE>
nmap <Leader>fj :RGjs<SPACE>
nmap <Leader>fr :RGruby<SPACE>
nmap <Leader>fb :RGblueprint<SPACE>

" Switch between the last two files
nnoremap '' <C-^>
map <Leader>n <C-w>v<C-h>''

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-'> :TmuxNavigatePrevious<cr>
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Set tags for vim-fugitive
set tags^=.git/tags

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
if &diff
  set diffopt-=internal
  set diffopt+=vertical
endif

colorscheme codedark
"Open config file
nmap <Leader>vc :tabedit ~/.vimrc<CR>
nmap <Leader>vb :tabedit ~/.vimrc.bundles<CR>
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>ntf :NERDTreeFind<CR>
"Remove search highlights
nmap <Leader>uh :noh<CR>

" Save and update
nnoremap <Leader>w :update<CR>
nnoremap <Leader>q :q<CR>

"PlugInstall
nmap <Leader>vi :PlugInstall<CR>
nmap <Leader>vs :source ~/.vimrc<CR>

"Remove whitespace after saved
let g:better_whitpace_enabled=1
nmap <Leader>ws :StripWhitespace<CR>

" rails-db-migrate.vim mappings
nmap <Leader>dm :RailsMigrate<CR>
nmap <Leader>dd :RailsMigrateDown<CR>
nmap <Leader>du :RailsMigrateUp<CR>
nmap <Leader>dr :RailsMigrateRedo<CR>
let g:rails_migrate_command = "Dispatch bundle exec rake"

" ZoomFullPanel
nmap Z <C-w>\|
" UnZoom
nmap zz <C-w>=

" Rails
nmap <Leader>c :Vcontroller<SPACE>
nmap <Leader>m :Vmodel<SPACE>
nmap <Leader>vv :Vview<SPACE>
nmap <Leader>vq :Vquery<SPACE>
nmap <Leader>p :Vpolicy<SPACE>
nmap <Leader>d <ESC>obyebug<ESC>

nmap + :vertical resize +20<cr>
nmap _ :vertical resize -20<cr>
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" vim-copypath
"noremap <silent> yp :CopyPath<CR>
"nnoremap <silent> yfn :CopyFileName<CR>


function! DectectViewFromController()
  let l:index = line('.')
  while l:index > 1
    let l:line_string = getline(l:index)
    let l:line_words = split(l:line_string, ' ')
    let l:def_index = index(l:line_words, 'def')
    if (l:def_index >= 0)
      let l:func_name = split(l:line_words[l:def_index + 1], "(")[0]
      let l:command_string = ":Vview " . l:func_name . '.html.haml!'
      execute l:command_string
      return
    endif
    let l:index -= 1
  endwhile
  echo 'No method name detected.'
endfunction
map <Leader>dv :call DectectViewFromController()<CR>

let g:ale_linters = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier', 'typecheck'],
      \ 'c': ['clang', 'gcc'],
      \ 'ruby': ['rubocop'],
      \ 'dockerfile': ['hadolint'],
      \ 'eruby': ['erubi'],
      \ 'json': ['jsonlint'],
      \ 'yaml': ['yamllint'],
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'ruby': ['rubocop'],
      \ 'json': ['jq', 'fixjson'],
      \ '*': ['trim_whitespace']
      \ }
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:move_key_modifier = 'C'

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space()? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

map <S-/> <Plug>(easymotion-sn)
" Free keybindings
map <S-h> <Nop>
map <S-l> <Nop>
map <S-k> <Nop>
" map <S-j> <Nop> " For join line

"Switch between panes
" nnoremap <C-j> <C-W>j
" nnoremap <C-k> <C-W>k
" nnoremap <C-h> <C-W>h
" nnoremap <C-l> <C-W>l
"
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"
" map <Leader>tn :bnext<CR>
" map <Leader>tp :bprevious<CR>
" map <Leader>1 :bfirst<CR>
" map <Leader>0 :blast<CR>
" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
set timeoutlen=500 ttimeoutlen=0
