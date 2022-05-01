local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____love_2Ephysics = require("love.physics")
local newWorld = ____love_2Ephysics.newWorld
function ____exports.createWorld(self, gravity, sleep)
    return newWorld(gravity.x, gravity.y, sleep)
end
local colliders = {}
local Collider = __TS__Class()
Collider.name = "Collider"
function Collider.prototype.____constructor(self, body, shape, fixture, exists)
    if exists == nil then
        exists = true
    end
    self.body = body
    self.fixture = fixture
    self.shape = shape
    if exists then
        colliders[#colliders + 1] = self
    end
end
function Collider.prototype.Destroy(self)
    local index = __TS__ArrayIndexOf(colliders, self, 0)
    if index > -1 then
        __TS__ArraySplice(colliders, index, 1)
    end
end
local RectCollider = __TS__Class()
RectCollider.name = "RectCollider"
__TS__ClassExtends(RectCollider, Collider)
function RectCollider.prototype.____constructor(self, world, width, height, position)
    local body = love.physics.newBody(world, position.x, position.y)
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(body, shape)
    Collider.prototype.____constructor(self, body, shape, fixture)
    self.width = width
    self.height = height
    self.position = position
end
function ____exports.DEBUG_DRAW_COLLIDERS(self)
    do
        local i = 0
        while i < #colliders do
            if colliders[i + 1] then
                local args = {colliders[i + 1].shape:getPoints()}
                love.graphics.polygon(
                    "line",
                    {colliders[i + 1].body:getWorldPoints(unpack(args))}
                )
            end
            i = i + 1
        end
    end
end
return ____exports
