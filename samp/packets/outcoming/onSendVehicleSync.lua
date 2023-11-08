require('lib.samp.events').onSendVehicleSync = function(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end

    if core["Прочее"].Синхра[6][3] then
		data.quaternion[0] = 1/0
		data.quaternion[1] = 1/0
		data.quaternion[2] = 1/0
		data.quaternion[3] = 1
	end

end
