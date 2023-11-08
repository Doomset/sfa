
return
{
    name = 'Аптечки',
    icon = 'PILLS',
    hint = [[Учёным, заспавиться и сделать аптечки]],
    func =
    function()
        apt = true
        spawn()
        SendSync(280 , 1873.125 , 8.75, key, 402)
        wait(500)
        spawn()
        apt = false
    end
}