import { Entity } from "../Entity";

export class ExampleEntity extends Entity{

    /**
     * The constructor is called whenever this class is instantiated.
    */

    constructor(){
        //this super call executes all the code in the Entity classes' constructor.
        super();

    }

    /**
     * Load is called at the very start of the game, this will not fire unless the entity is instantiated during load. 
     * It is reccomened for most cases to put this code into the constructor.
    */
    load(): void {
        super.load();

    /**
     * <-- Code here -->
     */
    }

    /**
     * Update is called once per frame before draw
     */
    update(dt: number): void{
        //the parameter dt is the delta time, (time between frames)


        // this super call updates all components of the entity.
        super.update(dt);

        /**
         * <-- Code here -->
         */
    }

    /**
     * Callback function used to draw on the screen every frame. 
     */
    draw(): void {
        // this super call draws all components of the entity.
        super.draw();

        /**
         * <-- Code here -->
         */
    }
}