---@diagnostic disable: missing-fields
local imgui = require("mimgui")

--package.loading["mimgui"] = nil
local faicons = require("fAwesome6")

local mod = {}


local color_text = require('sfa.imgui.extra').color_text
mod.fatext = function(f, size, col)
    local ic = faicons[f]
    if not ic then return end
    imgui.PushFont(font[size])
    color_text(col or imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), ic)
    imgui.PopFont()
end



mod.Icon = function(pos, icon_name, size, dl)
    local ic = faicons[icon_name]
    if not ic then ic = faicons["TRASH"] end


    local dl = dl or imgui.GetWindowDrawList()

    local col = imgui.ColorConvertU32ToFloat4(0xFF000000)
    local col = imgui.ColorConvertFloat4ToU32({ col.x, col.y, col.z, imgui.GetStyle().Alpha })

    dl:AddTextFontPtr(font[1], size or 13, { pos[1] + 1, pos[2] + 1 }, col, ic)
    dl:AddTextFontPtr(font[1], size or 13, pos, imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]), ic)
end



local load_icons_name = function()
    local upper, ipairs = string.upper, ipairs

    local exist = function (table, icon_name)
        for _, icon in ipairs(table) do
            if upper(icon) == upper(icon_name) then return true end
        end
    end

    
    local osn = require('sfa.imgui.i_select.Œ—ÕŒ¬ÕŒ≈')

    local proch = require('sfa.imgui.i_select.œ–Œ◊≈≈')

    local set = require('sfa.imgui.i_select.Õ¿—“–Œ… »')






    return Loaded_Icons
end



mod.init_icons = function (size)

    local builder = imgui.ImFontGlyphRangesBuilder()

    for _, b in ipairs( load_icons_name() ) do builder:AddText(faicons(b)) end

    defaultGlyphRanges1 = imgui.ImVector_ImWchar()
    builder:BuildRanges(defaultGlyphRanges1)

    font[1] = imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), size or 17, nil,
        defaultGlyphRanges1[0].Data)
end


local extra = require('sfa.imgui.extra')



sdsdds = ""
vvv = -1


mod.Button = function(text, size, icon, center)
    local hover, dl, p, press = false, imgui.GetWindowDrawList(), imgui.GetCursorScreenPos(), false


    local tsize2 = imgui.CalcTextSize(text)
    local size2 = size and imgui.ImVec2(size) or tsize2




    text = tsize2.x > size2.x and string.sub(text, 1, math.floor(size2.x / 4.2)) .. "..." or text --8

    local tsize = imgui.CalcTextSize(text)
    size = size and imgui.ImVec2(size) or tsize




    --print(size)

    size = imgui.ImVec2((size.x + (center and icon and 30 or 0)), size.y)

    local res = imgui.InvisibleButton(text, size)
    hover = imgui.IsItemHovered()

    if hover and sdsdds ~= text then
        sdsdds = text
        vvv = os.clock()
        --msg("+")
    end


    local col = extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button], 0.5)

    local col2 = extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button], 0.8)

    local col, col2 = imgui.GetColorU32Vec4(col), imgui.GetColorU32Vec4(col2)


    local col_anim = imgui.GetColorU32Vec4(extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],
        extra.bringFloatTo(0.01, 1, vvv, 0.2)))

    if res then vvv = os.clock() end


    if imgui.IsItemClicked(2) then
        local line = debug.getinfo(1).currentline
        msg(line)
        local path = thisScript().path
        msg(path)
        
     --  os.execute(string.format('code --g "%s\\lib\\sfa\\imgui\\menu.lua:201"', getWorkingDirectory(), path) )
    end


    if hover then
        dl:AddRectFilledMultiColor({ p.x, p.y }, { p.x + size.x, p.y + size.y }, col_anim, col_anim, col_anim,
            col_anim);
    end

    dl:AddRectFilledMultiColor(p, { p.x + size.x, p.y + size.y }, col, col, col2, col2);



    local col = imgui.ColorConvertU32ToFloat4(0xFF000000)
    local col = imgui.ColorConvertFloat4ToU32({ col.x, col.y, col.z, imgui.GetStyle().Alpha })
    if imgui.GetStyle().FrameBorderSize == 1 then
        dl:AddRect({ p.x - 1, p.y - 1 }, { p.x + size.x + 1, p.y + size.y + 1 },
            col)
    end -- Ó·‚Ó‰Í‡



    if not center then
        size2 = { ((p.x + size.x / 2) - tsize.x / 2) + (icon and 10 or 0), ((p.y + size.y / 2) - tsize.y / 2) } -- ‡ÒÒÚÓˇÌËÂ ÚÂÍÒÚ‡
    else
        size2 = { p.x + (icon and 24 or 0), ((p.y + size.y / 2) - tsize.y / 2) }
    end

    if icon then mod.Icon({ p.x + 13 / 2, ((p.y + size.y / 2) - 13 / 2) }, icon) end



    extra.shadowText(size2, text)

    return res
end





mod.Checkbox = function(label, bool, icon)
	local hover, dl, p, r = false,  imgui.GetWindowDrawList(), imgui.GetCursorScreenPos(), bool[0]
	local col, col2 = imgui.GetColorU32Vec4(extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.5)), imgui.GetColorU32Vec4(extra.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.8))
	local tsize = imgui.CalcTextSize(label)
	local size = imgui.ImVec2(imgui.GetFontSize() + imgui.GetStyle().FramePadding.x * 1, imgui.GetFontSize() + imgui.GetStyle().FramePadding.y * 2)

	local res = imgui.InvisibleButton(label, {size.x + (icon and (imgui.GetWindowSize().x - 30) or (tsize.x + 5)), size.y}); hover = imgui.IsItemHovered()

	local wh = imgui.GetWindowSize().x
	local wh = wh - 14


	if hover then dl:AddRectFilledMultiColor({p.x + 4, p.y + 3}, {p.x + size.x - 2, p.y + size.y - 2}, col, col, col2, col2); end

	if r then dl:AddRectFilledMultiColor({p.x + 1, p.y}, {p.x + size.x, p.y + size.y}, col, col, col2, col2); end

	dl:AddRect( {p.x + 1, p.y}, {p.x + size.x + 1, p.y + size.y + 1}, 0xFF000000) -- Ó·‚Ó‰Í‡

	local size2 = {p.x + size.x + 5,  p.y + 2}

	imgui.PushStyleColor(imgui.Col.Text, (r or hover) and imgui.GetStyle().Colors[imgui.Col.Button] or imgui.GetStyle().Colors[imgui.Col.TextDisabled] )
	extra.shadowText(size2, label)

	if icon then mod.Icon({p.x + imgui.GetWindowSize().x - 25 , ((p.y + size.y / 2) - 14 / 2 )}, icon, 15) end
	imgui.PopStyleColor()
	return res
end

mod.menu_bar_child = function(name, size, func)
	imgui.BeginChild(name, size, true, imgui.WindowFlags.MenuBar)
	func()
	imgui.EndChild()
end

return mod