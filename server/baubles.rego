package tree.baubles

# validate the baubles are on a point on the outline
deny[message] {
	bauble := input.baubles[_]

	# find all the points of the outline that the bauble is on
	# if 0 (none), then deny
	count({point |
		point := input.outline[_]
		point == bauble
	}) == 0

	message := "bauble was found off tree outline"
}

# validate that baubles are at the bottom of points of trees
deny[message] {
	# generate an outline which allows wrapping round
	final_outline_point := input.outline[count(input.outline)-1]
	outline_with_final_at_start := array.concat([final_outline_point], input.outline)
	outline := array.concat(outline_with_final_at_start, [input.outline[0]])

	# find any bauble
	bauble := input.baubles[_]
	# find the point it's on
	point := input.outline[i]
	bauble == point

	# find the adj points in the outline
	point_before := outline[i]
	point_after := outline[i+2]

	# find the min y coord, bauble must have this
	ys := sort([point_before[1], point_after[1], point[1]])

	# the bauble does not have the minimum y coord
	ys[0] != bauble[1]

	message := "bauble was not on a tree point"
}
