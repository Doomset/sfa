
return
{
    name = 'Заготовки2',
    icon = 'SCREWDRIVER',
    hint = [[нужно быть в гараже]],
    func =
    function()
        for i = 1, 5 do
            SendSync{ pos = {614.625 , -80.5 , 1497.875}, pick = 591}
        end
    end
}