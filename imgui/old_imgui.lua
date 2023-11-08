local req = require("mimgui")

local imgui = {ColorConvertFloat4ToU32 = req.ColorConvertFloat4ToU32,
GetItemRectSize = req.GetItemRectSize,
line = req.line,
GetWindowWidth = req.GetWindowWidth,
GetForegroundDrawList = req.GetForegroundDrawList,
SetCursorPosX = req.SetCursorPosX,
GetTime = req.GetTime,
Col = req.Col,
StyleVar = req.StyleVar,
SetCursorPos = req.SetCursorPos,
Checkbox = req.Checkbox,
PushIDInt = req.PushIDInt,
End = req.End,
PushStyleVarVec2 = req.PushStyleVarVec2,
BeginChild = req.BeginChild,
ImDrawList = req.ImDrawList,
PopStyleVar = req.PopStyleVar,
IsMouseReleased = req.IsMouseReleased,
IsKeyReleased = req.IsKeyReleased,
Cond = req.Cond,
EndChild = req.EndChild,
GetFontSize = req.GetFontSize,
SameLine = req.SameLine,
Begin = req.Begin,
GetIO = req.GetIO,
GetWindowDrawList = req.GetWindowDrawList,
ColorConvertU32ToFloat4 = req.ColorConvertU32ToFloat4,
new = req.new,
PopStyleColor = req.PopStyleColor,
Image = req.Image,
GetCursorScreenPos = req.GetCursorScreenPos,
ImVec4 = req.ImVec4,
PopFont = req.PopFont,
IsItemHovered = req.IsItemHovered,
GetKeyIndex = req.GetKeyIndex,
Selectable = req.Selectable,
GetStyle = req.GetStyle,
menu = req.menu,
GetMousePos = req.GetMousePos,
SliderFloat = req.SliderFloat,
SetNextWindowSize = req.SetNextWindowSize,
Key = req.Key,
ImVec2 = req.ImVec2,
PushStyleVarFloat = req.PushStyleVarFloat,
EndGroup = req.EndGroup,
InputText = req.InputText,
BeginGroup = req.BeginGroup,
WindowFlags = req.WindowFlags,
GetMouseCursor = req.GetMouseCursor,
PopID = req.PopID,
BoolButton = req.BoolButton,
StrCopy = req.StrCopy,
PushStyleColor = req.PushStyleColor,
GetColorU32Vec4 = req.GetColorU32Vec4,
Separator = req.Separator,
MouseCursor = req.MouseCursor,
GetBackgroundDrawList = req.GetBackgroundDrawList,
OpenPopup = req.OpenPopup,
Flags = req.Flags,
SetNextWindowPos = req.SetNextWindowPos,
BoolText = req.BoolText,
Dummy = req.Dummy,
PushFont = req.PushFont,
CalcTextSize = req.CalcTextSize,
Button = req.Button,
SetMouseCursor = req.SetMouseCursor,
GetCursorPos = req.GetCursorPos,
IsItemClicked = req.IsItemClicked,
OnFrame = req.OnFrame,
SetClipboardText = req.SetClipboardText,
SetCursorPosY = req.SetCursorPosY,
InvisibleButton = req.InvisibleButton,
GetWindowSize = req.GetWindowSize,
Text = req.Text,
}
package.loading["mimgui"] = nil

local ffi = require 'ffi'
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

local resPass, resNick = new.char[28](""), new.char[28]("")

local vkeys = require "vkeys"



local selectMesta = 1

local faicons = require("fAwesome6")	

local cirlce = require("sfa.addons.circle")







local mod = require('sfa.imgui.extra')

inventar = {state = false, duration = 0.2}
setmetatable(inventar, mod.ui_meta)


1



local mainFrame = imgui.OnFrame(function() return menu.alpha > 0.00 end,
function(player)
	player.LockPlayer = input:active()
	tabs:begin(function(self)
		if переключалка_чайлдов then self.animate_child.offset = mod.bringFloatTo(-200, 30, переключалка_чайлдов, 0.1) end
			if переключалка_чайлдов2 then self.animate_child.offset = mod.bringFloatTo(30,
					imgui.GetWindowSize().x, переключалка_чайлдов2, 0.15) end
		self._sfa() -- sfaAAAAAAAAA
		self() --- TABBSSSSSSS
		imgui.SetCursorPosY(88) -- позиция окошка с функциями \/
		self:beginChild(function(d)
			self[self.current]:menu()
		end)
	end, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse + imgui.WindowFlags.NoCollapse)	

end)



















