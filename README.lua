-- Create template
local template = require "resty.template"
local readme_src = template.new "README-source.md"

-- Import HTTP

-- DateTime of file generation
readme_src.datetime = os.date("!%Y-%m-%dT%XZ") --

-- age calcualtion

local function get_days_in_month(month, year)
  local days_in_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }   
  local d = days_in_month[month]
   
  -- check for leap year
  if (month == 2) then
    if (math.mod(year,4) == 0) then
     if (math.mod(year,100) == 0)then                
      if (math.mod(year,400) == 0) then                    
          d = 29
      end
     else                
      d = 29
     end
    end
  end

  return d  
end

-- today
-- , os.time{year = 2008, month = 5, day = 4,}
local today = os.date("*t")
local age = {year = today.year-2005, month = today.month-5, day = today.day-5}


if age.day < 0 then
    age.month = age.month - 1
end
if age.month < 0 then
    age.year = age.year - 1
end
if age.month < 0 then
    age.month = age.month + 12
end
if age.day < 0 then
    age.day = age.day + get_days_in_month(age.month, today.year-1)
end
readme_src.age_year=age.year
readme_src.age_month=age.month
readme_src.age_day=age.day
-- Last git commit in readme source.
local f = io.popen("git log -n 1 --pretty=reference -- README-source.md", 'r')
readme_src.git_last = f:read('*a'):gsub("^%s*(.-)%s*$", "%1")
f:close()

-- Write template ot file.
local file = io.open("README.md", "w")
file:write(tostring(readme_src))