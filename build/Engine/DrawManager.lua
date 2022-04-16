local ____lualib = require("lualib_bundle")
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____Entity = require("Entities.Entity")
local entities = ____Entity.entities
local ____physics = require("libraries.physics")
local DEBUGDrawColliders = ____physics.DEBUGDrawColliders
____exports.DRAW_STACK = {}
function ____exports.DRAW(self, layer, callback)
    local tempCall = {layer = layer, callback = callback}
    local ____ = console
    __TS__ArrayPush(____exports.DRAW_STACK, tempCall)
end
function ____exports.ENGINE_DRAW(self)
    __TS__ArrayForEach(
        entities,
        function(____, entity)
            entity:draw()
        end
    )
    do
        local _ = 0
        while _ < #____exports.DRAW_STACK do
            local smallestIndex = 0
            local smallestValue = ____exports.DRAW_STACK[1].layer
            do
                local j = 0
                while j < #____exports.DRAW_STACK do
                    if ____exports.DRAW_STACK[j + 1].layer < smallestValue then
                        smallestValue = ____exports.DRAW_STACK[j + 1].layer
                        smallestIndex = j
                    end
                    j = j + 1
                end
            end
            ____exports.DRAW_STACK[smallestIndex + 1]:callback()
            if smallestIndex > -1 then
                __TS__ArraySplice(____exports.DRAW_STACK, smallestIndex, 1)
            end
            _ = _ + 1
        end
    end
    DEBUGDrawColliders(nil)
end
return ____exports
