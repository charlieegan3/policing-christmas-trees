package tree.topper

deny[message] {
	allowed_toppers := {"angel", "star"}
	# if the input is not in the allowed list
	allowed_toppers & {input} == set()
	# bind the message to the following error
	message := sprintf("topper '%s' not in list: %s", [input, concat(",", allowed_toppers)])
}
