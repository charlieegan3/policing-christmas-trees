package tree.topper

# single policy to describe allowed toppers
deny[message] {
	allowed_toppers := {"angel", "star"}
	# if the input is not in the allowed list
	# i.e. the intersection with the allowed toppers is empty
	allowed_toppers & {input} == set()
	# bind the message to the following error
	message := sprintf("topper '%s' not in list: %s", [input, concat(",", allowed_toppers)])
}
