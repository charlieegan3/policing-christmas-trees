<template>
  <div>
    <h1>Home</h1>
    <button v-on:click="tree.topper = 'star'">&#11088;</button>
    <button v-on:click="tree.topper = 'angel'">&#128519;</button>
    <button v-on:click="tree.topper = 'poop'">&#128169;</button>
    <button v-on:click="tree.outline = []; tree.tinsels = []">Clear</button>
    <br/>
    <button v-on:click="validate">Validate</button>
	<p v-if="validation.valid">Your tree is allowed</p>
	<p v-if="validation.valid == false">Your tree is bad</p>
	<p>{{ validation.status }}</p>
	<ul>
	  <li v-for="message in validation.messages">
		{{ message }}
	  </li>
	</ul>
    <br/>
	<p>PlotMode: {{ plottingMode }}</p>
	<button v-on:click="plottingMode = 'tree'">tree</button>
	<button v-on:click="plottingMode = 'tinsel'">tinsel</button>
	<button v-on:click="plottingMode = 'bauble'">bauble</button>
    <br/>
	<div>
		<div class="dib fl">
			<Plotter class="ba"
					 :width="height"
					 :height="height"
					 :scaleFactor="gridSize"
					 :tree="tree"
					 :cursor="cursor"
					 @mousemove="updateCursor"
					 @clicked="addPoint"/>
		</div>
		<div class="f7 fl">
			<textarea rows="50">{{ JSON.stringify(this.tree, null, 2) }}</textarea>
		</div>
		<div class="f7 fl">
			<p>Outline</p>
			<ul>
				<li v-for="point, index in tree.outline">
					{{ point }}
    				<button v-on:click="tree.outline.splice(index, 1)">X</button>
				</li>
			</ul>
		</div>
		<div class="f7 fl">
			<p>Tinsels</p>
			<ul>
				<li v-for="tinsel, index in tree.tinsels">
					{{ tinsel }}
    				<button v-on:click="tree.tinsels.splice(index, 1)">X</button>
				</li>
			</ul>
		</div>
		<div class="f7 fl">
			<p>Baubles</p>
			<ul>
				<li v-for="bauble, index in tree.baubles">
					{{ bauble }}
    				<button v-on:click="tree.baubles.splice(index, 1)">X</button>
				</li>
			</ul>
		</div>
	</div>

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
			"topper": "star",
			"baubles": [],
			"tinsels": [
				[ [ 1, 1.5 ], [ 10, 2.5 ] ], [ [ 2, 4.5 ], [ 9, 5.5 ] ], [ [ 4, 7.5 ], [ 7, 8.5 ] ]
			],
			"outline": [
				[ 1, 1.5 ], [ 4, 4.5 ], [ 2, 4.5 ], [ 5, 7.5 ], [ 4, 7.5 ], [ 6, 9.5 ], [ 8, 7.5 ], [ 7, 7.5 ], [ 10, 4.5 ], [ 8, 4.5 ], [ 11, 1.5 ]
			]
		},
		cursor: {x: 1, y: 1},
		plottingMode: "tree",
		validation: {
			valid: null,
			status: "",
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
		if (this.plottingMode == "tree") {
			this.tree.outline.push([
				this.roundValue(value.x) / this.gridSize,
				(this.height - this.roundValue(value.y)) / this.gridSize,
			])
		} else if (this.plottingMode == "bauble") {
			this.tree.baubles.push([
				this.roundValue(value.x) / this.gridSize,
				(this.height - this.roundValue(value.y)) / this.gridSize,
			])
		} else if (this.plottingMode == "tinsel") {
			var tinsels = this.tree.tinsels;
			var point = [this.roundValue(value.x) / this.gridSize,
						(this.height - this.roundValue(value.y)) / this.gridSize]
			if (tinsels.length == 0) {
				tinsels.push([point])
			} else {
				if (tinsels[tinsels.length-1].length < 2) {
					tinsels[tinsels.length-1].push(point)
				} else {
					tinsels.push([point])
				}
			}
			this.tree.tinsels = tinsels;
		}
	},
	roundValue: function(value) {
	  return Math.round(value / this.gridSize) * this.gridSize;
	},
	renderResponse: function(data) {
		this.validation.messages = data.messages;
		this.validation.valid = data.valid;
	},
	validate: function(value) {
	  this.validation.status = "awaiting validation response";
	  var app = this;
      axios.post("https://server.xmas-trees.charlieegan3.com/v0/data/tree/main/validate", this.tree)
        .then(function(response) {
			app.renderResponse(response.data)
	  app.validation.status = "";
        })
        .catch(function(error) {
          app.validation.messages = ["Unable to validate"];
	  app.validation.status = "error";
          console.log(error)
        });
	}
  },
  watch: {
	  tree: {
		  handler: function() { this.validate() },
		  deep: true
	  }
  },
  components: { Plotter }
}
</script>
