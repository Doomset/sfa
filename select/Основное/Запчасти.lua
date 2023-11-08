
return
{
    name = 'Запчасти',
    icon = 'SUITCASE',
    hint = [[спавнит и делает 10 запчастей из гаража]],
    func =
    function()
        zapchastt = true
        spawn()
        wait(500)
        for i = 0,10 do wait(50)
        SendSync(614.5 , -71.75 , 1497.875, key, 593) end
        wait(500)
        zapchastt = false
    end
}