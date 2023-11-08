
require('lib.samp.events').onVehicleStreamIn = function(vehId, data)
lua_thread.create(function()
    wait(0)
    local res, handle = sampGetCarHandleBySampVehicleId(vehId)
    if res and isCarInArea2d(handle, 1270, -2564, 1223, -2489, false) then
        cfg["Лодка"].id = vehId
        cfg()
    end
end)
end