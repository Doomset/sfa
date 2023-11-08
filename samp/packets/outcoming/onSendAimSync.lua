require('lib.samp.events').onSendAimSync = function(data)
	if BlockSync or SendSyncBlock or BlockSyncJob or loadplace then return false end
end