"echo ">^.^<"


let first_project_path=$WEB_DIRECTORY."/Laravel-projects/Blog"

"Opens first project main directory
nmap <leader>op1 :call Open_project(first_project_path)<cr>


"Opens the directory with the given path , given that the current file is not
"a child of that directory
function! Open_project(str)
"Current path
:cd %:p:h
let currentPath = getcwd()
let currentPathAsList = split(currentPath , "/")

"Project path
let projectPath = a:str
let projectPathAsList = split(projectPath , "/")

if len(projectPathAsList) > len(currentPathAsList)
execute ":e ".projectPath
return
else
let index = 0
while index < len(projectPathAsList)
if currentPathAsList[index] != projectPathAsList[index]
execute ":e ".projectPath
return 
endif
let index += 1
endwhile
endif
echo "Already inside the project"
endfunction


