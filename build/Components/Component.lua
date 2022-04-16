local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
____exports.Component = __TS__Class()
local Component = ____exports.Component
Component.name = "Component"
function Component.prototype.____constructor(self)
end
function Component.prototype.load(self)
    if not self.entity then
        return
    end
end
function Component.prototype.draw(self)
    if not self.entity then
        return
    end
end
function Component.prototype.update(self, dt)
    if not self.entity then
        return
    end
end
return ____exports
