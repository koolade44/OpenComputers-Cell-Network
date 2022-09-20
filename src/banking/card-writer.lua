local component = require("component")
local card_writer = component.os_cardwriter

math.randomseed(os.time())

local function generateId()
    local template = "xxxx-xxxx-xxxx-xxxx"
    string.gsub(template, '[x]', function(c)
        local v = (c == "x") and math.random(0, 0xf)
        return string.format('%x', v)
    end)
end

io.write("Beginning writing of debit card\n")
local data = generateId()
validPin = false
local pin

while validPin == false do
    io.write("Please insert a 4 digit numerical pin: ")
    local input = io.read()
    if pcall(function() pin = tonumber(input) end) and #input == 4 then
        validPin = true
    else
        io.write("\n" .. pin .. " is not a valid 4 digit numerical pin. Please try again\n")
    end
end

card_writer.write(data .. ":" .. pin, "Debit Card", true)