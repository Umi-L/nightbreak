local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____physics = require("libraries.physics")
local AABB = ____physics.AABB
function ____exports.AABBFromSprite(self, transform, sprite)
    return __TS__New(
        AABB,
        transform.position,
        sprite:getWidth() * transform.scale.x,
        sprite:getHeight() * transform.scale.y
    )
end
return ____exports
