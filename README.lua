-- Create template
local template = require "resty.template"
local readme_src = template.new "README-source.md"


-- DateTime of file generation
readme_src.datetime = os.date("%Y-%m-%dT%xZ")

-- Last git commit in readme source.
local f = io.popen("git log -n 1 --pretty=reference -- README-source.md", 'r')
readme_src.git_last = f:read('*a'):gsub("^%s*(.-)%s*$", "%1")
f:close()

-- Write template ot file.
local file = io.open("README.md", "w")
file:write(tostring(readme_src))