package treetopper

import data.test_utils as test

test_tree_is_topped {
	topper := "angel"

	output := deny with input as topper
	test.assert_allowed_and_trace(output)
}

test_tree_is_topped_with_star {
	topper := "star"

	output := deny with input as topper
	test.assert_allowed_and_trace(output)
}
