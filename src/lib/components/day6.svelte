<script lang="ts">
	import { T, useTask } from '@threlte/core'
	import { OrbitControls } from '@threlte/extras'
	import { Vector3,PointLight } from 'three';
	import mapValue from '../../utils/mapValue';
	import getRandomColor from '../../utils/colors';

	type boxDim = {
		height: number,
		position: Vector3
	}

	let boxWidth = 0.5;
	let totalLength = 8;
	let boxDatas: boxDim[] = [];
	let gap = 0;
	let variable = 0;
	const twoPi = 2 * Math.PI;
	const piDiv10 = Math.PI / 10;
	let aniColor = [0, 0, 0];
	let lightHeight = 5;
	let lightIntensity = 10;

	let pointLightHelper:PointLight;

	let ballPosition = new Vector3(0, 5, 0);

	function getAniColor(){
		return `rgb(${aniColor[0]}, ${aniColor[1]}, ${aniColor[2]})`
	}

	// Precompute initial box positions and heights
	for (let i = -totalLength / 2; i < totalLength / 2; i += boxWidth + gap) {
		for (let j = -totalLength / 2; j < totalLength / 2; j += boxWidth + gap) {
			let x = i;
			let z = j;
			let radius = Math.sqrt(x * x + z * z);
			let sinHeight = Math.sin(mapValue(radius, 0, totalLength, 0, twoPi));
			let cosHeight = Math.cos(mapValue(radius, 0, totalLength, 0, twoPi));
			if(i == 0 && j == 0){
				lightHeight = sinHeight * 2 + 7;
				lightIntensity  = cosHeight * 5 + 5;
			}
			ballPosition = new Vector3(0, cosHeight * 2 + 6, 0);
			boxDatas.push({
				height: sinHeight * 2 + 3,
				position: new Vector3(i, 0.5, j)
			});
		}
	}

	// Update task to oscillate box heights
	useTask((delta) => {
		boxDatas.forEach((boxData) => {
			let radius = Math.sqrt(boxData.position.x * boxData.position.x + boxData.position.z * boxData.position.z);
			let sinHeight = Math.sin(variable + mapValue(radius, 0, totalLength, 0, twoPi));
			let cosHeight = Math.cos(variable + mapValue(radius, 0, totalLength, 0, twoPi));
			boxData.height = sinHeight * 2 + 3;
			if(boxData.position.x == 0 && boxData.position.z == 0){
				lightHeight = sinHeight * 2 + 7;
				lightIntensity  = cosHeight * 5 + 5;
			}
			ballPosition = new Vector3(0, cosHeight * 2 + 6, 0);
		});
		variable = (variable + piDiv10) % twoPi;
		boxDatas = boxDatas
		// animate aniColor , smooth transition
		// aniColor = [Math.sin(variable) * 128 + 128, Math.sin(variable + Math.PI / 2) * 128 + 128, Math.sin(variable + Math.PI) * 128 + 128];
	});

</script>

<T.PerspectiveCamera
	makeDefault
	position={[-50, 50, 50]}
	fov={10}
>
	<OrbitControls
	  enableZoom={false}
	  enableDamping
	/>
</T.PerspectiveCamera>

<!-- Ground plane -->
<!-- <T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
	<T.PlaneGeometry args={[100, 100]} />
	<T.MeshStandardMaterial color="white" />
</T.Mesh> -->

<!-- <T.AxesHelper args={[100]} /> -->

<T.AmbientLight intensity={0.1} />

<T.DirectionalLight position={[0, 0, 10]} intensity={3} />
<T.DirectionalLight position={[-10, 0, 0]} color="lightblue" intensity={0.5} />


<T.PointLight position={[-1, lightHeight, 0]} intensity={lightIntensity} distance={25} decay={2} color={aniColor} castShadow receiveShadow
on:create={({ref})=>{
	pointLightHelper = ref
}}
/>

{#if pointLightHelper}
	<!-- <T.PointLightHelper args={[pointLightHelper, 0.5]} /> -->
{/if}

<T.Mesh position={ballPosition.toArray()}>
	<T.SphereGeometry args={[0.5, 32, 32]} />
	<T.MeshStandardMaterial color="red" />
</T.Mesh>

<!-- Oscillating boxes -->
<T.Group position={[0, 1, 0]}>
	{#each boxDatas as boxData}
		<T.Mesh position={boxData.position.toArray()} castShadow receiveShadow>
			<T.BoxGeometry args={[boxWidth, boxData.height, boxWidth]} />
			<T.MeshStandardMaterial color="lightblue" />
		</T.Mesh>
	{/each}
</T.Group>
