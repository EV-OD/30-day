<script lang="ts">
  import { T } from '@threlte/core'
  import { ContactShadows, Float, Grid, OrbitControls } from '@threlte/extras'

  import { BoxGeometry, SphereGeometry, ConeGeometry, CylinderGeometry, TorusGeometry, PlaneGeometry, CircleGeometry, RingGeometry, TetrahedronGeometry, IcosahedronGeometry } from 'three';

</script>

<T.PerspectiveCamera
  makeDefault
  position={[-14, 14, 14]}
  fov={15}
>
  <OrbitControls
    enableZoom={false}
    enableDamping
  />
</T.PerspectiveCamera>

<T.Mesh position={[0, 0.5, 0]}>
  <T.BoxGeometry args={[1, 1, 1]} />
  <T.MeshStandardMaterial  color="lightblue" />
</T.Mesh>

<!-- sphere -->
 <T.Mesh position={[2, 0.5, 0]}>
  <T.SphereGeometry args={[0.5, 32, 32]} />
  <T.MeshStandardMaterial color="red" />
</T.Mesh>

<!-- cone -->
<T.Mesh position={[4, 0.5, 0]}>
  <T.ConeGeometry args={[0.5, 1, 32]} />
  <T.MeshStandardMaterial color="green" />
</T.Mesh>

<!-- cylinder -->
<T.Mesh position={[-2, 0.5, 0]}>
  <T.CylinderGeometry args={[0.5, 0.5, 1, 32]} />
  <T.MeshStandardMaterial color="tomato" />
</T.Mesh>

<!-- torus -->
<T.Mesh position={[-4, 0.5, 0]}>
  <T.TorusGeometry args={[0.5, 0.2, 16, 100]} />
  <T.MeshStandardMaterial color="purple" />
</T.Mesh>

<!--  plane -->
<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3}>
  <T.PlaneGeometry args={[1, 1]} />
  <T.MeshStandardMaterial color="orange" />
</T.Mesh>

<!-- circle -->
<T.Mesh position={[2, 2, 0]}>
  <T.CircleGeometry args={[0.5, 32]} />
  <T.MeshStandardMaterial color="lightblue" />
</T.Mesh>

<!-- ring -->
<T.Mesh position={[4, 2, 0]}>
  <T.RingGeometry args={[0.3, 0.5, 32]} />
  <T.MeshStandardMaterial color="red" />
</T.Mesh>

<!-- tetrahedron -->
<T.Mesh position={[-2, 2, 0]}>
  <T.TetrahedronGeometry args={[0.6]} />
  <T.MeshStandardMaterial color="green" />
</T.Mesh>

<!-- icosahedron -->
<T.Mesh position={[0, 2, 0]}>
  <T.IcosahedronGeometry args={[0.6]} />
  <T.MeshStandardMaterial color="tomato" />
</T.Mesh>

<Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  />

<T.AmbientLight intensity={0.5} />
<T.DirectionalLight position={[5, 5, 5]} />
