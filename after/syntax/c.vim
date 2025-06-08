" NAYSAYER THEME
syn match cUserFunctionPointer "\%((\s*\*\s*\)\@6<=\h\w*\ze\s*)\_s\{-}(.*)"
syn match cUserFunction "\<\h\w*\ze\_s*("

highlight cUserFunction        guifg=#44b3ff gui=bold ctermfg=White cterm=bold
highlight cUserFunctionPointer guifg=#44b3ff gui=italic ctermfg=Cyan cterm=italic

" Constants
syntax match cAllCapsWord /\<[A-Z_]\{2,}\>/ 
highlight cAllCapsWord guifg=#c1d1e3

syntax match cParenChar /[()]/
syntax match cBracketChar /[\[\]]/
syntax match cCurlyChar /[{}]/
syntax match cCommaChar /,/
syntax match cSemicolonChar /;/ 
highlight cParenChar guifg=#d1b897
highlight cBracketChar guifg=#d1b897
highlight cCurlyChar guifg=#d1b897
highlight cCommaChar guifg=#d1b897
highlight cSemicolonChar guifg=#d1b897

" Vim groups
highlight Normal         guibg=#062329 guifg=#d1b897 " Main background/foreground
highlight Comment        guifg=#44b340                " comments
highlight cCommentL      guifg=#44b340                " single-line // comments
highlight cCommentStart  guifg=#44b340                " /* start of multiline comments */
highlight Error          guifg=#d1b897                " error text

highlight Type           guifg=#c1d1e3                " types (int, float, etc.)
highlight Structure      guifg=#ffbbbb                " struct, union, enum
highlight StorageClass   guifg=#c1d1e3                " static, register, etc.

highlight Statement      guifg=#c1d1e3                " e.g. return, break, continue
highlight Conditional    guifg=#c1d1e3                " if, else, switch
highlight Label          guifg=#c1d1e3                " case in switches
highlight UserLabel      guifg=#c1d1e3                " user-defined labels (goto targets)

highlight PreProc        guifg=#d1b897                " #pragma, ...
highlight cIncluded      guifg=#c1d1e3                " <stdio.h>
highlight Include        guifg=#d1b897                " #include
highlight PreCondit      guifg=#148310                " #ifdef
highlight cDefine        guifg=#d1b897                " #define

highlight Number         guifg=#7ad0c6                " numbers (decimal, hex, etc.)
highlight Float          guifg=#7ad0c6                " floating point numbers
highlight Octal          guifg=#7ad0c6                " octal numbers
highlight Character      guifg=#7ad0c6                " 'c', 'a', etc.

highlight String         guifg=#2ec90c                " string literals
highlight SpecialChar    guifg=#44b3ff                " special chars like \n
highlight cFormat        guifg=#d1b897 gui=bold       " format specifiers like %d (default links to special char)

" Terminal ANSI groups
highlight NormalFloat guibg=#032026 guifg=#d1b897 " Floating window bg/fg

" Map naysayer colors to terminal ANSI slots.
let g:terminal_ansi_colors = [
      \ '#163339',
      \ '#44b340',
      \ '#2ec90c',
      \ '#d1b897',
      \ '#7ad0c6',
      \ '#ffffff',
      \ '#c1d1e3',
      \ '#d1b897',
      \ '#0b3335',
      \ '#44b340',
      \ '#2ec90c',
      \ '#d1b897',
      \ '#7ad0c6',
      \ '#ffffff',
      \ '#c1d1e3',
      \ '#ffffff'
      \ ]
