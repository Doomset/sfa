local �����_���� = function(n, t)
	for i = 1, t or 1 do
		handler('dialog', {t = '�����: ', s = n - 1, i = ''}, 5)
		SendSync{pos = {2555.134765625, -1281.4006347656, 2054.6469726563}}
	end
end

return
{
    name = '���-���',
    icon = 'CROSSHAIRS',
    hint = [[������������ � ��������� 10 ���� ���-���,����� ����� � ������]],
    func =
    function()
        �����_����(6, 10)
    end
}