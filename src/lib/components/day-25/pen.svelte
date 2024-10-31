<script>
    import { T } from '@threlte/core';
    import { DEG2RAD } from 'three/src/math/MathUtils';

    export let position = { x: 0, y: 0, z: 0 };
    export let rotation = { x: 0, y: 0, z: 0 };
    export let color = '#1a1a1a';
</script>

<T.Group position={[position.x, position.y, position.z]} rotation={[rotation.x, rotation.y, rotation.z]}>
    <!-- Pen body -->
    <T.Mesh>
        <T.CylinderGeometry args={[0.08, 0.08, 2, 32]} />
        <T.MeshStandardMaterial {color} />
    </T.Mesh>

    <!-- Pen tip -->
    <T.Mesh position={[0, -1.1, 0]} rotation.x={Math.PI}>
        <T.ConeGeometry args={[0.08, 0.2, 32]} />
        <T.MeshStandardMaterial color="#303030" />
    </T.Mesh>

    <!-- Pen clip -->
    <T.Mesh position={[0.08, 0.8, 0]} rotation={[0, 0, -20 * DEG2RAD]}>
        <T.BoxGeometry args={[0.05, 0.4, 0.02]} />
        <T.MeshStandardMaterial {color} />
    </T.Mesh>

    <!-- pen top hemisphere -->
    <T.Mesh position={[0, 1, 0]}>
        <T.SphereGeometry args={[0.08, 32, 32, 0, Math.PI * 2, 0, Math.PI / 2]} />
        <T.MeshStandardMaterial color="white" />
    </T.Mesh>
     
</T.Group>