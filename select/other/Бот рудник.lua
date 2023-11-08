local imgui = nil

local gui = function ()
    if not imgui then imgui = require('mimgui') end
    
end

return {'Бот рудник ', 'ICON_COINS',  true, "Нужно быть на руднике в форме и с ломом и без админов в сети", gui}
