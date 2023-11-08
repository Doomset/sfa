local imgui = require('mimgui')
local extra = require('sfa.imgui.extra')


local selected = 1
local begin = function ()
    imgui.BeginChild("Dick", {395, 115}, true, imgui.WindowFlags.MenuBar)
    if imgui.BeginMenuBar() then
        imgui.Text(u8'Выбранная ставка ')
    imgui.SameLine()
    imgui.Button(tostring(selected))

        imgui.SetCursorPos{395 - 100 - 4, 3}
        if imgui.Button(u8"Обнулить числа", {100, 15}) then
            for i = 0, 36 do
                tablecount[i] = 0
            end
        end

         imgui.EndMenuBar()
    end
    local zero = imgui.ImVec4(0.0, 0.8, 0.0, 1.0)
    local red = imgui.ImVec4(1.0, 0.0, 0.0, 1.0)
    local black= imgui.ImVec4(0.0, 0.0, 0.0, 1.0)


    

    for i = 0, 36 do
        local secondColor = (i == 1 or i == 3 or i == 5 or i == 7 or i == 9 or i == 12 or i == 14 or i == 18 or i == 16 or i == 21 or i == 19 or i == 23 or i == 27 or i == 25 or i == 30 or i == 32 or i == 36 or i == 34)

        imgui.PushStyleColor(imgui.Col.Button, i == 0 and zero or (secondColor and red or black) )


--
        if imgui.Button(imgui.IsMouseDown(1) and '1' or tostring(i), i == 0 and imgui.ImVec2(25, 85) or imgui.ImVec2(25, 25)) then

            selected = i
            msg(i)
            timer('prochee-autobet-start', 0.1, function ()
                sendSync{key = 1024}
            end)
        end

        imgui.PopStyleColor()

        if i == 0 or i == 12 or i == 24 then
            imgui.SetCursorPos{35, (i == 12 and 35 + 20 or (i == 24 and 65 + 20 or 25))}
        end

        if i%12~=0 then

            imgui.SameLine( )
        end

    end
    imgui.EndChild()
end


local gui = function ()
 

    

    begin()
    
    
  

end

return

{'Автоставка ', 'COINS',  true, "Автоматом ставит по 10к на 14, надо включить авторулетку.", gui}
