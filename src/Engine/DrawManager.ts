import { Entity, entities } from "../Entities/Entity";
import { DEBUGDrawColliders } from "../libraries/Physics";

export interface drawCall {
    layer: number;
    callback: Function;
}

export let DRAW_STACK:drawCall[] = [];

export function DRAW(layer:number, callback:Function){
    let tempCall: drawCall = {
        layer: layer,
        callback: callback
    }

    console

    DRAW_STACK.push(tempCall);
}

export function ENGINE_DRAW() {
    entities.forEach(entity =>{
        entity.draw();
    });

    /**
     * Todo:
     * possible preformance gain and higher fps with better sorting algorythmn here, currently has O(n^2)
     */

    for (let _ = 0; _ < DRAW_STACK.length; _++) {
        let smallestIndex:number = 0;
        let smallestValue:number = DRAW_STACK[0].layer;

        for (let j = 0; j < DRAW_STACK.length; j++){
            if (DRAW_STACK[j].layer < smallestValue){
                smallestValue = DRAW_STACK[j].layer;
                smallestIndex = j;
            }
        }

        DRAW_STACK[smallestIndex].callback();
        if (smallestIndex > -1) {
            DRAW_STACK.splice(smallestIndex, 1);
        }
        
    }   

    DEBUGDrawColliders();
}