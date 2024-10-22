# Test Code Structure

Here I describe how I like to structure my test code.
Some samples following this style can be found in [another repository][testingStyleSamples].

In a lot of names some part is in angle brackets: `Prefix<ToBeReplaced>Suffix`.
The part in angle brackets is meant to be replaced while the other parts should be used verbatim.

[testingStyleSamples]: https://github.com/koenigst/samples/tree/main/testing-style

## Test class structure

### Class naming

The test class should be named like the component under test with a Test suffix (e.g. `EmployeeCurrentStaffingTest`).
Depending on the [type of test][testTypes] it is advantageous to have additional naming rules.
The following are some examples of such rules:

* Logic tests for classes: `<ClassUnderTest>Test`

* Component tests: `<ComponentUnderTest>Test` ([sample][componentSample])

* Web API tests: `<ApiAreaUnderTest>ApiTest` ([sample][apiSample])

* End-to-end application tests: `<ApplicationAreaUnderTest>ApplicationTest`

* Base classes for test classes: `<CommonTestClassDescriptor>TestBase`

[testTypes]: types.md
[componentSample]: https://github.com/koenigst/samples/tree/main/testing-style/test/SampleApp.Test/GuessingServiceTest.cs
[apiSample]: https://github.com/koenigst/samples/tree/main/testing-style/test/SampleApp.Test/GuessingApiTest.cs

### Regions

Regions should be used to separate the test cases from any other members.
This allows the reader to focus on the part of the test class that is most interesting to them which is usually the test cases.
The test cases themselves should not be wrapped in a region.
This way everything except the test cases is folded when a developer opens a test class file.
The following region structure is recommended:

1. `#region state` contains all constants, fields and properties.
2. `#region lifecycle` contains the constructor, Dispose methods and other lifecycle methods
3. Test cases
4. `#region implementation` contains all the methods that are not test cases and all nested types

## Test case method

### Method naming

The test case methods should be named with the following pattern `<FunctionUnderTest>_<TestedBehaviour>_<ExpectedOutcome>` (e.g. `CurrentStaffing_EmployeeDoesNotExist_EmptyListReturned`).
`FunctionUnderTest` is a general description of the use case or behaviour used to group multiple test methods it is not meant to be the exact name of method called during the test.
`TestedBehaviour` describes the preconditions and actions that apply to this test.
`ExpectedOutcome` describes the postconditions that the test asserts.
The description preconditions, actions and postconditions should focus on distinguishing between the test cases while giving a general idea of what the test does.

### Method implementation

Each test case should be structured in the ["given, when, then"][givenwhenthen] pattern (a.k.a. "arrange, act, assert").
Most of the times it is recommended to extract the actual implementation of each step into separate `Given`, `When`, `Then` implementation methods.
This makes the test method read almost like a [gherkin][gherkin] description of the test case which helps with understanding what the test case does in detail.
It also promotes code reuse between the test cases and reduces the amount of lines of code that have to be changed during refactorings.
The naming of the implementation methods should be as follows:

* `Given_<Subject>_<State>` defines in which state the unit under test is or one of its dependencies are (e.g. `Given_Database_WithOneEmployee`)

* `When_<Subject>_<Action>` defines what is done to the unit under test (e.g. `When_EmployeeService_AddsSkill`)

* `Then_<Subject>_<Expectation>` defines the expected state (e.g. `Then_Employee_HasSkill`)

* `Helper_<MethodDescription>` used for any methods not directly used in a test case method

It is recommended that the `Given`, `When`, `Then` implementation methods return `void` or `Task` and have no parameters.
Any return values should be stored in fields of the test class so that they can be used by other methods.
This helps with code reuse.
Helper methods can have any return types and parameters.

[givenwhenthen]: https://martinfowler.com/bliki/GivenWhenThen.html
[gherkin]: https://cucumber.io/docs/gherkin/

## Test bootstrapping

I like using the applications dependency injection (DI) facilities in all tests except the simplest logic tests.
This has the advantage that faking hard dependencies is relatively easy because most DI-frameworks allow for simple replacement of services.
It also simplifies writing reusable fakes.
