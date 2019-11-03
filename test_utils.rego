package test_utils

assert_allowed_and_trace(output) = output {
	trace(concat(",", output))
	output == set()
}
