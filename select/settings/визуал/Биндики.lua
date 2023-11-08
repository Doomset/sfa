
local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

imgui.Button = require('sfa.imgui.icon').Button
local extra = require('sfa.imgui.extra')
imgui.Text =  extra.Text

imgui.Separator = extra.Separator

local binds_from_settings = cfg['Биндики']['Список']



local gui = function ()

    
    local get_all_keys = function ()
    

    




    for i, v in ipairs(binds_from_settings) do
        

        if imgui.Checkbox('##'..i, new.bool(v.on)) then
            v.on = not v.on
            cfg['Биндики']['Список'][i].on = v.on
            cfg()
        end
        imgui.SameLine()
        if v.keys then
            for k, v2 in ipairs( (Edit_bind[2] and Edit_bind[2].name == v.name) and Edit_bind[2].keys or v.keys) do
                imgui.Button(v2)

                if k ~= #v.keys then imgui.SameLine(nil, 3) end
            end
        else
            imgui.Button('-')
        end
        
        imgui.SameLine()

        
        -- if Edit_bind[1] == i then
        --     os.clock()
        -- end


        imgui.Text(u8(v.name))


        imgui.SameLine()
        if imgui.Button('edit##'..i) then
            Edit_bind ={i, v }
            if v.keys ~= nil then imgui.StrCopy(Bind_buf, table.concat(v.keys)) end
        end
        imgui.Separator()

--        if  Edit_bind[2] and Edit_bind[2].name == v.name then imgui.InputText('', Bind_buf, sizeof(Bind_buf), imgui.InputTextFlags.ReadOnly) end
    end

    end
    
    get_all_keys()

    -- if imgui.BeginPopupModal('addhot', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize) then

    -- ---	if  then
    --         --settings["Спам"]["Строки"][k] = u8:decode(str(hotname))
    -- --	end
    --     imgui.InputText("##name", hotname, sizeof(hotname))

    --     imgui.InputTextMultiline('##lecteditortext', hotactrion, sizeof(hotactrion), imgui.ImVec2(400, 300))

    -- --  imgui.InputTextWithHint('##imgui.InputTextWithHint', 'Big Text Hint Fuck Me', hotactrion, sizeof(hotactrion))

        
    --     imgui.SetCursorPos(imgui.GetCursorPos())
    --     imgui.Text("dsdsdds")


    --     if imgui.Button("ADD", {300, 15}) then
    --         imgui.CloseCurrentPopup()
    --         hot{
    --             key = "Esc",
    --             name = u8:decode(str(hotname)),
    --             func = u8:decode(str(hotactrion)),
    --             on = false,
    --         }
    --         cfg()
                
    --     end

    --     imgui.EndPopup()
    -- end
   
end

--[[
    модуль хоткеев без соблюдения порядка нажатых клавиш
]]
-- local req = require("mimgui")

-- local imgui = {}
-- package.loading["mimgui"] = nil
local load_string, table_sort, copy_table = loadstring, table.sort, function(t) return {table.unpack(t)} end







local list =
{
    dick = binds_from_settings, -- ссыль на список биндов с настроек

    hookKeys = function(self, keys_in_hook)

        local t = copy_table(self.dick)


        

        table_sort(t, function(a, b)
           if a.keys == nil or b.keys == nil then return false end
           return (#a.keys > #b.keys)
        end)

  

        for i = 1, #t do
            local v = t[i]

            if v.on and v.keys and not sampIsChatInputActive() and not sampIsDialogActive() then
                local sovp, savp2 = #v.keys, 0
                for i = 1, #keys_in_hook do
                    for i2 = 1, #v.keys do
                        if keys_in_hook[i] == v.keys[i2] then
                            savp2 = savp2 + 1
                            break
                        end
                    end
                end
                if sovp == savp2 then
                    local res, reason = pcall(load_string(v.func))
                    if reason then Noti(reason, INFO) end
                    ot_list = self.dick;
                    break;
                end
            end
        end
    end
}


local hot = setmetatable(list, {
    __call = function(self, name, key, func, on)
        assert(name and key and func and on, "ЧО ЗА ХУЙНЯ НЕПРАВИЛЬНЫЕ АРГУМЕНТЫ")
        msg("add " .. name)
        rawset(self, #self + 1, { name = name, key = key, func = func, on = on })
        return true
    end,
})

local wm  = require('lib.windows.message')
local event_down = {
    [wm.WM_MOUSEWHEEL] = '',
    [wm.WM_KEYDOWN] = '',
    [wm.WM_SYSKEYDOWN] = '',
    [wm.WM_RBUTTONDOWN] = '',
    [wm.WM_LBUTTONDOWN] = '',
    [wm.WM_MOUSEWHEEL] = '',
    [wm.WM_MBUTTONDOWN]  = '',
}

local event_up = {
    [wm.WM_KEYUP] = '',
    [wm.WM_SYSKEYUP] = '',
    [wm.WM_RBUTTONUP] = '',
    [wm.WM_LBUTTONUP] = '',
    [wm.WM_XBUTTONUP] = '',
    [wm.WM_MOUSEWHEEL] = '',
    [wm.WM_MBUTTONUP] = '',
}


local keys_down, down_keys_limit = {}, 5
local is_key_down, get_key_name, null = isKeyDown, require("vkeys").id_to_name,

function()
    keys_down = {}
    if Edit_bind[2] ~= nil then
        msg(Edit_bind)
        cfg['Биндики']['Список'][Edit_bind[1]] = Edit_bind[2]
        Edit_bind[2] = nil
    end
end



Edit_bind = {name = nil}
Bind_buf = imgui.new.char[128]()


local bit = require'bit'
addEventHandler("onWindowMessage", function(message, wparam)

    if event_down[message] then
        if #keys_down < down_keys_limit then
            local find, sh = false, get_key_name(wparam)
            for i = 1, #keys_down do
                if keys_down[i] == sh then
                    find = true; break
                end
            end
            if not find then
                keys_down[#keys_down + 1] = sh

                if Edit_bind[2] then Edit_bind[2].keys = keys_down end
            end
        else
            null()
        end
    end

    if #keys_down > 0 and event_up[message] then
        local keys_up = {}
        for i = 1, 254 do
            if is_key_down(i) then
                if i ~= VK_CONTROL and i ~= VK_MENU and i ~= VK_SHIFT then
                    keys_up[#keys_up + 1] = get_key_name(i)
                end
            end
        end
        if Edit_bind.name == nil then hot:hookKeys(keys_up) end
        null()
    end

    if message == wm.WM_KILLFOCUS then null() end
end)





return  {"Биндики", "Отключить затемнение в метро и черный экран от сна", func = gui}