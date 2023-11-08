local imgui = nil

local gui = function ()
    if not imgui then imgui = require('mimgui') end
    local filter = imgui.ImGuiTextFilter()

    filter:Draw("search", -1)

    imgui.Button(u8"���")
    imgui.SameLine()
    imgui.Button(u8"mes")

    imgui.BeginChild("consol")

    imgui.PushFont(font[11])


    -- local clipper = imgui.ImGuiListClipper(#consolLog, imgui.GetTextLineHeightWithSpacing())
    -- while clipper:Step() do
    --     for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
    --         local line = consolLog[i]

    --         if filter:PassFilter(u8(string.lower(line))) or filter:PassFilter(u8(string.nupper(line))) or filter:PassFilter(u8(line))then
    --             imgui.Text(u8(line))
    --             if imgui.IsItemClicked(1) then
    --                 imgui.SetClipboardText(u8(line))
                
    --                 lineLog = u8(line)
    --             end
    --         end


    --     end
    -- end

    
    imgui.PopFont()
    
    if imgui.BeginPopup("chatLog") then
        imgui.PushItemWidth(imgui.CalcTextSize(lineLog).x )
        imgui.InputText("## inputLog", im_bufferLog, sizeof(core["������"]["��� ���"]), imgui.InputTextFlags.ReadOnly)
        imgui.PopItemWidth()
        imgui.SetCursorPosX( (imgui.GetWindowWidth() - 100 - imgui.GetStyle().ItemSpacing.x) / 2 )
        imgui.EndPopup()
    end
    imgui.EndChild()
end

return {'������� ', 'ICON_COINS',  true, "������ ��� �����", gui}
