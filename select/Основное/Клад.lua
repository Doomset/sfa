
return
{
    name = '����',
    icon = 'GEM',
    hint = [[�������� ��������� ����, �� ������]],
    func =
    function()
        handler('dialog', {t = '������ ������ ����', s = 8, i = '����� �������'})
        SendSync{pos = {1749.3259277344, 499.79718017578, -45.953170776367}, key = 1024}
        SendSync{pos = {249.875, 67.625, 2003.625}, pick = cfg['������']['2321.26'].id, force = true}
    end
}