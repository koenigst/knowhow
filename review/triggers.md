# Triggers during Code Review

One of the challenging parts of code review is that most of the code is correct.
The sections of code that need in-depth review are difficult to find.
The items in this documents are reasons to stop scanning the code and do a deeper analysis.
Most of the explanation are geared towards C# but are mostly applicable to similar languages.

## General

### Removing or changing old logic (see [Chesterton's fence][chestertonsfence])

Is the reason why the old logic was included known and understood by the person doing the change?
This is quite often not the case when removing branches that do not seem to be necessary.

### No Change in Tests

Every change in functionality should result in the test suite changing.
Even when fixing a regression the test suite must change to prevent this regression in the future.

### Simple comments in members

Most comments that are part of a code block are a detriment to readability.
Usually it is better to extract some parts of the code block into a separate member and naming it accordingly.

Sometimes there is further need for documentation such as linking to an external documentation or an issue.
This can be done directly in the XML-doc of the member using `/// <remarks>...</remarks>` blocks.
This makes it more visible in the IDE and the comment is part of the member signature.

## Component signature

### Unclear class or member signature

I try to guess what a class or member does based on its signature (name, modifiers and parameters).
If my understanding changes markedly when I read the implementation then the signature needs to be changed.

### Unclear separation of concerns

If it is difficult to describe the concerns of each class in one sentence I try to identify a better distribution of functionality.

### Too generic naming

For example `Service`/`Container`/`Manager`/`Provider` without any real hint to what this class does.

### Contextually redundant names

There are two main contexts in which names are relevant: definition and caller.
An easy example would be a static method called `CreateDateTime` defined on the class `DateTime`.
In the context of the definition it is slightly redundant but in the context of the caller it is highly redundant because the call will be `DateTime.CreateDateTime`.
The same logic also applies to instance methods which are usually called using a named reference e.g. `vector.Invert`.
The context of the caller is often overlooked during reviews as one focuses mostly on the definition.

### Unnecessary mutability

The default for any class or struct should be immutable.
If mutability is required it should be confined and concentrated.
It is better to have one mutable field or auto property containing an immutable type instead of having many mutable fields or auto properties.

### Unnecessary nullability

Is it a good idea to have `null` as a valid value for a field, auto property or parameter?
Allowing `null` can lead to a lot of additional complexity.
The [null-object pattern][nullobject] can be of great assistance here.

### Member parameters of delegate types (e.g. `Action` or `Func`)

Sometimes functionality is injected into a class (e.g. in the `ctor`) using a delegate, instead of passing in a reference to an interface or a class.
The delegate makes reasoning about interdependencies and control flow MUCH harder.
This does not apply when defining an operator in a functional programming style.

### `async void`

This is almost always a bug.
One of the very few places where it can be allowed is when adapting to infrastructure that does not support `async` (e.g. `ICommand`).

### Other signature triggers

* Unnecessary public visibility in classes/members

## Constructors

### Unnecessary work in the `ctor`

* Work that should be done in the `ctor`

  * Check parameters
  * Assign parameters to fields or auto properties
  * Create and assign the inner components of the class

* Work that should be done outside of the `ctor`

  * Computation based on parameters
  * Non-trivial initialization of components

* Possible solutions

  * Encapsulate computation and complex initialization in `System.Threading.Lazy'1`
  * Change the signature to allow the calling code to trigger the computation

### Event registrations in `ctor`

Registering an event callback in the `ctor` is dangerous because the callback might be called before the `ctor` has completed.
This can lead to hard to find concurrency bugs because the class is used in a partially initialized state.

Possible solutions:

* Use lifecycle infrastructure supplied by the framework/host
* Delegate the lifecycle management to the caller by creating a session object
* Use event registration propagation

## Control flow

### Unexpected null-conditional and null-coalescing operators

Unexpected use of the null-conditional (`?.`) and null-coalescing (`??`) operators can be a sign of hidden bugs.
The underlying implementation might return `null` when in an unexpected state.
Often it is better to fix the code returning the `null` instead of trying to handle it in the caller.

### Any try-catch or try-finally blocks

Especially critical are the following catch blocks:

* Catch all exceptions without re-throwing
* Catch unexpected exceptions (e.g. `InvalidOperationException`, `ArgumentException`,...)

## Dependency Injection

### State in services

State stored in services makes it difficult to reason about the total state of a system.

Possible solutions:

* Use a stateless approach

* Aggregate the state in a immutable object and delegate the state management to:

  * The caller

  * A dedicated state provider with as few dependencies as possible.
  This is state provider is usually registered as a singleton or scoped service.

### Interface extending `IDisposable`

It is allowed for an interface to extend `IDisposable` if the factory-methods creating instances with that interface have the interface as the return type and it is up to the caller to manage the lifecycle of the instance.
If the interface is implemented by classes managed by the dependency injection system or the caller creates instances with the `ctor` of the class then the class should implement `IDisposable` and the interface should not extend it.

### Static field or auto property

Instance caching should be done by the framework.
Static fields or auto properties can lead to issues with concurrency and testing.

## Iteration

* `foreach` statement collecting elements and returning collection => use Linq
* `List'1.ForEach` => use `foreach` statement
* Side effects in Linq => use `foreach` statement

## Unclassified

* Implementation of `IDisposable` (see the [Microsoft guidelines][idisposable])
* Code that looks like coming from Stack-Overflow
* `Thread.Sleep`

[chestertonsfence]: https://fs.blog/chestertons-fence/
[nullobject]: https://en.wikipedia.org/wiki/Null_object_pattern
[idisposable]: https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/implementing-dispose
