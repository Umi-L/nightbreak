import { ENGINE_DRAW } from "./Engine/DrawManager";
import { ENGINE_UPDATE } from "./Engine/UpdateManager";
import { DebugSprite } from "./Entities/Entities/DebugSprite";
import { Player } from "./Entities/Entities/Player";
import { Tile } from "./Entities/Entities/tile";
import { Entity, entities } from "./Entities/Entity";
import { DEBUGDrawColliders } from "./libraries/physics";
import { TiledDebug } from "./libraries/TiledParser";
import {Vector2, Color} from "./types"



love.load = () => {
    let player = new Player();
    player.transform.position = new Vector2(300,0)
    let platform = new Tile()
    platform.transform.position = new Vector2(500,600);

    let debugSprite = new DebugSprite();

    entities.forEach(entity =>{
        entity.load();
    });

    TiledDebug()
};

love.update = (dt) => {
    ENGINE_UPDATE(dt); 
}

love.draw = () => {
    ENGINE_DRAW();
}