imgui.line = function()
	local p = imgui.GetCursorScreenPos()
	local col = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], 1))
	local col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.WindowBg], 1))
	imgui.GetWindowDrawList():AddRectFilledMultiColor({p.x - 10, p.y - 1}, {p.x + imgui.GetWindowSize().x, p.y + 6}, col, col, col2, col2);
end



imgui.BoolText = function(bool, ...)
	local colors, clr = imgui.GetStyle().Colors, imgui.Col
	local color, p = bool and colors[clr.Button] or  mod.con(123, 123, 111), imgui.GetCursorPos()
    imgui.Dummy(imgui.CalcTextSize(...))
	imgui.SetCursorPos(p); mod.color_text(imgui.IsItemHovered() and colors[clr.ButtonHovered] or color, ...)
	return imgui.IsItemClicked(0)
end



setmetatable(cfg["Биндики"]["Список"], {
	__call = function(self, name, key, func, on)
		assert(name and key and func and on, "ЧО ЗА ХУЙНЯ НЕПРАВИЛЬНЫЕ АРГУМЕНТЫ")
		msg("add "..name)
		rawset(self, #self + 1, { name = name, key = key, func = func, on = on})
		return true
	end,
    __index = function(self, key)
		if key == "hookKeys" then
			return function(key)
				if input:active() or sampIsCursorActive() or cirlce.canDraw() then return end

				--local temple = self
				--table.sort(temple, function(a, b) return #a.key > #b.key end)

				for k, v in ipairs(self) do
					if self.edit then

						if self.edit == v.name then
							self.edit = nil
							msg{"rebind "..v.name, key[1]}

                            local function has_value (tab, val)
                                for index, value in ipairs(tab) do
                                    if value == val then
                                        return true
                                    end
                                end

                                return false
                            end
    
                            if table.concat(key) == table.concat(v.key) then
                                msg("EXIST")
                            end

							rawset(self, k, { name = v.name, key = key, func = v.func, on = v.on})
							cfg()
							print("\n", encodeJson(self))
							return true
						end 

					else
						if v.on then

							local function has_value (tab, val)
                                for index, value in ipairs(tab) do
                                    if value == val then
                                        return true
                                    end
                                end

                                return false
                            end

							local t = true 
							совпадений = #v.key
							совпадений1 = 0

							for i = 1, #key do -- длина отжатых клваиш
								if has_value (v.key, key[i]) then
									совпадений1 = совпадений1 + 1
								end
							end

							if совпадений == совпадений1 then
								print(совпадений, совпадений1)
							     --	msg{"СРАБОТАЛ ",v.name, table.concat(v.key, ", " )}
								loadstring(v.func)()
								msg(v.name)
								break
							end

						end

					end
				end
			end

		elseif key == "button" then
			return function (self, label, name)

				local io, isrebind = imgui.GetIO(), self.edit == name

				local label = isrebind and "press key" or table.concat(label, " + ")

                local label = label == "Esc" and u8"НЕ НАЗНАЧЕНА" or label
				local p, a = imgui.GetCursorPos(), math.floor(math.sin(imgui.GetTime() * 6) * 127 + 128) / 255

				local col = imgui.GetStyle().Colors[imgui.Col.Text]
				imgui.PushStyleColor(imgui.Col.Text, isrebind and {col.x, col.y, col.z, a} or col)

                if self.edit == name and imgui.IsMouseReleased(0) then self.edit = nil end

				local res = imgui.Button(label, {100, 20})

				if res then self.edit = name end

				imgui.PopStyleColor()  
				imgui.SetCursorPos({p.x + imgui.GetItemRectSize().x + imgui.GetStyle().ItemSpacing.x, p.y + 5})

				mod.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8(name))
				return res
			end

		elseif key == "getall" then
            return function ()
                imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(6, 6))
                for k, v in ipairs(self) do
                    local b = new.bool(v.on)
                    imgui.PushIDInt(k)
                    if imgui.Checkbox("", b) then
                        v.on = not v.on
                        cfg()
            
                    end
                    imgui.SameLine(imgui.GetWindowSize().x / 2 - 140)
                    if self:button(v.key, v.name) then 
                        msg(v.name)
                    end
                    imgui.PopID()
                    extra.Separator()
                end

                imgui.PopStyleVar()

                if imgui.Button("ADD", {350, 15}) then
                    imgui.OpenPopup('addhot')
                    hotname = new.char[12]()
                    hotactrion = new.char[2048]()
                end				
            end
		end
	end,
})
	


