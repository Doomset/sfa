local getTargetBlipCoordinatesFixed = function()
	local bool, x, y, z = getTargetBlipCoordinates(); if not bool then return false end
	requestCollision(x, y); loadScene(x, y, z)
	return getTargetBlipCoordinates()
end

local timeout = function ()
    timer("abuse", 6)
end

IsCharSurfing = false
local lodka = function (x, y ,z)
    BlockSync = true
    SendSync{manual = "player", surf = cfg["Лодка"].id}; IsCharSurfing = true


   -- self.state = 'surfing///'
    timer('surf lodka', 1.2, function ()
        timeout(); BlockSync = false
        setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z + 1)
        restoreCameraJumpcut()
        --self.active.handle = false
        
    end)
end

local scan = require('sfa.samp.zona.AntiCheat').scan




return
{
    name = 'Телепорт по метке',
    icon = 'THUMBTACK',
    hint = [[Телепорт без варна(в теории)   ]],
    func =
    function(self)

        if not doesCharExist(PLAYER_PED) then return end
        local bool, x, y, z = getTargetBlipCoordinatesFixed()
        if not bool then return error('Поставь метку') end

        
        if timer.exist("abuse") then
            setCharCoordinates(1, x, y, z)
            return
        end

        local id = scan()
        if id ~= false then
            sampSendExitVehicle(id)
            setCharCoordinates(PLAYER_PED, x, y, z)
            timeout()
           -- self.active.handle = false
            return
        end

        lodka(x, y, z)
        -- if isCharInAnyCar(PLAYER_PED) then setCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED), x, y, z) else
        -- 	if getActiveInterior() ~= 0 then
        -- 		--sampSendInteriorChange(0)
        -- 		setCharInterior(PLAYER_PED, 0); setInteriorVisible(0)
        -- 	end
        -- 	setCharCoordinatesDontResetAnim(PLAYER_PED, x, y, z + 1)
        -- end
    end
}
