
return
{
    name = '�����',
    icon = 'FIRE',
    hint = [[��������� ������ ������ ����� � ������� ����� 5 - 1 ��]],
    func =
    function()
        for i = 1, 3 do
            SendSync{pos = {2147 , -2255 , 13}, pick = 714}

            SendSync{pos = {2147, -2255, 13}, pick = 713}
            SendSync{pos = {2147 , -2255 , 13}, pick = 712}
            SendSync{pos = {2147 , -2255 , 13}, pick = 715}
            SendSync{ pos = {1619, 2209, 11}, pick = cfg['������']['3839'].id, force = true} -- ����

            SendSync{pos = {1782.5705566406, 2115.5239257813, 3.90625}, key = 1024}
        end
    end
}