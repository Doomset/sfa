 --  handler('dialog', {t = '������', s = 1})
-- handler('dialog', {t = '����'}) -- ��������� ������ � �������??!!?!!
-- handler('dialog', {t = '���� �����'})dd
return
{
    name = '�����-�����',
    icon = 'BANANA',
    hint = [[��������� ��������]],
    func =
    function()
        handler('dialog', {t = '������', s = 1})
        handler('dialog', {t = '���� �����', s = 0, button = 0})
        SendSync{ pos =  cfg['������']['3857.18'].pos,  pick = cfg['������']['3857.18'].id, force = true, specialKey = 1}
        SendSync{ pos = {288, -112, 1102}, pick = cfg['������']['1277.43'].id, force = true}
    end
}

