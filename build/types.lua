local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
____exports.Vector2 = __TS__Class()
local Vector2 = ____exports.Vector2
Vector2.name = "Vector2"
function Vector2.prototype.____constructor(self, x, y)
    self.x = x
    self.y = y
end
function Vector2.add(self, v1, v2)
    return __TS__New(____exports.Vector2, v1.x + v2.x, v1.y + v2.y)
end
function Vector2.subtract(self, v1, v2)
    return __TS__New(____exports.Vector2, v1.x - v2.x, v1.y - v2.y)
end
____exports.Color = __TS__Class()
local Color = ____exports.Color
Color.name = "Color"
function Color.prototype.____constructor(self, r, g, b, a)
    self.r = r
    self.g = g
    self.b = b
    self.a = a
end
return ____exports
