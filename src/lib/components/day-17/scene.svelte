<script lang="ts">
	import { Debug, RigidBody, Collider } from '@threlte/rapier';
	import { T } from '@threlte/core';
	import { AutoColliders } from '@threlte/rapier';
	import { Group, Vector3, PerspectiveCamera } from 'three';
	import { cubicIn, cubicInOut, cubicOut, linear, quadOut } from 'svelte/easing';
	import CustomCamera, { type AnimationOpts } from '../cameraComponent/CustomCamera.svelte';
	import { spring } from 'svelte/motion';
    import { RoundedBoxGeometry } from '@threlte/extras'

    let colorR = spring(255, { stiffness: 0.15, damping: 0.25 });

	let cameraRef: PerspectiveCamera;
	let animateCameraPos: ((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined;
	let animateCameraLookAt: ((pos: Vector3, options: AnimationOpts) => Promise<void>) | undefined;
	$: {
		if (animateCameraPos && animateCameraLookAt) {
			runAnimation();
		}
	}
	async function runAnimation() {
		if (animateCameraPos && animateCameraLookAt) {
			animateCameraPos(new Vector3(-20, 7, 14), {
				delay: 1000,
				duration: 1500,
				easing: cubicOut,
				func: function (t: number) {
					if (cameraRef) {
						cameraRef.lookAt(0, 0, 0);
					}
					return t;
				}
			}).then(() => {});
		}
	}

	let height = spring(1, { stiffness: 0.15, damping: 0.25 });
    let radius = spring(0.5, { stiffness: 0.1, damping: 0.4 });
	let isFirstContact = false;
</script>

<CustomCamera
	bind:cameraRef
	cameraPos={new Vector3(-10, 10, -30)}
	cameraLookAt={new Vector3(0, 0, 0)}
	bind:animateCameraPos
	bind:animateCameraLookAt
/>



<T.Group>
	<AutoColliders shape={'cuboid'}>
		<T.Mesh receiveShadow>
			<T.BoxGeometry args={[100, 0.1, 100]} />
			<T.MeshStandardMaterial color="orange" />
		</T.Mesh>
	</AutoColliders>
</T.Group>

<T.Group position={[0, 10, 0]}>
	<RigidBody
		type={'dynamic'}
		on:contact={(e) => {
			if (!isFirstContact) {
				isFirstContact = true;
				height.set(0.5).then(() => {
					height.set(1);
				});
                radius.set(0.1)
			}
		}}
	>
		<Collider
			contactForceEventThreshold={20}
			restitution={0.7}
			shape={'cuboid'}
			args={[0.5, 0.5, 0.5]}
		/>
		<T.Mesh castShadow receiveShadow>
			<RoundedBoxGeometry args={[1, 1, 1]} radius={$radius} />
			<T.MeshStandardMaterial color="red" />
		</T.Mesh>
	</RigidBody>
</T.Group>

<T.AmbientLight intensity={0.5} />
<T.SpotLight position={[0, 10, 0]} angle={0.3} penumbra={0.5} intensity={100} castShadow />
<T.DirectionalLight position={[0, 0, 4]} castShadow receiveShadow />

<T.DirectionalLight position={[10, 0, -10]} intensity={3} castShadow receiveShadow />
<T.DirectionalLight position={[-10, 0, -10]} intensity={3} castShadow receiveShadow />

<T.PointLight
	position={[-1, 4, 0]}
	intensity={1}
	distance={25}
	decay={2}
	castShadow
	receiveShadow
    color={`rgb(${$colorR}, 255, 255)`}
/>
