<script lang="ts">
	import { T } from '@threlte/core';

	export let width = 4;
	export let fakeWidth = width;
	export let height = 2;
	export let offset = 0.2;
	export let textureColor = 'rgb(190, 100, 82)';
	export let textureGap = 0.2;
	export let textureCount = 10;

	export let textureMeshWidth = 0.02;

	export let leftOffCut = 0;
	export let rightOffCut = 0;

	export let isLeftOffset = true;

	export let overallTextureOffset = 0;

	$: textureWidth =
		(fakeWidth - offset) / textureCount - (textureGap * (textureCount - 1)) / textureCount;
</script>

<!-- <T.Group  position={[0,0,(depth / -2) + (offset / 2)]}> -->
<T.Group position={[0, 0, 0]}>
	<!-- wall texture  -->
	<T.Group
		position={[offset / (2 * (isLeftOffset ? 1 : -1)) - overallTextureOffset, 0, offset / 2]}
	>
		{#each Array(textureCount).keys() as i}
			{#if offset - fakeWidth / 2 + i * (textureWidth + textureGap) + leftOffCut <= width / 2 && offset - fakeWidth / 2 + i * (textureWidth + textureGap) - rightOffCut >= width / -2}
				<T.Mesh
					position={[
						offset - fakeWidth / 2 + i * (textureWidth + textureGap),
						0,
						textureMeshWidth / 2
					]}
					castShadow
					receiveShadow
				>
					<T.BoxGeometry args={[textureWidth, height, textureMeshWidth]} />
					<T.MeshStandardMaterial color={textureColor} />
				</T.Mesh>
			{/if}
		{/each}
	</T.Group>
	<T.Mesh castShadow receiveShadow>
		<T.BoxGeometry args={[width, height, offset]} />
		<T.MeshStandardMaterial color="orange" emissiveIntensity={3} />
	</T.Mesh>
</T.Group>
