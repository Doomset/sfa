
return
{
    name = '�������� ���',
    icon = 'SCREWDRIVER_WRENCH',
    hint = [[������� ����� ������� ������, ��������� ����� �� �������������, �� ������.]],
    func =
    function()
        if not isCharInAnyCar(PLAYER_PED) then return error('����� ���� � ������', 3) end
        setCarHealth(storeCarCharIsInNoSave(PLAYER_PED), 1000)
        addOneOffSound(0.0, 0.0, 0.0, 1133)
    end
}