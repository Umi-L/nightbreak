import { Vector2 } from "../types"

/** Camera Smoother */
type CameraSmoother = (pos:Vector2, delta:Vector2, ...vargs: unknown[]) => Vector2

/** Camera Class */
export class Camera {

    /** Camera Position */
    protected position:Vector2;

    /** Camera Width */
    protected width: number

    /** Camera Height */
    protected height: number

    /** Camera Scaling, 1 = 100% */
    protected scale: number

    /** Default Smoothers */
    readonly default_smoothers = {
        /** None, directly return [dx, dy] */
        none(pos:Vector2, delta:Vector2): Vector2 {
            return new Vector2(delta.x, delta.y);
        },

        /**
         * Common Smoother, speed proportional to the distance to the target
         * @param vargs `[0]`: speed factor (1 = 100% -> Instantly), defaults to 0.1
         */
        common(pos:Vector2, delta:Vector2, ...vargs: unknown[]): Vector2 {
            if (pos.x == delta.x && pos.y == delta.y) return new Vector2(delta.x, delta.y)
            let speed = typeof vargs[0] == "number" ? vargs[0] : 0.001
            speed = Math.min(1, speed)
            return new Vector2(
                pos.x != delta.x ? (delta.x - pos.x) * speed + pos.x : pos.x,
                pos.y != delta.y ? (delta.y - pos.y) * speed + pos.y : pos.y
            )
        }
    }

    /**
     * Camera Constructor
     * @param position Camera Focus postion defaults to 0,0
     * @param scale Camera Scaling, defaults to 1 = 100%
     */
    constructor(position: Vector2 = new Vector2(0,0), width: number, height: number, scale: number = 1) {
        this.position = position;
        this.width = width;
        this.height = height;
        this.scale = scale;
    }

    /**
     * Move the camera by some vector
     * @param delta Direction to move the camera
     */
    move(delta:Vector2) {
        this.position = delta;
    }

    /**
     * Multiply zoom factor
     * @param mul Zoom changes, 1 = 100%
     */
    zoom(mul: number) {
        this.scale *= mul
    }

    /**
     * Get camera focused position
     * @returns
     * ```text
     * position: Vector2
     * ```
     */
    getPosition(): Vector2 {
        return new Vector2(this.position.x, this.position.y);
    }

    /**
     * Set the camera position
     * @param pos Point to focus

     */
    setPosition(pos: Vector2) {
        this.position.x = pos.x;
        this.position.y = pos.y;
    }

    /** Get zoom factor */
    getScale() {
        return this.scale
    }

    /**
     * Set zoom factor
     * @param scale New zoom factor
     */
    setScale(scale: number) {
        this.scale = scale
    }

    /**
     * Transform point from camera coordinates to world coordinates
     * @param pos Point to transform
     * @returns
     * ```text
     * x: Transformed point (X-axis)
     * y: Transformed point (Y-axis)
     * ```
     */
    getWorldCoords(pos:Vector2): Vector2 {
        let scale = this.scale
        return new Vector2(pos.x / scale - this.position.x - this.width / 2, pos.y / scale - this.position.y - this.height / 2)
    }

    /**
     * Transform point from world coordinates to camera coordinates
     * @param pos Point to transform
     * @returns
     * ```text
     * x: Transformed point (X-axis)
     * y: Transformed point (Y-axis)
     * ```
     */
    getCameraCoords(pos:Vector2): Vector2 {
        let scale = this.scale
        return new Vector2((pos.x + this.position.x + this.width / 2) * scale, (pos.y + this.position.y + this.height / 2) * scale)
    }

    /**
     * Look at a position with smoother view
     * @param pos Position
     * @param smoother Movement smoothing function
     * @param vargs Additional parameters to the smoothing function
     */
    lookAt(pos:Vector2 = this.position, smoother: CameraSmoother | keyof Camera["default_smoothers"] = this.default_smoothers.none, ...vargs: unknown[]) {
        if (typeof smoother == "string") {
            smoother = this.default_smoothers[smoother]
        }
        this.position = smoother(this.position, pos, ...vargs)
    }

    /**
     * Look at a position in segment with smoother view
     * @param x Position X-axis
     * @param y Position Y-axis
     * @param min_x Minimum Position X-axis
     * @param max_x Maximum Position X-axis
     * @param min_y Minimum Position Y-axis
     * @param max_y Maximum Position Y-axis
     * @param smoother Movement smoothing function
     * @param vargs Additional parameters to the smoothing function
     */
    lookAtSegment(
        x: number,
        y: number,
        min_x: number,
        max_x: number,
        min_y: number,
        max_y: number,
        smoother: CameraSmoother | keyof Camera["default_smoothers"] = this.default_smoothers.none,
        ...vargs: unknown[]
    ) {
        let scale = this.scale
        this.lookAt(
            new Vector2(
                Math.max((min_x + this.width / 2) / scale, Math.min(x, (max_x - this.width / 2) / scale)),
                Math.max((min_y + this.height / 2) / scale, Math.min(y, (max_y - this.height / 2) / scale))
            ),
            smoother,
            ...vargs
        )
    }

    /** Apply camera transformations until `detach()` */
    attach() {
        love.graphics.push("transform")
        love.graphics.translate(this.width / 2, this.height / 2)
        love.graphics.scale(this.scale)
        love.graphics.translate(-this.position.x, -this.position.y)
    }

    /** Unset camera transformations */
    detach() {
        love.graphics.pop()
    }
}
