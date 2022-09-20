local uuid = require("uuid")
local component = require("component")
local card_writer = component.os_cardwriter

io.write("beginning writing of debit card")
uuid.seed()
local data = uuid()
validPin = false
local pin

while validPin == false do
    io.write("Please insert a 4 digit numerical pin: ")
    local input = io.read()
    if pcall(function() pin = tonumber(input) end) and #pin == 4 then
        validPin = true
    else
        io.write("\n" .. pin .. " is not a valid 4 digit numerical pin. Please try again\n")
    end
end

card_writer.write(data .. ":" .. pin, "Debit Card", true)