

local imgui = require("mimgui")


local extra = require'sfa.imgui.extra'



local list = {
    [1] = {
        name = "визуал",
    },

    [2] = {
        name = "прочее",
    },

    [3] = {
        name = "автоматизация", 
    },

    [4] = {
        name = "необходимое", 
    }	
}


for k, v in ipairs{"визуал", "прочее", "автоматизация", 'необходимое'} do
	for _, v2 in ipairs(getFilesInPath("\\sfa\\select\\settings\\" .. v, '*.lua')) do
		table.insert(list[k], require('sfa.select.settings.' .. v .. '.' .. v2:gsub("%.lua", "")))
	end
end



local icon = "GEAR"
table.insert(Loaded_Icons, icon)





local t = {
    icon, "НАСТРОЙКИ", select = cfg.last.select['НАСТРОЙКИ'], functions = list, menu =
	function(self)
		imgui.PushStyleColor(imgui.Col.ChildBg, imgui.GetStyle().Colors[imgui.Col.MenuBarBg])
		imgui.PushStyleVarFloat(imgui.StyleVar.ChildRounding, 0)

		local seletable = function (label, select, f)

			if imgui.Selectable(u8(label), label == select, {120, 15}) then
				self.select = label
				
				self.select_funcs = f
				cfg.last.select['НАСТРОЙКИ'] = label
				cfg()
			end
		end

		

		imgui.SetCursorPosY(3)
		imgui.BeginChild("выбор вкладок - настройки", imgui.ImVec2(120, 287), true)
		imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0.1, 1))
		local b = imgui.new.bool(cfg.debug)
		if imgui.Checkbox('Debug', b) then
			cfg.debug = b[0]
			cfg()
		end
--		seletable('upd', self.select, update.gui)
		for k, v in ipairs(self.functions) do
			extra.Separator()
			imgui.SetCursorPosY(imgui.GetCursorPos().y  + 4)
			imgui.PushFont(font[13])
			imgui.Text(u8(v.name))
			imgui.PopFont()
			imgui.PushFont(font[15])
			for k2, v2 in ipairs(v) do
				seletable(v2[1], self.select, v2.func)

				if cfg.debug and imgui.IsItemClicked(1) then
					local line = debug.getinfo(1).currentline
					msg(line)
					os.execute(string.format('code --g "%s\\lib\\1sfa\\select\\settings\\%s\\%s.lua:1"', getWorkingDirectory(), v.name, v2[1]:trim()) )
				end

			end
			imgui.PopFont()
		end
		imgui.PopStyleVar()
		imgui.EndChild()
	
		imgui.PopStyleColor()
		imgui.PopStyleVar(1)
		imgui.SameLine(119)
	

		--imgui.SetCursorPosY(0)
		imgui.BeginChild("ввв", {425 + 15 - 30 + 10, 287}, true)
		imgui.PushFont(font[13]) 

		imgui.BeginChild("подокно вкладки", { (425 + 15 - 30 - 10 + 10) , 290 - 13}, false)
		if type(self.select_funcs) == "function" then
			
			local res, reason = pcall(self.select_funcs)
			if not res then imgui.Text(tostring(res)..'\n'..u8(reason or '')) end
			if reason then

				Noti(reason, ERROR)
				
				local name, reason2 = reason:match('(lib.+%.lua:%d+)(.+)')
				

				print(name, '\n', reason)


				if imgui.Button('go '..(reason2 or '?')) then
					os.execute(string.format('code --g "%s\\%s"', getWorkingDirectory(), name))
				end
			end


			
		end
		imgui.EndChild()

		imgui.PopFont()
		imgui.EndChild()
	end
}


local sel = function (skip)
	for k, v in ipairs(t.functions) do
		for k2, v2 in ipairs(v) do
			if v2[1] == t.select then
				t.select_funcs = v2.func
			end
		end
	end
end

sel()
	



return t
