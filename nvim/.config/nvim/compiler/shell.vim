if exists("current_compiler")
  finish
endif

let current_compiler = "shellcheck"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=shellcheck\ -f\ gcc\ %
CompilerSet errorformat=%f:%l:%c:\ %trror:\ %m\ [SC%n],
		       \%f:%l:%c:\ %tarning:\ %m\ [SC%n],
		       \%f:%l:%c:\ %tote:\ %m\ [SC%n],
		       \%-G%.%#
