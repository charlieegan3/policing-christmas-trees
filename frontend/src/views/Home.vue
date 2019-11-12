<template>
  <div>
    <h1>Home</h1>
	<Plotter class="ba" :tree="tree"/>
  </div>
</template>

<script>
import Plotter from '@/components/Plotter.vue'

export default {
  name: 'home',
  data() {
    return {
		tree: {
			topper: "not",
			outline: [
			[1,1],
			[2,3],
			[1.5,3],
			[2,4],
			[1.75,4],
			[2.25,5],
			[2.75,4],
			[2.5,4],
			[3,3],
			[2.5,3],
			[3.5,1],
			],
		}
	}
  },
  watch: { },
  components: { Plotter }
}
</script>
