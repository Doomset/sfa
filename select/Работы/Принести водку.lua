
return
{
    name = '�������� �����',
    icon = 'WINE_BOTTLE',
    hint = [[����� ����� ��� ������ �����,�� ������, ������]],
    func =
    function()
        NoKick()
        handler('dialog', {t = '���������'})
        SendSync{ pos = {-68, -255, 994}, pick = cfg['������']['670.98'].id, force = true}
        ��������(3.3)


        �����_�����(0)
        handler('dialog', {t = '������ � ����'})
        --handler('dialog', {t = '������ � ����'})
        --SendSync{pos = {615.625, -72, 997.875}, pick = cfg['������']['1541.55'].id, force = true}
    end
}