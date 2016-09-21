" Vim File
" AUTHOR:   Agapo (fpmarias@google.com)
" FILE:     /usr/share/vim/vim70/plugin/header.vim
" CREATED:  21:06:35 05/10/2004
" MODIFIED: 2013-05-16 14:22:11
" TITLE:    header.vim
" VERSION:  0.1.3
" SUMMARY:  When a new file is created a header is added on the top too.
"           If the file already exists, the pluging update the field 'date of
"           the last modification'.
" INSTALL:  Easy! Copy the file to vim's plugin directory (global or personal)
"           and run vim.


" FUNCTION:
" Detect filetype looking at its extension.
" VARIABLES:
" comment = Comment symbol associated with the filetype.
" type = Path to interpreter associated with file or a generic title
" when the file is not a script executable.


function s:filetype ()

  let s:file = expand("<afile>:t")
  let l:ft = &ft
"  if match (s:file, "\.sh$") != -1
"    let s:comment = "#"
"    let s:type = s:comment . "!" . system ("whereis -b bash | awk '{print $2}' | tr -d '\n'")
"  elseif match (s:file, "\.py$") != -1
"    let s:comment = "#"
"    let s:type = s:comment . "!" . system ("whereis -b python | awk '{print $2}' | tr -d '\n'")
"  elseif match (s:file, "\.pl$") != -1
"    let s:comment = "#"
"    let s:type = s:comment . "!" . system ("whereis -b perl | awk '{print $2}' | tr -d '\n'")
"  elseif match (s:file, "\.vim$") != -1
"    let s:comment = "\""
"    let s:type = s:comment . " Vim File"
  if l:ft ==# 'sh'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env bash"
  elseif l:ft ==# 'python'
      let s:comment = "#"
      let s:type = s:comment . "-*- coding:utf-8 -*-"
  elseif l:ft ==# 'r'
      let s:comment = "#"
      let s:type = s:comment . "-*- coding:utf-8 -*-"
      let s:type = s:comment . "!/usr/bin/env Rscript"
  elseif l:ft ==# 'perl'
      let s:comment = "#"
      let s:type = s:comment . "!/usr/bin/env perl"
  elseif l:ft ==# 'vim'
      let s:comment = "\""
      let s:type = s:comment . " Vim File"
  elseif l:ft ==# 'c' || l:ft ==# 'cpp'
      let s:comment = "\/\/"
      let s:type = s:comment . " C/C++ File"
  elseif l:ft==# 'rst'
      let s:comment = ".."
      let s:type = s:comment . " reStructuredText "
  elseif l:ft==# 'php'
      let s:comment = "\/\/"
      let s:type = s:comment . " Php File "
  elseif l:ft ==# 'javascript'
      let s:comment = "\/\/"
      let s:type = s:comment . " Javascript File"
  else
    let s:comment = "#"
    let s:type = s:comment . " Text File"
  endif
  unlet s:file

endfunction


" FUNCTION:
" Insert the header when we create a new file.
" VARIABLES:
" author = User who create the file.
" file = Path to the file.
" created = Date of the file creation.
" modified = Date of the last modification.

function s:insert ()

  call s:filetype ()

  let s:cline = s:comment .      " ------------------------------------------------------------------------------"
  let s:title = s:comment .     " Title:        TODO: (add title)"
  let s:file = s:comment .      " Filename:     " . expand('%:t')
  let s:role = s:comment .      " Description:  TODO: (write me)"
  let s:version = s:comment .   " Version:      0.0.0.000"
  let s:created = s:comment .   " Created:      " . strftime ("%Y-%m-%d %H:%M:%S")
  let s:modified = s:comment .  " Modified:     " . strftime ("%Y-%m-%d %H:%M:%S")
  let s:author = s:comment .    " Author:       Mickael Temporão < mickael.temporao.1 at ulaval.ca >"
  let s:copyright = s:comment . " Copyright (C) " . strftime ("%Y") . " Mickael Temporão"
  let s:license = s:comment .   " Licensed under the GPL-2 < https://www.gnu.org/licenses/gpl-2.0.txt >"

  call append (0, s:type)
  call append (1, s:cline)
  call append (2, s:title)
  call append (3, s:file)
  call append (4, s:role)
  call append (5, s:version)
  call append (6, s:created)
  call append (7, s:modified)
  call append (8, s:author)
  call append (9, s:cline)
  call append (10, s:copyright)
  call append (11, s:license)
  call append (12, s:cline)

  unlet s:type
  unlet s:comment
  unlet s:cline
  unlet s:title
  unlet s:file
  unlet s:role
  unlet s:version
  unlet s:created
  unlet s:modified
  unlet s:author
  unlet s:copyright
  unlet s:license

endfunction


" FUNCTION:
" Update the date of last modification.
" Check the line number 6 looking for the pattern.

function s:update ()

  call s:filetype ()

  let s:pattern = s:comment . " Modified:     [0-9]"
  let s:line = getline (8)

  if match (s:line, s:pattern) != -1
    let s:modified = s:comment . " Modified:     " . strftime ("%Y-%m-%d %H:%M:%S")
    call setline (8, s:modified)
    unlet s:modified
  endif

  unlet s:comment
  unlet s:pattern
  unlet s:line

endfunction


autocmd BufNewFile * call s:insert ()
autocmd BufWritePre * call s:update ()
