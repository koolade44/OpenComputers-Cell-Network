-- Firmware for microcontroller relays

local m = component.proxy(component.list("modem")())
local clock = os.clock()
m.setStrength(400)
m.open(443)

function sleep(n)
    local t0 = clock()
    while clock - t0 < n do end
end

while true do
    local name, _, _, port, _, message = computer.pullSignal()

    if (name == "modem_message") then
        computer.beep(1000, 0.3)
        m.broadcast(port, message)
        sleep(2)
    end
end