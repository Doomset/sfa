local imgui, button = nil, nil
local weapons = require 'game.weapons'

local t = {}
    for k, v in pairs(weapons.names) do
        table.insert(t, {id = k, text = v })
    end
    table.sort(t, function(a, b) return a.id < b.id end )

local gui = function ()
    if not imgui then
        imgui = require('mimgui')
        button = require('sfa.imgui.icon').Button
    end

    
    if not doesCharExist(1) then return end


    imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(5, 0.5))


        
    for k, v in ipairs(t) do local d = false
        imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(-1, -1))
        if button(tostring(v.id), {18, 18}) then d = true end
        imgui.SameLine()
        imgui.PopStyleVar()
        if button(v.text, {138 - 18, 18}) or d then
            NoKick()
            local model = getWeapontypeModel(v.id)
            requestModel(model)
            loadAllModelsNow()
            giveWeaponToChar(1, v.id, 99999)
            Noti('Выдан '..v.text, OK)
        end
        if k%3 ~= 0 then imgui.SameLine() end
    end
    imgui.PopStyleVar()	
   
end

return  {'Dgun ', 'GUN',  true, "Залупа хуй говно", gui}
