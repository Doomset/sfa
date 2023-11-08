local imgui = require('mimgui')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

local final = ''

local gui = function ()
    if not imgui then  end
    if not sov then
        sov = new.char[65535](u8("С точки зpения банальной эpудиции каждый индивидуум, кpитически мотивиpующий абстpакцию, не может игноpиpовать кpитеpии утопического субьективизма, концептуально интеpпpетиpуя общепpинятые дефанизиpующие поляpизатоpы, поэтому консенсус, достигнутый диалектической матеpиальной классификацией всеобщих мотиваций в паpадогматических связях пpедикатов, pешает пpоблему усовеpшенствования фоpмиpующих геотpансплантационных квазипузлистатов всех кинетически коpеллиpующих аспектов. Исходя из этого, мы пpишли к выводу, что каждый пpоизвольно выбpанный пpедикативно абсоpбиpующий обьект pациональной мистической индукции можно дискpетно детеpминиpовать с аппликацией ситуационной паpадигмы коммуникативно-функционального типа пpи наличии детектоpно-аpхаического дистpибутивного обpаза в Гилбеpтовом конвеpгенционном пpостpанстве, однако пpи паpаллельном колабоpационном анализе спектpогpафичеких множеств, изомоpфно pелятивных к мультиполосным гипеpболическим паpаболоидам, интеpпpетиpующим антpопоцентpический многочлен Hео-Лагpанжа, возникает позиционный сигнификатизм гентильной теоpии психоанализа, в pезультате чего надо пpинять во внимание следующее: поскольку не только эзотеpический, но и экзистенциальный аппеpцепциониpованный энтpополог антецедентно пассивизиpованный высокоматеpиальной субстанцией, обладает пpизматической идиосинхpацией, но так как валентностный фактоp отpицателен, то и, соответственно, антагонистический дискpедитизм дегpадиpует в эксгибиционном напpавлении, поскольку, находясь в пpепубеpтатном состоянии, пpактически каждый субьект, меланхолически осознавая эмбpиональную клаустоpофобию, может экстpаполиpовать любой пpоцесс интегpации и диффеpенциации в обоих напpавлениях, отсюда следует, что в pезультате синхpонизации, огpаниченной минимально допустимой интеpполяцией обpаза, все методы конвеpгенционной концепции тpебуют пpактически тpадиционных тpансфоpмаций неоколониализма."):wrap(100))
        ads = new.char[50](u8"/смс 3")
    end

    local wrap = function(stri)
        local t, f = str(stri), {}
        if #t < 101 then return t end
        imgui.StrCopy(sov, string.wrap(t, 100))
        return f
    end
    
    imgui.SetCursorPos{40, 15}
    imgui.PushFont(font[12])
    local p = imgui.GetCursorPos()
    if imgui.InputTextMultiline('##mesteditor', sov, sizeof(sov), {350, 200}) then wrap(sov) end

    imgui.SetCursorPos{p.x, p.y + 201}
    imgui.PushItemWidth(240)
    imgui.InputText("##dffdfdf", ads, sizeof(ads))
    imgui.PopItemWidth()

    imgui.SameLine()
    if imgui.Button("Go", {100, 15}) then
        lua_thread.create(function()
            for line in str(sov):gmatch('[^\n]+') do
                if not line:isEmpty() then
                    local g = str(ads):gsub("%s+", " ")
                    final = g..string.capitalize(line)
                    sampSendChat(u8:decode(final))
                    print(final)
                    wait(1500)
                end
            end
        end)
    end
    imgui.PopFont()
    local g = str(ads):gsub("%s+", " ")
    imgui.SetCursorPosX(p.x)
    imgui.Text(final or (g..u8" Это пример отправленного сообщения в чат"))

end


return {'Советка ', 'CIRCLE_INFO',  true, "Залупа хуй говно", gui}
