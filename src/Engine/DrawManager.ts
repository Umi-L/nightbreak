/**
 * 
 * This is the Engine's rendering stack, this is where all draw calls get queued and sorted 
 * 
*/


import { Entity, entities } from "../Entities/Entity";
import { Camera } from "../libraries/Camera";
import { DEBUGDrawColliders } from "../libraries/Physics";
import { Vector2 } from "../types";

export interface drawCall {
    layer: number;
    callback: Function;
    onUI: boolean;
}

export let MAIN_CAMERA: Camera = new Camera(new Vector2(0, 0), love.graphics.getWidth(), love.graphics.getHeight());

export let DRAW_STACK: drawCall[] = [];

export function DRAW(layer: number, callback: Function, UI: boolean = false) {
    let tempCall: drawCall = {
        layer: layer,
        callback: callback,
        onUI: UI,
    }

    DRAW_STACK.push(tempCall);
}

export function ENGINE_DRAW() {
    entities.forEach(entity => {
        entity.draw();
    });

    /**
     * Todo:
     * possible preformance gain and higher fps with better sorting algorythmn here, currently has O(n^2)
     */

    for (let _ = 0; _ < DRAW_STACK.length; _++) {
        let smallestIndex: number = 0;
        let smallestValue: number = DRAW_STACK[0].layer;

        for (let j = 0; j < DRAW_STACK.length; j++) {
            if (DRAW_STACK[j].layer < smallestValue) {
                smallestValue = DRAW_STACK[j].layer;
                smallestIndex = j;
            }
        }

        if (!DRAW_STACK[smallestIndex].onUI) {
            MAIN_CAMERA.attach()

            DRAW_STACK[smallestIndex].callback();

            MAIN_CAMERA.detach()
        }
        else {
            DRAW_STACK[smallestIndex].callback()
        }
        if (smallestIndex > -1) {
            DRAW_STACK.splice(smallestIndex, 1);
        }

    }
}