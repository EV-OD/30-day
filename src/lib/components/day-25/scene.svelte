<script lang="ts">
	import { BoxGeometry, MeshStandardMaterial } from 'three';
	import { T } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
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

	let width = 4;
	let height = 2;
	let depth = 3;
	let offset = 0.2;

	let windowWidth = 1;
	let windowHeight = 1;
</script>

<T.PerspectiveCamera makeDefault position={[14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={true} enableDamping target.y={height / 2} />
</T.PerspectiveCamera>

<T.AmbientLight intensity={0.1} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0, 0, 4]} castShadow receiveShadow />

<T.DirectionalLight position={[10, 0, -10]} intensity={1} castShadow receiveShadow />
<T.DirectionalLight position={[-10, 0, -10]} intensity={3} castShadow receiveShadow />
<!-- <T.DirectionalLight position={[10, 0, 10]} intensity={2} castShadow receiveShadow /> -->

<!-- <T.AxesHelper args={[5]} /> -->

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
		<Painting />
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
