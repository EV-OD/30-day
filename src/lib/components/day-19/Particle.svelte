<script
  lang="ts"
  context="module"
>
  const geometry = new SphereGeometry(0.25, 32, 32)
  export const muted = writable(true)
</script>

<script lang="ts">
  import { T } from '@threlte/core'
  import { PositionalAudio } from '@threlte/extras'
  import { Collider, RigidBody, type ContactEvent } from '@threlte/rapier'
  import { writable } from 'svelte/store'
  import type { Euler, Vector3 } from 'three'
  import { BoxGeometry, MeshStandardMaterial,SphereGeometry } from 'three'
  
  import { clamp } from 'three/src/math/MathUtils.js'
	import getRandomColor from '../../../utils/colors';

  export let position: Vector3 | undefined = undefined
  export let rotation: Euler | undefined = undefined
  export let color: string = 'red'
  const material = new MeshStandardMaterial({ color: color })



  $: rotationCasted = rotation?.toArray() as [x: number, y: number, z: number]
</script>

<T.Group
  position={position?.toArray()}
  rotation={rotationCasted}
>
  <RigidBody
    type={'dynamic'}
  >
    <Collider
      contactForceEventThreshold={50}
      restitution={0.7}
      shape={'ball'}
      args={[0.25]}
    />
    <T.Mesh
      castShadow
      receiveShadow
      {geometry}
      {material}
    />
  </RigidBody>
</T.Group>
