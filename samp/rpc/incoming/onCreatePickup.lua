
require('lib.samp.events').onCreatePickup = function(id, model, pickupType, pos)

	local pick_data = cfg["Пикапы"][tostring(shortPos(pos.x, pos.y, pos.z))]

	if pick_data and pick_data.id ~= id then
		Noti(pick_data.name.." перезаписан!")
		cfg["Пикапы"][tostring(shortPos(pos.x, pos.y, pos.z))].id = id
		cfg()
	end

	-- if (model == 1213 or model == 1602 or model == 701 or model == 1239) and render_radar_art[id] == nil then
	-- 	render_radar_art[id] = {pos.x, pos.y, pos.z, model}
	-- end

	-- if (model == 1213 or model == 1602 or model == 701) and арты_для_сбора[id] == nil and (shortPos(pos.x, pos.y, pos.z) ~= 1283.12) and (shortPos(pos.x, pos.y, pos.z) ~= 2960.62) then
	-- 	арты_для_сбора[id] = {pos.x, pos.y, pos.z}
	-- end
end