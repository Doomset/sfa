
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



	if ez == 2 and cfg["����� � ���"]["�������"]["����������"] then print('["����� � ���"]["�������"]["����������"]', "������������ ��������� � �����������") return false end

	

	

	-- if id == 2069 then
	-- 	SendSync{key = 1024}
	-- end

end