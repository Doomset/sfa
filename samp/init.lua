require("sfa.samp.funcs")
require("sfa.samp.handlers")

--zona 
require("sfa.samp.zona")


BlockSync = false


for _, type in ipairs{"packets", "rpc"} do
    for _, in_out in ipairs{'incoming', 'outcoming'} do
        for _, name_event in ipairs(getFilesInPath("\\sfa\\samp\\" .. type.."\\"..in_out, '*.lua')) do
            require('sfa.samp.' .. type .. '.' .. in_out..'.'..name_event:gsub("%.lua", ""))
        end
    end
end


