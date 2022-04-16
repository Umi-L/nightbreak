import { entities } from "../Entities/Entity";

export function ENGINE_UPDATE(dt:number): void{
    entities.forEach(entity =>{
        entity.update(dt);
    });
}