local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
____exports.Utils = __TS__Class()
local Utils = ____exports.Utils
Utils.name = "Utils"
function Utils.prototype.____constructor(self)
end
function Utils.clamp(self, number, min, max)
    return math.max(
        min,
        math.min(number, max)
    )
end
return ____exports
