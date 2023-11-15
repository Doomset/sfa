render_radar_art = {}
local imgui = require 'mimgui'


local icon = icon
lua_thread.create(function ()
    icon = require('sfa.imgui.icon')
end)

local ffi = require('ffi')

local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
local function GetBodyPartCoordinates(id, handle)
	local pedptr = getCharPointer(handle)
	local vec = ffi.new("float[3]")
	getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
	return vec[0], vec[1], vec[2]
end
local draw       = {
    radar_art = function()
        if not next(render_radar_art) then return end

        for k, v in pairs(render_radar_art) do
            local RadarX, RadarY = TransformRealWorldPointToRadarSpace(v[1], v[2], v[3])
            if IsPointInsideRadar(RadarX, RadarY) then
                local x, y = TransformRadarPointToScreenSpace(RadarX, RadarY)
                local size = imgui.ImVec2(12, 12)

                local p = imgui.ImVec2(x, y)

                imgui.GetForegroundDrawList():AddImage(texture[v[4]], { x - (size.x / 2), y },
                    imgui.ImVec2(p.x + (size.x / 1.5), p.y + (size.y)))
                imgui.GetBackgroundDrawList():AddImage(texture[v[4]], { x - (size.x / 2) + 1, y + 1 },
                    imgui.ImVec2(p.x + (size.x / 1.5), p.y + (size.y)), nil, nil, 0xFFFFFFFF)

                if sampIsCursorActive() then -- show text if ID hovered
                    local curX, curY = getCursorPos()
                    if curX > x - 12 / 2 and curX < x + 12 / 2 and curY > y and curY < y + 12 then
                        imgui.GetForegroundDrawList():AddImage(texture[v[4]], imgui.ImVec2(x - 64 / 2, y - 24),
                            imgui.ImVec2(x + 64 / 2, y + 32))

                        imgui.GetBackgroundDrawList():AddImage(texture[v[4]],
                            imgui.ImVec2((x - 64 / 2) + 1, (y - 24) + 1), imgui.ImVec2(x + 64 / 2, y + 32))

                        local text = tostring(v[4])

                        local tsize = imgui.ImVec2((x) - (imgui.CalcTextSize(text).x / 2), y - 12)

                        imgui.GetBackgroundDrawList():AddTextFontPtr(font[15], 15,
                            imgui.ImVec2({ tsize.x + 1, tsize.y + 1 }), 0xFF000000, text)

                        imgui.GetForegroundDrawList():AddTextFontPtr(font[15], 15, tsize, 0xFF000000, text)
                    end
                end
            end
        end
    end,

    indicatrs = function()
        local sX, sY = convert3DCoordsToScreen(GetBodyPartCoordinates(32, PLAYER_PED))
        for k, v in ipairs(core["Прочее"]["Синхра"]) do
            if  v[3] then
                local text = u8(v[1])
                local x = sX - 18 --(imgui.CalcTextSize(text).x - 20)
                icon.Icon({x, sY}, v[2], 14, imgui.GetBackgroundDrawList())
                sY = sY + 22
            end
        end
        --local id, state = ac.scan()
        --print(id, state )
       -- imgui.GetForegroundDrawList():AddTextFontPtr(font[12], 18, { sX, sY }, 0xFF000000, tostring(id)..tostring(state))

        
     --   handlerTimers()
    end




}


SetClipboardText = imgui.SetClipboardText



ffi.cdef('struct CVector2D {float x, y;}')
local CRadar_TransformRealWorldPointToRadarSpace = ffi.cast('void (__cdecl*)(struct CVector2D*, struct CVector2D*)', 0x583530)
local CRadar_TransformRadarPointToScreenSpace = ffi.cast('void (__cdecl*)(struct CVector2D*, struct CVector2D*)', 0x583480)
local CRadar_IsPointInsideRadar = ffi.cast('bool (__cdecl*)(struct CVector2D*)', 0x584D40)

local function TransformRealWorldPointToRadarSpace(x, y)
    local RetVal = ffi.new('struct CVector2D', {0, 0})
    CRadar_TransformRealWorldPointToRadarSpace(RetVal, ffi.new('struct CVector2D', {x, y}))
    return RetVal.x, RetVal.y
end
--TransformRadarPointToRealWorldSpace

local function TransformRadarPointToScreenSpace(x, y)
    local RetVal = ffi.new('struct CVector2D', {0, 0})
    CRadar_TransformRadarPointToScreenSpace(RetVal, ffi.new('struct CVector2D', {x, y}))
    return RetVal.x, RetVal.y
end

local function IsPointInsideRadar(x, y)
    return CRadar_IsPointInsideRadar(ffi.new('struct CVector2D', {x, y}))
end


local render_func = imgui.OnFrame(function() return isSampAvailable() end,
function(self)
    self.HideCursor = true; 
    timer.process()

    draw.indicatrs()
    

end)

local notifications = imgui.OnFrame(function() return isSampAvailable() and sampIsDialogActive() end,
function(self)
    local resX, resY = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY/2 - 155), 2, imgui.ImVec2(0.5, 0.5))
	imgui.Begin("dialog##", _, imgui.WindowFlags.NoDecoration + imgui.WindowFlags.AlwaysAutoResize)

	if imgui.Button("copy name") then
		local s = [[ SetClipboardText(u8(string.format("handler('dialog', {t = '%s'})",  sampGetDialogCaption())))]]
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


		local s = [[ SetClipboardText(u8(string.format("handler('dialog', {t = '%s', s = %d, i = '%s'})",  sampGetDialogCaption(), sampGetCurrentDialogListItem(), list)))]]
		loadstring(s)()
		print(s)

	end
	imgui.SameLine()	

	if imgui.Button("copy name id") then 
		local s = [[ SetClipboardText(  u8( string.format( 'handler("dialog", {t = "%s", id = "%d"} )', sampGetDialogCaption(), sampGetCurrentDialogId()) )  ) ]]
		loadstring(s)()
		print(s)
	end
    imgui.SameLine()
    if imgui.Button("res") then 
        NoKick()
        sampSendDialogResponse(sampGetCurrentDialogId(), 1, 1, '%n')
    end

	imgui.End()    
end)
