<script lang="ts">
	import { BoxGeometry, MeshStandardMaterial, Vector3,PerspectiveCamera } from 'three';
	import { T } from '@threlte/core';
	import { OrbitControls, HTML } from '@threlte/extras';
	import WindowModel from './windowModel.svelte';
	import Wall from './wall.svelte';
	import WallLamp from './wallLamp.svelte';
	import CustomPointLight from './customPointLight.svelte';
	import Table from './table.svelte';
	import Clock from './clock.svelte';
	import Book from './book.svelte';
	import Pen from './pen.svelte';
	import Bed from './bed.svelte';
	import Painting from './painting.svelte';
	import CustomCamera, {type AnimationOpts} from '../cameraComponent/CustomCamera.svelte';
	import { cubicOut } from 'svelte/easing';
	import { spring } from 'svelte/motion';

	let width = 4;
	let height = 2;
	let depth = 3;
	let offset = 0.2;

	let windowWidth = 1;
	let windowHeight = 1;
	let cameraRef: PerspectiveCamera;
	let animateCameraPos:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	let animateCameraLookAt:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	let backButtonPosition = new Vector3(0,0,0)
	let backButtonRotation = new Vector3(0,0,0)
	let backButtonScale = spring(0);
	// $:{
	// 	if(animateCameraPos && animateCameraLookAt){
	// 		runAnimation()
	// 	}
	// }

	async function focusPainting(){
		if(animateCameraPos && animateCameraLookAt){
			animateCameraPos(new Vector3(0.5, 1, 10 + offset + depth / -2), {duration: 500,func: function(t:number, cameraPosData:Vector3){
				console.log(cameraPosData)
				if(cameraRef){
					cameraRef.lookAt(0.5, 1, 0.08 + offset + depth / -2)
				}
				if(cameraPosData.x == 0.5 && cameraPosData.y == 1 && cameraPosData.z == 10 + offset + depth / -2){
					backButtonPosition = new Vector3(0.5, 1, -5 + offset + depth / -2)
					// backButtonRotation = new Vector3(0, Math.PI, 0)
					$backButtonScale = 0.3;
				}
				return t
			}}).then(()=>{
				// alert('Painting focused')
			})
		}
	}

	async function focusOut(){
		if(animateCameraPos && animateCameraLookAt){
			$backButtonScale = 0;
			let x = await animateCameraLookAt(new Vector3(0, height / 2, 0), {delay:500, duration: 1500, easing: cubicOut})
			animateCameraPos(new Vector3(14, 14, 14), {duration: 2000,func: function(t:number,cameraPosData:Vector3){
				if(cameraRef){
					cameraRef.lookAt(0, 0, 0)
				}
				// if(cameraPosData.x == 14 && cameraPosData.y == 14 && cameraPosData.z == 14){
				// 	backButtonPosition = new Vector3(0,0,0)
				// 	// backButtonRotation = new Vector3(0, Math.PI, 0)

				// }
				return t
			}})
		}
	}

	// async function runAnimation(){
	// 	if(animateCameraPos && animateCameraLookAt){
	// 		let x = await animateCameraLookAt(new Vector3(0, 0, 0), {delay:500, duration: 1500, easing: cubicOut})
	// 		animateCameraPos(new Vector3(-14, 14, 14), {duration: 2000,func: function(t:number){
	// 			if(cameraRef){
	// 				cameraRef.lookAt(0, 0, 0)
	// 			}
	// 			return t
	// 		}})
	// 	}
	// }
  

</script>

<CustomCamera
bind:cameraRef 
cameraPos={new Vector3(14, 14, 14)}
cameraLookAt={new Vector3(0, height / 2, 0)}
bind:animateCameraPos
bind:animateCameraLookAt
/>
<!-- <CustomCamera
bind:cameraRef 
cameraPos={new Vector3(0.5, 1, 10 + offset + depth / -2)}
cameraLookAt={new Vector3(0.5, 1, 0.08 + offset + depth / -2)}
bind:animateCameraPos
bind:animateCameraLookAt
/> -->

<!-- <T.PerspectiveCamera makeDefault position={[14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={true} enableDamping target.y={height / 2} />
</T.PerspectiveCamera> -->

<T.AmbientLight intensity={0.1} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0, 0, 4]} castShadow receiveShadow />

<T.DirectionalLight position={[10, 0, -10]} intensity={1} castShadow receiveShadow />
<T.DirectionalLight position={[-10, 0, -10]} intensity={3} castShadow receiveShadow />
<!-- <T.DirectionalLight position={[10, 0, 10]} intensity={2} castShadow receiveShadow /> -->

<!-- <T.AxesHelper args={[5]} /> -->

