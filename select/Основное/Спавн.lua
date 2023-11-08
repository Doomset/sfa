
return
{
    name = 'Спавн',
    icon = 'ROTATE',
    hint = [[Заспавнит, если в тачке - выкинет и заспавнит]],
    func =
    function()
        local str = "sampSendSpawn()"
        loadstring(str)()
    end
}