local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____types = require("types")
local Vector2 = ____types.Vector2
____exports.Camera = __TS__Class()
local Camera = ____exports.Camera
Camera.name = "Camera"
function Camera.prototype.____constructor(self, position, width, height, scale)
    if position == nil then
        position = __TS__New(Vector2, 0, 0)
    end
    if scale == nil then
        scale = 1
    end
    self.default_smoothers = {
        none = function(self, pos, delta)
            return __TS__New(Vector2, delta.x, delta.y)
        end,
        common = function(self, pos, delta, ...)
            local vargs = {...}
            if pos.x == delta.x and pos.y == delta.y then
                return __TS__New(Vector2, delta.x, delta.y)
            end
            local speed = type(vargs[1]) == "number" and vargs[1] or 0.001
            speed = math.min(1, speed)
            return __TS__New(Vector2, pos.x ~= delta.x and (delta.x - pos.x) * speed + pos.x or pos.x, pos.y ~= delta.y and (delta.y - pos.y) * speed + pos.y or pos.y)
        end
    }
    self.position = position
    self.width = width
    self.height = height
    self.scale = scale
end
function Camera.prototype.move(self, delta)
    self.position = delta
end
function Camera.prototype.zoom(self, mul)
    self.scale = self.scale * mul
end
function Camera.prototype.getPosition(self)
    return __TS__New(Vector2, self.position.x, self.position.y)
end
function Camera.prototype.setPosition(self, pos)
    self.position.x = pos.x
    self.position.y = pos.y
end
function Camera.prototype.getScale(self)
    return self.scale
end
function Camera.prototype.setScale(self, scale)
    self.scale = scale
end
function Camera.prototype.getWorldCoords(self, pos)
    local scale = self.scale
    return __TS__New(Vector2, pos.x / scale - self.position.x - self.width / 2, pos.y / scale - self.position.y - self.height / 2)
end
function Camera.prototype.getCameraCoords(self, pos)
    local scale = self.scale
    return __TS__New(Vector2, (pos.x + self.position.x + self.width / 2) * scale, (pos.y + self.position.y + self.height / 2) * scale)
end
function Camera.prototype.lookAt(self, pos, smoother, ...)
    if pos == nil then
        pos = self.position
    end
    if smoother == nil then
        smoother = self.default_smoothers.none
    end
    if type(smoother) == "string" then
        smoother = self.default_smoothers[smoother]
    end
    self.position = smoother(nil, self.position, pos, ...)
end
function Camera.prototype.lookAtSegment(self, x, y, min_x, max_x, min_y, max_y, smoother, ...)
    if smoother == nil then
        smoother = self.default_smoothers.none
    end
    local scale = self.scale
    self:lookAt(
        __TS__New(
            Vector2,
            math.max(
                (min_x + self.width / 2) / scale,
                math.min(x, (max_x - self.width / 2) / scale)
            ),
            math.max(
                (min_y + self.height / 2) / scale,
                math.min(y, (max_y - self.height / 2) / scale)
            )
        ),
        smoother,
        ...
    )
end
function Camera.prototype.attach(self)
    love.graphics.push("transform")
    love.graphics.translate(self.width / 2, self.height / 2)
    love.graphics.scale(self.scale)
    love.graphics.translate(-self.position.x, -self.position.y)
end
function Camera.prototype.detach(self)
    love.graphics.pop()
end
return ____exports
