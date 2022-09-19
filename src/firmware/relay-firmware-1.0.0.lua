-- Firmware for microcontroller relays

local m = component.proxy(component.list("modem")())
m.setStrength(400)
m.open(443)

while true do
    local name, _, _, port, _, message = computer.pullSignal()

    if (name == "modem_message") then
        computer.beep(1000, 0.3)
        m.broadcast(port, message)
    end
end