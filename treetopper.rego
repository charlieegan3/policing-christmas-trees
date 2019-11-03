package treetopper

deny[message] {
	not is_angel
	not is_star
	message := "input for topper was not one of the allowed values"
}

is_angel {
	input == "angel"
}

is_star {
	input == "star"
}
