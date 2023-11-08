
require('lib.samp.events').onDestroyPickup = function(id)
	if render_radar_art[id] then
		render_radar_art[id] = nil
	end
end