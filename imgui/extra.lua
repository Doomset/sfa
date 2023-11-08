local mod = {}
local encoding = require "encoding" --К переменным
local vkeys = require'vkeys'
encoding.default = 'CP1251'
local u8 = encoding.UTF8 -- перед main можешь пихнуть
mod.ui_meta = {
    __index = function(self, v)
        if v == "switch" then
            local switch = function(manual)
                if not manual and self.process and self.process:status() ~= "dead" then
                    return false -- // Предыдущая анимация ещё не завершилась!
                end
                self.timer = os.clock()
                self.state = not self.state

                self.process = lua_thread.create(function()
                    while true do
                        local a = mod.bringFloatTo(0.00, 1.00, self.timer, self.duration)
                        self.alpha = self.state and a or 1.00 - a
                        if a == 1.00 then break end
                        wait(0)
                    end
                end)
                return true -- // Состояние окна изменено!
            end
            return switch
        end

        if v == "alpha" then
            return self.state and 1.00 or 0.00
        end
    end
}

mod.bringFloatTo = function(from, to, start_time, duration)
    local timer = os.clock() - start_time
    if timer >= 0.00 and timer <= duration then
        local count = timer / (duration / 100)
        return from + (count * (to - from) / 100), true
    end
    return (timer > duration) and to or from, false
end



do--color_
    mod.explode_argb = function(argb)
        local a, r, g, b
        a = bit.band(bit.rshift(argb, 24), 0xFF)
        r = bit.band(bit.rshift(argb, 16), 0xFF)
        g = bit.band(bit.rshift(argb, 8), 0xFF)
        b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    mod.convertRGBAToARGB = function(color)
        local color = tonumber(color)
        local r, g, b, a = mod.explode_argb(color)
        return mod.join_argb(a, r, g, b)
    end

    mod.join_argb = function(a, r, g, b)
        local argb = b                       -- b
        argb = bit.bor(argb, bit.lshift(g, 8)) -- g
        argb = bit.bor(argb, bit.lshift(r, 16)) -- r
        argb = bit.bor(argb, bit.lshift(a, 24)) -- a
        return argb
    end
end
---





local imgui = require("mimgui")
-- req = nil
-- package.loading[mod_gui] = nil


--local Icon = require('sfa.imgui.icon').icon

mod.con = function(r, g, b, a)
    a = a or imgui.GetStyle().Alpha
    return r + g + b + a > 3.00 and imgui.ImVec4(r / 255.0, g / 255.0, b / 255.0, a) or imgui.ImVec4(r, g, b, a)
end

mod.setAlpha = function(c, a)
    return { c.x, c.y, c.z, c.w < 0.01 and c.w or imgui.GetStyle().Alpha * a }
end




mod.shadowText = function(s, text, isback)
    local dl = isback and imgui.GetBackgroundDrawList() or imgui.GetWindowDrawList()

    local col = imgui.ColorConvertU32ToFloat4(0xFF000000)
    local col = imgui.ColorConvertFloat4ToU32({ col.x, col.y, col.z, imgui.GetStyle().Alpha })

    dl:AddText({ s[1] + 1, s[2] + 1 }, col, text) -- тень
    dl:AddText(s, imgui.GetColorU32Vec4(imgui.GetStyle().Colors[imgui.Col.Text]), text)
end



mod.BoolText = function(bool, ...)
	local colors, clr = imgui.GetStyle().Colors, imgui.Col
	local color, p = bool and colors[clr.Button] or  mod.con(123, 123, 111), imgui.GetCursorPos()
    imgui.Dummy(imgui.CalcTextSize(...))
	imgui.SetCursorPos(p); mod.color_text(imgui.IsItemHovered() and colors[clr.ButtonHovered] or color, ...)
	return imgui.IsItemClicked(0)
end


function mod.U32ToImVec4(color)
	local r, g, b
	r = bit.rshift(color, 16)
	g = bit.band(bit.rshift(color, 8), 0xFF)
	b = bit.band(color, 0xFF)
	
	return mod.con(r, g, b, 1.0)
end

mod.Text = function(...)
	return mod.color_text(imgui.GetStyle().Colors[imgui.Col.Text], ...)
end

mod.Separator = function(o, o2)
    local col = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered], 0.8))
    local col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.FrameBgHovered], 0.1))

    imgui.SetCursorPosY(imgui.GetCursorPos().y + (o or 1))
    local p = imgui.GetCursorScreenPos()

    imgui.GetWindowDrawList():AddRectFilledMultiColor({ p.x + (o2 or 0), p.y },
        { p.x + imgui.GetWindowSize().x - 10, p.y + 1 }, col, col, col2, col2);
    imgui.Dummy({ imgui.GetWindowSize().x, 1 })
    imgui.SetCursorPosY(imgui.GetCursorPos().y + (o or 1))
end


