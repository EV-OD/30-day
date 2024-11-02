<script lang="ts">
    import { useTask, useThrelte } from '@threlte/core'
    import {
      BlendFunction,
      EffectComposer,
      EffectPass,
      OutlineEffect,
      RenderPass
    } from 'postprocessing'
    import { onMount } from 'svelte'
  
    export let selectedMesh: THREE.Mesh
    export let show = true;

  
    const { scene, renderer, camera, size, autoRender, renderStage } = useThrelte()
  
    const composer = new EffectComposer(renderer)
  
    const setupEffectComposer = (camera: THREE.Camera, selectedMesh: THREE.Mesh) => {
      composer.removeAllPasses()
      composer.addPass(new RenderPass(scene, camera))
  
      const outlineEffect = new OutlineEffect(scene, camera, {
        blendFunction: BlendFunction.ALPHA,
        edgeStrength: 10,
        pulseSpeed: 0.0,
        visibleEdgeColor: 0xffffff,
        hiddenEdgeColor: 0xffffff,
        xRay: false,
        blur: true
      })
      if (selectedMesh !== undefined) {
        outlineEffect.selection.add(selectedMesh)
      }
      composer.addPass(new EffectPass(camera, outlineEffect))
    }
  
    $: setupEffectComposer($camera, selectedMesh)
    $: composer.setSize($size.width, $size.height)
  
    onMount(() => {
      let before = autoRender.current
      autoRender.set(false)
      return () => {
        composer.removeAllPasses()
        autoRender.set(before)
      }
    })
  
    useTask(
      (delta) => {
            composer.render(delta)
      },
      { stage: renderStage, autoInvalidate: false }
    )
  </script>
  