hot = cfg["Биндики"]["Список"]
hot.t = {}
hot.lastkey = -1















local notifications = imgui.OnFrame(function() return isSampAvailable() and sampIsDialogActive() end,
function(self)
    local resX, resY = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY/2 - 155), 2, imgui.ImVec2(0.5, 0.5))
	imgui.Begin("dialog##", _, imgui.WindowFlags.NoDecoration + imgui.WindowFlags.AlwaysAutoResize)

	if imgui.Button("copy name") then
		local s = [[ imgui.SetClipboardText(u8(string.format("handler('dialog', {t = '%s'})",  sampGetDialogCaption())))]]
		loadstring(s)()
		print(s)
	end
	imgui.SameLine()	

    if imgui.Button("copy name and select") then
		list, cound = "", 0
		if sampGetCurrentDialogListItem() ~= -1 then
			for text in sampGetDialogText():gmatch("[^\n]*\n?") do
				if cound == sampGetCurrentDialogListItem() then
					list = text
					break
				end
				cound = cound + 1
			end
		else
			list = sampGetCurrentDialogEditboxText()
		end


		local s = [[ imgui.SetClipboardText(u8(string.format("handler('dialog', {t = '%s', s = %d, i = '%s'})",  sampGetDialogCaption(), sampGetCurrentDialogListItem(), list)))]]
		loadstring(s)()
		print(s)

	end
	imgui.SameLine()	

	if imgui.Button("copy name id") then 
		local s = [[ imgui.SetClipboardText(  u8( string.format( 'handler("dialog", {t = "%s", id = "%d"} )', sampGetDialogCaption(), sampGetCurrentDialogId()) )  ) ]]
		loadstring(s)()
		print(s)
	end
	imgui.End()    
end)



centerText = function(text, off, color, fontsize)
	imgui.PushFont(fontsize or font[18])
	imgui.SetCursorPos({imgui.GetWindowWidth() / 2 - imgui.CalcTextSize(text).x / 2, off or 50}); 
	mod.color_text(color or imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 0.5), text)
	imgui.PopFont()
end



function imgui.BoolButton(bool, ...)
	if type(bool) ~= 'boolean' then return end
	local colors, clr = imgui.GetStyle().Colors, imgui.Col
	imgui.PushStyleColor(imgui.Col.Button, bool and colors[clr.Button] or imgui.ImVec4(0.20, 0.20, 0.20, 0))
	imgui.PushStyleColor(imgui.Col.ButtonHovered, colors[clr.ButtonHovered])
	imgui.PushStyleColor(imgui.Col.ButtonActive, bool and colors[clr.Button] or imgui.ImVec4(0.16, 0.16, 0.16, 1.00))
	local result = imgui.Button(...)
	imgui.PopStyleColor(3)
	return result
end









angle = 0
speed = 0.1

origbutton = imgui.Button







imgui.Checkbox = function(label, bool, icon)
	local hover, dl, p, r = false,  imgui.GetWindowDrawList(), imgui.GetCursorScreenPos(), bool[0]
	local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.5)), imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.8))
	local tsize = imgui.CalcTextSize(label)
	local size = imgui.ImVec2(imgui.GetFontSize() + imgui.GetStyle().FramePadding.x * 1, imgui.GetFontSize() + imgui.GetStyle().FramePadding.y * 2)

	local res = imgui.InvisibleButton(label, {size.x + (icon and (imgui.GetWindowSize().x - 30) or (tsize.x + 5)), size.y}); hover = imgui.IsItemHovered()

	local wh = imgui.GetWindowSize().x
	local wh = wh - 14


	if hover then dl:AddRectFilledMultiColor({p.x + 4, p.y + 3}, {p.x + size.x - 2, p.y + size.y - 2}, col, col, col2, col2); end

	if r then dl:AddRectFilledMultiColor({p.x + 1, p.y}, {p.x + size.x, p.y + size.y}, col, col, col2, col2); end

	dl:AddRect( {p.x + 1, p.y}, {p.x + size.x + 1, p.y + size.y + 1}, 0xFF000000) -- обводка

	local size2 = {p.x + size.x + 5,  p.y + 2}

	imgui.PushStyleColor(imgui.Col.Text, (r or hover) and imgui.GetStyle().Colors[imgui.Col.Button] or imgui.GetStyle().Colors[imgui.Col.TextDisabled] )
	imgui.shadowText(size2, label)

	if icon then imgui.Icon({p.x + imgui.GetWindowSize().x - 25 , ((p.y + size.y / 2) - 14 / 2 )}, icon, 15) end
	imgui.PopStyleColor()
	return res	
