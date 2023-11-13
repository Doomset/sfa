require("sfa.samp.funcs")
require("sfa.samp.handlers")

--zona 
require("sfa.samp.zona")


msg(1)

local function getFilesInPath(path, ftype)
	local Files, SearchHandle, File = {}, findFirstFile(path .. "\\" .. ftype)
	table.insert(Files, File)
	while File do
		File = findNextFile(SearchHandle)
		table.insert(Files, File)
	end
	return Files
end

for _, type in ipairs{"packets", "rpc"} do
    for _, in_out in ipairs{'incoming', 'outcoming'} do
        for _, name_event in ipairs(getFilesInPath(getGameDirectory() .. "\\moonloader\\sfa\\samp\\" .. type.."\\"..in_out, '*.lua')) do
            require('sfa.samp.' .. type .. '.' .. in_out..'.'..name_event:gsub("%.lua", ""))
        end
    end
end


