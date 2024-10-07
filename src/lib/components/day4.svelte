<script lang="ts">
	import { T } from '@threlte/core';
	import { ContactShadows, Float, Grid, OrbitControls } from '@threlte/extras';
	import { cubicIn, cubicOut, elasticIn, elasticInOut } from 'svelte/easing';
	import { spring, tweened } from 'svelte/motion';
	import { SpotLight, DirectionalLight, PointLight, PerspectiveCamera, Vector3 } from 'three';
	import {
		BoxGeometry,
		SphereGeometry,
		ConeGeometry,
		CylinderGeometry,
		TorusGeometry,
		PlaneGeometry,
		CircleGeometry,
		RingGeometry,
		TetrahedronGeometry,
		IcosahedronGeometry
	} from 'three';

	import CustomCamera, {type AnimationOpts} from './cameraComponent/CustomCamera.svelte';

	// other codes ....
	let cameraRef: PerspectiveCamera;
	let animateCameraPos:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	let animateCameraLookAt:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	$:{
		if(animateCameraPos && animateCameraLookAt){
			runAnimation()
		}
	}
	async function runAnimation(){
		if(animateCameraPos && animateCameraLookAt){
			let x = await animateCameraLookAt(new Vector3(0, 0, 0), {delay:500, duration: 2000, easing: cubicOut})
			animateCameraPos(new Vector3(-10, 10, -40), {duration: 3000,func: function(t:number){
				if(cameraRef){
					cameraRef.lookAt(0, 0, 0)
				}
				return t
			}})
		}
	}
</script>

<CustomCamera 
bind:cameraRef 
cameraPos={new Vector3(-10, 10, 10)}
cameraLookAt={new Vector3(0, 10, 0)}
bind:animateCameraPos
bind:animateCameraLookAt
/>

<!-- other codes -->

<T.Mesh position={[-1, 1, 0]} castShadow receiveShadow>
	<T.BoxGeometry args={[1, 1, 1]} />
	<T.MeshStandardMaterial color="lightblue" />
</T.Mesh>

<!-- sphere -->
<T.Mesh position={[1, 1, 0]} castShadow receiveShadow>
	<T.SphereGeometry args={[0.5, 32, 32]} />
	<T.MeshStandardMaterial color="red" />
</T.Mesh>

<!--  plane -->
<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
	<T.PlaneGeometry args={[100, 100]} />
	<T.MeshStandardMaterial color="orange" />
</T.Mesh>

<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
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
/>
