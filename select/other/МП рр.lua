local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    if not imgui then imgui = require('mimgui') end

    if not core["Прочее"]["Мп РР"] then
        core["Прочее"]["Мп РР"] = {
            ["Админ"] = new.char[28](u8"Nikolay"),
            ["Сообщение"] = new.char[28](u8"3"),
            ["Ник"] = new.int(0),
            ["Задержка"] = new.int(0),
        }
    end

    extra.centerText(u8"Хуй", 30)

    local adm, mess = str(core["Прочее"]["Мп РР"]["Админ"]), str(core["Прочее"]["Мп РР"]["Сообщение"])

    



    extra.centerText(string.format(u8"%s[%s]: %s",adm , "12" ,mess), 50, extra.U32ToImVec4(bit.rshift(-1, 8)))




    extra.centerText(string.format(u8"[ВЧ] %s[%s]: %s",adm , "12" ,mess), 80, extra.U32ToImVec4(bit.rshift(-3407617, 8))) --ВЧ

    local p = imgui.GetWindowSize().x / 2 - 100 /2

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"Ник админа проводящего МП").x / 2)

    imgui.PushItemWidth(100)
    imgui.InputText(u8"Ник админа проводящего МП## input2", core["Прочее"]["Мп РР"]["Админ"], sizeof(core["Прочее"]["Мп РР"]["Админ"]))

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"Ник админа проводящего МП").x / 2)

    imgui.InputText(u8"Сообщение## input2", core["Прочее"]["Мп РР"]["Сообщение"], sizeof(core["Прочее"]["Мп РР"]["Админ"]))

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"Ид того, кого надо ебашить").x / 2)
    imgui.InputInt(u8"Ид того, кого надо ебашить## input3", core["Прочее"]["Мп РР"]["Ник"], 0, 0)
    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"Задержка после сообщения").x / 2)
    imgui.InputInt(u8"Задержка после сообщения## input3", core["Прочее"]["Мп РР"]["Задержка"], 0, 0)
    imgui.PopItemWidth()

end


return  {'МП рр ', 'ICON_COINS',  true, "Чисто ебнуть какого-нибуть нелюбимого чела на мп русской рулетке, а так лучше не налегать", gui}
