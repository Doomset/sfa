
return
{
    name = '��������',
    icon = 'SUITCASE',
    hint = [[������� � ������ 10 ��������� �� ������]],
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