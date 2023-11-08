local imgui = require('mimgui')

local gui = function ()

end

local render = imgui.OnFrame(function() return isSampAvailable() and sampIsDialogActive() end,
function (s)
    s.HideCursor = false
end)



return  {"Индикация",  "Индикаторы на скине для удобного отслеживание включённых функций"}