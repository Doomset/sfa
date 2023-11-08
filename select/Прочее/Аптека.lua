
return
{
    name = 'Аптека',
    icon = 'ICON_CAPSULES',
    hint = [[Регистратура, не кикает, варнит]],
    func =
    function()
        SendSync{pos = {-224.875 , 1407.5 , 27.75}, pick = cfg["Пикапы"]["1210"].id, force = true}
    end
}