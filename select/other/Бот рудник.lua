local imgui = nil

local gui = function ()
    if not imgui then imgui = require('mimgui') end
    
end

return {'��� ������ ', 'ICON_COINS',  true, "����� ���� �� ������� � ����� � � ����� � ��� ������� � ����", gui}
