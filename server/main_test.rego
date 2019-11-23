package tree.main

import data.test_utils as test

test_validate_returns_flat_list_of_messages {
	tree := {
		"topper": "poop",
		"outline": [
			[ 1, 1.5 ], [ 4, 4.5 ], [ 2, 4.5 ]
		]
	}

	output := validate with input as tree
	trace(sprintf("%v", [concat(",", output["messages"])]))
	output == {
		"valid": false,
		"messages": [
			"outline is asymetrical",
			"topper 'poop' not in list: angel,star",
		]
	}
}

test_validate_valid_tree {
	tree := {
		"topper": "star",
		"outline": [
			[ 2, 1.5 ],
			[ 4, 3.5 ],
			[ 3, 3.5 ],
			[ 5, 5.5 ],
			[ 7, 3.5 ],
			[ 6, 3.5 ],
			[ 8, 1.5 ]
		]
	}

	output := validate with input as tree
	trace(sprintf("%v", [concat(",", output["messages"])]))
	output == {
		"valid": true,
		"messages": [ ]
	}
}

test_ensure_message_appears_once {
	# an outline with an even number of points is invalid since the tree has no
	# top point
	tree := {
		"topper": "star",
		"outline": [
			[ 2, 1.5 ],
			[ 6, 9.5 ],
			[ 9, 1.5 ],
			[ 8, 0.5 ],
			[ 9, 2.5 ],
		]
	}

	output := validate with input as tree
	trace(sprintf("%v", [concat(",", output["messages"])]))
	output == {
		"valid": false,
		"messages": ["outline is asymetrical"]
	}
}
