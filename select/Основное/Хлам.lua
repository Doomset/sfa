return
{
    name = '����',
    icon = 'DUMPSTER',
    hint = [[c����� �������� ������� ���� ������� ����� � ����.]],
    func =
    function()
        NoKick()
        handler('dialog', {t = '������� �����'})
        handler('dialog', {t = '������� �����', button = 0})
        handler('player_pos', {2036.24})
        SendSync{ pos = {211, 2610, 17}, pick = cfg['������']['2837.88'].id, force = true}
        SendSync{ pos = {159, 2412, 18}, pick = cfg['������']['2588.92'].id, force = true}
        SendSync{ pos = {623, 2205, 24}, pick = cfg['������']['2851.63'].id, force = true}
        SendSync{ pos = {698, 1293, 15}, pick = cfg['������']['2006.33'].id, force = true}
        SendSync{ pos = {185, 1345, 11}, pick = cfg['������']['1540.85'].id, force = true}
        SendSync{ pos = {-126, 1126, 20}, pick = cfg['������']['1020.55'].id, force = true}
        SendSync{ pos = {615, -72, 1498}, pick = cfg['������']['2040.68'].id, force = true}
    end
}
