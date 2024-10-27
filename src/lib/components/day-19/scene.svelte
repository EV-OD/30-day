<script lang="ts">
	import { Debug, RigidBody, Collider } from '@threlte/rapier';
	import { T, useTask } from '@threlte/core';
	import { AutoColliders } from '@threlte/rapier';
	import { Group, Vector3, PerspectiveCamera } from 'three';
	import { cubicIn, cubicInOut, cubicOut, linear, quadOut } from 'svelte/easing';
	import CustomCamera, { type AnimationOpts } from '../cameraComponent/CustomCamera.svelte';
	import { spring } from 'svelte/motion';
	import { OrbitControls } from '@threlte/extras';
	import fragmentShader from './fragment.glsl?raw';
	import vertexShader from './vertex.glsl?raw';
	import Home2 from '../models/home2.svelte';
	import Emitter from './Emitter.svelte';
</script>

<T.PerspectiveCamera makeDefault position={[-14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={false} enableDamping />
</T.PerspectiveCamera>

<!-- <Debug /> -->

<T.Group position={[0, -0.5, 0]}>
	<AutoColliders shape={'cuboid'}>
		<T.Mesh receiveShadow>
			<T.BoxGeometry args={[100, 1, 100]} />
			<T.MeshStandardMaterial color="orange" />
		</T.Mesh>
	</AutoColliders>
</T.Group>

<!-- <T.Group position={[0, -0.5, 0]}>
	<AutoColliders shape={'cuboid'}>
	  <T.Mesh receiveShadow>
		<T.BoxGeometry args={[10, 1, 10]} />
		<T.MeshStandardMaterial />
	  </T.Mesh>
	</AutoColliders>
  </T.Group> -->

<Emitter/>

<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={100} castShadow />
<T.DirectionalLight position={[0, 0, 4]} castShadow receiveShadow />

<T.DirectionalLight position={[10, 0, -10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10, 0, -10]} intensity={3} castShadow receiveShadow />

<T.PointLight
	position={[-1, 4, 0]}
	intensity={1}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
	color={`0, 255, 255)`}
/>
