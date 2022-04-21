import { Drawable, Quad, Texture } from "love.graphics";
import { DRAW } from "../../Engine/DrawManager";
import { Component } from "../Component";
import { Transform } from "./Transform";

export class SpriteRender extends Component {

    layer: number;
    sprite: Drawable;
    origin:string;
    quad: Quad|undefined;
    width: number|undefined;
    height: number|undefined;

    constructor(sprite: Drawable, layer:number=1, quad?:Quad, origin:string = "center", width?:number, height?:number) {
        super();

        this.sprite = sprite;
        this.layer = layer;
        this.origin = origin;
        this.quad = quad;

        this.width = width;
        this.height = height;
    }

    draw(){
        let transform = this.entity!.GetComponent(Transform);
        
        let offsetX:number = 0;
        let offsetY:number = 0;

        if (this.origin == "center" && !this.width && !this.height){
            offsetX = (this.sprite as Texture).getWidth() / 2;
            offsetY = (this.sprite as Texture).getHeight() / 2;
        }
        else{
            if (!this.width || !this.height){
                error("Proveded only 1 param for width and height")
            }

            offsetX = this.width / 2;
            offsetY = this.height / 2;
        }

        let callback = () => {
            if (this.quad){
                love.graphics.draw(<Texture>this.sprite, this.quad, transform.position.x, transform.position.y, transform.rotation, transform.scale.x, transform.scale.y, offsetX, offsetY);
            }
            else{
                love.graphics.draw(this.sprite, transform.position.x, transform.position.y, transform.rotation, transform.scale.x, transform.scale.y, offsetX, offsetY);

            }
        }
        DRAW(this.layer, callback);
    }
}