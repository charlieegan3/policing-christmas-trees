package tree.main

import future.keywords.contains
import future.keywords.if
import future.keywords.in

deny contains messages if some messages in data.tree.outline.deny with input as input.outline
deny contains messages if some messages in data.tree.topper.deny  with input as input.topper
deny contains messages if some messages in data.tree.tinsels.deny # needs outline and tinsels
deny contains messages if some messages in data.tree.baubles.deny # needs outline and baubles

# main entrypoint that forms part of the v0 path: /v0/data/tree/main/validate
#                                                          tree.main validate
validate := {
	"valid": count(deny) == 0,
	"messages": sort(deny)
}
