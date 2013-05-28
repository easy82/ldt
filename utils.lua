output = ""

function writeOutput(line)
  output = output .. line .. "\n"
  print(line)
end

function try(condition, errorMessage, successMessage)
  if condition == true then
    writeOutput(errorMessage)
    return false
  end

  if successMessage then writeOutput(successMessage) end
  return true
end

function trimStr(str)
  return str:match("^%s*(.-)%s*$")
end

function splitStr(str, sep)
  local ret = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(c) ret[#ret + 1] = c end)
  return ret
end

function testDir(path)
  return tonumber(os.execute('cd "' .. path .. '"')) == 0 and true or false
end

function testFile(file)
  local f = io.open(file, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- This piece of code is originally from https://github.com/lualatex/lualibs/blob/master/lualibs-os.lua
function testOutput(command)
  local h = io.popen(command, "r")
  return h and h:read("*all") or ""
end