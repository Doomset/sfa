
local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

imgui.Button = require('sfa.imgui.icon').Button
local extra = require('sfa.imgui.extra')
imgui.Text =  extra.Text

imgui.Separator = extra.Separator

local que = cfg['Ѕинды'].que

local binds_from_settings = cfg['Ѕинды'].list



local gui = function ()
    local get_all_keys = function ()
        for index = 1, #binds_from_settings do    
            imgui.Text(u8(que[index]))


            for i, v in ipairs(binds_from_settings[index]) do

                local b =new.bool(v.on)
                if imgui.Checkbox('##'..i..index, b) then
                    cfg['Ѕинды'].list[index][i].on = b[0]
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
                imgui.Text(u8(v.name))
                imgui.SameLine()
                if imgui.Button('edit##'..i) then
                    Edit_bind ={i, v }
                    if v.keys ~= nil then imgui.StrCopy(Bind_buf, table.concat(v.keys)) end
                end
                imgui.Separator()

                
            end
        end
    end
    get_all_keys()
end


local load_string, table_sort, copy_table = loadstring, table.sort, function(t) return {table.unpack(t)} end






local list =
{
    dick =  copy_table(cfg['Ѕинды'].list), -- ссыль на список биндов с настроек

    hookKeys = function(self, keys_in_hook)

        local t = copy_table(self.dick)


        for i = 1, #t do
            local v = t[i]

            table_sort(v, function(a, b)
                if a.keys == nil or b.keys == nil then return false end
                --print( #a.keys , #b.keys)
                return (#a.keys > #b.keys)
            end)
        end
     

  

        for i = 1, #t do
            local v = t[i]

            local br = false
            
            for i, v in ipairs(v) do

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
                        Noti(v.name, INFO)
                        hot_list = self.dick;
                        br = true
                        break;
                    end
                end
            end
            if br then break; end
        end
    end
}


local hot = setmetatable(list, {
    __call = function(self, name, key, func, on)
        assert(name and key and func and on, "„ќ «ј ’”…Ќя Ќ≈ѕ–ј¬»Ћ№Ќџ≈ ј–√”ћ≈Ќ“џ")
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
        cfg['Ѕинды'][Edit_bind[1]] = Edit_bind[2]
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





return  {"Ѕиндики", "ќтключить затемнение в метро и черный экран от сна", func = gui}