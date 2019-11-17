<template>
  <canvas :width="width" :height="height" :data-trigger="ctx &amp;&amp; redraw"/>
</template>

<script>

export default {
  props: ["tree", "cursor", "width", "height", "scaleFactor"],
  data() {
	  return { ctx: null };
  },
  mounted() {
	var canvas = this.$el;
	var component = this;
    this.$el.addEventListener('mousemove', function(evt) {
      var rect = canvas.getBoundingClientRect();
      var cursorPos = { x: evt.clientX - rect.left, y: evt.clientY - rect.top };
	  component.$emit("mousemove", cursorPos);
    }, false);
    this.$el.addEventListener('click', function(evt) {
      var rect = canvas.getBoundingClientRect();
      var cursorPos = { x: evt.clientX - rect.left, y: evt.clientY - rect.top };
	  component.$emit("clicked", cursorPos);
    }, false);
	this.ctx = canvas.getContext('2d');
  },
  methods: {
    draw: function(ctx) {
      // draw cursor
      ctx.font = "10px Arial";
      ctx.fillStyle = "#ccc";
      ctx.fillText(String.fromCodePoint(10060), this.cursor.x-5, this.cursor.y+5);

		for (var i = 0; i < this.width; i+=this.scaleFactor) {
			for (var j = 0; j < this.height; j+=this.scaleFactor) {
      			ctx.fillText("x", i, j);
			}
		}

	  // don't render if missing outline
		if (this.tree.outline.length == 0) {
			return
		}

      ctx.font = "30px Arial";
      var outline = this.transformOutline(this.tree.outline);

      var treeTop = outline[Math.floor(outline.length/2)];

      var topperString = String.fromCodePoint(128519);
      if (this.tree.topper == "star") {
        topperString = String.fromCodePoint(11088);
      }
      if (this.tree.topper == "poop") {
        topperString = String.fromCodePoint(128169);
      }

      ctx.fillText(topperString, treeTop[0]-15, treeTop[1]-5);

      // add a point to complete the shape
      ctx.lineWidth = 2;
      ctx.strokeStyle = "green";
      ctx.beginPath();
      outline.push(outline[0]);
      for (var i = 0; i < outline.length - 1; i++) {
        ctx.moveTo(outline[i][0],outline[i][1]);
        ctx.lineTo(outline[i+1][0],outline[i+1][1]);
        ctx.stroke();
      }

      var tinsels = this.transformTinsels(this.tree.tinsels);
      ctx.beginPath();
      ctx.lineWidth = 10;
      ctx.strokeStyle = "red";
      for (var i = 0; i < tinsels.length; i++) {
		ctx.moveTo(tinsels[i][0][0],tinsels[i][0][1]);
		ctx.lineTo(tinsels[i][1][0],tinsels[i][1][1]);
		ctx.stroke();
      }
    },
	transformOutline: function(outline) {
		var transformedOutline = [];
		for (var i = 0; i < outline.length; i++) {
			transformedOutline.push(this.transformPoint(outline[i]))
		}
		return transformedOutline
	},
	transformTinsels: function(tinsels) {
		var transformedTinsels = [];
		for (var i = 0; i < tinsels.length; i++) {
			if (tinsels[i].length == 2) {
				transformedTinsels.push([
					this.transformPoint(tinsels[i][0]),
					this.transformPoint(tinsels[i][1]),
				]);
			}
		}
		return transformedTinsels
	},
	transformPoint: function(point) {
		return [
			point[0] * this.scaleFactor,
			this.height - point[1] * this.scaleFactor,
		]
	}
  },
  computed: {
    redraw() {
      let canvas = this.$el;
      canvas.width = this.width;
      canvas.height = this.height;
      this.ctx.clearRect(0, 0, this.width, this.height);
      this.ctx.save();
      this.draw(this.ctx);
      this.ctx.restore();
    },
  },
}
</script>

<style>
</style>
