% Code Review Guide<!-- markdownlint-disable-line -->
% koenigst
% 30. August 2024

---

## Define Expectations

. . .

... and document them

---

### Time

* 1-3 days to merge
* &lt;30 min per review

---

### Scope

* Code conventions
* Existing code
* Structure
* Temporary code

::: notes

* Code conventions means things such as spacing but also things such as; using linq or not, having tests.
* Knowledge of existing code is important to spot duplications and inconsistencies.
* Structure means how the code is structured and embedded into the solution (e.g. SOLID)
* Temporary code can be:
  * Debugging code
  * Commented out code
  * Unresolved todos

:::

---

### Out of Scope

* Checking acceptance criteria
* CI/CD status
* Testing

---

## It Hurts

---

### Common Pain Points

* Effort
* [Anxiety][changelogAnxiety]
* Delays
* Low perceived value
* Costly refactoring

[changelogAnxiety]: https://changelog.com/podcast/598

---

## Make it Easy

---

### Conversational Review

* Write whole sentences
* Questions instead of statements
* Talk through findings
* Express joy
* Appreciate feedback
* Learning mentality

---

> The worst time to do a review is during the pull-request.

---

### Iterative Review

* Structure review
* Signature/API review
* Test case review
* Partial implementation review
* Final review

::: notes

* The structure review can be done on a whiteboard before the first line of code is written.
* The signature/API review focuses mostly on naming and on usability from a consumer perspective.
* The test case review should check that the relevant scenarios are tested.
  * One fun exercise is defining the API together then having one person write the tests and one person the implementation.
* It is important during the partial implementation review to clearly communicate which parts are ready for review and which are not.
* The final review should mostly focus on internal consistency and small oversights such as typos and temporary code.

:::

---

> Not all findings are created equal.

---

### Prioritised Findings

* Use [priority classes][priorityClasses]
* Fix small things immediately

[priorityClasses]: https://www.netlify.com/blog/2020/03/05/feedback-ladders-how-we-encode-code-reviews-at-netlify/

---

> Perfect is the enemy of good - Voltaire

---

### Volume

* Smaller is better
* Split change into chunks
* Merge frequently
* Branch of branches if necessary

::: notes

* Branch of branches
  * Create smaller branches off the feature branch.
  * Review and merge smaller branches onto the feature branch.
  * It is unnecessary to do a in-depth review of the feature branch because every increment was already reviewed.

:::

---

## Looking at the Code

---

### Efficient Process

* Signature before implementation
* Skim the code
* Find [triggers][] for in-depth review

[triggers]: https://github.com/koenigst/knowhow/blob/main/review/triggers.md

---

## Steal it! Share it!<!-- markdownlint-disable-line -->

[Sources][sources] ([CC BY-SA 4.0][ccBySa]).

[sources]: https://github.com/koenigst/knowhow/tree/main/review/guide
[ccBySa]: https://creativecommons.org/licenses/by-sa/4.0/
