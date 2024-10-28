<script lang="ts">
	import { T } from "@threlte/core";
	import type { DirectionalLight } from "three";
	let directionlightRef:DirectionalLight;
	export let isHelperVisible = false;
	export let color = 'black';
</script>

<T.DirectionalLight {...$$restProps}
on:create={({ref})=>{
	directionlightRef = ref;
}}
/>

{#if isHelperVisible}
	<T.PointLightHelper args={[directionlightRef, color]} />

{/if}
