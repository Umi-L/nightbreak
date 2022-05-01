local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__Delete = ____lualib.__TS__Delete
local __TS__MathSign = ____lualib.__TS__MathSign
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local DRAW = ____DrawManager.DRAW
local ____types = require("types")
local Vector2 = ____types.Vector2
local colliders = {}
local actors = {}
local solids = {}
____exports.AABB = __TS__Class()
local AABB = ____exports.AABB
AABB.name = "AABB"
function AABB.prototype.____constructor(self, position, width, height, exists, canCollide, blacklistEnabled, whitelistEnabled)
    if exists == nil then
        exists = true
    end
    if canCollide == nil then
        canCollide = true
    end
    if blacklistEnabled == nil then
        blacklistEnabled = false
    end
    if whitelistEnabled == nil then
        whitelistEnabled = false
    end
    self.collisionBlacklist = {}
    self.collisionWhitelist = {}
    self.canCollide = canCollide
    self.whitelistEnabled = whitelistEnabled
    self.blacklistEnabled = blacklistEnabled
    self.position = position
    self.width = width
    self.height = height
    self.p1 = __TS__New(Vector2, -self.width / 2 + self.position.x, -self.height / 2 + self.position.y)
    self.p2 = __TS__New(Vector2, self.width / 2 + self.position.x, self.height / 2 + self.position.y)
    if exists then
        colliders[#colliders + 1] = self
    end
end
function AABB.prototype.whitelistAdd(self, box)
    local ____self_collisionWhitelist_0 = self.collisionWhitelist
    ____self_collisionWhitelist_0[#____self_collisionWhitelist_0 + 1] = box
end
function AABB.prototype.whitelistRemove(self, box)
    __TS__ArraySplice(
        self.collisionWhitelist,
        __TS__ArrayIndexOf(self.collisionWhitelist, box),
        1
    )
end
function AABB.prototype.blacklistAdd(self, box)
    local ____self_collisionBlacklist_1 = self.collisionBlacklist
    ____self_collisionBlacklist_1[#____self_collisionBlacklist_1 + 1] = box
end
function AABB.prototype.blacklistRemove(self, box)
    __TS__ArraySplice(
        self.collisionBlacklist,
        __TS__ArrayIndexOf(self.collisionBlacklist, box),
        1
    )
end
function AABB.prototype.updatePosition(self)
    self.p1 = __TS__New(Vector2, -self.width / 2 + self.position.x, -self.height / 2 + self.position.y)
    self.p2 = __TS__New(Vector2, self.width / 2 + self.position.x, self.height / 2 + self.position.y)
end
function AABB.prototype.blacklistContains(self, box)
    if not self.blacklistEnabled then
        return true
    end
    return __TS__ArrayIncludes(self.collisionBlacklist, box)
end
function AABB.prototype.whitelistContains(self, box)
    if not self.whitelistEnabled then
        return true
    end
    return __TS__ArrayIncludes(self.collisionWhitelist, box)
end
function AABB.prototype.canCollideWith(self, other)
    if self.canCollide and other.canCollide then
        if not other.whitelistEnabled and not self.whitelistEnabled and not self.blacklistEnabled and not other.blacklistEnabled then
            return true
        end
        if self.whitelistEnabled or other.whitelistEnabled then
            if self:whitelistContains(other) and other:whitelistContains(self) then
                return true
            end
        end
        if self.blacklistEnabled or other.blacklistEnabled then
            if not self:blacklistContains(other) and not other:blacklistContains(self) then
                return true
            end
        end
    end
    return false
end
function AABB.IsColliding(self, box1, box2)
    if not box1:canCollideWith(box2) then
        return false
    end
    if box1.p1.y > box2.p2.y or box1.p2.y < box2.p1.y then
        return false
    end
    if box1.p1.x > box2.p2.x or box1.p2.x < box2.p1.x then
        return false
    end
    return true
end
function AABB.prototype.PointIsColliding(self, point)
    if point.x > self.p1.x and point.x < self.p2.x and point.y < self.p1.y and point.y > self.p2.y then
        return true
    end
    return false
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
    actors[#actors + 1] = self
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
                local ____self_collider_position_2, ____x_3 = self.collider.position, "x"
                ____self_collider_position_2[____x_3] = ____self_collider_position_2[____x_3] + sign
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
                local ____self_collider_position_4, ____y_5 = self.collider.position, "y"
                ____self_collider_position_4[____y_5] = ____self_collider_position_4[____y_5] + sign
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
    solids[#solids + 1] = self
end
function ____exports.LineIntersects(self, a1, a2, b1, b2)
    local b = Vector2:subtract(a2, a1)
    local d = Vector2:subtract(b2, b1)
    local bDotDPerp = b.x * d.y - b.y * d.x
    if bDotDPerp == 0 then
        return
    end
    local c = Vector2:subtract(b1, a1)
    local t = (c.x * d.y - c.y * d.x) / bDotDPerp
    if t < 0 or t > 1 then
        return
    end
    local u = (c.x * b.y - c.y * b.x) / bDotDPerp
    if u < 0 or u > 1 then
        return
    end
    b.x = b.x * t
    b.y = b.y * t
    local intersection = Vector2:add(a1, b)
    return intersection
end
function ____exports.rayCast(self, pos, angle, distance, blackList, draw)
    if blackList == nil then
        blackList = {}
    end
    if draw == nil then
        draw = false
    end
    local x = distance * math.sin(angle)
    local y = -(distance * math.cos(angle))
    local pos2 = Vector2:add(
        pos,
        __TS__New(Vector2, x, y)
    )
    if draw then
        DRAW(
            nil,
            2,
            function()
                love.graphics.line(pos.x, pos.y, pos2.x, pos2.y)
            end
        )
    end
    do
        local i = 0
        while i < #colliders do
            if not __TS__ArrayIncludes(blackList, colliders[i + 1]) then
                local hit
                hit = ____exports.LineIntersects(
                    nil,
                    pos,
                    pos2,
                    colliders[i + 1].p1,
                    __TS__New(Vector2, colliders[i + 1].p2.x, colliders[i + 1].p1.y)
                )
                if hit then
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", hit.x, hit.y, 10)
                            end
                        )
                    end
                    return hit
                end
                hit = ____exports.LineIntersects(
                    nil,
                    pos,
                    pos2,
                    __TS__New(Vector2, colliders[i + 1].p1.x, colliders[i + 1].p2.y),
                    colliders[i + 1].p2
                )
                if hit then
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", hit.x, hit.y, 10)
                            end
                        )
                    end
                    return hit
                end
                hit = ____exports.LineIntersects(
                    nil,
                    pos,
                    pos2,
                    colliders[i + 1].p1,
                    __TS__New(Vector2, colliders[i + 1].p1.x, colliders[i + 1].p2.y)
                )
                if hit then
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", hit.x, hit.y, 10)
                            end
                        )
                    end
                    return hit
                end
                hit = ____exports.LineIntersects(
                    nil,
                    pos,
                    pos2,
                    __TS__New(Vector2, colliders[i + 1].p2.x, colliders[i + 1].p1.y),
                    colliders[i + 1].p2
                )
                if hit then
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", hit.x, hit.y, 10)
                            end
                        )
                    end
                    return hit
                end
                if colliders[i + 1]:PointIsColliding(pos) then
                    print("point is in rect")
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", pos.x, pos.y, 10)
                            end
                        )
                    end
                    return pos
                end
                if colliders[i + 1]:PointIsColliding(pos2) then
                    print("point is in rect")
                    if draw then
                        DRAW(
                            nil,
                            2,
                            function()
                                love.graphics.circle("line", pos2.x, pos2.y, 10)
                            end
                        )
                    end
                    return pos2
                end
            end
            i = i + 1
        end
    end
    return
end
function ____exports.DEBUGDrawColliders(self)
    do
        local i = 0
        while i < #colliders do
            local collider = colliders[i + 1]
            DRAW(
                nil,
                999,
                function()
                    love.graphics.rectangle(
                        "line",
                        collider.position.x - collider.width / 2,
                        collider.position.y - collider.height / 2,
                        collider.width,
                        collider.height
                    )
                end
            )
            i = i + 1
        end
    end
end
return ____exports
