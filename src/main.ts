import { ENGINE_DRAW } from "./Engine/DrawManager";
import { ENGINE_UPDATE } from "./Engine/UpdateManager";
import { DebugSprite } from "./Entities/Entities/DebugSprite";
import { Player } from "./Entities/Entities/Player";
import { Tile } from "./Entities/Entities/Tile";
import { entities } from "./Entities/Entity";
import { Vector2 } from "./types"
import { Debug } from "./Entities/Entities/Debug";
import { ENGINE_LOAD } from './Engine/LoadManager';
import {TiledParser } from './libraries/TiledParser';
import * as map from "./assets/testmap.json";
import { RootObject } from "./libraries/tiledMap";
import { DEBUGDrawColliders } from "./libraries/Physics";

let parser = new TiledParser(map, love.graphics.newImage("assets/sheet.png"));

love.load = () => {
    new Debug()

    let player = new Player();
    player.transform.position = new Vector2(300, -200);

    let debugSprite = new DebugSprite(0);
    debugSprite.transform.position = new Vector2(100, 100);
    let debugSprite2 = new DebugSprite(2);
    debugSprite2.transform.position = new Vector2(500, 100);

    parser.initmap();

    ENGINE_LOAD();
};

love.update = (dt) => {
    ENGINE_UPDATE(dt);
}

love.draw = () => {
    parser.draw(5, 0, 0);

    ENGINE_DRAW();

    DEBUGDrawColliders();
}