end


function extra.U32ToImVec4(color)
	local r, g, b
	r = bit.rshift(color, 16)
	g = bit.band(bit.rshift(color, 8), 0xFF)
	b = bit.band(color, 0xFF)
	
	return mod.con(r, g, b, 1.0)
end







imgui.Selectable = function(text, bool, size, icon)
	local hover, dl, p = false,  imgui.GetWindowDrawList(), imgui.GetCursorScreenPos()
	local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.1)), imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],1))
	local tsize = imgui.CalcTextSize(text)
	local size = size and imgui.ImVec2(size) or tsize
	local res = imgui.InvisibleButton(text, size); hover = imgui.IsItemHovered()
	
	if bool then dl:AddRectFilledMultiColor(p, {p.x + size.x, p.y + size.y}, col2, col , col, col2); end	

	if hover then dl:AddRectFilledMultiColor(p, {p.x + size.x, p.y + size.y}, col2, col2, col2, col2); end

	imgui.PushStyleColor(imgui.Col.Text, bool and imgui.GetStyle().Colors[imgui.Col.Text] or imgui.GetStyle().Colors[imgui.Col.TextDisabled] )
	if icon then imgui.Icon({p.x + 3 , ((p.y + size.y / 2) - 12 / 2 )}, icon) end
	imgui.shadowText({p.x + (icon and 21 or 2), ((p.y + size.y / 2) - tsize.y / 2)}, text)
	imgui.PopStyleColor()
	return res
end




function renderDrawProgress(posX, posY, sizeX, sizeY, progress, drawProgress)
	local outlineSize = 1
	local f, b = mod.bringFloatTo(1, sizeX, progress,  drawProgress)
	local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.8)), imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],1))
	local text = u8"ТАЙМЕР"  
	
	imgui.GetForegroundDrawList():AddRect(imgui.ImVec2(posX, posY), imgui.ImVec2(posX + sizeX, posY + sizeY ), 0xFF000000)
	imgui.GetForegroundDrawList():AddRect(imgui.ImVec2(posX, posY), imgui.ImVec2(posX + sizeX + 1, posY + sizeY  +1), 0xFF000000)

	imgui.GetForegroundDrawList():AddRectFilledMultiColor(imgui.ImVec2(posX + outlineSize, posY + outlineSize), {posX  + (f -  outlineSize * 2), posY + (sizeY - outlineSize * 2)}, col, col, col2, col2);
	mod.shadowText({posX +  sizeX / 2 - imgui.CalcTextSize(text).x / 2, posY + imgui.CalcTextSize(text).y / 2}, text, 1)
end


local ToU32 = imgui.ColorConvertFloat4ToU32
local ToVEC = imgui.ColorConvertU32ToFloat4

CircularProgressBar = function(value, radius, thickness, format)
	local DL = imgui.GetWindowDrawList()
	local p = imgui.GetCursorScreenPos()
	local pos = imgui.GetCursorPos()
	local ts = nil

	if type(format) == 'string' then
		format = string.format(format, value)
		ts = imgui.CalcTextSize(format)
	end

	local side = imgui.ImVec2(
		radius * 2 + thickness,
		radius * 2 + thickness + (ts and (ts.y + imgui.GetStyle().ItemSpacing.y) or 0)
	)
	local centre = imgui.ImVec2(p.x + radius + (thickness / 2), p.y + radius + (thickness / 2))

    imgui.BeginGroup()
		imgui.Dummy(side) if imgui.IsItemClicked(0) then msg("DD") end

		local corners = radius * 5
	    local col_bg = ToU32(imgui.GetStyle().Colors[imgui.Col.FrameBg])
	    local col = ToU32(imgui.GetStyle().Colors[imgui.Col.ButtonActive])
	    local a1 = 90 - (360 / 100) * (value / 2)
		local a2 = 90 + (360 / 100) * (value / 2)

	    DL:AddCircle(centre, radius, col_bg, corners, thickness / 2)
		DL:PathClear()
        DL:PathArcTo(centre, radius, math.rad(a1) + imgui.GetTime() * 12, math.rad(a2)  + imgui.GetTime() * 12, corners)
		DL:PathStroke(col, 0, thickness)
	
