<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
	import { PlaneGeometry, Vector3, PointLight } from 'three';
	import { createNoise2D } from 'simplex-noise';
	import { interactivity } from '@threlte/extras';
	import fragmentShader from './day-15/fragment.glsl?raw';
	import vertexShader from './day-15/vertex.glsl?raw';
	import { tweened } from 'svelte/motion';
	import { quadOut } from 'svelte/easing';

	interactivity();
	const pulsePosition = new Vector3();
	const pulseTimer = tweened(0, {
		easing: quadOut
	});

	const terrainSize = 100;
  	const geometry = new PlaneGeometry(terrainSize, terrainSize,300,300);
  	const noise = createNoise2D();
  	const vertices = geometry.getAttribute('position').array as Float32Array;
  	for(let i = 0; i < vertices.length; i += 3){
  	  const x = vertices[i];
  	  const y = vertices[i + 1];

  	  vertices[i + 2] = noise(x / 10, y / 10) * 2;
  	}

  	geometry.computeVertexNormals();
	  let lightPos = new Vector3(0, 10.0, 0);

let pointLightRef:PointLight | null = null;
</script>

<T.Group>
  <T.PerspectiveCamera makeDefault position={[10, 5, 10]} fov={30}>
    <OrbitControls autoRotate={false} autoRotateSpeed={1} />
  </T.PerspectiveCamera>
</T.Group>


<T.PointLight
	position={[0, lightPos, 0]}
	intensity={10}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
	on:create={({ref}) => pointLightRef = ref}
/>
{#if pointLightRef}
	<T.PointLightHelper args={[pointLightRef, 1]} />
{/if}

<T.AmbientLight intensity={0.5} color={'white'} />
<T.Group rotation.x={Math.PI / -2}>
  <T.Mesh
    on:click={({ point }) => {
      pulsePosition.set(point.x, point.y, point.z);
      pulseTimer.set(0, {
        duration: 0
      })
      pulseTimer.set(1, {
        duration: 3000
      })
    }}
	geometry={geometry}
  >
    <T.ShaderMaterial wireframe={false} {fragmentShader} {vertexShader}
    uniforms={{
      pulseTimer: {
        value: 0
      },
      pulsePosition: {
        value: pulsePosition
      },
	  lightPosition:{
			type:"v3",
			value: lightPos
		}
    }}
    uniforms.pulseTimer.value={$pulseTimer}
    />
  </T.Mesh>
</T.Group>

<!-- <T.AxesHelper args={[10]} /> -->
