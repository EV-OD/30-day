<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls, MeshLineGeometry, MeshLineMaterial } from '@threlte/extras';
	import { Vector3, LineBasicMaterial, type Vector3Tuple, CatmullRomCurve3 } from 'three';
	import getRandomColor from '../../../utils/colors';
	const curve = new CatmullRomCurve3([
    new Vector3(-3, 0, 0),
    new Vector3(-1, 1, -1),
    new Vector3(1, -1, 1),
    new Vector3(3, 0, 0)
  ])
  const points = curve.getPoints(100)
</script>

<T.PerspectiveCamera makeDefault position={[14, 14, 14]} fov={15}>
	<OrbitControls enableZoom={false} enableDamping />
</T.PerspectiveCamera>
<T.AmbientLight intensity={1} />

<!-- <T.Mesh position={[0, 0, 0]} rotation.x={Math.PI / -2} castShadow receiveShadow>
	<T.PlaneGeometry args={[100, 100]} />
	<T.MeshStandardMaterial color="gray" />
</T.Mesh> -->


<T.Group scale={1}>
	<T.Mesh>
		<MeshLineGeometry {points} />
		<MeshLineMaterial width={0.5} color="#fe3d00" />
	</T.Mesh>
</T.Group>

<T.AxesHelper args={[5]} />
