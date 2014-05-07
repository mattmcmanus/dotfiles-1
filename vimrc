" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
filetype plugin indent on

" Mouse
set mouse=a

" Automatically reload files
set autoread

" Lazily redraw screen
set lazyredraw

" Set swap location
set directory=/tmp

" Colors
autocmd ColorScheme * highlight Visual ctermbg=236
colorscheme railscasts
syntax on

" Sign and number columns
highlight SignColumn ctermbg=0
highlight NonText ctermbg=0 ctermfg=0
highlight Vertsplit ctermbg=233 ctermfg=233

" Tabs
highlight! link TabLineFill CursorColumn
highlight TabLine ctermfg=7 ctermbg=234 cterm=none
highlight TabLineSel ctermfg=166 ctermbg=234
map <Tab> :tabn<cr>
map <S-Tab> :tabp<cr>

" Line numbers
set number
set numberwidth=1

" Don't wrap text
set nowrap

" Backspace over anything
set backspace=eol,indent,start

" Soft tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4

" Fancy characters
set listchars=tab:‣\ ,trail:·,extends:⇢,precedes:⇠
set list

" Highlight trailing whitespace
highlight! link ExtraWhitespace Todo
autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufWinLeave * call clearmatches()

" Filetype mappings
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd BufNewFile,BufRead *.skim set filetype=slim
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown

" Filetype-specific settings
autocmd FileType gitcommit,markdown set spell
autocmd FileType markdown set wrap
autocmd FileType "" set wrap

" 80-column line
set colorcolumn=81
highlight! link ColorColumn CursorColumn

" Smart search
set incsearch
set ignorecase
set smartcase

" Smarter tab-completion
set wildmode=list:list,full

" Smarter split opening
set splitbelow
set splitright

" Scroll before the cursor reaches the edge
set scrolloff=5

" Show leader keystrokes in the bottom right
set showcmd

" Extra leader mappings
nmap , \

" Always show filename
set laststatus=2

" NERDCommenter
let NERDRemoveExtraSpaces=1
let NERDSpaceDelims=1

map <leader>/ <plug>NERDCommenterToggle<CR>

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" seeing-is-beleiving
map <F4> <Plug>(seeing-is-believing-mark)
imap <F4> <Plug>(seeing-is-believing-mark)
map <F5> <Plug>(seeing-is-believing-run)
imap <F5> <Plug>(seeing-is-believing-run)

" alias common mistyped commands to correct command
cabbrev E e
cabbrev Q q
cabbrev W w
cabbrev Wq wq

" The Silver Searcher
let g:ag_binary = system("which ag | xargs echo -n")
if filereadable(g:ag_binary)
  let g:ackprg = g:ag_binary . ' --nocolor --nogroup --column'
  let g:ctrlp_user_command = g:ag_binary . ' %s -l --nocolor -g ""'
endif

" vim-airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_a='' " mode
let g:airline_section_b='' " branch
let g:airline_section_z='' " ruler
let g:airline_theme='monochrome'

" Sort
vnoremap <Leader>s :sort<cr>

" Macro repeat
nnoremap <Space> @q

" Insert debuggers
nnoremap <Leader>d Orequire 'debugger'; debugger<Esc>
nnoremap <Leader>p Orequire 'pry'; binding.pry<Esc>

" Focus RSpec block
nnoremap <Leader>f $? do$<Return>hi, :focus<Esc>

" Frequently used operations
command! ConvertCamelCaseToUnderScore :%s/\<\u\|\l\u/\=len(submatch(0)) == 1 ? tolower(submatch(0)) : submatch(0)[0].'_'.tolower(submatch(0)[1])/gc
command! ConvertRubyHashSyntax19 :%s/:\([^ ]*\)\(\s*\)=>/\1:/g
command! DeleteComments :g/^\s*#\|\/\//d
command! RemoveTrailingWhitespace :%s/ \+$//g

" CtrlP
let g:ctrlp_max_height = 100
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = ''

" Automatically adjust quickfix height
autocmd FileType qf execute line("$") . "wincmd _"

" Close quickfix with Esc
autocmd FileType qf nnoremap <buffer> <Esc> :cclose<cr>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
