
local t = {
    {info = "����� ����", action = "NoKick() -- ������"},
    {info = "   ���� ������", action = "�����_�����(1)"},
    {info = "������ �������", action = "�����('31')"},
    {info = "������ �����", action = "addArmourToChar(PLAYER_PED, 100)"},
    {info = "���� ������", action = "BlockSync = true"},
    {info = "", action = "handler('dialog', {t = '�������'})"},
    {info = "", action = "��������(1)"},
    {info = "", action = "�����_�����(1)"},
    {info = "", action = "��������(3)"},
    {info = "����� ����", action = "NoKick()"},
    {info = "", action = "handler('dialog', {t = '�������'})"},
    {info = "", action = "��������(1)"},
    {info = "����� ����", action = "NoKick()"},
    {info = "����� ����� ��������� (������)", action = "SendSync{ pos = {211.5 , 1922.875 , 17.625}, pick = cfg['������']['2152.09'].id}"},
    {info = "", action = "SendSync{ pos = {308.68273925781, -131, 1099}}"},
    {info = "", action = "SendSync{ pos = {-145, 437, 12}}"},
    {info = "", action = "��������(0)"},
    {info = "����� ����", action = "NoKick()"},
    {info = "����� ����� ������ (������)", action = "local p=cfg['������']['1012.29'] exSync{ pos = p.pos, p = p.id}"},
    {info = "����� ����� ������ (����)", action = "local p=cfg['������']['2567.37']  exSync{ pos = p.pos, p = p.id}"},
    {info = "����� ����", action = "NoKick()"},
    {info = "����� ����� ������ (�����)", action = "local p=cfg['������']['1902.39']  exSync{ pos = p.pos, p = p.id}"},
    {info = "����� ����� ������ (������)", action = "local p=cfg['������']['685.78']   exSync{ pos = p.pos, p = p.id}"},
    {info = "", action = "��������(1)"},
    {info = "������ ������", action = "BlockSync = false"},
    {info = "", action = "SendSync{ pos = {278.30606079102, 1360.9072265625, 10.625912666321}}"},
}
--



����_������ = function()
	�������_���_�������(false, 1);
	wait(3500)
	���_���_�����(false, 1);
	wait(3500)
	�������_���_�������(true, 1);
	NoKick()
	wait(3500)
	���_���_�����(true, 1)
	wait(3500)
end

return t
