import { DRAW } from "../../Engine/DrawManager";
import { Entity } from "../Entity";

export class Debug extends Entity{
    update(dt: number){
        super.update(dt);
        
        DRAW(5, ()=>{
            love.graphics.print("Current FPS: " + love.timer.getFPS(), 10, 10)
        }, true)
    }
}