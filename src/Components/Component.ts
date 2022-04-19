import { Entity } from "../Entities/Entity";

/**
 * 
 * Abstract component class that has ovveridable methods.
 * To be used when making new components.
 * All callback funcitons are called by the entity the component is attached to.
 * Every component has a refferance to the entity its attached to.
 * When using `this.entity` in classes you must tell the typescript compiler that entity is not undefined using the ! salt (eg. this.entity!.transform)
 * 
 * Components should not be called when not attached to an entity.
 * 
 */

export abstract class Component {
    load(){}
    draw(){}
    update(dt: number){}

    entity?: Entity;
}