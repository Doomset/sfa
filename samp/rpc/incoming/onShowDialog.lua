local dialogs = {}


require('lib.samp.events').onShowDialog = function(id, style, title, button1, button2, text)
	-- if not dialogs[id] then
	-- 	dialogs[id] = title
	-- elseif dialogs[id] then
	-- 	Noti('DIALOG EXIST !!!!! '.. title..id, INFO)
	-- end

	if title:find('�������') then

	
	    -- ('������� %(���� ������%)')
		-- ('��������� %(���� ������%)')
		-- ('��� (���� ������)')
		-- ('����� %(���� ������%)')
		-- ('���������� %(���� ������%)')
		-- ('������� %(���� ������%)')
	end


	

	-- if id == 6 then
	-- 	list_inv = {}
	-- 	for line in text:gmatch('[^\n]+') do
	-- 		list_inv[#list_inv + 1] = line
	-- 	end

	-- 	inventar.switch()
	-- 	sampSendDialogResponse(id, 0, -1, "")
	-- 	return false
	-- end

	if text:find('��� ��� �������� � ����� ���') then
		attempt_to_login = attempt_to_login + 1
		msg(attempt_to_login..' ������� �����')
	elseif text:find('���� �� �����, �� ������ ����!') then
		attempt_to_login = 0
	end

	

	for k, v in ipairs(cfg["�������"]["������"]) do
		if v.on and title:find(v.title) then
			sampSendDialogResponse(id, v.button, v.select, v.input)
			print('settings["�������"]["������"]', "������ ����� ������� ", id, v.button, v.select, v.input)
			return false
		end
	end

	if cfg["����������"]["�������"]["������ �����"] and title:find("������� ������������") then
		local t = timer.exist("�����")

		timer("���� � ������", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = '���������'})
			handler('dialog', {t = '������� ���������', s = 2, i = '���������� ��������'})
			--timer.exist(@) ��� �� �������� �� ���� ����������
			sampSendChat("/�����")
		end)
		return false
	end


	if ������:����(title, text, id) then return false end

	if title:find("�����������") then
		������.������["�������"], ������.������["���������"] = text:match("�������	(%d+)"), text:match("���������	(%d+)")
	elseif title:find("��������") then
		������.������["��������"], ������.������["�����"] = text:match("��������	(%d+)"), text:match("�����	(%d+)")
	elseif title:find("���������") then
		������.������["����"] = text:match("����	(%d+)")
	elseif title:find("�����������") then
		������.������["���������"], ������.������["��������"], ������.������["�������"] = text:match("���������	(%d+)"), text:match("��������	(%d+)"), text:match("�������	(%d+)")
	end

if handler.has("dialog", {id, title}) then return false end

	local f = title
	if cfg["����������"]["������"] and ( f:find('���� �����������') or f:find('�������� ��� ���������') or f:find('����������� ��������') or f:find('���� �����') ) then


		if attempt_to_login ~= 0 and f:find('���� �����') then msg('�� ���������� ������, ��������� ������ �� ��������� ����') cfg["����������"]["������"] = false return end

		if cfg["����������"]["����� ���"].on then sampSendDialogResponse(id, 1, -1, f:find('����������� ��������') and " " or cfg["����������"]["����� ���"].pass) print("AUTOLOGIN") return false end
		local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))


		for k, v in ipairs(cfg["����������"]["�������"]["����"]) do
			if v.on and (string.lower(v.nick) == string.lower(sampGetPlayerNickname(myid))) then
				print("AUTOLOGIN")
				sampSendDialogResponse(id, 1, -1, f:find('����������� ��������') and " " or v.pass)
				return false
			end
		end
	end
end

