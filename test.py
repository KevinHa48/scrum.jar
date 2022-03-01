#!/usr/bin/env python3

tests = [
    "Accepts controller input?",
    "User can submit audio?",
    "Visual output is affected by audio?",
]

passed_tests = 0

for t in tests:
    print(t)
    if input("[y/n]: ") == "y":
        print("Passed")
        passed_tests += 1
    else:
        print("Failed")
    print()

print("Passed {}/{} tests".format(passed_tests, len(tests)))
