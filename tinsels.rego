package tree.tinsels

deny[message] {
	some tinsel
	point_a := input.tinsels[tinsel][0]
	point_b := input.tinsels[tinsel][1]
	point_b[1] < point_a[1]
	message := "tinsel has negative gradient"
}
