import { Component } from "../Components/Component"
import { Transform } from "../Components/Components/Transform";

type ComponentClass<T extends Component> = new (...args: any[]) => T

let entities:Entity[] = [];

abstract class Entity{
    components:Component[] = [];
    transform:Transform;
    id:number;

    constructor(){
        this.id = entities.length;
        
        entities.push(this);

        this.AddComponent(new Transform());

        this.transform = this.GetComponent(Transform);
    }

    public AddComponent(component:Component){
        this.components.push(component);

        component.entity = this;
    }

    public GetComponent<C extends Component>(constr: { new(...args: any[]): C }): C {
        for (const component of this.components) {
            if (component instanceof constr) {
                return component as C
            }
        }
        throw new Error(`Component ${constr.name} not found on Entity ${this.constructor.name}`)
    }

    public RemoveComponent<C extends Component>(constr: { new(...args: any[]): C }): void {
        for (let i = 0; i < this.components.length; i++) {
            if (this.components[i] instanceof constr) {
                delete this.components[i];
            }
        }
    }

    load(){
        console.log("loaded Entity")

        this.components.forEach((component)=>{
            if (component.load) {
                component.load();
            }
        });
    }
    update(dt:number){
        this.components.forEach((component)=>{
            if (component.update) {
                component.update(dt);
            }
        });
    }
    draw(){
        this.components.forEach((component)=>{
            if (component.draw) {
                component.draw();
            }
        });
    }
}

export {entities, Entity}