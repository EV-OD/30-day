<script lang="ts">
import {T} from "@threlte/core"
	import { BoxGeometry, MeshStandardMaterial } from "three";
    import Photo from "../../../assets/photo.jpg"
    import { useTexture } from '@threlte/extras'

    let map = useTexture(Photo);
</script>

<T.Group>
    {#await map then value}
    <T.Mesh castShadow receiveShadow>
        <T.BoxGeometry args={[0.8,0.6,0.04]} />
        <T.MeshStandardMaterial map={value} />
    </T.Mesh>
    {/await}
</T.Group>



