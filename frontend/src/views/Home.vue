<template>
  <div>
    <h1>Home</h1>
    <button v-on:click="tree.topper = 'star'">&#11088;</button>
    <button v-on:click="tree.topper = 'angel'">&#128519;</button>
    <button v-on:click="tree.topper = 'poop'">&#128169;</button>
    <button v-on:click="tree.outline = []">Clear</button>
    <br/>
	<Plotter class="ba"
			 :width="height"
			 :height="height"
			 :scaleFactor="gridSize"
			 :tree="tree"
			 :cursor="cursor"
			 @mousemove="updateCursor"
			 @clicked="addPoint"/>
  </div>
</template>

<script>
import Plotter from '@/components/Plotter.vue'

export default {
  name: 'home',
  data() {
    return {
		width: 500, height: 500,
		gridSize: 40,
		tree: {
			topper: "not",
			outline: [ [1,1], [2,3], [1.5,3], [2,4], [1.75,4], [2.25,5], [2.75,4], [2.5,4], [3,3], [2.5,3], [3.5,1] ],
		},
		cursor: {x: 1, y: 1}
	}
  },
  methods: {
    updateCursor: function(value) {
		this.cursor.x = this.roundValue(value.x)
		this.cursor.y = this.roundValue(value.y)
	},
	addPoint: function(value) {
		this.tree.outline.push([
			this.roundValue(value.x) / this.gridSize,
			(this.height - this.roundValue(value.y)) / this.gridSize,
		])
	},
	roundValue: function(value) {
	  return Math.round(value / this.gridSize) * this.gridSize;
	}
  },
  components: { Plotter }
}
</script>
