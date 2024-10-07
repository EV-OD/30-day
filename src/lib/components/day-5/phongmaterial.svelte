<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls, MeshLineGeometry, MeshLineMaterial } from '@threlte/extras';
	import { Vector3, LineBasicMaterial, type Vector3Tuple, CatmullRomCurve3 } from 'three';
	import getRandomColor from '../../../utils/colors';
</script>

<T.PerspectiveCamera makeDefault position={[14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={false} enableDamping />
</T.PerspectiveCamera>
<T.AmbientLight intensity={0.5} />
<T.DirectionalLight position={[10, 10, 5]} intensity={1} />
<T.DirectionalLight position={[10, 10, -10]} intensity={1} />




<T.Mesh position={[0, 0, 0]} rotation.x={Math.PI / -2} castShadow receiveShadow>
	<T.PlaneGeometry args={[100, 100]} />
	<T.MeshStandardMaterial color="gray" />
</T.Mesh>

<T.Mesh>
    <T.PlaneGeometry args={[1, 1]} />
    <T.MeshPhongMaterial color={getRandomColor()} side={T.DoubleSide} />
</T.Mesh>




<T.AxesHelper args={[5]} />
