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



	segment_interceptions := {segment |
		# check outline segments
		some i
		i < count(input.outline) -1
		# find a start and end for each segment
		outline_point_a := input.outline[i]
		outline_point_b := input.outline[i+1]

		# find the gradient of the outline segment
		gradient := (outline_point_a[1] - outline_point_b[1]) /
					(outline_point_a[0] - outline_point_b[0])

		# find the y intercept to build the line equation
		y_intercept := -1*((-1*outline_point_a[1]) + (gradient * outline_point_a[0]))

		# calculate the expected y for the tinsel point
		expected_y := gradient * point[0] + y_intercept

		# if there is an intercept
		expected_y == point[1]

		segment := [outline_point_a, outline_point_b]
	}

	# if there are no interceptions
	count(segment_interceptions) == 0

	message := "tinsel does not start and end on outline"
}
