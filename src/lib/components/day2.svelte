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

<T.Mesh position={[-1, 1, 0]} castShadow receiveShadow>
  <T.BoxGeometry args={[1, 1, 1]} />
  <T.MeshStandardMaterial  color="lightblue" />
</T.Mesh>

<!-- sphere -->
 <T.Mesh position={[1, 1, 0]} castShadow receiveShadow>
  <T.SphereGeometry args={[0.5, 32, 32]} />
  <T.MeshStandardMaterial color="red" />
</T.Mesh>



<!--  plane -->
<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
  <T.PlaneGeometry args={[100, 100]} />
  <T.MeshStandardMaterial color="orange" />
</T.Mesh>



<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0,0,4]} castShadow receiveShadow />

<T.DirectionalLight position={[10,0,-10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10,0,-10]} intensity={3} castShadow receiveShadow />

<T.PointLight position={[-1, 4, 0]} intensity={1} distance={25} decay={2} castShadow receiveShadow />



<!-- <Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  /> -->

