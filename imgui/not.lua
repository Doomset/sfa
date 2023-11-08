


local imgui = require("mimgui")
local extra = require('sfa.imgui.extra')

local Notifications = {}

INFO, OK, WARN, ERROR = 1,2,3,4
Noti = function (text, type)
    print(text)
    table.insert(Notifications, {text = text, type = type or INFO,  clock = os.clock(), remove = false, size = size or 1})
end



local type_colors = {
    --[[INFO]]  [1] = {0.24, 0.55, 0.84, 1},
    --[[OK]]    [2] = {0.14, 0.71, 0.2, 1},
    --[[WARN]]  [3] = {0.93, 0.5, 0, 1},
    --[[ERROR]] [4] = {0.73, 0.01, 0.01, 1},
}

-- EXPORTS.type_icons = {
--     --[[INFO]]  [1] 
-- }

local icons = {"INFO", "CHECK", "EXCLAMATION_TRIANGLE", "XMARK"}

for k, v in ipairs(icons) do table.insert(Loaded_Icons, v) end


local lastwindsize = 1
local Rem = false


local icon = require('sfa.imgui.icon').Icon

local frame = imgui.OnFrame(function() return #Notifications > 0 end,
function(s)
    s.HideCursor = true

    local resX, resY = getScreenResolution()
    local y = resY - 300

    local create_window = function(index, text, type, clock, del, size)
        local alpha = extra.bringFloatTo(del and 1 or 0, del and 0 or 1, del or clock, 0.2)

        y = y - alpha* size
        local pos = {alpha * 30,  y}

        imgui.SetNextWindowPos(pos, 1, {0, 0})
        imgui.PushStyleVarFloat(0, alpha)
        imgui.PushStyleColor(imgui.Col.WindowBg, type_colors[type])
        imgui.Begin('not'..index, _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
        local text = u8(tostring(text))
       
       -- imgui.Text(tostring(#Notifications))
    
  
        local p = imgui.GetCursorScreenPos()


      --  imgui.SetCursorPos{20, 7}
       local v = Notifications[index]

        imgui.PushFont(font[14])
        imgui.PushTextWrapPos( 400)

        imgui.Dummy{5, 1}
        imgui.Dummy{20, 1}
        imgui.SameLine()
        imgui.Text(text); 
        if imgui.IsItemClicked(0) and v.remove == false  then v.remove = os.clock() end
        imgui.SameLine()
        imgui.Dummy{20, 1}
        imgui.Dummy{5, 1}

       
        imgui.PopTextWrapPos()
        imgui.PopFont()

 
        icon({p.x + 5, p.y + 14/2}, icons[type], 15)

        v.size = imgui.GetWindowSize().y + 3




      --  msg(lastwindsize)

        imgui.End()
        imgui.PopStyleColor()
        imgui.PopStyleVar()
        
        
    end




    for i = #Notifications, 1, -1 do
        local v = Notifications[i]
        local timer = (os.clock() - v.clock) > 3

        if timer and v.remove == false then v.remove = os.clock() end

        create_window(i, v.text, v.type, v.clock, v.remove, v.size)
    end

    
    --if Rem ~= false then table.remove(Notifications, Rem) Rem = false end


end)

return add