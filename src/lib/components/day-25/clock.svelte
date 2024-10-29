<script lang="ts">
    import {T, useTask} from "@threlte/core"
    import { ContactShadows, Float, Grid, OrbitControls , Text} from '@threlte/extras'
    import { CylinderGeometry, MeshStandardMaterial } from "three";

    let outerRadius = 0.2;
    let innerRadius = 0.17;
    $: offset = outerRadius - innerRadius;

    let time = new Date();
    let hours = time.getHours();
    let minutes = time.getMinutes();
    let seconds = time.getSeconds();

    useTask((delta)=>{
        time = new Date();
        hours = time.getHours();
        minutes = time.getMinutes();
        seconds = time.getSeconds();
    })

</script>

<!-- watch -->
<T.Group>
    <!-- circluar full circle  -->
    <T.Mesh rotation.x={Math.PI / 2}>
        <T.CylinderGeometry args={[outerRadius, outerRadius, 0.015, 32]} />
        <T.MeshStandardMaterial color="white" />
    </T.Mesh>

    <!-- ring cover (donut shape) -->
     <T.Mesh>
        <T.TorusGeometry args={[outerRadius, offset, 50, 50]} />
        <T.MeshStandardMaterial color="black" metalness={0.5} roughness={0.5} />
     </T.Mesh>

    <!-- black coloured ring -->
    <T.Mesh position={[0,0,0.01]}>
        <T.RingGeometry args={[innerRadius - 0.01,innerRadius - 0.008, 50]} />
        <T.MeshStandardMaterial color="black" />
    </T.Mesh>

    <!-- time in circle -->
     <T.Group
     rotation={[0, 0, Math.PI / 2]}
     >
        {#each Array(12).keys() as i}
            <Text
            position={[(innerRadius - 0.04) * Math.cos(i * Math.PI / 6), (innerRadius - 0.04) * Math.sin(i * Math.PI / 6), 0.02]}
            color="black"
            rotation.z={Math.PI / -2}
            fontSize={0.03}
            text={12 - i}
            anchorX="center"
            anchorY="middle"
            castShadow
            receiveShadow 
        />
        {/each}
    </T.Group>

    <!-- two legs -->
     <T.Mesh position={[Math.sin(Math.PI / 6) * (outerRadius + 0.02),Math.cos(0) * (outerRadius + 0.03) * -1,0 ]} rotation.z={Math.PI / 7}>
        <T.CylinderGeometry args={[0.02,0.008,0.06,20,20]} />
        <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.01} />
     </T.Mesh>
     <T.Mesh position={[Math.sin(Math.PI / 6) * (outerRadius + 0.02) * -1,Math.cos(0) * (outerRadius + 0.03) * -1,0 ]} rotation.z={Math.PI / -7}>
        <T.CylinderGeometry args={[0.02,0.008,0.06,20,20]} />
        <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.01} />
     </T.Mesh>

    <!-- clock hands -->
    <T.Group>
        <!-- center decorative elements -->
        <T.Mesh position={[0,0,0.05]}>
            <T.CylinderGeometry args={[0.015, 0.015, 0.005, 32]} />
            <T.MeshStandardMaterial color="#333333" metalness={0.8} roughness={0.2} />
        </T.Mesh>
        <T.Mesh position={[0,0,0.053]}>
            <T.CylinderGeometry args={[0.008, 0.008, 0.005, 32]} />
            <T.MeshStandardMaterial color="#666666" metalness={0.9} roughness={0.1} />
        </T.Mesh>
        
        <!-- hour hand (shorter, wider) -->
        <T.Group rotation.z={hours * Math.PI / -6}>
            <T.Mesh position={[0, 0.04, 0.02]}>
                <T.CylinderGeometry args={[0.012, 0.006, 0.08, 6]} />
                <T.MeshStandardMaterial color="#111111" metalness={0.7} roughness={0.3} />
            </T.Mesh>
            <!-- counterweight -->
            <T.Mesh position={[0, -0.015, 0.02]}>
                <T.CylinderGeometry args={[0.008, 0.008, 0.03, 6]} />
                <T.MeshStandardMaterial color="#111111" metalness={0.7} roughness={0.3} />
            </T.Mesh>
        </T.Group>

        <!-- minute hand (longer, thinner) -->
        <T.Group rotation.z={minutes * Math.PI / -30}>
            <T.Mesh position={[0, 0.06, 0.03]}>
                <T.CylinderGeometry args={[0.008, 0.004, 0.12, 6]} />
                <T.MeshStandardMaterial color="#222222" metalness={0.7} roughness={0.3} />
            </T.Mesh>
            <!-- counterweight -->
            <T.Mesh position={[0, -0.02, 0.03]}>
                <T.CylinderGeometry args={[0.006, 0.006, 0.04, 6]} />
                <T.MeshStandardMaterial color="#222222" metalness={0.7} roughness={0.3} />
            </T.Mesh>
        </T.Group>

        <!-- second hand (longest, thinnest) -->
        <T.Group rotation.z={seconds * Math.PI / -30}>
            <!-- main hand -->
            <T.Mesh position={[0, 0.07, 0.04]}>
                <T.CylinderGeometry args={[0.004, 0.002, 0.14, 4]} />
                <T.MeshStandardMaterial color="#CC0000" metalness={0.6} roughness={0.4} />
            </T.Mesh>
            <!-- counterweight -->
            <T.Mesh position={[0, -0.025, 0.04]}>
                <T.CylinderGeometry args={[0.006, 0.006, 0.05, 8]} />
                <T.MeshStandardMaterial color="#CC0000" metalness={0.6} roughness={0.4} />
            </T.Mesh>
            <!-- decorative circle near tip -->
            <T.Mesh position={[0, 0.11, 0.04]}>
                <T.CylinderGeometry args={[0.008, 0.008, 0.002, 16]} />
                <T.MeshStandardMaterial color="#CC0000" metalness={0.6} roughness={0.4} />
            </T.Mesh>
        </T.Group>
    </T.Group>

    <!-- top hand grip -->
     <T.Mesh position={[Math.sin(Math.PI / 6) * (0.27), Math.cos(Math.PI / 6) * (0.27),0 ]} rotation.z={Math.PI / -7}>
        <T.SphereGeometry args={[0.08, 32, 32, 0, Math.PI * 2, 0, Math.PI / 2]} />
        <T.MeshStandardMaterial color="#333333" metalness={0.8} roughness={0.2} />
     </T.Mesh>
     <!-- sphere at the top of hemisphere -->
        <T.Mesh position={[Math.sin(Math.PI / 6) * (0.34) * -1, Math.cos(Math.PI / 6) * (0.34),0 ]} rotation.z={Math.PI / 7}>

            <T.SphereGeometry args={[0.02, 32, 32, 0, Math.PI * 2, 0, Math.PI / 2]} />
            <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.2} />
        </T.Mesh>

     <!-- left stand for top left grip -->
        <T.Mesh position={[Math.sin(Math.PI / 6) * (0.27) * -1, Math.cos(Math.PI / 6) * (0.27),0 ]} rotation.z={Math.PI / 7}>
            <T.CylinderGeometry args={[0.01,0.01,0.1,20,20]} />
            <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.01} />
        </T.Mesh>

     

     <T.Mesh position={[Math.sin(Math.PI / -6) * (0.27), Math.cos(Math.PI / 6) * (0.27),0 ]} rotation.z={Math.PI / 7}>
        <T.SphereGeometry args={[0.08, 32, 32, 0, Math.PI * 2, 0, Math.PI / 2]} />
        <T.MeshStandardMaterial color="#333333" metalness={0.8} roughness={0.2} />
     </T.Mesh>
     <T.Mesh position={[Math.sin(Math.PI / 6) * (0.34) * 1, Math.cos(Math.PI / 6) * (0.34),0 ]} rotation.z={Math.PI / -7}>

        <T.SphereGeometry args={[0.02, 32, 32, 0, Math.PI * 2, 0, Math.PI / 2]} />
        <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.2} />
    </T.Mesh>
     <T.Mesh position={[Math.sin(Math.PI / 6) * (0.27) , Math.cos(Math.PI / 6) * (0.27),0 ]} rotation.z={Math.PI / -7}>
        <T.CylinderGeometry args={[0.01,0.01,0.1,20,20]} />
        <T.MeshStandardMaterial color="white" metalness={0.8} roughness={0.01} />
    </T.Mesh>

    <!-- top hand grip ring -->
    <T.Mesh position={[0,0.2,0]} rotation.z={(Math.PI - Math.PI / 1.4) / 2}>
        <T.TorusGeometry args={[0.2, 0.01, 50, 50, Math.PI / 1.4]} />
        <T.MeshStandardMaterial color="#333333" metalness={0.8} roughness={0.2} />
    </T.Mesh>
</T.Group>