local imgui = require('mimgui')

local gui = function ()


    for k, v in ipairs(cfg["Аттачи"]["Модели"]) do
        local b, n = new.bool(v.on), new.char[28](u8(v.name))


        if imgui.Checkbox("", b) then
            v.on = not v.on
            cfg()
        end
        imgui.SameLine() 
        for _, obj in pairs(v.list) do
    
            for k, v2 in ipairs(render_models) do
                if v2 == obj.data.id then
                    --msg"222"
                    local p = imgui.GetCursorPos()
                    imgui.Image(texture[v2], {32, 32})
                    
                    imgui.PushFont(font[10])
                    imgui.SetCursorPos{p.x + 32/2 - imgui.CalcTextSize(tostring(obj.data.id)).x / 2, p.y + 32 - 15}
                    imgui.Text(tostring(obj.data.id))
                    imgui.PopFont()
                    
                    imgui.SetCursorPos{p.x + 32 + imgui.GetStyle().ItemSpacing.x / 2 + 1, p.y}
                    break
                end
            end
            
        end

        imgui.SameLine()

        imgui.PushItemWidth(60)
        if imgui.InputText("##name"..k, n, sizeof(n)) then v.name = u8:decode(str(n)); end
        imgui.PopItemWidth()


    --	imgui.InputText("##name", hotname, sizeof(hotname))

        imgui.SameLine()
        local col = imgui.GetStyle().Colors[imgui.Col.FrameBg]
        imgui.PushStyleColor(imgui.Col.Button, col)
        if imgui.Button("X", {23, 18}) then table.remove(cfg["Аттачи"]["Модели"], k) cfg() end
        imgui.PopStyleColor()
        
    end

--	sampTextdrawSetModelRotationZoomVehColor(int id, int model, float rotX, float rotY, float rotZ, float zoom, int clr1, int clr2)


    imgui.NewLine()
    --sampev.onse
    if imgui.Button("add", {120, 15}) then
        local t = {}; 

        for k, v in pairs(lastattached) do
            msg(v.data.id)
            table.insert(t, v.data.id)
        end;

        table.sort(t)

        --msg( #t > 0 and table.concat(t, ", ") or "Без названия")

        print(lastattached, "ПИСЯЫ ПИМСВЫВЫВ")

        table.insert(cfg["Аттачи"]["Модели"], {name = #t > 0 and table.concat(t, ", ") or "Без название", list = lastattached, on = false})

        
        cfg()
        --sampev.o
    end


end

return {"Аттачи",  "Есть возможно отключить на выбор маску/балаклаву/аттачи пушек/кокаин/противогаз/нитро", func = gui}