mod.hint = setmetatable(
    {
        un_text = "",
        storoka_takaya_bejit_ebat = "",
        clock = os.clock(),


        list = {}


    }, {
        __call = function(self, text, p2, size)
            local size = imgui.ImVec2(size)


            
            local function limit(v, min, max) -- Ограничение динамического значения
                min = min or 0.0
                max = max or 1.0
                return v < min and min or (v > max and max or v)
            end

         
            if imgui.IsItemHovered() and not self.list[text] then
                self.list[text] = {run = '', delay =  os.clock(), show = true}
                --msg(text, 'dabov')
            elseif not imgui.IsItemHovered() and self.list[text] then
                self.list[text] = nil --{run = '', delay =  os.clock(), show = false}
            end


            local data = self.list[text]
            if data and data.show then

                local c = os.clock() - data.delay


                if c > 0.3 and not data.go then data.go = os.clock() end


                

                if data.go then


                    local float = mod.bringFloatTo(1, #text, data.go, 0.5)



                    local pos = imgui.GetCursorScreenPos()
                    local size = imgui.GetItemRectSize()

                    imgui.PushFont(font[15])

            
                    local res = limit(float, 0, 1)

                    local for_alpha = mod.bringFloatTo(0.1, 1, data.go, 0.3)
                    imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, for_alpha)
            

                    -- local c = os.clock() - self.list[text].delay
                    -- print(c)
                    -- if c > 1 then
                    --     self.list[text].clock = os.clock()
                    --     msg('gp')
                    -- end

                    



                    local size_text = imgui.CalcTextSize(u8(text))

                    imgui.SetNextWindowPos({ size.x + ( (pos.x + 30) - 30 * for_alpha), pos.y - size.y})
                    imgui.Begin(text, _, imgui.WindowFlags.Tooltip + imgui.WindowFlags.NoDecoration + imgui.WindowFlags.AlwaysAutoResize)
                  
                    local size = imgui.GetWindowSize()
            

                    local f = math.modf(float)

                    self.list[text].run = string.sub(text, 1, f)

                    

                    imgui.PushTextWrapPos(300)
                    imgui.Text(u8( self.list[text].run))
                    imgui.PopTextWrapPos()


                    -- -- if os.clock() - self.clock_t > 0.99 then 
                    -- --     self.un_text = text
                    -- --     self.storoka_takaya_bejit_ebat = "" -- первый символ сюда ебать
                    -- --     self.clock = os.clock()
                    -- --  end



                    -- print(self.list[text].clock)
                
                    
                    -- local f = math.modf(mod.bringFloatTo(1, #text, self.list[text].clock, 0.8))

                    
                    -- local qwer = mod.bringFloatTo(0.1, 1, self.list[text].clock, 0.3)

                

                    -- local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.WindowBg], qwer)),
                    --     imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.ChildBg], qwer))
                    -- imgui.GetWindowDrawList():AddRectFilledMultiColor(p2,
                    --     { p2.x + imgui.GetWindowSize().x * 5, p2.y + imgui.GetWindowSize().y }, col2, col, col, col2);

                    -- local ac = check_car()
                    -- mod.color_text(ac and mod.con(46, 204, 113) or mod.con(207, 0, 15), ac and "NO WARN" or "WARN")

                    
                    -- self.list[text].run = string.sub(text, 1, f)
                    -- imgui.PushTextWrapPos(size.x * 2);
                    -- imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
                    -- imgui.Text(u8(self.list[text].run))
                    -- imgui.PopStyleColor()
                    -- imgui.PopTextWrapPos();

                    imgui.End()
                    imgui.PopStyleVar()
                    imgui.PopFont()
                end
            end
        end,

        __index = function(self, key)
            if key == "p" then
                return imgui["GetCursorScreenPos"]
            end
        end,
    })

local lasng = {[" "] = " ",['`'] = 'ё', ['~'] = 'ё', ['q'] = 'й', ['w'] = 'ц', ['e'] = 'у', ['r'] = 'к', ['t'] = 'е', ['y'] = 'н', ['u'] = 'г', ['i'] = 'ш', ['o'] = 'щ', ['p'] = 'з', ['['] = 'х', ['{'] = 'х', [']'] = 'ъ', ['}'] = 'ъ', ['a'] = 'ф', ['s'] = 'ы', ['d'] = 'в', ['f'] = 'а', ['g'] = 'п', ['h'] = 'р', ['j'] = 'о', ['k'] = 'л', ['l'] = 'д', [';'] = 'ж', ["'"] = 'э', ['"'] = 'э', ['z'] = 'я', ['x'] = 'ч', ['c'] = 'с', ['v'] = 'м', ['b'] = 'и', ['n'] = 'т', ['m'] = 'ь', ['<'] = 'б', [','] = 'б', ['>'] = 'ю', ['.'] = 'ю'}
local lasen = {}
for k, v in pairs(lasng) do
	lasen[v] = k
end
local insert, concat, lower = table.insert, table.concat, string.lower
local function RusToEng(tex, en)
    local str, word  = {}
    for i = 1, #tex do
        word = (lower(tex)):sub(i, i)
        insert(str, (en and lasen or lasng)[word] or word)
	end; return concat(str)
end


