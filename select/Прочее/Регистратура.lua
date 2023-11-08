
return
{
    name = 'Регистратура',
    icon = 'PILLS',
    hint = [[Протеин,не кикает, варнит]],
    func =
    function()
        SendSync{ pos = {324, 1832, 6}, pick = cfg['Пикапы']['2162.01'].id, force = true}
    end
}