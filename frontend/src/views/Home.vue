<template>
	<div>
		<p>Create a Christmas tree and find out if it's valid</p>
		<p>
			Choose
			<button v-on:click="tree.topper = 'star'">&#11088;</button>
			<button v-on:click="tree.topper = 'angel'">&#128519;</button>
			<button v-on:click="tree.topper = 'poop'">&#128169;</button>
		</p>
		<p>
			Draw
			<button v-bind:class="{ 'ba pa2 b--green': plottingMode == 'tree'}" v-on:click="plottingMode = 'tree'">&#127876; outline</button>
			<button v-bind:class="{ 'ba pa2 b--green': plottingMode == 'tinsel'}" v-on:click="plottingMode = 'tinsel'">&#10024; tinsel</button>
			<button v-bind:class="{ 'ba pa2 b--green': plottingMode == 'bauble'}" v-on:click="plottingMode = 'bauble'">&#128302; bauble</button>
			<button v-on:click="tree.outline = []; tree.tinsels = []; tree.baubles = []">Clear</button>
			<button v-on:click="validate">Validate</button>
			<button v-on:click="showExamples = !showExamples">
				{{ showExamples ? "Hide Examples" : "Examples" }}
			</button>
		</p>
		<div v-if="showExamples">
			<button v-for="t, name in examples" v-on:click="tree = t">
				{{ name }}
			</button>
		</div>
		<p v-if="validation.status != ''">
			<img src="https://upload.wikimedia.org/wikipedia/commons/d/de/Ajax-loader.gif">
			{{ validation.status }}
		</p>
		<p v-if="validation.valid">Your tree is <span class="green">good</span></p>
		<p v-if="validation.valid == false">Your tree is <span class="red">bad</span></p>
		<ul>
			<li v-for="message in validation.messages">
				{{ message }}
			</li>
		</ul>
		<div>
			<div>
				<Plotter v-if="renderMode == 'canvas'"
					class="ba"
					:width="height"
					:height="height"
					:scaleFactor="gridSize"
					:tree="tree"
					:cursor="cursor"
					@mousemove="updateCursor"
					@clicked="addPoint"/>
			</div>
			<div class="f7">
				<textarea v-if="renderMode == 'json'" rows="50">{{ JSON.stringify(this.tree, null, 2) }}</textarea>
			</div>
			<input type="radio" value="json" v-model="renderMode">
			<label for="json">JSON</label>
			<br>
			<input type="radio" value="canvas" v-model="renderMode">
			<label for="canvas">Canvas</label>
			<br>
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
	created() {
		this.tree = this.examples.full;
	},
	data() {
		return {
			width: 500,
			height: 500,
			gridSize: 40,
			tree: { },
			cursor: { x: 1, y: 1 },
			plottingMode: "tree",
			renderMode: "canvas",
			validation: {
				valid: null,
				status: "",
				messages: []
			},
			showExamples: false,
			examples: {
				full: {
					"topper": "star",
					"baubles": [ [ 8, 7.5 ], [ 4, 7.5 ], [ 2, 4.5 ], [ 1, 1.5 ], [ 11, 1.5 ], [ 10, 4.5 ] ],
					"tinsels": [ [ [ 1, 1.5 ], [ 10, 2.5 ] ], [ [ 2, 4.5 ], [ 9, 5.5 ] ], [ [ 4, 7.5 ], [ 7, 8.5 ] ] ],
					"outline": [ [ 1, 1.5 ], [ 4, 4.5 ], [ 2, 4.5 ], [ 5, 7.5 ], [ 4, 7.5 ], [ 6, 9.5 ], [ 8, 7.5 ], [ 7, 7.5 ], [ 10, 4.5 ], [ 8, 4.5 ], [ 11, 1.5 ] ]
				},
				simple: {
					"topper": "star",
					"baubles": [], "tinsels": [],
					"outline": [ [ 3, 2.5 ], [ 5, 7.5 ], [ 7, 2.5 ] ]
				},
				asym: {
					"topper": "star",
					"baubles": [], "tinsels": [],
					"outline": [ [ 3, 3.5 ], [ 7, 10.5 ], [ 8, 3.5 ] ]
				},
				badBaubs: {
					"topper": "star",
					"baubles": [ [ 5, 7.5 ], [ 6, 9.5 ] ],
					"tinsels": [],
					"outline": [ [ 4, 4.5 ], [ 2, 4.5 ], [ 5, 7.5 ], [ 4, 7.5 ], [ 6, 9.5 ], [ 8, 7.5 ], [ 7, 7.5 ], [ 10, 4.5 ], [ 8, 4.5 ] ]
				},
				badTins: {
					"topper": "star",
					"baubles": [],
					"tinsels": [ [ [ 5, 7.5 ], [ 9, 5.5 ] ], [ [ 2, 5.5 ], [ 7, 7.5 ] ] ],
					"outline": [ [ 4, 4.5 ], [ 2, 4.5 ], [ 5, 7.5 ], [ 4, 7.5 ], [ 6, 9.5 ], [ 8, 7.5 ], [ 7, 7.5 ], [ 10, 4.5 ], [ 8, 4.5 ] ]
				},
				complex: {
					"topper": "angel",
					"baubles": [ [ 11, 10.5 ], [ 11, 9.5 ], [ 11, 8.5 ], [ 11, 7.5 ], [ 11, 6.5 ], [ 11, 5.5 ], [ 11, 4.5 ], [ 11, 3.5 ], [ 11, 1.5 ], [ 11, 2.5 ], [ 1, 10.5 ], [ 1, 1.5 ], [ 1, 2.5 ], [ 1, 3.5 ], [ 1, 4.5 ], [ 1, 4.5 ], [ 1, 5.5 ], [ 1, 6.5 ], [ 1, 7.5 ], [ 1, 9.5 ], [ 1, 8.5 ] ],
					"tinsels": [ [ [ 2, 2.5 ], [ 10, 3.5 ] ], [ [ 2, 3.5 ], [ 10, 4.5 ] ], [ [ 2, 4.5 ], [ 10, 5.5 ] ], [ [ 2, 5.5 ], [ 10, 6.5 ] ], [ [ 2, 6.5 ], [ 10, 7.5 ] ], [ [ 2, 7.5 ], [ 10, 8.5 ] ], [ [ 2, 8.5 ], [ 10, 9.5 ] ], [ [ 2, 9.5 ], [ 10, 10.5 ] ] ],
					"outline": [ [ 1, 1.5 ], [ 2, 2.5 ], [ 1, 2.5 ], [ 2, 3.5 ], [ 1, 3.5 ], [ 2, 4.5 ], [ 1, 4.5 ], [ 2, 5.5 ], [ 1, 5.5 ], [ 2, 6.5 ], [ 1, 6.5 ], [ 2, 7.5 ], [ 1, 7.5 ], [ 2, 8.5 ], [ 1, 8.5 ], [ 2, 9.5 ], [ 1, 9.5 ], [ 2, 10.5 ], [ 1, 10.5 ], [ 6, 11.5 ], [ 11, 10.5 ], [ 10, 10.5 ], [ 11, 9.5 ], [ 10, 9.5 ], [ 11, 8.5 ], [ 10, 8.5 ], [ 11, 7.5 ], [ 10, 7.5 ], [ 11, 6.5 ], [ 10, 6.5 ], [ 11, 5.5 ], [ 10, 5.5 ], [ 11, 4.5 ], [ 10, 4.5 ], [ 11, 3.5 ], [ 10, 3.5 ], [ 11, 2.5 ], [ 10, 2.5 ], [ 11, 1.5 ] ]
				}
			}
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
					(this.height - this.roundValue(value.y)) / this.gridSize
				]
				if (tinsels.length == 0) {
					tinsels.push([point])
				} else {
					if (tinsels[tinsels.length - 1].length < 2) {
						tinsels[tinsels.length - 1].push(point)
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
			handler: function() {
				this.validate()
			},
			deep: true
		}
	},
	components: {
		Plotter
	}
}
</script>
