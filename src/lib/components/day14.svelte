<script lang="ts">
	import { T, useTask, useThrelte } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
	import { PlaneGeometry, Vector3, PointLight } from 'three';
	import { createNoise2D } from 'simplex-noise';
	import { interactivity } from '@threlte/extras';
	import fragmentShader from './day-14/fragment.glsl?raw';
	import vertexShader from './day-14/vertex.glsl?raw';
	import { writable } from 'svelte/store';

	const terrainSize = 100;
  	const geometry = new PlaneGeometry(terrainSize, terrainSize,700,700);
  	const noise = createNoise2D();
  	const vertices = geometry.getAttribute('position').array as Float32Array;
  	for(let i = 0; i < vertices.length; i += 3){
  	  const x = vertices[i];
  	  const y = vertices[i + 1];

  	  vertices[i + 2] = noise(x / 10, y / 10) * 2;
  	}

  	geometry.computeVertexNormals();

	interactivity();
	const pulsePosition = new Vector3();

	let time = writable(0);
	useTask(() => {
		$time += 0.01;
	});


	let {size} = useThrelte()
	let lightPos = new Vector3(0, 10.0, 0);

	let pointLightRef:PointLight | null = null;
</script>

<T.Group>
  <T.PerspectiveCamera makeDefault position={[20, 20, 20]} fov={40}>
    <OrbitControls autoRotate={true} autoRotateSpeed={3} />
  </T.PerspectiveCamera>
</T.Group>


<T.PointLight
	position={lightPos.toArray()}
	intensity={500.0}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
	on:create={({ref}) => pointLightRef = ref}
	color={'red'}
/>

{#if pointLightRef}
	<T.PointLightHelper args={[pointLightRef, 1]} />
{/if}
<T.AmbientLight intensity={0.5} color={'white'} />
<T.Group position.x={0}>
<T.Group rotation.x={0}>
  <T.Mesh 
  rotation.x={Math.PI / -2}
  	geometry={geometry} 
  >
    <T.ShaderMaterial wireframe={false} {fragmentShader} {vertexShader}
	uniforms={{
		Itime:{
			type:"f",
			value: 0
		},
		lightPosition:{
			type:"v3",
			value: lightPos
		},
	  }}
	uniforms.Itime.value={$time}
    />
  </T.Mesh>
</T.Group>

<!-- <T.Group rotation.x={0}>
	<T.Mesh 
	rotation.x={Math.PI / -2}
		geometry={geometry} 
	>
	  <T.MeshStandardMaterial color={'gray'} />
	</T.Mesh>
  </T.Group> -->
</T.Group>

<T.AxesHelper args={[10]} />
