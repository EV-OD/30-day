<script lang="ts">
      import { World } from '@threlte/rapier'
	import Scene from './day-17/scene.svelte';

</script>

<World
on:ready={() => {
    console.log('World ready');
}}
>
    <Scene/>
</World>
