local component = require("component")
local event = require("event")
local thread = require("thread")
local modem = component.modem
local computer = component.computer

modem.open(12)
io.write("Is this a receiving or sending computer (r/s): ")
local response = io.read()

if response == "s" then
    io.write("\nAwaiting link request from receiving computer")
    local _, _, from, _, _, message = event.pull("modem_message")
    if message == "requestLink" then
        local dataFile = io.open("/linked-device-information", "w+")
        dataFile:write(from)
        dataFile:close()
        modem.send(from, 12, "linkSuccess")
        io.write("Successfully linked as sender for " .. from)
    end
else if response == "r" then
    io.write("\nBroadcasting link request")
    modem.broadcast(12, "requestLink")
    local _, _, from, _, _, message = event.pull("modem_message")
    while message ~= "linkSuccess" do _, _, from, _, _, message = event.pull("modem_message") end
    io.write("Successfully linked as receiver to " .. from)
end
end