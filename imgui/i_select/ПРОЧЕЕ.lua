local imgui = require'mimgui'


local mod = require'sfa.imgui.extra'

local mod_icon = require'sfa.imgui.icon'



imgui.Selectable = function(text, bool, size, icon)
	local hover, dl, p = false,  imgui.GetWindowDrawList(), imgui.GetCursorScreenPos()
	local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.1)), imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],1))
	local tsize = imgui.CalcTextSize(text)
	local size = size and imgui.ImVec2(size) or tsize
	local res = imgui.InvisibleButton(text, size); hover = imgui.IsItemHovered()
	
	if bool then dl:AddRectFilledMultiColor(p, {p.x + size.x, p.y + size.y}, col2, col , col, col2); end	

	if hover then dl:AddRectFilledMultiColor(p, {p.x + size.x, p.y + size.y}, col2, col2, col2, col2); end

	imgui.PushStyleColor(imgui.Col.Text, bool and imgui.GetStyle().Colors[imgui.Col.Text] or imgui.GetStyle().Colors[imgui.Col.TextDisabled] )
	if icon then mod_icon.Icon({p.x + 3 , ((p.y + size.y / 2) - 12 / 2 )}, icon) end
	mod.shadowText({p.x + (icon and 21 or 2), ((p.y + size.y / 2) - tsize.y / 2)}, text)
	imgui.PopStyleColor()
	return res
end






local ffi = require'ffi'
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof





local list = {}




local require_function = function(pos, name)
	local req = require('sfa.select.other.' .. name)
	table.insert(list, pos, req)
	table.insert(Loaded_Icons, req[2])
end



local campare = cfg.sort['прочее']

for pos, table_1 in ipairs(campare) do
	require_function(pos, table_1:trim())
end


local find = function (element)
	for _, v in ipairs(list) do if v[1]:trim() == element then  return true end end
	return false
end



for _, v2 in ipairs(getFilesInPath(getGameDirectory() .. "\\moonloader\\lib\\sfa\\select\\other" , '*.lua')) do
	v2 = v2:gsub('%.lua', ''):trim()
	if not find(v2) then
		require_function(#list + 1, v2)
	end
end





local drag = function (index, b)
	if not isKeyDown(VK_MENU) then return end
	local p = imgui.GetCursorPos()
	if imgui.BeginDragDropSource() then
		imgui.SetDragDropPayload('##payload', ffi.new('int[1]', index), 23)
		b()
		imgui.EndDragDropSource()
	end


	if imgui.BeginDragDropTarget() then
		local Payload = imgui.AcceptDragDropPayload()
		if Payload ~= nil then
			local old_index = ffi.cast("int*",Payload.Data)[0]
			local old, new = list[old_index], list[index]
	
			list[old_index] = new

			list[index] = old

			cfg.sort.прочее[old_index] = new[1]
			cfg.sort.прочее[index] = old[1]




			cfg()
		end
		imgui.EndDragDropTarget()
	end
end


local icon = "GRIP"
table.insert(Loaded_Icons, icon)

return
{
    icon,'ПРОЧЕЕ', functions = list, select = cfg.last.select['ПРОЧЕЕ'], menu =
	function(self)
		cfg.last.name = self[2]
				


		imgui.PushStyleColor(imgui.Col.ChildBg, imgui.GetStyle().Colors[imgui.Col.MenuBarBg])
		imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 0)
		local col = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.3))
		local col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button],0.8))
		local p = imgui.GetCursorScreenPos()

		imgui.GetWindowDrawList():AddRectFilledMultiColor({p.x - 2, p.y - 2}, {p.x - 4, p.y + imgui.GetWindowSize().y}, col, col, col2, col2);

		imgui.SetCursorPosY(3)
		imgui.BeginChild("выбор вкладок", {100, 287}, true)
        imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0.1, 1))
		imgui.PushFont(font[16])
		for k, v in ipairs(self.functions) do
			local p = imgui.GetCursorPos()
			

			
			if imgui.Selectable(u8(v[1]), self.select == k, {100, 20}, v[2]) then
				self.select = k

				cfg.last.select['ПРОЧЕЕ'] = k
				cfg()
			end
			
			if imgui.IsItemClicked(1) then
				local line = debug.getinfo(1).currentline
				msg(line)
				os.execute(string.format('code --g "%s\\lib\\sfa\\select\\other\\%s.lua:1"', getWorkingDirectory(), v[1]:trim()) )
			end

			drag(k, function () if imgui.Selectable(u8(v[1]), self.select == k, {100, 20}, v[2]) then end end)
		
		end
		imgui.PopFont()
		imgui.EndChild()
		imgui.PopStyleColor()
		imgui.PopStyleVar(1)

		imgui.SameLine(99)
		
		imgui.BeginChild(u8("основное окно вкладки"), {425 + 15, 287}, true)

		imgui.BeginChild("подокно вкладки", {425 + 15 - 10, 290 - 13}, false)
		

		self.functions[   self.select    ][5]()
		--if not res then Noti(reason, ERROR) end
		if reason then
			local name, reason = reason:match('\\(.+%.lua:%d+)(.+)')
			if imgui.Button('go '..reason) then
				os.execute(string.format('code --g "%s\\%s"', getGameDirectory(), name))
			end
		end

		imgui.EndChild()

		imgui.EndChild()
        imgui.PopStyleVar(1)
	
	end
}