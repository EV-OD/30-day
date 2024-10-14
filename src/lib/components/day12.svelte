<script lang="ts">
	import { T, useTask, useThrelte } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
	import { PlaneGeometry, Vector3, Color } from 'three';
	import { createNoise2D } from 'simplex-noise';
	import { interactivity } from '@threlte/extras';
	import fragmentShader from './day-12/fragment.glsl?raw';
	import vertexShader from './day-12/vertex.glsl?raw';
	import { tweened } from 'svelte/motion';
	import { quadOut } from 'svelte/easing';
	import { writable } from 'svelte/store';

	interactivity();
	const pulsePosition = new Vector3();

	let time = writable(0);
	useTask(() => {
		$time += 0.01;
	});


	let {size} = useThrelte()
</script>

<T.Group>
  <T.PerspectiveCamera makeDefault position={[0, 0, 200]} fov={40}>
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
<T.Group position.x={0}>
<T.Group rotation.x={0}>
  <T.Mesh>
    <T.PlaneGeometry args={[100, 100, 10, 10]} />
    <T.ShaderMaterial wireframe={false} {fragmentShader} {vertexShader}
	uniforms={{
		Itime:{
			type:"f",
			value: 0
		}
	  }}
	uniforms.Itime.value={$time}
    />
  </T.Mesh>
</T.Group>
<!-- <T.Group rotation.x={0} position.x={10}>
	<T.Mesh>
	  <T.PlaneGeometry args={[100, 100, 10, 10]} />
	  <T.ShaderMaterial wireframe={true} {fragmentShader} {vertexShader}

	  />
	</T.Mesh>
  </T.Group> -->
</T.Group>

<!-- <T.AxesHelper args={[10]} /> -->
