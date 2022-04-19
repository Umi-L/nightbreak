/**
 * 
 * Manages the load calls of entities.
 * 
*/


import { entities } from "../Entities/Entity";

export function ENGINE_LOAD(): void{
    entities.forEach(entity =>{
        entity.load();
    });
}