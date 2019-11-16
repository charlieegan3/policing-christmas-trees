package tree.outline

deny[message] {
	count(input) % 2 == 0
	message := sprintf("outline missing single central point (found %d points)", [count(input)])
}

deny[message] {
	point_count := count(input)
	left := array.slice(input, 0, round(point_count/2)-1)
	right := array.slice(input, round(point_count/2), point_count)
	top:= input[round(point_count/2)-1]
	trace(sprintf("top %v", [top]))

	trace(sprintf("left %v", [left]))
	trace(sprintf("right %v", [right]))

	left_point := left[i]
	right_point := right[count(right) -1 - i]
	trace(sprintf("i %v", [i]))

	trace(sprintf("l %v", [left_point]))
	trace(sprintf("r %v", [right_point]))


	transform := top[0] - left_point[0]
	trace(sprintf("t %v", [transform]))
	trace(sprintf("expect x %v", [top[0] + transform]))
	trace(sprintf("expect y %v", [left_point[1]]))

	valid_y := right_point[1] == left_point[1]
	valid_x := right_point[0] == top[0] + transform

	{ false } & { valid_y, valid_x } != set()

	message := "outline is asymetrical"
	trace(sprintf("Message set to %v", [message]))
}
