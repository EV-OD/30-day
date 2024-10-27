<script lang="ts">
	import { T } from "@threlte/core";

    export let windowWidth = 1;
    export let windowHeight = 1;
    export let windowDepth = 0.1;

    export let glassDepth = 0.001;

    export let innerOffset = 0.1;

    export let frameColor = "rgb(100,50,0)";
    export let glassColor = "rgb(173, 216, 230)";


</script>


<T.Group>
    <!-- top frame -->
    <T.Mesh position={[0,windowWidth / 2,0]}>
        <T.BoxGeometry args={[windowWidth,innerOffset,windowDepth]}/>
        <T.MeshStandardMaterial color={frameColor} />
    </T.Mesh>

    <!-- left frame -->
    <T.Mesh position={[-windowWidth / 2,0,0]}>
        <T.BoxGeometry args={[innerOffset,windowHeight + innerOffset,windowDepth]}/>
        <T.MeshStandardMaterial color={frameColor} />
    </T.Mesh>


    <!-- right frame -->
    <T.Mesh position={[windowWidth / 2,0,0]}>
        <T.BoxGeometry args={[innerOffset,windowHeight + innerOffset,windowDepth]}/>
        <T.MeshStandardMaterial color={frameColor} />
    </T.Mesh>

    <!-- bottom frame -->
    <T.Mesh position={[0,-windowWidth / 2,0]}>
        <T.BoxGeometry args={[windowWidth,innerOffset,windowDepth]}/>
        <T.MeshStandardMaterial color={frameColor} />
    </T.Mesh>

    <!-- glass -->
    <T.Mesh position={[0,0,0]}>
        <T.BoxGeometry args={[windowWidth - innerOffset,windowHeight - innerOffset,glassDepth]}/>
        <T.MeshStandardMaterial color={glassColor} />
    </T.Mesh>
</T.Group>
