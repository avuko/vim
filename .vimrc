" vi: set sw=4 ts=4 ai:
"
" Personal preference .vimrc file
" Maintained by avuko
" Original by Ton Kersten
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible				" vim like real VI. You're nuts!!

" General settings, for all files
syntax on
set number							" I like these old-fashioned line numbers
set bs=2							" allow backspacing over everything
set noai nocin nosi inde=			" always set autoindenting off
set nobackup						" do not keep a backup file
set noswapfile						" do not write annoying swapfiles
" set viminfo=						" no viminfo stuff
set noerrorbells					" stop whining about everything
set modeline						" allow the last line to be a mode line
set modelines=10					" number of mode lines
set showmode						" show the current mode !!YES!!
set autoindent						" always set autoindenting on
set showcmd							" display incomplete commands
set backspace=indent,eol,start		" define how the backspace reacts
set shiftround						" use multiple of shiftwidth when indenting
set copyindent						" copy indentation on autoindenting
set scrolloff=4						" keep 4 lines off the edges of the screen
set nolist							" do not show the list chars
set listchars=tab:»·,trail:· 		" but define how they should appear
"set paste							" start in 'paste' mode
set noexpandtab						" keep tabs as they are
set encoding=utf-8					" use utf-8 as default encoding
"set cursorcolumn					" show where the cursor is
"set virtualedit=all				\" allow the cursor to go in to \"invalid\" places
set autochdir						" change automatically to the directoy of the current file
set fileformats="unix,dos,mac"		" which types are supported
set ignorecase						" ignore case when searching
set smartcase						" ignore case if search pattern is all lowercase,
set smarttab						" insert tabs on the start of a line according to sw
set nohlsearch						" highlight search terms
set incsearch						" show search matches as you type
set nofoldenable					" I do not like that folding stuff
set formatoptions+=1				" when wrapping paragraphs, don't end lines
"    with 1-letter words (looks stupid)

if v:version >= 700
	set numberwidth=4
endif
set mouse=v
behave xterm
set selectmode=mouse

" Load Pathogen
execute pathogen#infect('bundle/{}')
call pathogen#helptags()
let snips_author="avuko"
let snips_email="no-reply@avuko.net"
let snips_github="http://github.com/avuko"
let snips_organisation="avuko.net"

" Plugins
map <silent> <C-n> :NERDTreeFocus<CR>
" nnoremap <F5> :NERDTree<CR>

" Highlighting whitespaces at end of line
autocmd Filetype * highlight WhitespaceEOL ctermbg=lightgrey guibg=lightgrey
autocmd Filetype * match WhitespaceEOL /\s\+$/

" The status line
set laststatus=2
set statusline=
set statusline+=%f\ 							" filename (basename)
set statusline+=%h%m%r%w						" status flags
set statusline+=\[%{strlen(&ft)+2?&ft:'none'}]	" file type
if v:version >= 700
	set statusline+=\ Spell:%-10{strpart('OffOn',&spell*3,3).'\ ('.&spelllang.')'}	" Spell
	 let g:airline_section_y = 'Spell:%-10{strpart("OffOn",&spell*3,3)."\ (".&spelllang.")"}'
endif
set statusline+=%=								" right align remainder
set statusline+=Char:0x%-5B						" character value
set statusline+=Pos:%-8(%l,%c%)					" line, character
set statusline+=%<%P							" file position

" Spell checking
if v:version >= 700
	setlocal spell spelllang=en_gb
	set nospell
	set spellfile=~/.vim/spell/spellfile.add
	autocmd Filetype tex set spell
	autocmd Filetype plaintex set spell
	map <silent> <F2> :set spelllang=nl<CR>
	map <silent> <F3> :set spelllang=en<CR>
	map <silent> <F4> :set spell!<CR>
endif

" Don't use Ex mode, use Q for formatting
map Q gq
map q gq}

" For CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.tgz,*.gz

" Only do this part when compiled with support for autocommands
filetype plugin indent on
if has("autocmd")
	" For all text files do not set 'textwidth' (prevents autowrapping)
	au FileType text setlocal tw=0

	" When editing a file, always jump to the last known cursor position.
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\	exe "normal g`\"" |
				\ endif
endif " has("autocmd")

