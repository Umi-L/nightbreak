import { Component } from "../Component";
import {Actor, AABB, Solid} from "../../libraries/Physics"
import { Vector2 } from "../../types";
import { Transform } from "./Transform";

export class SolidCollider extends Component {
    solid: Solid;

    constructor(boundingBox: AABB) {
        super();
        this.solid = new Solid(boundingBox);
    }

    update(dt:number): void {
        super.update(dt);

        this.solid.collider.updatePosition();
    }
}