mod.input = function(self)
    local bo = {
        is_clicked = false,
        chars = "поиск",
    }

    bo.render = function(self, size)
        local p = imgui.GetCursorPos()
        local tsize = imgui.CalcTextSize(u8(self.chars))
        local size = size and imgui.ImVec2(size) or imgui.ImVec2 { 528, 20 }

        imgui.SetCursorPos(p)
        local p2 = imgui.GetCursorScreenPos()
        imgui.Dummy(size)

        -- addEventHandler("onWindowMessage", function(message, wparam)
        --     if (message == 0x100 or message == 0x101) and not self.is_clicked then
        --         if wparam == 13 then
        --             msg('BLOCK ENTER')
        --             consumeWindowMessage(true, false)
        --         end
        --     end
        -- end)



        if imgui.IsItemClicked() or imgui.IsKeyReleased(13) then self.is_clicked = true end

        imgui.SetCursorPos({ p.x + (size.x / 2 - tsize.x / 2), p.y - 5 })
        local p = imgui.GetCursorScreenPos()
        imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.TextDisabled])
        imgui.Text(u8(self.chars))
      --  if self.chars == "поиск" then imgui.Icon({ p.x - 13, p.y + 3 }, "MAGNIFYING_GLASS", 10.5) end
        imgui.PopStyleColor()

        if self.is_clicked then
            local a = math.floor(math.sin(imgui.GetTime() * 10) * 127 + 128) / 255
            local col, col2 = imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button], a)),
                imgui.GetColorU32Vec4(mod.setAlpha(imgui.GetStyle().Colors[imgui.Col.Button], a))

            imgui.GetForegroundDrawList():AddRectFilledMultiColor({ p.x + tsize.x, p.y }, { p.x + tsize.x + 1, p.y + 14 },
                col, col, col2, col2);

            if self.chars == "поиск" then self.chars = "" end

            if imgui.IsKeyPressed(8) then
                self.chars = (self.chars:reverse():gsub(self.chars:sub(-1), "", 1)):reverse()
            end

            for i = 1, 250 do
                if (i ~= 8 and i ~= 16 and i ~= 18 and i ~= 91 and i ~= 17 and i ~= 13 and imgui.IsKeyPressed(i)) and tsize.x < 150 then
                    self.chars = self.chars .. (i == 32 and " " or RusToEng(vkeys.id_to_name(i)))
                end
            end
        end
    end

    bo.active = function(self)
        return self.is_clicked
    end

    bo.filt = function(self, f)
        if self.is_clicked then
            if f:lower():find(self.chars) then
                return true
            end
            if imgui.IsMouseReleased(0) or imgui.IsKeyReleased(13) then
               -- msg("ывы")
                self:null()
                return true
            end
            return false
        else
            return true
        end
    end

    bo.null = function(self)
        self.is_clicked = false
        self.chars = "поиск"
    end

    return bo
end



-- addEventHandler("onWindowMessage", function(message, wparam)
--     if (message == 0x100 or message == 0x101) then
--         if wparam == VK_SPACE then
--             msg('BLOCK ENTER')
--             consumeWindowMessage(true, false)
--         end
--     end
-- end)



mod.BoolButton = function(bool, ...)
	if type(bool) ~= 'boolean' then return end
	local colors, clr = imgui.GetStyle().Colors, imgui.Col
	imgui.PushStyleColor(imgui.Col.Button, bool and colors[clr.Button] or imgui.ImVec4(0.20, 0.20, 0.20, 0))
	imgui.PushStyleColor(imgui.Col.ButtonHovered, colors[clr.ButtonHovered])
	imgui.PushStyleColor(imgui.Col.ButtonActive, bool and colors[clr.Button] or imgui.ImVec4(0.16, 0.16, 0.16, 1.00))
	local result = imgui.Button(...)
	imgui.PopStyleColor(3)
	return result
end

mod.color_text = function(color, ...)
    local pos, a = imgui.GetCursorPos(), imgui.GetStyle().Alpha
    imgui.SetCursorPos(imgui.ImVec2(pos.x + 1, pos.y))
    imgui.TextColored(imgui.ImVec4(0, 0, 0, a), ...) -- shadow
    imgui.SetCursorPos(imgui.ImVec2(pos.x - 1, pos.y))
    imgui.TextColored(imgui.ImVec4(0, 0, 0, a), ...) -- shadow
    imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y + 1))
    imgui.TextColored(imgui.ImVec4(0, 0, 0, a), ...) -- shadow
    imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y - 1))
    imgui.TextColored(imgui.ImVec4(0, 0, 0, a), ...) -- shadow
    imgui.SetCursorPos(pos);
    imgui.TextColored(color, ...)
end



mod.centerText = function(text, off, color, fontsize)
    text = u8(text)
	imgui.PushFont(fontsize or font[18])
	imgui.SetCursorPos({imgui.GetWindowWidth() / 2 - imgui.CalcTextSize(text).x / 2, off or 50}); 
	mod.color_text(color or imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 0.5), text)
	imgui.PopFont()
end

return mod
