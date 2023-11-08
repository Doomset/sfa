local imgui = require('mimgui')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    if not imgui then imgui = require('mimgui') end
    
    if not core["Прочее"]["Чат лог"] then
        core["Прочее"]["Чат лог"] = new.char[300](u8"")
    end


    local log = {}



    local filter = imgui.ImGuiTextFilter()
    filter:Draw("search", 500)


    local path = getFolderPath(0x05) .. '\\GTA San Andreas User Files\\SAMP\\chatlog.txt'


    imgui.BeginChild("Chatlog", false, imgui.WindowFlags.AlwaysHorizontalScrollbar)
    local file = io.open(path, "r")
    for line in file:lines() do
        table.insert(log, line)
    end
    file:close()

    imgui.PushFont(font[11])


    local clipper = imgui.ImGuiListClipper(#log, imgui.GetTextLineHeightWithSpacing())
    while clipper:Step() do
        for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
            local line = log[i]
            if filter:PassFilter(u8(string.lower(line))) or filter:PassFilter(u8(string.nupper(line))) or filter:PassFilter(u8(line))then


             
                local function TextColoredRGB(text)
                    local style = imgui.GetStyle()
                    local colors = style.Colors
                    local ImVec4 = imgui.ImVec4
                
                    local explode_argb = function(argb)
                        local a = bit.band(bit.rshift(argb, 24), 0xFF)
                        local r = bit.band(bit.rshift(argb, 16), 0xFF)
                        local g = bit.band(bit.rshift(argb, 8), 0xFF)
                        local b = bit.band(argb, 0xFF)
                        return a, r, g, b
                    end
                
                    local getcolor = function(color)
                        if color:sub(1, 6):upper() == 'SSSSSS' then
                            local r, g, b = colors[1].x, colors[1].y, colors[1].z
                            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
                            return ImVec4(r, g, b, a / 255)
                        end
                        local color = type(color) == 'string' and tonumber(color, 16) or color
                        if type(color) ~= 'number' then return end
                        local r, g, b, a = explode_argb(color)
                        return imgui.ImVec4(r/255, g/255, b/255, a/255)
                    end
                
                    local render_text = function(text_)
                        for w in text_:gmatch('[^\r\n]+') do
                            local text, colors_, m = {}, {}, 1
                            w = w:gsub('{(......)}', '{%1FF}')
                            while w:find('{........}') do
                                local n, k = w:find('{........}')
                                local color = getcolor(w:sub(n + 1, k - 1))
                                if color then
                                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                                    colors_[#colors_ + 1] = color
                                    m = n
                                end
                                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
                            end
                            if text[0] then
                                for i = 0, #text do
                                    extra.color_text(colors_[i] or colors[1], u8(text[i]))
                                    imgui.SameLine(nil, 0)
                                end
                                imgui.NewLine()
                            else extra.Text(u8(w)) end
                        end
                    end
                
                    render_text(text)
                end
                
                    


                TextColoredRGB(line)

                if imgui.IsItemClicked(1) then
                    setClipboardText(line)
                    lineLog = u8(line)
                    -- imgui.StrCopy(core["Прочее"]["Чат лог"], u8(line))
                    -- imgui.OpenPopup("chatLog")
                end
            end
        end
    end

    
    imgui.PopFont()
    
    if imgui.BeginPopup("chatLog") then
        imgui.PushItemWidth(imgui.CalcTextSize(lineLog).x )
        imgui.InputText("## inputLog", im_bufferLog, sizeof(core["Прочее"]["Чат лог"]), imgui.InputTextFlags.ReadOnly)
        imgui.PopItemWidth()
        imgui.SetCursorPosX( (imgui.GetWindowWidth() - 100 - imgui.GetStyle().ItemSpacing.x) / 2 )
        imgui.EndPopup()
    end
    imgui.EndChild()

end

return  {'Чатлог ', 'SCROLL', true, "удобная функция для поиска/просмотра/копирования содержимого чатлога", gui}
