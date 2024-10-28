<script lang="ts">
    import { useThrelte, useTask } from '@threlte/core'
    import {
      EffectComposer,
      EffectPass,
      RenderPass,
      SMAAEffect,
      SMAAPreset,
      BloomEffect,
      KernelSize
    } from 'postprocessing'
	import type { Camera } from 'three';
  
    const { scene, renderer, camera, size } = useThrelte()
  
    const composer = new EffectComposer(renderer)
  
    const setupEffectComposer = (camera:Camera) => {
      composer.removeAllPasses()
      composer.addPass(new RenderPass(scene, camera))
      composer.addPass(
        new EffectPass(
          camera,
          new BloomEffect({
            intensity: 10,
            luminanceThreshold: 0.01,
            height: 512,
            width: 512,
            luminanceSmoothing: 0.01,
            mipmapBlur: true,
            kernelSize: KernelSize.MEDIUM
          })
        )
      )
      composer.addPass(
        new EffectPass(
          camera,
          new SMAAEffect({
            preset: SMAAPreset.LOW
          })
        )
      )
    }
  
    // We need to set up the passes according to the camera in use
    $: setupEffectComposer($camera)
    $: composer.setSize($size.width, $size.height)
  
    useTask((delta) => {
      composer.render(delta)
    })
  </script>
  