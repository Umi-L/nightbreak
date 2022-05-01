local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____Entity = require("Entities.Entity")
local entities = ____Entity.entities
local ____Camera = require("libraries.Camera")
local Camera = ____Camera.Camera
local ____types = require("types")
local Vector2 = ____types.Vector2
____exports.MAIN_CAMERA = __TS__New(
    Camera,
    __TS__New(Vector2, 0, 0),
    love.graphics.getWidth(),
    love.graphics.getHeight()
)
____exports.DRAW_STACK = {}
function ____exports.DRAW(self, layer, callback, UI)
    if UI == nil then
        UI = false
    end
    local tempCall = {layer = layer, callback = callback, onUI = UI}
    local ____exports_DRAW_STACK_0 = ____exports.DRAW_STACK
    ____exports_DRAW_STACK_0[#____exports_DRAW_STACK_0 + 1] = tempCall
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
            if not ____exports.DRAW_STACK[smallestIndex + 1].onUI then
                ____exports.MAIN_CAMERA:attach()
                ____exports.DRAW_STACK[smallestIndex + 1]:callback()
                ____exports.MAIN_CAMERA:detach()
            else
                ____exports.DRAW_STACK[smallestIndex + 1]:callback()
            end
            if smallestIndex > -1 then
                __TS__ArraySplice(____exports.DRAW_STACK, smallestIndex, 1)
            end
            _ = _ + 1
        end
    end
end
return ____exports
