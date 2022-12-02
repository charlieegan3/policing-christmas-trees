package tree.main

deny[messages] {
	data.tree.outline.deny[messages] with input as input.outline
}
deny[messages] {
	data.tree.topper.deny[messages] with input as input.topper
}
deny[messages] {
	data.tree.tinsels.deny[messages] # needs outline and tinsels
}
deny[messages] {
	data.tree.baubles.deny[messages] # needs outline and baubles
}

# main entrypoint that forms part of the v0 path: /v0/data/tree/main/validate
#                                                          tree.main validate
validate := {
	"valid": count(deny) == 0,
	"messages": sort(deny)
}
