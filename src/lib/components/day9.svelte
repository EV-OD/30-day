<script lang="ts">
  import { T ,} from '@threlte/core'
  import { ContactShadows, Float, Grid, OrbitControls , Text} from '@threlte/extras'
  import { interactivity ,RoundedBoxGeometry } from '@threlte/extras'
  import { spring, tweened } from 'svelte/motion'
	import mapValue from '../../utils/mapValue';
  import {
		BoxGeometry,
		SphereGeometry,
		ConeGeometry,
		CylinderGeometry,
		TorusGeometry,
		PlaneGeometry,
		CircleGeometry,
		RingGeometry,
		TetrahedronGeometry,
		IcosahedronGeometry,
    Vector3,
    PerspectiveCamera
	} from 'three';

	import CustomCamera, {type AnimationOpts} from './cameraComponent/CustomCamera.svelte';
	import { cubicOut } from 'svelte/easing';
  import Toycar from "./models/scene.svelte"



  
	let cameraRef: PerspectiveCamera;
	let animateCameraPos:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	let animateCameraLookAt:((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined
	$:{
		if(animateCameraPos && animateCameraLookAt){
			runAnimation()
		}
	}
	async function runAnimation(){
		if(animateCameraPos && animateCameraLookAt){
      carposZ.set(0).then(()=>{
        shouldStop = true
        console.log("testing 1", shouldStop)
      })
			await animateCameraPos(new Vector3(-14, 14, 14), {delay:300,duration: 6000,func: function(t:number){
				if(cameraRef){
					cameraRef.lookAt(0, 0, $carposZ)
				}
				return t
			}})
      console.log("testing")
      shouldStop = true
		}
	}

  let carposZ = tweened(-10, {
    duration: 6000,
    delay:300
  })

  let shouldStop:boolean 
  

</script>

<CustomCamera
bind:cameraRef 
cameraPos={new Vector3(-10, 10, -20)}
cameraLookAt={new Vector3(0, 0, -10)}
bind:animateCameraPos
bind:animateCameraLookAt
/>


<!-- <T.PerspectiveCamera
  makeDefault
  position={[-14, 14, 14]}
  fov={15}
>
  <OrbitControls
    enableZoom={false}
    enableDamping
  />
</T.PerspectiveCamera> -->



<T.Mesh position={[0, 0, 0]} rotation.x={-Math.PI / 2} scale={3} castShadow receiveShadow>
  <T.PlaneGeometry args={[100, 100]} />
  <T.MeshStandardMaterial color="orange" />
</T.Mesh>





<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0,0,4]} castShadow receiveShadow />

<T.DirectionalLight position={[10,0,-10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10,0,-10]} intensity={3} castShadow receiveShadow />
<T.PointLight position={[0, 10, 0]} intensity={10} distance={25} decay={2} castShadow receiveShadow />

<T.PointLight position={[-1, 4, 0]} intensity={1} distance={25} decay={2} castShadow receiveShadow />

<T.Group position={[0,0, $carposZ]} scale={0.2} >
  <Toycar bind:shouldStop={shouldStop}/>
</T.Group>


<T.AxesHelper args={[10]} />



<!-- <Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  /> -->