" If we do have a GUI
" colors etc.
set t_Co=256
set background=dark
let g:airline_theme='zenburn'
colorscheme zenburn
if has("gui_running")
	let base16colorspace=256
	colorscheme zenburn

	set guifont=Source\ Code\ Pro\ for\ Powerline\ 10

	set ch=2		" Make command line two lines high
	set mouse=c
	set mousehide	" Hide the mouse when typing text

	" Make shift-insert work like in Xterm
	map  <S-Insert> <MiddleMouse>
	map! <S-Insert> <MiddleMouse>
	nmap <C-V> "+gP
	imap <C-V> <ESC><C-V>i
	vmap <C-C> "+y

	" I like highlighting strings inside C comments
	let c_comment_strings=1

	" Switch on syntax highlighting if it wasn't on yet.
	if !exists("syntax_on")
		syntax on
	endif

	"set vb
	set mouse=c
	set gcr=a:blinkwait0,a:block-cursor
	set background=dark

	set guioptions+=m
	set guioptions-=T
	set guioptions-=r
	set guioptions-=R
endif

" Special settings for LaTeX files
augroup tex
	autocmd!

	autocmd BufEnter *.tex set nopaste
	autocmd BufEnter *.tex set sr
	autocmd BufEnter *.tex set textwidth=68
	autocmd BufEnter *.tex set wrapmargin=0
	autocmd BufEnter *.tex set list
	"autocmd BufEnter *.tex set formatoptions=croqtam
augroup END

" Special settings for Markdown
augroup md
	autocmd!

	autocmd BufEnter *.md,*.mkd,*.pdc match ErrorMsg /\%>72v.\+/
	autocmd BufEnter *.md,*.mkd,*.pdc set filetype=markdown
	autocmd BufEnter *.md,*.mkd,*.pdc set nopaste
"	autocmd BufEnter *.md,*.mkd,*.pdc set digraph "creates weird glyphs
	autocmd BufEnter *.md,*.mkd,*.pdc set nohlsearch
	autocmd BufEnter *.md,*.mkd,*.pdc set textwidth=72
	autocmd BufEnter *.md,*.mkd,*.pdc set wrapmargin=0
	autocmd BufEnter *.md,*.mkd,*.pdc set ts=4
	autocmd BufEnter *.md,*.mkd,*.pdc set sw=4
	autocmd BufEnter *.md,*.mkd,*.pdc set nowrap
	autocmd BufEnter *.md,*.mkd,*.pdc set list
	autocmd BufEnter *.md,*.mkd,*.pdc set spell
	autocmd BufEnter *.md,*.mkd,*.pdc set spelllang=en
	autocmd BufEnter *.md,*.mkd,*.pdc map q gq}
augroup END

" Nice handy trick for gnupg files
augroup gpg
	autocmd!
	autocmd BufReadPre,FileReadPre *.gpg set viminfo=
	autocmd BufReadPre,FileReadPre *.gpg set noswapfile
	autocmd BufReadPost *.gpg :%!gpg -q -d
	autocmd BufReadPost *.gpg | redraw!
	autocmd BufWritePre *.gpg :%!gpg --default-recipient-self -q -e -a
	autocmd BufWritePost *.gpg u
	autocmd VimLeave *.gpg :!clear
augroup END

" Use the Vim Airline. Do use the PowerLine fonts with Airline
 let g:airline_powerline_fonts = 1

" use vim-flake8
"
" run flake8 when you save a file
autocmd BufWritePost *.py call Flake8()
" show in gutter
let g:flake8_show_in_gutter=1  " show
" Hopefully disable some flake noise with regards to pep8 checking
" set in .config/flake8, see:
" http://flake8.readthedocs.io/en/latest/warnings.html#error-codes
" and:
" http://flake8.readthedocs.io/en/latest/config.html
" nice. but close when you are the last please
function NoShow()
	let g:flake8_show_quickfix=0
	wq
endfunction
autocmd FileType python cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? 'call NoShow()' : 'wq'
autocmd FileType python cnoreabbrev <expr> q winnr("$") > 1 && getcmdtype() == ":" && getcmdline() == 'q' ? 'ccl <BAR> q' : 'q'
autocmd FileType python cnoreabbrev <expr> x winnr("$") > 1 && getcmdtype() == ":" && getcmdline() == 'x' ? 'ccl <BAR> x' : 'x'

" Some things handy for syntax highlighting
let myfiletypefile = "~/.vim/filetype.vim"
let mysyntaxfile = "~/.vim/syntax.vim"
syntax on
hi MatchParen cterm=none ctermbg=none ctermfg=blue
autocmd Syntax * syntax sync fromstart
