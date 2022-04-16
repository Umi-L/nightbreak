local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__Delete = ____lualib.__TS__Delete
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local ____types = require("types")
local Vector2 = ____types.Vector2
local colliders = {}
local actors = {}
local solids = {}
____exports.AABB = __TS__Class()
local AABB = ____exports.AABB
AABB.name = "AABB"
function AABB.prototype.____constructor(self, position, width, height, exists)
    if exists == nil then
        exists = true
    end
    self.position = position
    self.width = width
    self.height = height
    self.p1 = __TS__New(Vector2, -self.width / 2 + self.position.x, -self.height / 2 + self.position.y)
    self.p2 = __TS__New(Vector2, self.width / 2 + self.position.x, self.height / 2 + self.position.y)
    if exists then
        __TS__ArrayPush(colliders, self)
        print("A collider was added")
    end
end
function AABB.prototype.updatePosition(self)
    self.p1 = __TS__New(Vector2, -self.width / 2 + self.position.x, -self.height / 2 + self.position.y)
    self.p2 = __TS__New(Vector2, self.width / 2 + self.position.x, self.height / 2 + self.position.y)
end
function AABB.IsColliding(self, box1, box2)
    if box1.p1.y > box2.p2.y or box1.p2.y < box2.p1.y then
        return false
    end
    if box1.p1.x > box2.p2.x or box1.p2.x < box2.p1.x then
        return false
    end
    return true
end
function AABB.prototype.Destroy(self)
    __TS__Delete(
        colliders,
        __TS__ArrayIndexOf(colliders, self) + 1
    )
end
____exports.Actor = __TS__Class()
local Actor = ____exports.Actor
Actor.name = "Actor"
function Actor.prototype.____constructor(self, collider)
    self.collider = collider
    __TS__ArrayPush(actors, self)
end
function Actor.prototype.collideAt(self, position)
    local tempCollider = __TS__New(
        ____exports.AABB,
        position,
        self.collider.width,
        self.collider.height,
        false
    )
    do
        local i = 0
        while i < #colliders do
            if self.collider ~= colliders[i + 1] or colliders[i + 1] == tempCollider then
                if ____exports.AABB:IsColliding(tempCollider, colliders[i + 1]) then
                    tempCollider:Destroy()
                    return true
                end
            end
            i = i + 1
        end
    end
    tempCollider:Destroy()
    return false
end
function Actor.prototype.moveX(self, amount, onCollide)
    local xRemainder = amount
    local move = math.floor(xRemainder + 0.5)
    if move ~= 0 then
        xRemainder = xRemainder - move
        local sign = __TS__MathSign(move)
        while move ~= 0 do
            if not self:collideAt(Vector2:add(
                self.collider.position,
                __TS__New(Vector2, sign, 0)
            )) then
                local ____self_collider_position_0, ____x_1 = self.collider.position, "x"
                ____self_collider_position_0[____x_1] = ____self_collider_position_0[____x_1] + sign
                move = move - sign
            else
                if onCollide then
                    onCollide(nil)
                end
                break
            end
        end
    end
end
function Actor.prototype.moveY(self, amount, onCollide)
    local yRemainder = amount
    local move = math.floor(yRemainder + 0.5)
    if move ~= 0 then
        yRemainder = yRemainder - move
        local sign = __TS__MathSign(move)
        while move ~= 0 do
            if not self:collideAt(Vector2:add(
                self.collider.position,
                __TS__New(Vector2, 0, sign)
            )) then
                local ____self_collider_position_2, ____y_3 = self.collider.position, "y"
                ____self_collider_position_2[____y_3] = ____self_collider_position_2[____y_3] + sign
                move = move - sign
            else
                if onCollide then
                    onCollide(nil)
                end
                break
            end
        end
    end
end
____exports.Solid = __TS__Class()
local Solid = ____exports.Solid
Solid.name = "Solid"
function Solid.prototype.____constructor(self, collider)
    self.collider = collider
    __TS__ArrayPush(solids, self)
end
function ____exports.DEBUGDrawColliders(self)
    do
        local i = 0
        while i < #colliders do
            local collider = colliders[i + 1]
            love.graphics.rectangle(
                "line",
                collider.position.x - collider.width / 2,
                collider.position.y - collider.height / 2,
                collider.width,
                collider.height
            )
            love.graphics.circle("line", collider.p1.x, collider.p1.y, 10)
            love.graphics.circle("line", collider.p2.x, collider.p2.y, 10)
            i = i + 1
        end
    end
end
return ____exports
