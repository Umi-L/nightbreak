import { Entity } from "../Entities/Entity";

export abstract class Component {
    load(){
        if (!this.entity){
            return
        }
    }
    draw(){
        if (!this.entity){
            return
        }
    }
    update(dt: number){
        if (!this.entity){
            return
        }
    }

    entity?: Entity;
}