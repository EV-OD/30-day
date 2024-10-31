<script lang="ts">
	import { T } from "@threlte/core";
    import {RoundedBoxGeometry} from "@threlte/extras"



</script>

<!-- top part -->
<T.Mesh castShadow receiveShadow>
    <RoundedBoxGeometry args={[1, 0.1, 0.7]} radius={0.02} />
    <T.MeshStandardMaterial color="orange" />
</T.Mesh>
<!-- legs -->
<T.Group scale={0.9}>
    <T.Mesh position={[-0.4, -0.4, -0.3]}         castShadow
        receiveShadow>
        <T.BoxGeometry args={[0.1, 0.8, 0.1]} />
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh>
    <T.Mesh position={[0.4, -0.4, -0.3]}         castShadow
        receiveShadow>
        <T.BoxGeometry args={[0.1, 0.8, 0.1]} />
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh>
    <T.Mesh position={[-0.4, -0.4, 0.3]}         castShadow
        receiveShadow>
        <T.BoxGeometry args={[0.1, 0.8, 0.1]} />
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh>
    <T.Mesh position={[0.4, -0.4, 0.3]}         castShadow
        receiveShadow>
        <T.BoxGeometry args={[0.1, 0.8, 0.1]} />
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh>
</T.Group>

