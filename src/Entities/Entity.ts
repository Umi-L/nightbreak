/**
 * 
 * This is the default entity class, all new entities should extned from this and be put in the Entities/Entities directory as shown in ExampleEntity.ts
 * 
 * The entity stores an array of components that contain code that is ran by event callbacks.
 * 
 */

import { Component } from "../Components/Component"
import { Transform } from "../Components/Components/Transform";

let entities: Entity[] = [];

abstract class Entity {

    components: Component[] = [];
    transform: Transform;

    constructor() {
        entities.push(this);

        this.AddComponent(new Transform());

        this.transform = this.GetComponent(Transform);
    }

    public AddComponent(component: Component) {
        this.components.push(component);

        component.entity = this;
    }

    public GetComponent<C extends Component>(constr: { new(...args: any[]): C }): C {
        for (const component of this.components) {
            if (component instanceof constr) {
                return component as C
            }
        }
        error(`Component ${constr.name} not found on Entity ${this.constructor.name}`)
    }

    public RemoveComponent<C extends Component>(constr: { new(...args: any[]): C }): void {
        for (let i = 0; i < this.components.length; i++) {
            if (this.components[i] instanceof constr) {
                delete this.components[i];
            }
        }
    }

    load() {
        this.components.forEach((component) => {
            if (component.load) {
                component.load();
            }
        });
    }
    update(dt: number) {
        this.components.forEach((component) => {
            if (component.update) {
                component.update(dt);
            }
        });
    }
    draw() {
        this.components.forEach((component) => {
            if (component.draw) {
                component.draw();
            }
        });
    }
}

export { entities, Entity }