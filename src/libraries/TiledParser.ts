import { DRAW } from "../Engine/DrawManager";
import * as map from "../maps/untitled.json";


export function TiledDebug(){
    
    for (let i = 0; i < map.layers.length; i++){
        if (map.layers[i].type === "tilelayer"){
            //height and width are always defined on a tilelayer.
            for (let y = 0; y < map.layers[i].height!; y++){
                for (let x = 0; x < map.layers[i].width!; x++){
                    DRAW()
                }
            }
        }
    }
}