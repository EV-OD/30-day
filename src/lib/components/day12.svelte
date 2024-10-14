<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
	import { PlaneGeometry, Vector3, Color } from 'three';
	import { createNoise2D } from 'simplex-noise';
	import { interactivity } from '@threlte/extras';
	import fragmentShader from './day-12/fragment.glsl?raw';
	import vertexShader from './day-12/vertex.glsl?raw';
	import { tweened } from 'svelte/motion';
	import { quadOut } from 'svelte/easing';

	interactivity();
	const pulsePosition = new Vector3();
	const pulseTimer = tweened(0, {
		easing: quadOut
	});

	let time = 5;
	let increaseDirection = 1;
	useTask((delta) => {
		time += delta * increaseDirection;
		if (time > 10) {
			increaseDirection = -1;
		} else if (time < 5) {
			increaseDirection = 1;
		}
	});
</script>

<T.Group>
  <T.PerspectiveCamera makeDefault position={[10, 10, 10]} fov={30}>
    <OrbitControls autoRotate={false} autoRotateSpeed={1} />
  </T.PerspectiveCamera>
</T.Group>

<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0, 0, 4]} castShadow receiveShadow />

<T.DirectionalLight position={[10, 0, -10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10, 0, -10]} intensity={3} castShadow receiveShadow />
<T.PointLight
	position={[0, 10, 0]}
	intensity={10}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
/>

<T.PointLight
	position={[-1, 4, 0]}
	intensity={1}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
/>
<T.AmbientLight intensity={0.5} color={'white'} />
<T.Group rotation.x={0}>
  <T.Mesh
    on:click={({ point }) => {
      pulsePosition.set(point.x, point.y, point.z);
      pulseTimer.set(0, {
        duration: 0
      })
      pulseTimer.set(1, {
        duration: 3000
      }).then(()=>{
        pulseTimer.set(0, {
          duration: 0
        })
      })
    }}
  >
    <T.PlaneGeometry args={[10, 10, 100, 100]} />
    <T.ShaderMaterial wireframe={true} {fragmentShader} {vertexShader}
    uniforms={{
      pulseTimer: {
        value: 0
      },
      pulsePosition: {
        value: pulsePosition
      }
    }}
    uniforms.pulseTimer.value={$pulseTimer}
    />
  </T.Mesh>
</T.Group>

<!-- <T.AxesHelper args={[10]} /> -->
