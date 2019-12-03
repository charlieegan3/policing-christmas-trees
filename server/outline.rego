package tree.outline

# reject trees that have an even number of points as they can't be symetrical
# with a flat bottom and point at the top
deny[message] {
	# even check
	count(input) % 2 == 0
	message := sprintf("outline missing single central point (found %d points)", [count(input)])
}

# validate the outline has points either side that match forming a symetrical
# shape
deny[message] {
	point_count := count(input)
	# find the number of points that need to be considered
	max_index := point_count-1

	# find the top of the tree
	top := input[round(max_index/2)]

	# for some index
    some i
    index_a = i
	# find the point on the other side of the tree
    index_b = (max_index-i)

	# store the two points
    point_a := input[index_a]
    point_b := input[index_b]

	# work out the diff with the centre point's x value
	transform := top[0] - point_a[0]

	# valid pairs have matching y coord
	valid_y := point_b[1] == point_a[1]
	# and matching x, after 'mirror' transform
	valid_x := point_b[0] == top[0] + transform

	# if either x or y is invalid
	{ false } & { valid_y, valid_x } != set()

	message := "outline is asymetrical"
}
