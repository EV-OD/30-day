<script lang="ts">
  import { T } from '@threlte/core'
  import { ContactShadows, Float, Grid, OrbitControls, HTML } from '@threlte/extras'

  import { BoxGeometry, SphereGeometry, ConeGeometry, CylinderGeometry, TorusGeometry, PlaneGeometry, CircleGeometry, RingGeometry, TetrahedronGeometry, IcosahedronGeometry } from 'three';
  import Mockup from './day-16/mockup.svelte';
  import Toycar from "./models/scene.svelte"
	import { tweened } from 'svelte/motion';
	import { linear, quadOut } from 'svelte/easing';
  let shouldStop = true;
  let carPosZ = tweened(0);


</script>

<T.PerspectiveCamera
  makeDefault
  position={[-20, 7, 14]}
  fov={10}
>
  <OrbitControls
    enableZoom={false}
    enableDamping
  />
</T.PerspectiveCamera>

<T.Group position={[0,0, $carPosZ]} scale={0.2} >
  <Toycar bind:shouldStop={shouldStop}/>
</T.Group>

<HTML transform scale={0.2} rotation.y={Math.PI / -3} position={[3,0.5,0.2]}>
    <Mockup/>
</HTML>

<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
  <T.PlaneGeometry args={[100, 100]} />
  <T.MeshStandardMaterial color="orange" />
</T.Mesh>

<!-- <T.AxesHelper args={[10]} /> -->






<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={100} castShadow />
<T.DirectionalLight position={[0,0,4]} castShadow receiveShadow />

<T.DirectionalLight position={[10,0,-10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10,0,-10]} intensity={3} castShadow receiveShadow />

<T.PointLight position={[-1, 4, 0]} intensity={1} distance={25} decay={2} castShadow receiveShadow />



<!-- <Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  /> -->

<style>
  .mockup-wrapper{
    width: 0px;
    transition: width 2s ease-in-out;
    display:grid;
    place-items: center;
    overflow: hidden;
  }
</style>
