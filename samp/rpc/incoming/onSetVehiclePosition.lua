
require('lib.samp.events').onSetVehiclePosition = function(vehicleId, pos)
	print("onSetVehiclePosition ������ ��������� ������� ",pos.x, pos.y, pos.z, shortPos(pos.x, pos.y, pos.z))
	if BlockSyncJob then return false end
end