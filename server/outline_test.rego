package tree.outline

import data.test_utils as test

test_simple_triangle_tree {
	# simple triangle is the most basic permitted outline
	outline := [
		[1, 1],
		[2, 2],
		[3, 1]
	]

	output := deny with input as outline
	test.assert_allowed_and_trace(output)
}

test_invalid_tree_without_top {
	# an outline with an even number of points is invalid since the tree has no
	# top point
	outline := [
		[1, 1],
		[1, 1]
	]

	output := deny with input as outline
	test.assert_denied_and_trace(output, "outline missing single central point (found 2 points)")
}

test_symetrical_tree_is_allowed {
	outline := [
		[1,1],
		[2,3],
		[1.5,3],
		[2,4],
		[1.75,4],
		[2.25,5],
		[2.75,4],
		[2.5,4],
		[3,3],
		[2.5,3],
		[3.5,1],
	]

	output := deny with input as outline
	test.assert_allowed_and_trace(output)
}

test_asymetrical_tree_is_blocked {
	outline := [
		[1, 1],
		[2, 2],
		[3, 3],
		[4, 3],
		[5, 2]
	]

	output := deny with input as outline
	test.assert_denied_and_trace(output, "outline is asymetrical")
}
