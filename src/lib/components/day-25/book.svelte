<script lang="ts">
	import { T } from "@threlte/core";
	import { Box } from "@threlte/flex";
	import { MeshStandardMaterial } from "three";

    let bookWidth = 0.8;
    let bookHeight = 1;
    let bookDepth = 0.1;
    
    let pageAndBookGap = 0.05;
    let pageWidth = bookWidth - pageAndBookGap;
    let pageHeight = bookHeight - pageAndBookGap;

    export let coverColor = "rgb(50,50,50)";
    

    let bookCoverDepth = 0.01;
</script>

<!-- book -->
<T.Group>
    <!-- front cover -->
     <T.Mesh position={[0,0, bookDepth / 2]}
     castShadow
     receiveShadow
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

