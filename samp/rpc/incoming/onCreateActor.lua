
require('lib.samp.events').onCreateActor = function(actorId, skinId, p, rotation, health)
	if skinId == 78 then
		-- placeWaypoint(p.x, p.y, p.z)
	end


	if skinId == 33 and cfg["�����"] ~= actorId then
		cfg["�����"] = actorId
		msg{'settings["�����"]', actorId}
		cfg()
	end
end