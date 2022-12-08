if exists("current_compiler")
  finish
endif

let current_compiler = "shellcheck"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=shellcheck\ %
