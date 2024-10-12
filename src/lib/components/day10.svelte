<script lang="ts">
  import { T, useTask } from '@threlte/core'
  import {OrbitControls } from '@threlte/extras'
  import { PlaneGeometry, Vector3 } from 'three'
  import { createNoise2D } from 'simplex-noise'
  import { interactivity } from '@threlte/extras'
  import fragmentShader from './day-10/fragment.glsl?raw'
  import vertexShader from './day-10/vertex.glsl?raw'

  const terrainSize = 500;
  const geometry = new PlaneGeometry(terrainSize, terrainSize,700,700);
  const noise = createNoise2D();
  const vertices = geometry.getAttribute('position').array as Float32Array;
  for(let i = 0; i < vertices.length; i += 3){
    const x = vertices[i];
    const y = vertices[i + 1];

    vertices[i + 2] = noise(x / 10, y / 10) * 5;
  }

  geometry.computeVertexNormals();
  interactivity()

  let time = 5;
  let increaseDirection = 1;
  useTask((delta)=>{
    time += delta * increaseDirection;
    if(time > 10){
      increaseDirection = -1;
    }else if(time < 5){
      increaseDirection = 1;
    }
  })

</script>

<T.PerspectiveCamera
  makeDefault
  position={[70, 50, 70]}
  fov={30}
>
  <OrbitControls
    autoRotate
    target.y={1.5}
    autoRotateSpeed={1}
  />
</T.PerspectiveCamera>


<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={20} castShadow />
<T.DirectionalLight position={[0,0,4]} castShadow receiveShadow />

<T.DirectionalLight position={[10,0,-10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10,0,-10]} intensity={3} castShadow receiveShadow />
<T.PointLight position={[0, 10, 0]} intensity={10} distance={25} decay={2} castShadow receiveShadow />

<T.PointLight position={[-1, 4, 0]} intensity={1} distance={25} decay={2} castShadow receiveShadow />

<!-- <T.AxesHelper args={[10]} /> -->

<T.Mesh geometry={geometry} rotation.x={Math.PI / -2} >
  <T.MeshStandardMaterial color="lightblue" />
  <T.ShaderMaterial
  fragmentShader={fragmentShader}
  vertexShader={vertexShader}
  wireframe={false}
  uniforms={{
    time:{
      value:5
    }
  }}
  uniforms.time.value={time}
  />
</T.Mesh>

<!-- <T.Mesh >
  <T.BoxGeometry args={[10, 10, 10,10,10,10]} />
  <T.ShaderMaterial
  fragmentShader={fragmentShader}
  vertexShader={vertexShader}
  wireframe={false}
  uniforms={{
    time:{
      value:0.0
    }
  }}
  uniforms.time.value={time}
  />
</T.Mesh> -->

<!-- <T.Mesh >
  <T.BoxGeometry args={[1,1, 1,10,10,10]} />
  <T.MeshStandardMaterial color="lightblue" wireframe={true} />
</T.Mesh> -->




