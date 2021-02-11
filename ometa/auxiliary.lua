local tostring, tonumber, select, type, getmetatable, setmetatable, rawget = tostring, tonumber, select, type, getmetatable, setmetatable, rawget
local band, bor, lshift
local lua_dot_version = _VERSION:match("5%.(%d)")
--print("_VERSION", _VERSION, lua_dot_version)
if lua_dot_version == "2" then
	local bit32 = require("bit32")
	band, bor, lshift = bit32.band, bit32.bor, bit32.lshift
elseif lua_dot_version > "2" then
	loadstring = load
	local bit = require("bit-compact")
	band, bor, lshift = bit.band, bit.bor, bit.lshift
else
	bit = require('bit')
	band, bor, lshift = bit.band, bit.bor, bit.lshift
end
local Types = require('types')
local Any, Array = Types.Any, Types.Array
local Auxiliary = {pattern = function (input, p, drop)
local r = input.stream:pattern(p)
if not r then
return false
end
local success, res = input:collect(#r - (drop or 0))
return success, (res:concat())
end, apply = function (input, ruleRef, fallback, ...)
ruleRef = input.grammar[ruleRef]
if not ruleRef then
if not fallback then
return false
end
ruleRef = type(fallback) == 'string' and input.grammar[fallback] or fallback
end
if ... then
return input:applyWithArgs(ruleRef, ...)
else
return input:apply(ruleRef)
end
end}
return Auxiliary
