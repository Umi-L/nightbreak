local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local DRAW = ____DrawManager.DRAW
____exports.TiledParser = __TS__Class()
local TiledParser = ____exports.TiledParser
TiledParser.name = "TiledParser"
function TiledParser.prototype.____constructor(self, map, spriteSheet)
    self.spriteSheet = spriteSheet
    self.canvas = love.graphics.newCanvas()
    self.map = map
    self.tileWidth = self.map.tilewidth
    self.tileHeight = self.map.tileheight
    self.tiles = ____exports.TiledParser:spriteSheetToQuads(spriteSheet, self.tileHeight, self.tileWidth)
end
function TiledParser.spriteSheetToQuads(self, spriteSheet, tileWidth, tileHeight)
    local quads = {}
    local dimentions = {spriteSheet:getDimensions()}
    do
        local y = 0
        while y < spriteSheet:getHeight() / tileHeight do
            do
                local x = 0
                while x < spriteSheet:getWidth() / tileWidth do
                    quads[#quads + 1] = love.graphics.newQuad(
                        x * tileWidth,
                        y * tileHeight,
                        tileWidth,
                        tileHeight,
                        dimentions[1],
                        dimentions[2]
                    )
                    x = x + 1
                end
            end
            y = y + 1
        end
    end
    return quads
end
function TiledParser.prototype.initmap(self)
    local layers = self.map.layers
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    do
        local i = 1
        while i <= 2 do
            local layer = layers[i]
            if layer.type == "tilelayer" then
                do
                    local y = 0
                    while y < layer.height do
                        do
                            local x = 0
                            while x < layer.width do
                                local tileIndex = y * layer.width + x
                                local spriteIndex = layer.data[tileIndex + 1]
                                if spriteIndex ~= 0 then
                                    local tilex = x * self.tileWidth
                                    local tiley = y * self.tileHeight
                                    love.graphics.draw(self.spriteSheet, self.tiles[spriteIndex], tilex, tiley)
                                end
                                x = x + 1
                            end
                        end
                        y = y + 1
                    end
                end
            end
            i = i + 1
        end
    end
    love.graphics.setCanvas()
end
function TiledParser.prototype.draw(self, layer, x, y)
    DRAW(
        nil,
        layer,
        function()
            love.graphics.draw(self.canvas, x, y)
        end
    )
end
return ____exports
