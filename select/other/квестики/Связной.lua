
local t = {
    {info = "Обход кика", action = "NoKick() -- писька"},
    {info = "   Надо нарыть", action = "Взять_Квест(1)"},
    {info = "Выдать автомат", action = "пушка('31')"},
    {info = "Выдать броню", action = "addArmourToChar(PLAYER_PED, 100)"},
    {info = "Блок синхры", action = "BlockSync = true"},
    {info = "", action = "handler('dialog', {t = 'Связной'})"},
    {info = "", action = "Задержка(1)"},
    {info = "", action = "Взять_Квест(1)"},
    {info = "", action = "Задержка(3)"},
    {info = "Обход кика", action = "NoKick()"},
    {info = "", action = "handler('dialog', {t = 'Записка'})"},
    {info = "", action = "Задержка(1)"},
    {info = "Обход кика", action = "NoKick()"},
    {info = "Взять пикап Военкомат (Анклав)", action = "SendSync{ pos = {211.5 , 1922.875 , 17.625}, pick = cfg['Пикапы']['2152.09'].id}"},
    {info = "", action = "SendSync{ pos = {308.68273925781, -131, 1099}}"},
    {info = "", action = "SendSync{ pos = {-145, 437, 12}}"},
    {info = "", action = "Задержка(0)"},
    {info = "Обход кика", action = "NoKick()"},
    {info = "Взять пикап Тайник (Карсон)", action = "local p=cfg['Пикапы']['1012.29'] exSync{ pos = p.pos, p = p.id}"},
    {info = "Взять пикап Тайник (Боун)", action = "local p=cfg['Пикапы']['2567.37']  exSync{ pos = p.pos, p = p.id}"},
    {info = "Обход кика", action = "NoKick()"},
    {info = "Взять пикап Тайник (Брудж)", action = "local p=cfg['Пикапы']['1902.39']  exSync{ pos = p.pos, p = p.id}"},
    {info = "Взять пикап Тайник (Робада)", action = "local p=cfg['Пикапы']['685.78']   exSync{ pos = p.pos, p = p.id}"},
    {info = "", action = "Задержка(1)"},
    {info = "Анблок синхры", action = "BlockSync = false"},
    {info = "", action = "SendSync{ pos = {278.30606079102, 1360.9072265625, 10.625912666321}}"},
}
--



Надо_Нарыть = function()
	Антирад_Или_Аптечка(false, 1);
	wait(3500)
	Еда_Или_Водка(false, 1);
	wait(3500)
	Антирад_Или_Аптечка(true, 1);
	NoKick()
	wait(3500)
	Еда_Или_Водка(true, 1)
	wait(3500)
end

return t
