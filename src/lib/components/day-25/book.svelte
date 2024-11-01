<script lang="ts">
	import { T } from "@threlte/core";
	import { interactivity } from "@threlte/extras";

	import { spring } from "svelte/motion";
	import { MeshStandardMaterial, Mesh } from "three";
	import OutlineRenderer from "./outlineRenderer.svelte";
    interactivity()

    let bookWidth = 0.8;
    let bookHeight = 1;
    let bookDepth = 0.1;
    
    let pageAndBookGap = 0.05;
    let pageWidth = bookWidth - pageAndBookGap;
    let pageHeight = bookHeight - pageAndBookGap;

    export let isBookHovered = false;
    let scale = spring(1)

    export let coverColor = "rgb(50,50,50)";
    let meshRef:Mesh;
    

    let bookCoverDepth = 0.01;
</script>

<!-- book -->
<T.Group scale={$scale}>
    <!-- front cover -->
    {#if isBookHovered}
    <OutlineRenderer selectedMesh={meshRef} />
    {/if}
     <T.Mesh position={[0,0, bookDepth / 2]}
     castShadow
     receiveShadow
     bind:ref={meshRef}
     on:pointerover={()=>{
        isBookHovered = true;
        $scale = 1.2;
     }}
     on:pointerout={()=>{
        isBookHovered = false;
        $scale = 1;
     }}
     >
        <T.BoxGeometry args={[bookWidth, bookHeight, bookCoverDepth]} />
        <T.MeshStandardMaterial color={coverColor} />
     </T.Mesh>

     <!-- pages -->
        <T.Mesh position.x={-pageAndBookGap / 2} position.z={bookCoverDepth / 2}
        castShadow
        receiveShadow
        >
            <T.BoxGeometry args={[pageWidth, pageHeight, bookDepth - bookCoverDepth]} />
            <T.MeshStandardMaterial color="white" />
        </T.Mesh>

    <!-- back cover -->
    <T.Mesh position={[0,0, -bookDepth / 2]}
    castShadow
    receiveShadow

    >
        <T.BoxGeometry args={[bookWidth, bookHeight, bookCoverDepth]} />
        <T.MeshStandardMaterial color={coverColor} />
    </T.Mesh>
</T.Group>

