package tree.tinsels

deny[message] {
	some tinsel
	point_a := input.tinsels[tinsel][0]
	point_b := input.tinsels[tinsel][1]
	point_b[1] <= point_a[1]
	message := sprintf("tinsel does not have positive gradient (%v %v)", [point_a, point_b])
}

deny[message] {
	# check tinsels
	some t
	some p
	# find the start and end point for each
	point := input.tinsels[t][p]

	# find the set of segments for universal quantification
	segment_matches := {segment |
		# check outline segments
		some i
		i < count(input.outline) -1
		# find a start and end for each segment
		outline_point_a := input.outline[i]
		outline_point_b := input.outline[i+1]
		segment := [outline_point_a, outline_point_b]

		# find the gradient of the outline segment
		gradient := (outline_point_a[1] - outline_point_b[1]) /
					(outline_point_a[0] - outline_point_b[0])

		# find the y intercept to build the line equation
		y_intercept := -1*((-1*outline_point_a[1]) + (gradient * outline_point_a[0]))

		# there is an intercept with the segment's line equation
		expected_y := gradient * point[0] + y_intercept
		expected_y == point[1]

		# x is within line segment range
		segment_x_range := sort([outline_point_a[0], outline_point_b[0]])
		point[0] >= segment_x_range[0]
		point[0] <= segment_x_range[1]

		# y is within line segment range
		segment_y_range := sort([outline_point_a[1], outline_point_b[1]])
		point[1] >= segment_y_range[0]
		point[1] <= segment_y_range[1]
	}

	# if there are no matches
	count(segment_matches ) == 0

	message := "tinsel does not start and end on outline"
}
