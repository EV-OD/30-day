<script context="module" lang="ts">
    export type AnimationOpts = {
        duration: number;
        delay?: number;
        easing?: ((t: number) => number) | undefined;
        func?: ((t: number) => number) | undefined;
    };

    export type AnimationPosStore = {
        isAnimating: boolean;
        duration: number;
        delay: number;
        easing: (t: number) => number;
        intialPos: Vector3;
        finalPos: Vector3;
        func: ((t: number) => number) | undefined;
        resolve?: () => void;
    };

    export type AnimationLookAtStore = {
        isAnimating: boolean;
        duration: number;
        delay: number;
        easing: (t: number) => number;
        intialLookAt: Vector3;
        finalLookAt: Vector3;
        func: ((t: number) => number) | undefined;
        resolve?: () => void;
    };
</script>

<script lang="ts">
    import { T, useTask } from '@threlte/core';
    import { ContactShadows, Float, Grid, OrbitControls } from '@threlte/extras';
    import { cubicIn, cubicOut, elasticIn, elasticInOut, linear } from 'svelte/easing';
    import { spring, tweened } from 'svelte/motion';
    import { SpotLight, DirectionalLight, PointLight, Vector3, PerspectiveCamera } from 'three';

    export let cameraPos = new Vector3(0, 0, 0);
    export let cameraLookAt = new Vector3(0, 10, 0);

    export let cameraRef: PerspectiveCamera;

    let isPosAnimation: AnimationPosStore = {
        isAnimating: false,
        duration: 1000,
        delay: 0,
        easing: linear,
        intialPos: new Vector3(0, 0, 0),
        finalPos: new Vector3(0, 0, 0),
        func: undefined
    };
    let isLookAtAnimation: AnimationLookAtStore = {
        isAnimating: false,
        duration: 1000,
        delay: 0,
        easing: linear,
        intialLookAt: new Vector3(0, 0, 0),
        finalLookAt: new Vector3(0, 0, 0),
        func: undefined
    };

    export const animateCameraPos = (pos: Vector3, options: AnimationOpts) => {
        return new Promise<void>((resolve) => {
            isPosAnimation = {
                isAnimating: true,
                duration: options.duration && options.duration > 0 ? options.duration : 1000,
                delay: options.delay && options.delay > 0 ? options.delay : 0,
                easing: options.easing ? options.easing : linear,
                intialPos: cameraPos.clone(),
                finalPos: pos,
                func: options.func,
                resolve
            };
        });
    };

    export const animateCameraLookAt = (lookAt: Vector3, options: AnimationOpts) => {
        return new Promise<void>((resolve) => {
            isLookAtAnimation = {
                isAnimating: true,
                duration: options.duration && options.duration > 0 ? options.duration : 1000,
                delay: options.delay && options.delay > 0 ? options.delay : 0,
                easing: options.easing ? options.easing : linear,
                intialLookAt: cameraLookAt.clone(),
                finalLookAt: lookAt,
                func: options.func,
                resolve
            };
        });
    };

    let animationStartTime: number | null = null;

    useTask((delta) => {
        if (isPosAnimation.isAnimating) {
            const { duration, delay, easing, intialPos, finalPos, func, resolve } = isPosAnimation;

            if (animationStartTime === null) {
                animationStartTime = performance.now();
            }

            let elapsedTime = performance.now() - animationStartTime - delay;
            if (elapsedTime < 0) return;

            const t = Math.min(elapsedTime / duration, 1);
            const easedT = easing(t);

            if (t <= 1) {
                const newPos = new Vector3().lerpVectors(intialPos, finalPos, easedT);
                cameraPos = newPos;
                if (func) func(easedT);
            } else {
                cameraPos = finalPos.clone();
                isPosAnimation.isAnimating = false;
                animationStartTime = null;
                if (resolve) resolve();
            }
        }

        if (isLookAtAnimation.isAnimating) {
            console.log('isLookAtAnimation');
            const { duration, delay, easing, intialLookAt, finalLookAt, func, resolve } = isLookAtAnimation;

            if (animationStartTime === null) {
                animationStartTime = performance.now();
            }

            let elapsedTime = performance.now() - animationStartTime - delay;
            if (elapsedTime < 0) return;

            const t = Math.min(elapsedTime / duration, 1);
            const easedT = easing(t);

            if (t < 1) {
                const newLookAt = new Vector3().lerpVectors(intialLookAt, finalLookAt, easedT);
                cameraRef.lookAt(newLookAt);
                console.table({ newLookAt, intialLookAt, finalLookAt, easedT });
                
                if (func) func(easedT);
            } else {
                console.table({ finalLookAt });
                cameraRef.lookAt(finalLookAt.clone());
                isLookAtAnimation.isAnimating = false;
                animationStartTime = null;
                if (resolve) resolve();
            }
        }
    });
</script>

<T.Group position={cameraPos.toArray()}>
    <T.PerspectiveCamera
        makeDefault
        position={[0, 0, 0]}
        fov={15}
        on:create={({ ref }) => {
            cameraRef = ref;
            cameraRef.lookAt(cameraLookAt);
        }}
    />
</T.Group>
