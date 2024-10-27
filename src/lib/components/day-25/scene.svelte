<script lang="ts">
	import { BoxGeometry, MeshStandardMaterial } from 'three';
	import { T } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';
	import WindowModel from './windowModel.svelte';
	import Wall from './wall.svelte';

	let width = 4;
	let height = 2;
	let depth = 3;
	let offset = 0.2;

	let windowWidth = 1;
	let windowHeight = 1;
</script>

<T.PerspectiveCamera makeDefault position={[14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={false} enableDamping />
</T.PerspectiveCamera>

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

<T.Mesh position={[0, -offset, 0]}>
	<T.BoxGeometry args={[100, offset, 100]} />
	<T.MeshStandardMaterial color="rgb(100,100,100)" />
</T.Mesh>

<T.AxesHelper args={[5]} />

<T.Group position.y={height / 2}>
	<!-- floor -->
	<T.Mesh position.y={height / -2}>
		<T.BoxGeometry args={[width, offset, depth]} />
		<T.MeshStandardMaterial color="orange" />
	</T.Mesh>

	<!-- wall 1 -->
	<T.Group position={[0, 0, depth / -2 + offset / 2]}>
		<Wall />
	</T.Group>

	<!-- wall 2 -->
	<T.Mesh position={[width / -2 + offset / 2, 0, 0]} rotation.y={Math.PI / 2}>
		<!-- top part -->
		<T.Group position.y={height / 2 - (height - windowHeight) / 2 / 2}>
			<Wall width={depth} height={(height - windowHeight) / 2} isLeftOffset={false} textureColor="rgb(220,130,30)" />
		</T.Group>

		<WindowModel />
		<!-- bottom part -->
		<T.Group position.y={-(height / 2) + (height - windowHeight) / 2 / 2}>
			<Wall width={depth} height={(height - windowHeight) / 2} isLeftOffset={false}  textureColor="rgb(220,130,30)"/>
		</T.Group>

		<!-- left part -->
		<T.Group position.x={-(depth / 2) + (depth - windowWidth) / 2 / 2}>
			<Wall width={(depth - windowWidth) / 2} height={windowHeight} isLeftOffset={true} textureColor="rgb(220,130,30)" fakeWidth={depth} overallTextureOffset={0.1} />
		</T.Group>

		<!-- right part -->
        <T.Group position.x={(depth / 2) - (depth - windowWidth) / 2 / 2}>
			<Wall width={(depth - windowWidth) / 2} height={windowHeight} isLeftOffset={true} textureColor="rgb(220,130,30)" fakeWidth={depth} leftOffCut={0.1} />
		</T.Group>

	</T.Mesh>
</T.Group>
