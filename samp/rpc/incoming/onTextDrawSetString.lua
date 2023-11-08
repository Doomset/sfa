
require('lib.samp.events').onTextDrawSetString = function(id, text)
	for k, v in pairs(ds) do
		if text:find(v.n) then
			local res, _, i = text:find("%w+ (%d+)")

			if tonumber(i) >= 80 and v.on then
				if sampIsDialogActive() then return end
				Инвентарь( v.n == "rad" and 8 or 10 )
			end

		end
	end
end