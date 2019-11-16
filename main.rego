package tree.main

import data.tree.outline
import data.tree.topper

deny[messages] {
	data.tree.outline.deny[messages] with input as input.outline
}
deny[messages] {
	data.tree.topper.deny[messages] with input as input.topper
}

output = [m | m := deny[_]]

validate = {
	"valid": count(output) == 0,
	"messages": sort(output)
}
