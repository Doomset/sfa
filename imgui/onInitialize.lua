print('trying load mod')
local imgui = require("mimgui")




local load_icons = function ()
    require('sfa.imgui.icon').init_icons()
end




local load_fonts = function()
    local first_font = 13
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    imgui.GetIO().Fonts:Clear()

    imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', first_font, nil, glyph_ranges)

    for size = 8, 21 do
        font[size] = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', size, nil, glyph_ranges)
    end

    font[54] = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 54, nil, glyph_ranges)

    load_icons()
    imgui.InvalidateFontsTexture()
end





imgui.OnInitialize(function()
    --textc = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\resource\\1.png")



    imgui.GetIO().ConfigWindowsMoveFromTitleBarOnly = true
    imgui.GetIO().IniFilename = nil

    
    load_fonts()

    local vec2, style = imgui.ImVec2, imgui.GetStyle()
    imgui.SwitchContext()
    style.WindowPadding                   = vec2(5, 5)
    style.FramePadding                            = vec2(5, 3)
    style.ItemSpacing                             = vec2(5, 5)
    style.ItemInnerSpacing                        = vec2(2, 2)
    style.TouchExtraPadding                       = vec2(0, 0)
    style.IndentSpacing                           = 0
    style.ScrollbarSize                           = 3
    style.GrabMinSize                             = 10
    --==[ BORDER ]==--
    style.WindowBorderSize                        = 1
    style.ChildBorderSize                         = 1
    style.PopupBorderSize                         = 1
    style.FrameBorderSize                         = 1
    style.TabBorderSize                           = 1
    --==[ ROUNDING ]==--
    style.WindowRounding                          = 0
    style.ChildRounding                           = 0
    style.FrameRounding                           = 0
    style.PopupRounding                           = 0
    style.ScrollbarRounding                       = 0
    style.GrabRounding                            = 0
    style.TabRounding                             = 0
    --==[ ALIGN ]==--
    style.WindowTitleAlign                        = vec2(0.5, 0.5)
    style.ButtonTextAlign                         = vec2(0.5, 0.5)
    style.SelectableTextAlign                     = vec2(0.5, 0.5)
    --==[ COLORS ]==--
    local style_color, vec4                      = style.Colors, imgui.ImVec4
    style_color[imgui.Col.Text]                  = vec4(1.00, 1.00, 1.00, 1.00)
    style_color[imgui.Col.TextDisabled]          = vec4(0.50, 0.50, 0.50, 1.00)
    style_color[imgui.Col.WindowBg]              = vec4(18 / 255, 17 / 255, 15 / 255, 1.00)
    style_color[imgui.Col.ChildBg]               = vec4(23 / 255, 22 / 255, 23 / 255, 1.00)
    style_color[imgui.Col.PopupBg]               = vec4(0.07, 0.07, 0.07, 1.00)
    style_color[imgui.Col.Border]                = vec4(10 / 255, 10 / 255, 10 / 255, 1)
    style_color[imgui.Col.BorderShadow]          = vec4(0.00, 0.00, 0.00, 1.00)
    style_color[imgui.Col.FrameBg]               = vec4(0.12, 0.12, 0.12, 1.00)
    style_color[imgui.Col.FrameBgHovered]        = vec4(0.25, 0.25, 0.26, 1.00)
    style_color[imgui.Col.FrameBgActive]         = vec4(0.25, 0.25, 0.26, 1.00)
    style_color[imgui.Col.TitleBg]               = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.TitleBgActive]         = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.TitleBgCollapsed]      = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.MenuBarBg]             = vec4(0.12, 0.12, 0.12, 1.00)
    style_color[imgui.Col.ScrollbarBg]           = vec4(0.12, 0.12, 0.12, 0)
    style_color[imgui.Col.ScrollbarGrab]         = vec4(0.00, 0.00, 0.00, 1.00)
    style_color[imgui.Col.ScrollbarGrabHovered]  = vec4(0.41, 0.41, 0.41, 1.00)
    style_color[imgui.Col.ScrollbarGrabActive]   = vec4(0.51, 0.51, 0.51, 1.00)
    style_color[imgui.Col.CheckMark]             = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.SliderGrab]            = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.SliderGrabActive]      = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.Button]                = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.ButtonHovered]         = vec4(0.54, 0.32, 1, 0.5)
    style_color[imgui.Col.ButtonActive]          = vec4(0.54, 0.32, 1, 0.7)
    style_color[imgui.Col.Header]                = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.HeaderHovered]         = vec4(0.20, 0.20, 0.20, 1.00)
    style_color[imgui.Col.HeaderActive]          = vec4(0.47, 0.47, 0.47, 1.00)
    style_color[imgui.Col.Separator]             = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.SeparatorHovered]      = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.SeparatorActive]       = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.ResizeGrip]            = vec4(1.00, 1.00, 1.00, 0.25)
    style_color[imgui.Col.ResizeGripHovered]     = vec4(1.00, 1.00, 1.00, 0.67)
    style_color[imgui.Col.ResizeGripActive]      = vec4(1.00, 1.00, 1.00, 0.95)
    style_color[imgui.Col.Tab]                   = vec4(0.54, 0.32, 1, 1.00)
    style_color[imgui.Col.TabHovered]            = vec4(0.28, 0.28, 0.28, 1.00)
    style_color[imgui.Col.TabActive]             = vec4(0.30, 0.30, 0.30, 1.00)
    style_color[imgui.Col.TabUnfocused]          = vec4(0.07, 0.10, 0.15, 0.97)
    style_color[imgui.Col.TabUnfocusedActive]    = vec4(0.14, 0.26, 0.42, 1.00)
    style_color[imgui.Col.PlotLines]             = vec4(0.61, 0.61, 0.61, 1.00)
    style_color[imgui.Col.PlotLinesHovered]      = vec4(1.00, 0.43, 0.35, 1.00)
    style_color[imgui.Col.PlotHistogram]         = vec4(0.90, 0.70, 0.00, 1.00)
    style_color[imgui.Col.PlotHistogramHovered]  = vec4(1.00, 0.60, 0.00, 1.00)
    style_color[imgui.Col.TextSelectedBg]        = vec4(1.00, 0.00, 0.00, 0.35)
    style_color[imgui.Col.DragDropTarget]        = vec4(1.00, 1.00, 0.00, 0.90)
    style_color[imgui.Col.NavHighlight]          = vec4(0.26, 0.59, 0.98, 1.00)
    style_color[imgui.Col.NavWindowingHighlight] = vec4(1.00, 1.00, 1.00, 0.70)
    style_color[imgui.Col.NavWindowingDimBg]     = vec4(0.80, 0.80, 0.80, 0.20)
    style_color[imgui.Col.ModalWindowDimBg]      = vec4(0.00, 0.00, 0.00, 0.70)
end)

print('module loaded!!!!')



require('sfa.imgui.onScreen')
require('sfa.imgui.menu')
require('sfa.imgui.not')

