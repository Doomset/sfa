�����_������ = function()
    if not sampIsDialogActive() then return end
    sampCloseCurrentDialogWithButton(0)
end



��������� = function(n)
    SendSync { key = 64 } --- �������� ���������
    handler('dialog', { t = '������', s = n - 1, i = '' })
end



�����_���� = function()
    if not ������:�����() then ��������(3) end

    local ����� = ������:�����().�����������
    msg(�����)
    NoKick()

    if ����� == "��������" then
        handler('dialog', { t = '���������', s = 6, i = '����� ��� ���������' })
        SendSync { pos = { 419, 2543, 10 }, pick = cfg['������']['2971.19'].id, force = true }
    end
end



������� = function(n)
    local frak = { "�������", "��������", "�������" }

    if type(n) == "string" then
        for k, v in ipairs(frak) do
            if v:find(n:lower()) then
                handler('dialog', { t = '�����', s = 8 + k, i = '' })
            end
        end
    else
        handler('dialog', { t = '�����', s = 8 + n, i = '' })
    end

    handler('dialog', { t = '' })


    SendSync { pos = { -92, 1027, 1516 }, pick = cfg['������']['2450.93'].id, force = true }
end

��� = function(n)
    handler('dialog', { t = '���� ����', s = n - 1, i = '' })
    sampSendChat("/���")
end

������ = function(n)
    ���������(20)
    handler('dialog', { t = '������', s = n - 1, i = '' })
end



��������� = function(n)
    handler('dialog', { t = '�����', s = n - 1, i = '' })
end



������� = function(n)
    sampSendChat("/�������")
    handler('dialog', { t = '�������', s = n - 1, i = '' })
end



������ = function(n)
    handler('dialog', { t = '�����', s = n - 1, i = '' })
    SendSync { pos = { -1058.375, -1205.375, 129.125 }, pick = cfg['������']['-2134.68'].id }
end


local lasng = {[" "] = " ",['`'] = '�', ['~'] = '�', ['q'] = '�', ['w'] = '�', ['e'] = '�', ['r'] = '�', ['t'] = '�', ['y'] = '�', ['u'] = '�', ['i'] = '�', ['o'] = '�', ['p'] = '�', ['['] = '�', ['{'] = '�', [']'] = '�', ['}'] = '�', ['a'] = '�', ['s'] = '�', ['d'] = '�', ['f'] = '�', ['g'] = '�', ['h'] = '�', ['j'] = '�', ['k'] = '�', ['l'] = '�', [';'] = '�', ["'"] = '�', ['"'] = '�', ['z'] = '�', ['x'] = '�', ['c'] = '�', ['v'] = '�', ['b'] = '�', ['n'] = '�', ['m'] = '�', ['<'] = '�', [','] = '�', ['>'] = '�', ['.'] = '�'}
local lasen = {}
for k, v in pairs(lasng) do
	lasen[v] = k
end
local insert, concat, lower = table.insert, table.concat, string.lower
local function RusToEng(tex, en)
    local str, word  = {}
    for i = 1, #tex do
        word = (lower(tex)):sub(i, i)
        insert(str, (en and lasen or lasng)[word] or word)
	end; return concat(str)
end

local weapons = require 'game.weapons'

weapons.names[44] = nil; weapons.names[45] = nil
����� = function(par)
    local f, q, w = RusToEng(par, true):lower()
    if f:isEmpty() then return msg("����� �� ��� �������� �����") end

    for k, v in pairs(weapons.names) do
        q, w = v:lower(), k
        if q:find(f) or w == tonumber(f) or (string.getSimilarity(q, f) > 0.7) then
            NoKick()
            requestModel(getWeapontypeModel(k)); loadAllModelsNow()
            giveWeaponToChar(1, k, 99999)
            return msg { "����� ��� - " .. v, "�� " .. k }
        end
    end
    return msg("�� ����� " .. f)
end






�������_���_������� = function(�������, �)
	handler('dialog', {t = '������������', s = ������� and 1 or 2, i = ''})
	handler('dialog', {t = ������� and '������� �������' or '������� ����������', s = � and 0 or 1, i = ''})
	handler('dialog', {t = '������������', s = 1, i = '', button = 0})

	if � then handler('dialog', {t = ������� and '������� �������' or '������� ����������', button = 0, i = ''}, 3) end

	SendSync{pos = {324, 1832, 6}, pick = cfg['������']['2162.01'].id, force = true}
end



���_���_����� = function(eda, n)
	handler('dialog', {t = '���', s = eda and 1 or 0, i = ''})
	handler('dialog', {t = eda and '������� ���' or '������� �����', s = � and 0 or 1, i = ''})
	handler('dialog', {t = '���', s = 1, i = '������ ��� (100$)', button = 0})
	SendSync{pos = {-224.875, 1407.5, 27.75}, pick = cfg['������']['1210.47'].id, force = true}
end



������_��������� = function(n)
	handler('dialog', {t = '�����', s = 0, i = '������ �������� (300$)'})
	handler('dialog', {t = '������� ���������� (300$)', s = -1, i = n and tostring(n) or '25'})
	handler('dialog', {t = '�����', button = 0})
	SendSync{pos = {615.625, -72, 997.875}, pick = cfg['������']['1541.55'].id, force = true}
end






�������� = function(n)
	local w = sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) + ((n * 1000) + 10)
	msg(w)
	return wait(w)
