<script lang="ts">
	import { BoxGeometry, MeshStandardMaterial } from "three";
    import { T } from '@threlte/core'
    import {OrbitControls} from "@threlte/extras"
	import WindowModel from "./windowModel.svelte";

    let width = 4;
    let height = 2;
    let depth = 3;
    let offset = 0.2;

    let wall1 = {
        textureColor: "rgb(190, 100, 82)",
        textureGap: 0.2,
        textureCount: 10,
        get textureWidth(){
            return ((width - offset) / this.textureCount) - (this.textureGap * (this.textureCount - 1) / this.textureCount);
        }
    }

</script>

<T.PerspectiveCamera
  makeDefault
  position={[14, 14, 14]}
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

<T.Mesh position={[0,-offset,0]}>
    <T.BoxGeometry args={[100,offset,100]}/>
    <T.MeshStandardMaterial color="rgb(100,100,100)" />
</T.Mesh>

<T.AxesHelper args={[5]} />


<T.Group position.y={height / 2} >

    <WindowModel/>
    <!-- floor -->
    <T.Mesh position.y={height / -2}>
        <T.BoxGeometry args={[width,offset,depth]}/>
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh>
    
    <!-- wall 1 -->
     <T.Group  position={[0,0,(depth / -2) + (offset / 2)]}>
        <!-- wall texture  -->
        <T.Group position={[offset / 2,offset / 4,offset / 2]}>
            <!-- <T.Mesh>
                <T.BoxGeometry args={[width - offset,height - offset / 2,0.01]}/>
                <T.MeshStandardMaterial color="brown" />
            </T.Mesh>  -->
            {#each Array(wall1.textureCount).keys() as i}
            <T.Mesh position={[(offset-width / 2) + i * (wall1.textureWidth + wall1.textureGap),0,0]}>
                <T.BoxGeometry args={[wall1.textureWidth ,height - offset / 2,0.01]}/>
                <T.MeshStandardMaterial color={wall1.textureColor} />
            </T.Mesh> 
            {/each}
        </T.Group>
         <T.Mesh>
             <T.BoxGeometry args={[width,height,offset]}/>
             <T.MeshStandardMaterial color="orange" />
         </T.Mesh> 
     </T.Group>

    <!-- wall 2 -->
    <T.Mesh position={[(width / -2) + (offset / 2),0,0]}>
        <T.BoxGeometry args={[offset,height,depth]}/>
        <T.MeshStandardMaterial color="orange" />
    </T.Mesh> 

</T.Group>

