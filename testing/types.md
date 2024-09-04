# Tests Types

What should be tested varies a lot with the scope under test.
The following break down helps me to classify tests.
The names of the classifications can change **a lot** depending on source.

1. **Logic tests**

    These tests check the logic contained within one or more closely related domain or utility classes.

    * **Infrastructure**: There should be no dependencies on infrastructure.

    * **What to test**: Complex logic, edge cases, input verification

    * **Examples**:

        * Testing an algorithm like [Levenshtein distance][levenshteinWiki]

        * Testing that logic on a sequence of data can handle an empty input sequence

2. **Component tests**

    These tests check the behaviour of one or more closely related business services.

    * **Infrastructure**: The real dependencies should be used but any hard or costly dependencies are replaced.

    * **What to test**: Use cases, interactions between services

    * **Examples**:

        * Testing that employees can be aggregated by their skills

        * Testing that a change in an employee profile is reflected when searching for employees

3. **Integration tests**

    These tests check the behaviour of the whole application.

    * **Infrastructure**: Only the dependencies outside of the control of the development team should be replaced.

    * **What to test**: High value use cases, application bootstrapping

    * **Examples**:

        * Testing that the employees with low workload can be filtered and sorted

        * Testing that a published interface contract is fulfilled by the application

4. **System tests**

    These tests check the behaviour of a real system.

    * **Infrastructure**: This requires a copy of the system including the parts that a real user uses to interact with it.

    * **What to test**: Compatibility of the system components

    * **Examples**:

        * Testing that the employee page is correctly displayed in chrome

        * Testing that changes in another system are visible to the user

[levenshteinWiki]: https://en.wikipedia.org/wiki/Levenshtein_distance
