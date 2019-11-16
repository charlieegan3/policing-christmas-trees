package tree.outline

deny[message] {
	count(input) % 2 == 0
	message := sprintf("outline missing single central point (found %d points)", [count(input)])
}

deny[message] {
	point_count := count(input)
	max_index := count(input)-1

	top:= input[round(max_index/2)]
    some i

    index_a = i
    index_b = (max_index-i)
    point_a := input[index_a]
    point_b := input[index_b]

	transform := top[0] - point_a[0]
	trace(sprintf("t %v", [transform]))
	trace(sprintf("expect x %v", [top[0] + transform]))
	trace(sprintf("expect y %v", [point_a[1]]))

	valid_y := point_b[1] == point_a[1]
	valid_x := point_b[0] == top[0] + transform

	{ false } & { valid_y, valid_x } != set()

	message := "outline is asymetrical"
	trace(sprintf("Message set to %v", [message]))
}
