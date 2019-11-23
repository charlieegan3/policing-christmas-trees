package tree.baubles

deny[message] {
	bauble := input.baubles[_]

	count({point |
		point := input.outline[_]
		point == bauble
	}) == 0

	message := "bauble was found off tree outline"
}
