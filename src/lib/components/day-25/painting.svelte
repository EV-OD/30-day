<script lang="ts">
import {T} from "@threlte/core"
	import { BoxGeometry, MeshStandardMaterial, Mesh } from "three";
    import Photo from "../../../assets/photo.jpg"
    import { useTexture , interactivity} from '@threlte/extras'
	import { spring } from "svelte/motion";
	import OutlineRenderer from "./outlineRenderer.svelte";
    interactivity()


    let map = useTexture(Photo);

    export let isPaintingHovered = false;
    
    let scale = spring(1);
    let meshRef:Mesh;

</script>

<T.Group>
    {#await map then value}
    {#if isPaintingHovered}
        <OutlineRenderer selectedMesh={meshRef} />
    {/if}
        <T.Mesh castShadow receiveShadow
        scale={$scale}
        bind:ref={meshRef}
        on:pointerover={()=>{
            $scale = 1.2
            isPaintingHovered = true
        }}
        on:pointerout={()=>{
            $scale = 1;
            isPaintingHovered = false
        }}
        on:click={()=>{
        }}
        >
            <T.BoxGeometry args={[0.8,0.6,0.04]} />
            <T.MeshStandardMaterial map={value} />
        </T.Mesh>
    {/await}
</T.Group>



