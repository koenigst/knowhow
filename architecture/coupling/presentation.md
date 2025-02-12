% Cohesion, Coupling and Cost<!-- markdownlint-disable-line -->
% koenigst
% 19. February 2025

---

## Definitions

---

> Cohesion is the degree to which the elements **inside** a module belong together.

::: notes

Source: [wikipedia](https://en.wikipedia.org/wiki/Cohesion_(computer_science))

:::

---

> Coupling is the degree of interdependence **between** modules.

::: notes

Source: [wikipedia](https://en.wikipedia.org/wiki/Coupling_(computer_programming))

:::

---

## Modules

---

### Module Boundaries

* Bounded contexts
* Development teams
* User groups
* Technology

::: notes

Boundaries are not always by choice but can be required by factors outside of our control.
Understanding which boundaries can be changed, or removed should inform architectural decisions.
Trying to ignore existing boundaries will increase cost.

:::

---

### Increasing Cohesion

* Reduce distance between
  * People
  * Files
* Be concrete

---

### Reducing Coupling

* Boundary contracts
* Semantic abstraction
* Simplified temporal patterns

::: notes

Reducing coupling is all about minimising the propagation of changes across module barriers.
Changes in one module should not necessitate changes in another module unless this change is significant to the other module.

:::

---

> Using an abstract type instead of a concrete type does not inherently reduce coupling.

---

### Costs of Reducing Coupling

* Design
* Maintenance
* Readability
* Performance

::: notes

Reducing coupling always introduces cost!
It is usually more expensive than expected.

:::

---

### Benefits of Reduced Coupling

* Extensibility
* Stability
* Parallel development
* Refactoring
* Testability

---

### Worth Investing

* Wrong size modules
* Wrong module boundaries
* Insufficient abstraction

---

## Examples

---

### Natural Boundary

![](./media/examples_naturally_bounded.svg){width=100%}

::: notes

The natural module boundary of different teams is sufficient.
The application module has only simple interactions with the file system abstractions.

:::

---

### Moving Boundaries

:::::: { .stacked }
::: incremental

* ![](./media/examples_moved_boundary_01.svg){width=100%}
* ![](./media/examples_moved_boundary_02.svg){width=100%}

:::
::::::

::: notes

The database module needs complex interactions with the file system.
The file system abstraction is leaky and the interactions depend on the underlying OS.
This leads to tight coupling between the modules because of insufficient abstraction.

A solution can be to introduce a custom abstraction.
The custom abstraction has a high cohesion with the underlying file system which is necessary to be fit for purpose.
As the new abstraction better fits the usage pattern the modules are now less tightly coupled.

:::

---

## Conclusion

---

### Key Take-aways

* Know your boundaries.
* Correct abstraction is key.
* Be as cohesive as possible and reduce coupling where necessary.

---

## Steal it! Share it!<!-- markdownlint-disable-line -->

[Sources][sources] ([CC BY-SA 4.0][ccBySa]).

[sources]: https://github.com/koenigst/knowhow/tree/main/architecture/coupling
[ccBySa]: https://creativecommons.org/licenses/by-sa/4.0/

<!-- markdownlint-disable -->

---
header-includes: # Additional styles https://pandoc.org/chunkedhtml-demo/8.10-metadata-blocks.html
- |
  <style type="text/css">
    blockquote strong {
      font-weight: 900;
    }
    .stacked ul {
      list-style: none;
      margin: 75px;
    }
    .stacked > .incremental > *:not([aria-selected]) { display: none; }
  </style>
...
