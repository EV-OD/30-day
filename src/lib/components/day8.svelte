<script lang="ts">
  import { T } from '@threlte/core'
  import { ContactShadows, Float, Grid, OrbitControls , Text} from '@threlte/extras'
  import { interactivity ,RoundedBoxGeometry } from '@threlte/extras'
  import { spring } from 'svelte/motion'
	import mapValue from '../../utils/mapValue';


  import { BoxGeometry, SphereGeometry, ConeGeometry, CylinderGeometry, TorusGeometry, PlaneGeometry, CircleGeometry, RingGeometry, TetrahedronGeometry, IcosahedronGeometry } from 'three';

  let uiWidth = 1;
  let gap = 0.1;
  type UIDataItem = {
    content: string;
    id: -1 | 0 | 1;
  };

  let uiData: UIDataItem[] = [
    { content: "About me", id: -1 },
    { content: "Projects", id: 0 },
    { content: "Contact", id: 1 },
  ];

  let scale1 = spring(1)
  let scale2 = spring(1)
  let scale3 = spring(1)
  interactivity()

  // lightblue in rgb array
  let color = [173, 216, 230];

  let hoveredIndex: -1 | 0 | 1 | null = null;

  const getColor = ()=>{
    return `rgb(${color[0]}, ${color[1]}, ${color[2]})`
  }
  let r = spring(color[0])
  let g = spring(color[1])
  let b = spring(color[2])


  const handlePointerEnter = (index:-1 | 0 | 1) => {
    hoveredIndex = index;
    $r = 255
    $g = 0
    $b = 0
    if(index == -1){
      $scale1 = 1.4
      $scale2 = 0.2
      $scale3 = 0.2
    }else if(index == 0){
      $scale2 = 1.4
      $scale1 = 0.2
      $scale3 = 0.2
    }else if(index == 1){
      $scale3 = 1.4
      $scale2 = 0.2
      $scale1 = 0.2
    }


    // animate the color in smooth transition from initial color to red
    
    

  }

  const handlePointerLeave = (index:-1 | 0 | 1) => {
    hoveredIndex = null;
    $r = color[0]
    $g = color[1]
    $b = color[2]

      $scale1 = 1
      $scale2 = 1
      $scale3 = 1


  }

  

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



{#each uiData as item}
  <T.Mesh position={[item.id * 1.1 + (gap * item.id), mapValue(item.id == -1 ? $scale1 : item.id == 0 ? $scale2 : $scale3, 1, 1.4, 0.3, 0), 0]}
  castShadow
  receiveShadow 
  scale={[item.id == -1 
  ? $scale1 
  : item.id == 0
  ? $scale2
  : $scale3,
  1, 
  item.id == -1 
  ? $scale1 
  : item.id == 0 
  ? $scale2 
  : $scale3]}
  on:pointerenter={()=>handlePointerEnter(item.id)}
  on:pointerleave={()=>handlePointerLeave(item.id)}
  >
    <T.BoxGeometry args={[uiWidth, 0.3, uiWidth]} />
    <T.MeshStandardMaterial  color={getColor()} />
  </T.Mesh>
  <Text
    position={[item.id * 1.1 + (gap * item.id), mapValue(item.id == -1 ? $scale1 : item.id == 0 ? $scale2 : $scale3, 1, 1.4, 0.3, 0) +0.2,0 ]}
    rotation={[Math.PI / -2, 0, 0]}
    color="black"
    fontSize={0.13}
    scale={item.id == hoveredIndex ? 1 : hoveredIndex == null ? 1 : 0}
    text={item.content}
    anchorX="center"
    anchorY="middle"
    castShadow
    receiveShadow 
  />
{/each}

<!-- <T.AxesHelper args={[10]} /> -->



<!-- <Grid fadeDistance={30} sectionColor="gray" type="grid" cellColor="red"  /> -->

