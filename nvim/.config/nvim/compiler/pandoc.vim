if exists("current_compiler")
  finish
endif

let current_compiler = "pandoc"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=pandoc\ %\ -f\ markdown\ -t\ html\ -s\ -o\ %<.html
