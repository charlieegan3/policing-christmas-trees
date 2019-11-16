package tree.main

import data.tree.outline
import data.tree.topper

deny[messages] {
	data.tree.outline.deny[messages] with input as input.outline
}
deny[messages] {
	data.tree.topper.deny[messages] with input as input.topper
}

# this must be a set as outline can have many solutions
# https://stackoverflow.com/questions/58895492/limit-opa-rego-to-a-single-rule-solution
output = {m | m := deny[_]}

validate = {
	"valid": count(output) == 0,
	"messages": sort(output)
}
