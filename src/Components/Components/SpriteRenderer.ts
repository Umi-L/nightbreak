import { Drawable, Texture } from "love.graphics";
import { DRAW } from "../../Engine/DrawManager";
import { Component } from "../Component";
import { Transform } from "./Transform";

export class SpriteRender extends Component {

    layer: number;
    sprite: Drawable;
    origin:string;

    constructor(sprite: Drawable, layer:number=1, origin:string = "Center") {
        super();

        this.sprite = sprite;
        this.layer = layer;
        this.origin = origin;
    }

    draw(){
        super.draw();

        let transform = this.entity!.GetComponent(Transform);
        
        let offsetX:number = 0;
        let offsetY:number = 0;

        if (this.origin == "Center"){
            offsetX = (this.sprite as Texture).getWidth() / 2;
            offsetY = (this.sprite as Texture).getHeight() / 2;
        }

        let callback = () => {
            love.graphics.draw(this.sprite,transform.position.x, transform.position.y, transform.rotation, transform.scale.x, transform.scale.y, offsetX, offsetY);
        }

        DRAW(this.layer, callback);
    }
}