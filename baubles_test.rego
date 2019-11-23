package tree.baubles

import data.test_utils as test

test_baubles_on_outline_point_valid {
	tree := {
		"topper": "star",
		"baubles": [ [ 3, 1.5 ] ],
		"outline": [ [ 3, 1.5 ], [ 5, 4.5 ], [ 7, 1.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_allowed_and_trace(output)
}

test_baubles_on_outline_point_invalid {
	tree := {
		"topper": "star",
		"baubles": [ [ 2, 1.5 ] ],
		"outline": [ [ 3, 1.5 ], [ 5, 4.5 ], [ 7, 1.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_denied_and_trace(output, "bauble was found off tree outline")
}

test_baubles_on_external_outline_points_valid {
	tree := {
		"topper": "star",
		"baubles": [ [ 3, 1.5 ] ], # valid bauble
		"outline": [ [ 3, 1.5 ], [ 5, 4.5 ], [ 7, 1.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_allowed_and_trace(output)
}

test_baubles_on_external_outline_points_invalid {
	tree := {
		"topper": "star",
		"baubles": [ [ 5, 4.5 ] ], # invalid location
		"outline": [ [ 3, 1.5 ], [ 5, 4.5 ], [ 7, 1.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_denied_and_trace(output, "bauble was not on a tree point")
}
