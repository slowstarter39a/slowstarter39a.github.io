#!/bin/bash


 git config diff.tool vimdiff

 git config difftool.vimdiff.cmd 'cd "$LOCAL"..; zip -r test_diff.zip *;cp test_diff.zip `cd -`;' 

 git difftool -d $1~ $1

# git config --unset diff.tool
# git config --unset difftool.vimdiff.cmd
