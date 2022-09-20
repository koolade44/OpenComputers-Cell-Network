-- Firmware for microcontroller credit relays

local m = component.proxy(component.list("modem")())
m.setStrength(400)
m.open(45)

while true do
    local name, _, _, port, _, message = computer.pullSignal()

    if (name == "modem_message") then
        computer.beep(1000, 0.3)
        m.broadcast(port, message)
        -- Make the process wait half a second before checking again so that we don't just create a signal loop
        os.sleep(0.5)
    end
end