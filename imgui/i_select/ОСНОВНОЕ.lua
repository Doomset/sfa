
local imgui = require("mimgui")




local list =
{
	{name =  "работы"},
	{name =  "основное"},
	{name = "прочее"}
}






local require_function = function(section, pos, section_name, name)
	local req = require('sfa.select.' .. section_name .. '.' .. name)
	table.insert(list[section], pos, req)
	table.insert(Loaded_Icons, req.icon)
end



local campare = cfg.sort['основное']
for i = 1, 3, 1 do -- запрос порядок функций из кфг
	for pos, table_1 in ipairs(campare[i]) do
		require_function(i, pos, list[i].name, table_1)
	end
end


local find = function (element, section)
	for i = 1, 3  do
		for _, v in ipairs(list[i]) do
			if v.name == element then return true end
		end
	end
	return false
end



for i = 1, 3, 1 do -- если нет в конфиге элемента - добавляется из файла
	for _, v2 in ipairs(getFilesInPath(getGameDirectory() .. "\\moonloader\\sfa\\select\\" .. list[i].name, '*.lua')) do
		v2 = v2:gsub('%.lua', '')
		if not find(v2) then
			require_function(i, #list[i].name + 1, list[i].name, v2)
		end
	end
end

local ffi = require('ffi')

local extra = require('sfa.imgui.extra')
local input = extra.input()

--msg("WWWWWWWWWWWWWWWWWW", list[1][1].name)
local hint = extra.hint





local but = require('sfa.imgui.icon').Button





local drag = function (section, index, b, pizda)
	if isKeyDown(VK_MENU) then
		local p = imgui.GetCursorPos()
		if imgui.BeginDragDropSource() then
			imgui.SetDragDropPayload('##payload', ffi.new('int[1]', index), 23)
			b()
			imgui.EndDragDropSource()
		end


		if imgui.BeginDragDropTarget() then
			local Payload = imgui.AcceptDragDropPayload()
			if Payload ~= nil then
				local OldItemPos = ffi.cast("int*",Payload.Data)[0]
				local old, new = list[section][OldItemPos], list[section][index]
				list[section][OldItemPos] = new
				list[section][index] = old
				cfg.sort.основное[section][OldItemPos] = new.name
				cfg.sort.основное[section][index] = old.name
				cfg()
				Noti(string.format('смена позиции\n%s -> %s\n%s -> %s', old.name, new.name, new.name, old.name), INFO)
			end
			imgui.EndDragDropTarget()
		end
	end
end

local icon = "WAND_MAGIC"
table.insert(Loaded_Icons, icon)


table.insert(Loaded_Icons, "CAR")
local noti = require('sfa.imgui.not')


IsAnyFuncActiove = false

return
{
	icon,
	'ОСНОВНОЕ',
	state = '',
	functions = list,
	menu =
    function(self)

		local b = function(v)
			local size = imgui.ImVec2(166, 18)
			local p2 = hint.p()
			if input:filt(v[1]) then
				local p = imgui.GetCursorPos()	
				imgui.Dummy(size)
				imgui.PushFont(font[ (imgui.IsItemHovered() and not imgui.IsMouseDown(0)) and 17 or 15 ] )
				imgui.SetCursorPos(p)
					if ((input.is_clicked and #input.chars > 0) and imgui.IsItemClicked(0) or (but(u8(v[1]), size, not imgui.IsItemHovered() and v[2] or false))) then
					input:null()
					local id = check_car()
					if id and id ~= -1 then sampSendExitVehicle(id) end
					--print("ВЫЗВАНА ФУНКЦИЯ ", v[1])
--					timers.timeout = {os.clock(), 3}
					IsAnyFuncActiove = true
					self.active.name = v[1]
					self.active.handle =

					lua_thread.create(function()
						local res, reason = pcall(v[4], self)
						if reason then Noti(reason, ERROR) end
						if res then Noti(string.format('%s -  OK', v[1]), OK) end
						wait(0)
						IsAnyFuncActiove = false
						self.active.name = false
						self.active.handle = false
						ProcessLog = {}
					end)

				end
				imgui.PopFont()
				hint(v[3], p2, size)
			end
		end
		--if isKeyDown(1) then sort() end

		imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 0)

		if self.active.handle == false then
			imgui.SetCursorPos{0}
			imgui.BeginChild("hotbar##", {540, 17}, 1, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse) 	
			input:render()	
			imgui.EndChild()
		end


		imgui.SetCursorPosY(imgui.GetCursorPosY() - 2)
		
		local childsize = {177.5, 268}
		imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1, 0.4))
		for i=1, #self.functions do
			local childp = imgui.GetCursorPos()
			local index_section = i
			if IsAnyFuncActiove == false then
				imgui.PushStyleVarVec2(imgui.StyleVar.FramePadding, imgui.ImVec2(-0.2, -0.2))
				imgui.BeginChild("selectedTab##"..i, childsize, 1, imgui.WindowFlags.MenuBar + imgui.WindowFlags.NoScrollbar)
				imgui.PopStyleVar()
				local name_section = self.functions[i].name
				if imgui.BeginMenuBar() then
					imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
					imgui.SetCursorPosY(imgui.GetScrollY() - 3)
					imgui.PushFont(font[12])
					imgui.Text(u8(self.functions[i].name))
					imgui.PopFont()
					imgui.PopStyleColor()
					imgui.EndMenuBar()
				end

				local time, dva, tri = timer.exist("job delay")

				if u8:decode(self.functions[i].name) == "работы" and time then
					imgui.SetCursorPos{60, 80}
					CircularProgressBar( ((dva) / tri * 100), 25, 5, tostring(math.floor(tri  - dva)))
				else
					local t = self.functions[i]
					
					local clipper = imgui.ImGuiListClipper(#t, imgui.GetTextLineHeightWithSpacing())
					if input:active() then
						for i = 1, #t do
						    b { t[i].name, t[i].icon, t[i].hint, t[i].func }
						end	
					else
						while clipper:Step() do	
							for i = clipper.DisplayStart + 1, clipper.DisplayEnd do
					
					
								b { t[i].name, t[i].icon, t[i].hint, t[i].func }

								if  cfg.debug and imgui.IsItemClicked(1) then
									local form = string.format(getWorkingDirectory()..'\\lib\\1sfa\\select\\%s\\%s.lua', name_section, t[i].name)
									os.execute('start explorer '..form)
									print('run '..form)
							
								end

								drag(index_section, i, function ()
									b { t[i].name, t[i].icon, t[i].hint, t[i].func }
								end, name_section)



							end
						end
					end
				end
				imgui.EndChild()
				imgui.SameLine(childp.x + childsize[1] + 4)
			end
		end
		imgui.PopStyleVar(1)
		imgui.PopStyleVar()

		if self.active.handle then

			imgui.Text(self.state)

			local l = ProcessLog
			if #l>0 then
				for i=1, #l do
					imgui.Text(u8(l[i]))
					imgui.SetScrollHereY(0)
				end
			end
		end

		
	end
}