<HTML transform 
position={backButtonPosition.toArray()}
rotation={backButtonRotation.toArray()}
scale={$backButtonScale}
>
	<button on:click={focusOut} style="position: absolute; top: 20px; left: 20px; padding: 10px 20px; color: black; border: 2px solid silver; border-radius: 5px; cursor: pointer; animation: pulse 1.5s infinite; background: rgb(255 255 255 / 50%); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
		Back
	</button>
</HTML>

<T.Group position.y={height / 2}>
	<T.Group position={[1.2, 0.2 + height / -2, 0.25]}>
		<T.Mesh>
			<T.BoxGeometry args={[0.8, 0.04, 2]} />
			<T.MeshStandardMaterial color="brown"
			metalness={0.01} roughness={1}
			/>
		</T.Mesh>
	</T.Group>

	<T.Group position={[0.5, 0.2, 0.08 + offset + depth / -2]}>
		<Painting focusPainting={focusPainting} />
	</T.Group>
	<T.Group position={[-0.5, -0.13, -0.8]} scale={0.5}>
		<Clock />
	</T.Group>

	<T.Group
		scale={0.1}
		position={[-0.7, -0.24, -0.7]}
		rotation.x={Math.PI / 2}
		rotation.z={Math.PI / 6}
	>
		<Pen />
	</T.Group>

	<T.Group position={[-0.5, -0.55, 0.3]}>
		<Bed />
	</T.Group>

	<!-- book group -->
	<T.Group position={[0, -0.1, 0]}>
		<T.Group position={[-0.9, -0.13, -0.8]} scale={0.3} rotation.x={Math.PI / 2}>
			<Book />
		</T.Group>
		<T.Group
			position={[-0.95, -0.09, -0.8]}
			scale={0.3}
			rotation.x={Math.PI / 2}
			rotation.z={Math.PI / 6}
		>
			<Book coverColor="rgb(100,50,50)" />
		</T.Group>
		<T.Group
			position={[-0.95, -0.05, -0.8]}
			scale={0.3}
			rotation.x={Math.PI / 2}
			rotation.z={Math.PI / 5}
		>
			<Book coverColor="rgb(100,100,50)" />
		</T.Group>
	</T.Group>

	<T.Group position={[-1.5, -0.15, -1]} rotation.y={Math.PI / 2}>
		<WallLamp />
	</T.Group>
	<T.Group position={[-1.6, -0.15, 1]} rotation.y={Math.PI / 2}>
		<WallLamp />
	</T.Group>

	<T.Group position={[-0.8, -0.3, -0.7]}>
		<Table />
	</T.Group>
	<!-- floor -->
	<T.Mesh position.y={height / -2} castShadow receiveShadow>
		<T.BoxGeometry args={[width, offset, depth]} />
		<T.MeshStandardMaterial color="orange" />
	</T.Mesh>

	<!-- wall 1 -->
	<T.Group position={[0, 0, depth / -2 + offset / 2]}>
		<Wall textureMeshWidth={0.05} />
	</T.Group>

	<!-- wall 2 -->
	<T.Mesh position={[width / -2 + offset / 2, 0, 0]} rotation.y={Math.PI / 2}>
		<!-- top part -->
		<T.Group position.y={height / 2 - (height - windowHeight) / 2 / 2}>
			<Wall
				width={depth}
				height={(height - windowHeight) / 2}
				isLeftOffset={false}
				textureColor="rgb(220,130,30)"
			/>
		</T.Group>

		<WindowModel windowDepth={0.3} />
		<!-- bottom part -->
		<T.Group position.y={-(height / 2) + (height - windowHeight) / 2 / 2}>
			<Wall
				width={depth}
				height={(height - windowHeight) / 2}
				isLeftOffset={false}
				textureColor="rgb(220,130,30)"
			/>
		</T.Group>

		<!-- left part -->
		<T.Group position.x={-(depth / 2) + (depth - windowWidth) / 2 / 2}>
			<Wall
				width={(depth - windowWidth) / 2}
				height={windowHeight}
				isLeftOffset={true}
				textureColor="rgb(220,130,30)"
				fakeWidth={depth}
				overallTextureOffset={0.1}
			/>
		</T.Group>

		<!-- right part -->
		<T.Group position.x={depth / 2 - (depth - windowWidth) / 2 / 2}>
			<Wall
				width={(depth - windowWidth) / 2}
				height={windowHeight}
				isLeftOffset={true}
				textureColor="rgb(220,130,30)"
				fakeWidth={depth}
				leftOffCut={0.1}
			/>
		</T.Group>
	</T.Mesh>
</T.Group>


<style>
	@keyframes pulse {
		0% {
			transform: scale(1);
			opacity: 1;
		}
		50% {
			transform: scale(1.1);
			opacity: 0.7;
		}
		100% {
			transform: scale(1);
			opacity: 1;
		}
	}
</style>
