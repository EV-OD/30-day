<script lang="ts">
	import { T } from '@threlte/core';
	import { CylinderGeometry, ConeGeometry } from 'three';
	import CustomPointLight from './customPointLight.svelte';
</script>

<T.Group>
    <T.Group position={[0,0.3,0.3]}>
        <T.Mesh castShadow receiveShadow position.y={0.1}>
            <T.CylinderGeometry args={[0.09, 0.09, 0.2, 32]} />
            <T.MeshStandardMaterial color="gray" />
        </T.Mesh>
        <T.Group>
            <!-- cone -->
            <T.Mesh castShadow receiveShadow>
                <T.CylinderGeometry args={[0.05, 0.2, 0.2, 32]} />
                <T.MeshStandardMaterial emissive="white" emissiveIntensity={10} transparent={true} opacity={0.9} />
            </T.Mesh>
            <!-- sphere -->
            <T.Mesh position={[0, -0.1, 0]} castShadow receiveShadow>
                <T.SphereGeometry args={[0.08, 32, 32]} />
                <T.MeshStandardMaterial emissive="rgb(100,100,250)" emissiveIntensity={10} toneMapped={false} />
            </T.Mesh>
            <CustomPointLight
            position={[0, -0.1, 0]}
                intensity={1}
                distance={0}
                decay={2}
                castShadow
                receiveShadow
                isHelperVisible={false}
            />
        </T.Group>
    </T.Group>

    <!-- stand -->
    <T.Mesh castShadow receiveShadow>
        <T.BoxGeometry args={[0.05,1.5,0.05]} />
        <T.MeshStandardMaterial color="white" />
    </T.Mesh>

    <!-- top base -->
    <T.Mesh position={[0,0.6,0.2]} castShadow receiveShadow>
        <T.BoxGeometry args={[0.05,0.05,0.5]} />
        <T.MeshStandardMaterial color="gray" />
    </T.Mesh>

    <!-- base and lamp chain -->
    <T.Mesh position={[0,0.55,0.3]} castShadow receiveShadow>
        <T.CylinderGeometry args={[0.02, 0.02, 0.1, 32]} />
        <T.MeshStandardMaterial color="gray" />
    </T.Mesh>
</T.Group>
