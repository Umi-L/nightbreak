/**
 * 
 * This is the Engine's update stack, this is where all entities get their updates called.
 * 
*/


import { entities } from "../Entities/Entity";

export function ENGINE_UPDATE(dt:number): void{
    entities.forEach(entity =>{
        entity.update(dt);
    });
}