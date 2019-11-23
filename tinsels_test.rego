package tree.tinsels

import data.test_utils as test

test_tinsels_positive_gradient {
	tree := {
	  "topper": "star",
	  "tinsels": [
		[ [ 3, 2.5 ], [ 6, 4.5 ] ]
	  ],
	  "outline": [
		[ 2, 1.5 ], [ 4, 3.5 ], [ 3, 3.5 ], [ 5, 5.5 ], [ 7, 3.5 ], [ 6, 3.5 ], [ 8, 1.5 ]
	  ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_allowed_and_trace(output)
}

test_tinsels_negative_gradient_blocked {
	tree := {
	  "topper": "star",
	  "tinsels": [
		[ [ 3, 2.5 ], [ 6, 4.5 ] ],
	  	[ [ 4, 4.5 ], [ 7, 2.5 ] ] # this tinsel has neg gradiant
	  ],
	  "outline": [
		[ 2, 1.5 ], [ 4, 3.5 ], [ 3, 3.5 ], [ 5, 5.5 ], [ 7, 3.5 ], [ 6, 3.5 ], [ 8, 1.5 ]
	  ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_denied_and_trace(output, "tinsel does not have positive gradient ([4, 4.5] [7, 2.5])")
}

test_tinsel_on_outline_allowed {
	tree := {
		"topper": "star",
		"tinsels": [[ [ 2, 2.5 ], [ 5, 3.5 ] ]],
		"outline": [ [ 2, 2.5 ], [ 4, 4.5 ], [ 6, 2.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_allowed_and_trace(output)
}

test_tinsel_off_outline_blocked_1 {
	tree := {
		"topper": "star",
		"tinsels": [ [ [ 2, 2.5 ], [ 6, 4.5 ] ] ],
		"outline": [ [ 2, 2.5 ], [ 4, 4.5 ], [ 6, 2.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_denied_and_trace(output, "tinsel does not start and end on outline")
}

# example where on line but not on segment
test_tinsel_off_outline_blocked_2 {
	tree := {
		"topper": "star",
		# tinsel is on the same equation as a segment but not on the segment
		"tinsels": [ [ [ 2, 1.5 ], [ 3, 4.5 ] ] ],
		"outline": [ [ 2, 1.5 ], [ 4, 3.5 ], [ 6, 1.5 ] ]
	}

	output := deny with input as tree # need the tree for the outline too
	test.assert_denied_and_trace(output, "tinsel does not start and end on outline")
}
