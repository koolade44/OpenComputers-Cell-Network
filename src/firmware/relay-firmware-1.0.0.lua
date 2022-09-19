-- Firmware for microcontroller relays

-- TEST --
local component = require("component")
local computer = component.computer
-- TEST --

local m = component.proxy(component.list("modem")())

while true do
    local name, data = computer.pullSignal()

    -- TEST --
    io.write(name)
    -- TEST --

    if (name == "modem_message") then
        local port = data[3]
        local message = data[5]
        relaySignal(port, message)
    end
end

function relaySignal(port, message)
    computer.beep(1000, 0.3)
    if not m.isOpen(port) then
        m.open(port)
    end
    m.broadcast(port, message)
end