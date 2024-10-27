<script lang="ts">
	import { BoxGeometry, MeshStandardMaterial } from "three";
    import { T } from '@threlte/core'
    import {OrbitControls} from "@threlte/extras"


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

<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0,0,4]} castShadow receiveShadow />

<T.DirectionalLight position={[10,0,-10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10,0,-10]} intensity={3} castShadow receiveShadow />

<T.PointLight position={[-1, 4, 0]} intensity={1} distance={25} decay={2} castShadow receiveShadow />

<T.Mesh position={[0,-0.1,0]}>
    <T.BoxGeometry args={[100,0.2,100]}/>
    <T.MeshStandardMaterial color="rgb(100,100,100)" />
</T.Mesh>


<!-- floor -->
<T.Mesh>
    <T.BoxGeometry args={[3,0.2,3]}/>
    <T.MeshStandardMaterial color="orange" />
</T.Mesh>

