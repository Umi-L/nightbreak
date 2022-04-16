import { Component } from "../Component";
import { Vector2 } from "../../types";

export class Transform extends Component {
    position: Vector2;
    rotation: number;
    scale: Vector2;

    constructor(position:Vector2 = new Vector2(0,0), rotation:number = 0, scale:Vector2 = new Vector2(1,1)) {
        super();

        this.position = position;
        this.rotation = rotation;
        this.scale = scale;
    }
}