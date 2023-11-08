local imgui = nil

local gui = function ()

    -- memory.fill(sampGetBase()+0x713F2, 0x90, 5, true) --f1
    -- memory.write(sampGetBase()+0x797E, 0, 1, true) --f4
    -- memory.fill(sampGetBase() + 0x71369, 0x00, 1, true) --F5
end

return {"Ф1", "Возможность на выбор отключить ф1, ф4 или зафорсить включенный киллист без возможости его отключить", func = gui}