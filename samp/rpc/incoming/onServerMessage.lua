
attempt_to_login = 0
require('lib.samp.events').onServerMessage = function(color, text)
	lastservermsg = {color = color, text = text}

	
	if IsCharSurfing and text == '����� � �����' and color == -1439485014 then
		cfg["�����"].block = true
		cfg()
	end

	if text:find('��� �������') and color == -1439485014 then
	end

	 if cfg["����������"]["�������"]["�����"] and color == 267386880 and text:find("�� ������ � ���� � �������� ��������") then
		local t = timer.exist("���� � ������")
		timer("�����", t and t + 1.1 or 0.0, function()
			handler('dialog', {t = '���������'})
			handler('dialog', {t = '������� ���������', s = 2, i = '���������� ��������'})
			--timer.exist(@) ��� �� �������� �� ���� ����������
			sampSendChat("/�����")
		end)
		return false
	end

	if text:find("����� ���������� � ����") then
		attempt_to_login = 0
	end


	if color == 267386880 and text:find("�� ��������� %d+$ %+ %d+$ ����� �� �������") then
		timer("job delay", 61)
		if BlockSyncJob then

		--	msg{BlockSyncJob, "BlockSyncjob"}
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		elseif BlockSyncJob and text == '�� ������� ������!' and color == -1439485014 then
			BlockSyncJob = false
			msg("BlockSyncJob = false")
		end
	end

	for k, v in ipairs(cfg["����"]["������"]) do
		if text:find(v.text) and color == v.color then
			print('settings["����"]["������"]', "ServerMessage block", color, text)
			return false
		end
	end

	print (string.format("handler('onServerMessage', {text = '%s', color = %d})", text, color))

	if text == '����� ����������� ��� ��� ������� .����������' and color == 267386880 and cfg["����� � ���"]["�������"]["����������"] then
		sampSendChat("/����������")
		print("/����������", '[����� � ���"]["�������"]["����������"]')
	end

	if handler.has("onServerMessage", {color, text}) then return false end

	if text:find('� ��� ��� ����������. ������ ��� � ����� ������') and color == -1439485014 and ds[685].on then ds[685].on = false return {color, "��������� ��������"}
	elseif text:find('� ��� ��� ���. ������ � � ����') and color == -1439485014 and ds[605].on then ds[605].on = false return {color, "��� ���������"} end
end