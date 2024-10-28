<script lang="ts">
	import { T } from "@threlte/core";
	import type { PointLight } from "three";
	let pointLightRef:PointLight;
	export let isHelperVisible = false;
	export let color = 'black';
</script>

<T.PointLight {...$$restProps}
on:create={({ref})=>{
	pointLightRef = ref;
}}
/>

{#if isHelperVisible}
{#if pointLightRef}
	<T.PointLightHelper args={[pointLightRef,0.1, color]} />
{/if}
{/if}
