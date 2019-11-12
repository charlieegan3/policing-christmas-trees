<template>
  <canvas :width="width" :height="height" :data-trigger="ctx &amp;&amp; redraw"/>
</template>

<script>

export default {
  props: ['tree'],
  data() {
	  return {
		  ctx: null,
		  width: 500,
		  height: 600,
		  scaleFactor: 100,
	  };
  },
  mounted() { this.ctx = this.$el.getContext('2d'); },
  methods: {
    draw: function(ctx) {
      ctx.font = "30px Arial";
      var outline = this.transformOutline(this.tree.outline);

      var treeTop = outline[Math.floor(outline.length/2)];

      var topperString = String.fromCodePoint(128519);
      if (this.tree.topper == "star") {
        topperString = String.fromCodePoint(11088);
      }

      ctx.fillText(topperString, treeTop[0]-15, treeTop[1]-5);

      // add a point to complete the shape
      outline.push(outline[0]);
      for (var i = 0; i < outline.length - 1; i++) {
        ctx.moveTo(outline[i][0],outline[i][1]);
        ctx.lineTo(outline[i+1][0],outline[i+1][1]);
        ctx.stroke();
      }

    },
	transformOutline: function(outline) {
		var transformedOutline = [];
		for (var i = 0; i < outline.length; i++) {
			transformedOutline.push([
				outline[i][0] * this.scaleFactor,
				this.height - outline[i][1] * this.scaleFactor,
			])
		}
		return transformedOutline
	},
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