-- PathLineTo(ImVec2(centre.x + ImCos(a + ImGui::GetTime() * speed) * radius,
--                centre.y + ImSin(a + ImGui::GetTime() * speed) * radius));

	    if format ~= nil then
	    	imgui.SetCursorPos(
	    		imgui.ImVec2(
	    			(pos.x + (side.x - ts.x) / 2) + 1.5,
	    			(pos.y + radius * 2 + thickness + imgui.GetStyle().FramePadding.y) / 1.38
	    		)
	    	)
	    	imgui.Text(format)
	    end
	imgui.EndGroup()
end





local function ImRotate(v, cos_a, sin_a) return imgui.ImVec2(v.x * cos_a - v.y * sin_a, v.x * sin_a + v.y * cos_a) end 
function imgui.ImDrawList.__index:RotateVerts(vtx_start, vtx_end, rotate_vec, center_vec)
    local base = math.pi/2
    local sx, cx = math.sin(base + rotate_vec.x), math.cos(base + rotate_vec.x)
    local sy, cy = math.sin(base + rotate_vec.y), math.cos(base + rotate_vec.y)

    local center = {
        ImRotate(center_vec, sx, cx),
        ImRotate(center_vec, sy, cy)
    }

    center[1].x = center[1].x - center_vec.x
    center[2].y = center[2].y - center_vec.y

    for vert = vtx_start, vtx_end do
        local pos = self.VtxBuffer.Data[vert].pos
  
        local rot = { ImRotate(pos, sx, cx), ImRotate(pos, sy, cy) }
        self.VtxBuffer.Data[vert].pos.x = rot[1].x - center[1].x
        self.VtxBuffer.Data[vert].pos.y = rot[2].y - center[2].y
    end
end






-- prog = 1
-- local _SliderFloat = imgui.SliderFloat
-- imgui.SliderFloat = function(...)
-- 	local slider = _SliderFloat(...)
-- 	msg(tostring(slider))
-- 	local a = {...}

-- 	if a[2] then
-- 		local grabsize = imgui.GetStyle().GrabMinSize
-- 		p = imgui.GetCursorScreenPos()
-- 		if slider then
-- 			prog = imgui.GetMousePos().x - p.x
-- 		end
-- 		local col = imgui.GetColorU32Vec4(setAlpha(imgui.GetStyle().Colors[imgui.Col.ButtonHovered], 1))
-- 		--msg(grabsize)
-- 		imgui.GetForegroundDrawList():AddRectFilledMultiColor({p.x + 2, p.y - 22}, {p.x + prog, p.y - 4}, col, col, col, col);
		
-- 	end
	
-- 	return slider
-- end

--imgui.SliderFloat(constchar*label,float*v,floatv_min,floatv_max,constchar*format,floatpower)




imgui.menu_bar_child = function(name, size, func)
	imgui.BeginChild(name, size, true, imgui.WindowFlags.MenuBar)
	func()
	imgui.EndChild()
end





-- local mainFrame = imgui.OnFrame(function() return true end,
-- function(self)
-- 	local res = imgui.GetIO().DisplaySize
-- 	self.HideCursor = true
	
-- 	local main_size = imgui.ImVec2(268 + 20, 160 + 20)
-- 	imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 11)
	
-- 	local wposX, wposY = convertGameScreenCoordsToWindowScreenCoords(97.9922, 343.4497)
-- 	imgui.SetNextWindowSize(main_size, 1)
-- 	imgui.SetNextWindowPos(imgui.ImVec2(wposX, wposY), 2, imgui.ImVec2(0.5, 0.5))
-- 	imgui.Begin("##Хуууй1", _, imgui.WindowFlags.NoDecoration + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoMouseInputs)

