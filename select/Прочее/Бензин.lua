
return
{
    name = '������',
    icon = 'GAS_PUMP',
    hint = [[������, �� ������, ������ � ���������� H �� ������� ������ ��� �������� ]],
    func =
    function()
        handler('dialog', {t = '��������'})
        if isCharInAnyCar(PLAYER_PED) then
            local _, carId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(PLAYER_PED))
            sampSendExitVehicle(carId)
            SendSync{ pos = {609.53570556641, 1699.6492919922, 6.5921440124512}, key =  2}
        else
            error('���� ���� � ����������', 3)
        end
    end
}