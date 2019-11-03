package treetopper

deny[message] {
	allowed_toppers := {"angel", "star"}
	# if the input is not in the allowed list
	allowed_toppers & {input} == set()
	# bind the message to the following error
	message := sprintf("input for treetopper was not in: %s", [allowed_toppers])
}
