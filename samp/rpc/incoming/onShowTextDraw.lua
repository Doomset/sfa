
require('lib.samp.events').onShowTextDraw = function(id, data)
	local ez = data.position.x + data.position.y
	local ind = ds[ez]
	if ind then
		local res, _, i = data.text:find("%w+ (%d+)")
		if tonumber(i) >= 80 and ind.on then
			if sampIsDialogActive() then return end
			���������( ind.n == "rad" and 8 or 10 )
		end
		if cfg[ind.n]["��"] ~= id then cfg[ind.n]["��"] = id; msg{"���������� ", ind.n}; cfg() end
	end

	if ez == 945 then indicatorArts = id end

	if ez == 2 and cfg["����� � ���"]["�������"]["����������"] then addConsole('["����� � ���"]["�������"]["����������"]', "������������ ��������� � �����������") return false end



	if ez == 201 and cfg["���������"]["�������"] ~= id then
		cfg["���������"]["�������"] = id -- �������
		addConsole("��������� ���������� �������")
		cfg()
	elseif ez == -50 and cfg["���������"]["������� �������"] ~= id then
		cfg["���������"]["������� �������"] = id -- �������
		addConsole("��������� ���������� �����")
		cfg()
	end

	if (data.position.x == 16 and data.position.y == -20) and cfg["���������"]["������"] then
		if blockNextTd then blockNextTd = nil return false end
		if cfg["���������"]["�������"]["��������"] < 0.01 then sampSendClickTextdraw(cfg["���������"]["�������"]) return end
		timer('seif', cfg["���������"]["�������"]["��������"], function ()
			sampSendClickTextdraw(cfg["���������"]["�������"])
		end)
	end

	if id == 2069 then
		SendSync{key = 1024}
	end

end