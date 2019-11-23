package tree.baubles

deny[message] {
	bauble := input.baubles[_]

	count({point |
		point := input.outline[_]
		point == bauble
	}) == 0

	message := "bauble was found off tree outline"
}

deny[message] {
	# generate an outline which allows wrapping round
	final_outline_point := input.outline[count(input.outline)-1]
	outline_with_final_at_start := array.concat([final_outline_point], input.outline)
	outline := array.concat(outline_with_final_at_start, [input.outline[0]])

	# find any bauble
	bauble := input.baubles[_]
	# find the point it's on
	point := outline[i]
	bauble == point

	# find the adj points in the outline
	point_before := outline[i-1]
	point_after := outline[i+1]
	trace(sprintf("charlie %v", [point_before]))

	# find the min x coord, bauble must have this
	xs := sort([point_before[0], point_after[0], point[0]])
	trace(sprintf("minx %v", [xs]))
	trace(sprintf("baubs %v", [bauble]))

	# the bauble does not have the minimum x coord
	xs[0] != bauble[0]

	message := "bauble was not on a tree point"
}