end


-- ������� = {
-- 	d = {
-- 		{n ="��� �� ������� �������", act = function() 
-- 			handler('dialog', {t = '�������� ��', s = 10})
-- 			SendSync{ pos = {745, 1440, 1103}, pick = cfg['������']['3287.9'].id, force = true}
-- 		end},


-- 		{n ="�����", act = function() sampSendChat("/�����") end},

--handler('onServerMessage', {text = '��������� ������ �������� ���� �� �������! ���� ����� ��������.', color = 267386880})


-- 	},


-- 	--sampSendChat("/�������")

-- }
-- -- function()


-- end
������ = {
    ������ = {
        -- ����
        ["�������"] = nil,
        ["���������"] = nil,
        ["��������"] = nil,
        ["��������"] = nil,
        ["�����"] = nil,
        ["����"] = nil,
        ["���������"] = nil,
        ["��������"] = nil,
        ["�������"] = nil,
        --������
        ["��������"] = nil,
        ["�����"] = nil,
        ["������"] = nil,
        ["���������"] = nil,
        ["��������"] = nil,
        --�����
        ["�����������"] = nil,
        ["������� �������"] = nil,
        ["������"] = nil,
        ["����"] = nil,
    },
    ������ = false,

    ��������� = function(self, n)
        self.������ = true; ���������(1)
        for select = 1, n and n or 4 do
            handler('dialog', { t = '���������', s = select, i = '' }, 5)
        end
    end,

    ������ = function(self)
        self.������ = true; ���������(3);
    end,

    ����� = function(self)
        ;
        if self.������["�����������"] == nil then
            self.������ = true; ���������(2);
            return
        end
        ;
        return self.������
    end,

    ���� = function(self, title, text, id)
        if title:find('���� �����') then
            self.������["�����������"] = text:match("�����������: ([�-�]+)")
            self.������["������� �������"] = text:match("������� �������: (%d+)")
            self.������["������"] = text:match("������ (%d+)")
            self.������["����"] = text:match("����� � ����: (%d+)")
            if self.������ then
                self.������ = false
                sampSendDialogResponse(id, 1, -1, "")
                return true
            end
        elseif title:find("������") then
            self.������["��������"] = text:match("�������� 	(%d+)")
            self.������["�����"] = text:match("����� 	(%d+)")
            self.������["������"] = text:match("������ 	(%d+)")
            self.������["���������"] = text:match("��������� 	(%d+)")
            self.������["��������"] = text:match("�������� 	(%d+)")
            if self.������ then
                self.������ = false
                msg(self.������)
                sampSendDialogResponse(id, 1, -1, "")
                return true
            end
        end

        if self.������ then
            if (title:find("�����������") or title:find("��������") or title:find("���������") or title:find("�����������")) then
                lua_thread.create(function()
                    wait(sampGetPlayerPing(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) + 300)
                    if title:find("�����������") then
                        self.������["�������"], self.������["���������"] =
                        text:match("�������	(%d+)"), text:match("���������	(%d+)")
                        ���������(1)
                    elseif title:find("��������") then
                        self.������["��������"], self.������["�����"] =
                        text:match("��������	(%d+)"), text:match("�����	(%d+)")
                        ���������(1)
                    elseif title:find("���������") then
                        self.������["����"] = text:match("����	(%d+)")
                        ���������(1)
                    elseif title:find("�����������") then
                        self.������["���������"], self.������["��������"], self.������["�������"] =
                        text:match("���������	(%d+)"), text:match("��������	(%d+)"),
                            text:match("�������	(%d+)")
                        ���������(1); msg(4)
                        self.������ = false
                        handler('dialog', { t = '���������', button = 0 }, 5)
                    end
                end)
                return true
            end
        end
    end
}



����� = function(id, gun)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteBool(bs, false) -- bool
    raknetBitStreamWriteInt16(bs, shluxa) -- actor id
    raknetBitStreamWriteFloat(bs, 1)   --damage
    raknetBitStreamWriteInt32(bs, gun) -- flowers
    raknetBitStreamWriteInt32(bs, 3)   -- tors
    raknetSendRpc(177, bs); raknetDeleteBitStream(bs)
end



����� = function(x, y)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteFloat(bs, x)
    raknetBitStreamWriteFloat(bs, y)
    raknetSendRpc(119, bs); raknetDeleteBitStream(bs)
end


��� = function()
    SendSync { pos = { 2224.4074707031, -1153.4415283203, 1025.796875 }, key = 1024, force = true }
end





-- ������� = {
-- 	d = {
-- 		{n ="��� �� ������� �������", act = function()
-- 			handler('dialog', {t = '�������� ��', s = 10})
-- 			SendSync{ pos = {745, 1440, 1103}, pick = cfg['������']['3287.9'].id, force = true}
-- 		end},


-- 		{n ="�����", act = function() sampSendChat("/�����") end},

--handler('onServerMessage', {text = '��������� ������ �������� ���� �� �������! ���� ����� ��������.', color = 267386880})


-- 	},


-- 	--sampSendChat("/�������")

-- }
-- -- function()


-- end
������ = function(n)
    handler('dialog', { t = '������', s = n - 1 })
    SendSync { pos = { 580, 874, 949 }, pick = cfg['������']['2403.74'].id, force = true }
end
