
return
{
    name = '�������',
    icon = 'PAPERCLIP',
    hint = [[����� ����� ��� ������ �����,�� ������, ������]],
    func =
    function()
        handler('dialog', {t = '�����', s = 4, i = '������� (100$)'})
        SendSync{pos = {615.625, -72, 997.875}, pick = cfg['������']['1541.55'].id, force = true}
    end
}