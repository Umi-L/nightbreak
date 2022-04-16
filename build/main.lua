local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____DrawManager = require("Engine.DrawManager")
local ENGINE_DRAW = ____DrawManager.ENGINE_DRAW
local ____UpdateManager = require("Engine.UpdateManager")
local ENGINE_UPDATE = ____UpdateManager.ENGINE_UPDATE
local ____DebugSprite = require("Entities.Entities.DebugSprite")
local DebugSprite = ____DebugSprite.DebugSprite
local ____Player = require("Entities.Entities.Player")
local Player = ____Player.Player
local ____tile = require("Entities.Entities.tile")
local Tile = ____tile.Tile
local ____Entity = require("Entities.Entity")
local entities = ____Entity.entities
local ____TiledParser = require("libraries.TiledParser")
local TiledDebug = ____TiledParser.TiledDebug
local ____types = require("types")
local Vector2 = ____types.Vector2
love.load = function()
    local player = __TS__New(Player)
    player.transform.position = __TS__New(Vector2, 300, 0)
    local platform = __TS__New(Tile)
    platform.transform.position = __TS__New(Vector2, 500, 600)
    local debugSprite = __TS__New(DebugSprite)
    __TS__ArrayForEach(
        entities,
        function(____, entity)
            entity:load()
        end
    )
    TiledDebug(nil)
end
love.update = function(dt)
    ENGINE_UPDATE(nil, dt)
end
love.draw = function()
    ENGINE_DRAW(nil)
end
return ____exports