-- 	imgui.SetCursorPos{0, 0}
-- 	imgui.Image(textc, main_size)

-- 	imgui.SetCursorPosY(10)



-- 	imgui.PushStyleColor(imgui.Col.ChildBg, con(0, 51, 0, 0.3))

-- 	imgui.GetMouseCursor()
-- 	local p = imgui.GetMousePos()
-- 	imgui.SetCursorPos{28, 18}

-- 	print(imgui.GetCursorPos())

-- 	imgui._BeginChild("", { main_size.x  - 69, main_size.y - 39})
	


-- 	imgui.SetCursorPosY(2)
-- 	imgui.SetCursorPosX(2)
-- 	im_colored_text_with_shadow(con(128, 126, 0, 0.9), "14/88/00")
-- 	imgui.SameLine()
-- 	imgui.SetCursorPosX(imgui.GetWindowSize().x - imgui.CalcTextSize("00:00").x - 7)
-- 	im_colored_text_with_shadow(con(128, 126, 0, 0.9), "00:00")
-- 	extra.Separator()
-- 	imgui.PushFont(font[15])
-- 	imgui.SetCursorPosX(2)
-- 	im_colored_text_with_shadow(con(0, 126, 0), u8"ПОЛЬЗОВАТЕЛЬ:")
-- 	imgui.SameLine()
-- 	imgui.Text("TRIO")
-- 	extra.Separator()
-- 	imgui.PopFont()

	
--     imgui.SetCursorPosX(2)
-- 	imgui.PushFont(font[14])
-- 	im_colored_text_with_shadow(con(0, 88, 133),u8"ГОЛОД: 99")
-- 	imgui.SameLine()
-- 	imgui.SetCursorPosX(120)
	
-- 	im_colored_text_with_shadow(con(44, 88, 0, 1),u8"ДОП ХП: 0/0")

-- 	imgui.SetCursorPosX(2)
-- 	im_colored_text_with_shadow(con(221, 221, 133),u8"РАДИАЦИЯ: 99")
-- 	extra.Separator()
-- 	imgui.SetCursorPosX(2)
-- 	im_colored_text_with_shadow(con(59, 59, 59), u8"СОН: 99")
-- 	imgui.SetCursorPosX(2)
-- 	im_colored_text_with_shadow(con(147, 44, 44), u8"ВИРУС: 99")
-- 	imgui.PopFont()





-- 	imgui.EndChild()
-- 	imgui.PopStyleColor()
-- 	imgui.PopStyleVar()

-- 	imgui.End()	

-- end)




-- local mainFrame = imgui.OnFrame(function() return inventar.alpha > 0.01 end,
-- function(self)
-- 	local res = imgui.GetIO().DisplaySize
-- 	self.HideCursor = inventar.alpha > 0.01
-- 	local t = list_inv
-- 	local a = inventar.alpha
	
-- 	local size = imgui.ImVec2(500, 300)
--     imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, inventar.alpha)


-- 	local a_anim = size.x / 5

-- 	print(a_anim)
-- 	imgui.SetNextWindowSize({ size.x - a_anim + a * a_anim, size.y - a_anim + a * a_anim } , 1)
--     imgui.SetNextWindowPos(imgui.ImVec2( res.x / 2, res.y / 2), 1, imgui.ImVec2(0.5, 0.5))
-- 	imgui.Begin(u8("Cодержимое рюкзака"))

-- 	imgui.BeginChild("-1")

-- 	imgui.SetCursorPos{5, 5}

-- 	imgui.PushFont(font[14])
-- --	imgui.PushStyleColor(imgui.Col.Button, imgui.GetStyle().Colors[imgui.Col.ChildBg])
-- 	imgui.PushStyleColor(imgui.Col.Button, imgui.GetStyle().Colors[imgui.Col.WindowBg])
-- 	for i = 2, #t do
-- 		imgui.Button(u8(t[i]), {100, 50})
		
-- 		if i ~= 5 then
-- 			imgui.SameLine()
-- 		end
-- 	end
-- 	imgui.PopFont()
-- 	imgui.PopStyleColor()
-- 	imgui.EndChild()



-- 	imgui.End()	
-- 	imgui.PopStyleVar()

-- end)




