<template>
  <div>
    <h1>Home</h1>
    <button v-on:click="tree.topper = 'star'">&#11088;</button>
    <button v-on:click="tree.topper = 'angel'">&#128519;</button>
    <button v-on:click="tree.topper = 'poop'">&#128169;</button>
    <button v-on:click="tree.outline = []">Clear</button>
    <br/>
    <button v-on:click="validate">Validate</button>
	<p v-if="validation.valid">Your tree is allowed</p>
	<p v-if="!validation.valid">Your tree is bad</p>
	<ul>
	  <li v-for="message in validation.messages">
		{{ message }}
	  </li>
	</ul>
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
import axios from 'axios';

export default {
  name: 'home',
  data() {
    return {
		width: 500, height: 500,
		gridSize: 40,
		tree: {
			topper: "star",
			outline: [
              [ 1, 1.5 ],
              [ 4, 4.5 ],
              [ 2, 4.5 ],
              [ 5, 7.5 ],
              [ 4, 7.5 ],
              [ 6, 9.5 ],
              [ 8, 7.5 ],
              [ 7, 7.5 ],
              [ 10, 4.5 ],
              [ 8, 4.5 ],
              [ 11, 1.5 ]
			],
		},
		cursor: {x: 1, y: 1},
		validation: {
			valid: null,
			messages: []
		},
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
		console.log(this.tree.outline)
	},
	roundValue: function(value) {
	  return Math.round(value / this.gridSize) * this.gridSize;
	},
	renderResponse: function(data) {
		console.log(data);
		this.validation.messages = data.messages;
		this.validation.valid = data.valid;
	},
	validate: function(value) {
	  var app = this;
      axios.post("http://localhost:8081/v0/data/tree/main/validate", this.tree)
        .then(function(response) {
			app.renderResponse(response.data)
        })
        .catch(function(error) {
          console.log(error)
        });
	}
  },
  components: { Plotter }
}
</script>
