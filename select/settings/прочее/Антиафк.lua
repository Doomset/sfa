local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')


local mem = require('memory')
script_properties("work-in-pause")

local WorkInBackground = function(on)
    if on then
		mem.setuint8(7634870, 1, false)
		mem.setuint8(7635034, 1, false)
		mem.fill(7623723, 144, 8, false)
		mem.fill(5499528, 144, 6, false)
    else
        mem.setuint8(7634870, 0, false)
		mem.setuint8(7635034, 0, false)
		mem.hex2bin('0F 84 7B 01 00 00', 7623723, 8)
		mem.hex2bin('50 51 FF 15 00 83 85 00', 5499528, 6)
	end
end



local gui = function ()
    local bool = new.bool(cfg["�������"]["������"])

    local state = mem.getuint8(7634870, false)

    extra.centerText('������ '..state, 30)


    extra.centerText('���� ���, ������� ������������ ����� ���� ��������')

    if imgui.Checkbox(u8("�������"), bool) then
        cfg["�������"]["������"] = not cfg["�������"]["������"]; cfg()
        if not bool[0] then WorkInBackground(false) end
    end
end



local wm = require('lib.windows.message')
addEventHandler("onWindowMessage", function(m)
	if(m == wm.WM_KILLFOCUS or m == wm.WM_SETFOCUS) then
		if cfg["�������"].������ then
			WorkInBackground(m == wm.WM_KILLFOCUS)
        end
	end
end)


return {"�������", "�� ��� � ��� ��� �������", func = gui}