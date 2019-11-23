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
	test.assert_denied_and_trace(output, "tinsel has negative gradient")
}
