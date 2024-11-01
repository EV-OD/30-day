<script lang="ts">
	import { T } from '@threlte/core';
    import {RoundedBoxGeometry} from "@threlte/extras"
	import Book from './book.svelte';

	let bedTopWidth = 2;
	let bedTopHeight = 1;
	let bedTopDepth = 0.1;
	let totalBedHeight = 0.55;

	const bedColor = 'rgb(50,50,50)';
	const woodColor = '#8B4513'; // Brown wooden color
</script>

<T.Group>
	<!-- bed -->
	<T.Group>
		<!-- top -->
        <T.Mesh position={[0.15, 0.1, bedTopDepth / 2]} castShadow receiveShadow>
			<RoundedBoxGeometry args={[bedTopWidth - 0.3, bedTopDepth, bedTopHeight]} />
			<T.MeshStandardMaterial color={"orange"} />
		</T.Mesh>
		<T.Mesh position={[0, 0, bedTopDepth / 2]} castShadow receiveShadow>
			<T.BoxGeometry args={[bedTopWidth, bedTopDepth, bedTopHeight]} />
			<T.MeshStandardMaterial color={bedColor} />
		</T.Mesh>
        <!-- pillow -->
        <T.Mesh position={[-1 + 0.2, 0.1, -0.1 +  bedTopDepth / -2]} castShadow receiveShadow>
			<RoundedBoxGeometry args={[0.2, bedTopDepth, bedTopHeight / 2]} />
			<T.MeshStandardMaterial color={"orange"} />
		</T.Mesh>
        <T.Mesh position={[-1 + 0.2, 0.1,0.25 + bedTopDepth / 2]} castShadow receiveShadow>
			<RoundedBoxGeometry args={[0.2, bedTopDepth, bedTopHeight / 2]} />
			<T.MeshStandardMaterial color={"orange"} />
		</T.Mesh>

        <!-- bed cover -->
        <T.Mesh position={[0.51, 0.11, bedTopDepth / 2]} castShadow receiveShadow>
			<RoundedBoxGeometry args={[bedTopWidth / 2, bedTopDepth, bedTopHeight + 0.02]} />
			<T.MeshStandardMaterial color={"red"} />
		</T.Mesh>
        <T.Mesh position={[0.51, -0.1, bedTopDepth / 2]} castShadow receiveShadow>
			<RoundedBoxGeometry args={[0.01 + bedTopWidth / 2, totalBedHeight - bedTopDepth, bedTopHeight + 0.04]} />
			<T.MeshStandardMaterial color={"red"} />
		</T.Mesh>

		<!-- legs -->
		<T.Group>
			<T.Mesh
				position={[
					bedTopWidth / 2 - 0.1,
					(totalBedHeight - bedTopDepth) / -2,
					bedTopHeight / 2 - 0.1
				]}
				castShadow
				receiveShadow
			>
				<T.BoxGeometry args={[0.1, totalBedHeight - bedTopDepth, 0.1]} />
				<T.MeshStandardMaterial color={woodColor} />
			</T.Mesh>

			<T.Mesh
				position={[
					bedTopWidth / 2 - 0.1,
					(totalBedHeight - bedTopDepth) / -2,
					bedTopHeight / -2 + 0.2
				]}
				castShadow
				receiveShadow
			>
				<T.BoxGeometry args={[0.1, totalBedHeight - bedTopDepth, 0.1]} />
				<T.MeshStandardMaterial color={woodColor} />
			</T.Mesh>

			<T.Mesh
				position={[
					bedTopWidth / -2 + 0.1,
					(totalBedHeight - bedTopDepth) / -2,
					bedTopHeight / 2 - 0.1
				]}
				castShadow
				receiveShadow
			>
				<T.BoxGeometry args={[0.1, totalBedHeight - bedTopDepth, 0.1]} />
				<T.MeshStandardMaterial color={woodColor} />
			</T.Mesh>

			<T.Mesh
				position={[
					bedTopWidth / -2 + 0.1,
					(totalBedHeight - bedTopDepth) / -2,
					bedTopHeight / -2 + 0.2
				]}
				castShadow
				receiveShadow
			>
				<T.BoxGeometry args={[0.1, totalBedHeight - bedTopDepth, 0.1]} />
				<T.MeshStandardMaterial color={woodColor} />
			</T.Mesh>
		</T.Group>

		<!-- front shape -->
		<T.Mesh position={[0.05 + bedTopWidth / -2, 0.1, 0.05]}>
			<T.BoxGeometry args={[0.1, 0.2, bedTopHeight]} />
			<T.MeshStandardMaterial color={bedColor} />
		</T.Mesh>

		<T.Group>
			<!-- side table -->
			<T.Mesh position={[0.2 + bedTopWidth / -2, totalBedHeight / -2, 0.7]}>
				<T.BoxGeometry args={[0.4, totalBedHeight, 0.3]} />
				<T.MeshStandardMaterial color={woodColor} />
			</T.Mesh>

			<!-- book -->
			<T.Group position={[-0.8, 0.01, 0.7]}>
				<T.Group scale={0.15} rotation.x={Math.PI / 2} rotation.z={Math.PI / 6}>
					<Book coverColor="rgb(50,60,50)" />
				</T.Group>
			</T.Group>
		</T.Group>
	</T.Group>

</T.Group>
