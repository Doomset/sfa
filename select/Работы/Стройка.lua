
return
{
    name = '�������',
    icon = 'SACK',
    hint = [[��������� ����� ������ ������ � ��� ������]],
    func =
    function()
        NoKick()

        handler('dialog', {t = '����������'})
        SendSync{pos = cfg['������']['-45.27'].pos, pick = cfg['������']['-45.27'].id}

        job(function()
            for i = 1, 12 do
                SendSync{pos = {-2387.1374511719 , 2365.0344238281 , 3.8995151519775}}
                SendSync{pos = {-2060.998046875 , 316.69290161133 , 1009.2188110352}}
            end
        end)
    end
}