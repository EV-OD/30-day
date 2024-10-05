<script lang="ts">
	import { T } from '@threlte/core';
	import { ContactShadows, Float, Grid, OrbitControls } from '@threlte/extras';
	import { cubicIn, cubicOut, elasticIn, elasticInOut } from 'svelte/easing';
	import { spring, tweened } from 'svelte/motion';
	import { SpotLight, DirectionalLight, PointLight } from 'three';

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

	let isModelLoaded = false;
	let isSpotLightLoaded = false;
	let isPlaneLoaded = false;
	let isLightLoaded = false;
	let isLightPlaneLoaded = false;
	
	let modelScale = tweened(0, {
		duration: 1000,
		easing: cubicOut
	});
	let secondModelScale = tweened(0, {
		duration: 1000,
		easing: cubicOut
	});
	let spotLightIntensity = tweened(0,	{
		duration: 1000,
		easing:cubicIn,
		delay:100
	});
	let AmbientLightIntensity = tweened(0, {
		duration: 1000,
		easing:cubicIn,
		delay:100
	})
	let lightIntensity1 = tweened(0, {
		duration: 1000,
		easing:cubicIn,
		delay:100
	})

	let lightIntensity2 = tweened(0, {
		duration: 1000,
		easing:cubicIn,
		delay:100
	})
	let lightIntensity3 = tweened(0, {
		duration: 1000,
		easing:cubicIn,
		delay:100
	})

	let pointLightIntensity = tweened(0, {
		duration: 1000,
		easing:cubicIn,
		delay:100
	})
	
	spotLightIntensity.set(100).then(()=>{
		isSpotLightLoaded = true;
		setTimeout(()=>{
			modelScale.set(1).then(()=>{
				secondModelScale.set(1).then(()=>{
					isModelLoaded = true;
					isLightLoaded = true;
					isPlaneLoaded = true;
						lightIntensity1.set(1).then(()=>{
							lightIntensity2.set(1).then(()=>{
								lightIntensity3.set(1).then(()=>{
									isLightPlaneLoaded = true;
									pointLightIntensity.set(10)
								})
							})
						})
				})
			})
		},400)
	});

	let spotLight: SpotLight | undefined;
	let dirLight1: DirectionalLight | undefined;
	let dirLight2: DirectionalLight | undefined;
	let dirLight3: DirectionalLight | undefined;

	let pointLight: PointLight | undefined;

	let planeSize = 5;
</script>

<T.PerspectiveCamera makeDefault position={[15, 50, -70]} fov={15}>
	<OrbitControls zoom={1} enableZoom={true} enableDamping />
</T.PerspectiveCamera>

<T.Mesh position={[-1, 1, 0]} castShadow receiveShadow scale={$modelScale}>
	<T.BoxGeometry args={[1, 1, 1]} />
	<T.MeshStandardMaterial color="lightblue" />
</T.Mesh>

<!-- sphere -->
<T.Mesh position={[1, 1, 0]} castShadow receiveShadow scale={$secondModelScale}>
	<T.SphereGeometry args={[0.5, 32, 32]} />
	<T.MeshStandardMaterial color="red" />
</T.Mesh>

<!--  plane -->
<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
	<T.PlaneGeometry args={[100, 100]} />
	<T.MeshStandardMaterial color="orange" />
</T.Mesh>

<T.SpotLight
position={[0, 10, 0]}
angle={0.003 * $spotLightIntensity}
penumbra={0.5}
intensity={$spotLightIntensity}
castShadow
on:create={({ ref }) => {
	spotLight = ref;
}}
/>
{#if isLightLoaded}
<T.AmbientLight intensity={$AmbientLightIntensity} />
<!-- back light -->
<T.DirectionalLight
	position={[0, 0, 4]}
	castShadow
	receiveShadow
	on:create={({ ref }) => {
		dirLight1 = ref;
	}}
	intensity={$lightIntensity1 * 10}
/>

<!-- left light -->
<T.DirectionalLight
	position={[10, 0, -10]}
	intensity={$lightIntensity2}
	castShadow
	receiveShadow
	on:create={({ ref }) => {
		dirLight2 = ref;
	}}
/>

<!-- right light -->
<T.DirectionalLight
	position={[-10, 0, -10]}
	intensity={$lightIntensity3 * 6}
	castShadow
	receiveShadow
	on:create={({ ref }) => {
		dirLight3 = ref;
	}}
/>

<T.PointLight
	position={[-1, 4, 1]}
	intensity={$pointLightIntensity}
	on:create={({ ref }) => {
		pointLight = ref;
	}}
	distance={25}
	decay={2}
	castShadow
></T.PointLight>

{/if}
{#if isPlaneLoaded}
<T.Group>
	<T.Group position={[0, 0, 4]} scale={$lightIntensity1}>
		<T.Mesh rotation.y={Math.PI}>
			<T.PlaneGeometry args={[planeSize * 2, planeSize * 2]} />
			<T.MeshMatcapMaterial color="white" />
		</T.Mesh>
	</T.Group>
	<T.Group position={[10, 0, -10]} scale={$lightIntensity2}>
		<T.Mesh rotation.y={Math.PI + Math.PI / -4}>
			<T.PlaneGeometry args={[planeSize * 2, planeSize * 2]} />
			<T.MeshMatcapMaterial color="white" />
		</T.Mesh>
	</T.Group>
	<T.Group position={[-10, 0, -10]} scale={$lightIntensity3}>
		<T.Mesh rotation.y={(3 * Math.PI) / 2 + Math.PI / -4}>
			<T.PlaneGeometry args={[planeSize * 2, planeSize * 2]} />
			<T.MeshMatcapMaterial color="white" />
		</T.Mesh>
	</T.Group>
	{#if isLightPlaneLoaded}
	<T.Group>
		<!-- {#if spotLight}
			<T.SpotLightHelper args={[spotLight, 'black']} />
		{/if}
		{#if dirLight1}
			<T.DirectionalLightHelper args={[dirLight1, planeSize, 'black']} />
		{/if}
		{#if dirLight2}
			<T.DirectionalLightHelper args={[dirLight2, planeSize, 'black']} />
		{/if}

		{#if dirLight3}
			<T.DirectionalLightHelper args={[dirLight3, planeSize, 'black']} />
		{/if} -->
		{#if pointLight}
			<T.PointLightHelper args={[pointLight, 0.2, 'yellow']} />
		{/if}
	</T.Group>
	{/if}
</T.Group>

{/if}
<!-- <Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  /> -->
