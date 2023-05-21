if exists("current_compiler")
  finish
endif

let current_compiler = "gcc"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=gcc\ -Wall\ -Wextra\ %\ -o\ %<
