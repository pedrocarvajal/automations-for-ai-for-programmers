# Refactor Tests Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Read task notes standard**: Read `standards/task-notes.md` for code review comment format.

2. **Understand the test file context**: Identify the test file to refactor, understand its purpose, and verify it exists and is readable.

**THEN, follow these specific rules for test refactoring:**

- **MUST** verify tests after each phase - run tests and confirm they pass
- **MUST** verify linting after each phase - ensure no errors (Ruff, mypy)
- **REQUIRED** to explain skipped tasks - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **MANDATORY** to review existing helpers in wrapper classes and follow the same pattern (structure, parameters, documentation, naming conventions) when creating new helpers, constants, or any new element
- **MUST** run tests BEFORE starting refactoring to establish baseline
- **MUST** stop immediately if tests fail - do NOT continue to next phase

---

## CRITICAL RULES (NEVER VIOLATE)

- **NEVER** skip running tests between phases
- **NEVER** proceed to next phase if current phase has failing tests
- **NEVER** modify test logic - only refactor structure and helpers
- **NEVER** remove test cases without user approval
- **NEVER** change test assertions without understanding expected behavior
- **NEVER** skip user confirmations - always wait for explicit approval
- **NEVER** ignore linting errors - fix them immediately
- **NEVER** create helpers without reviewing existing patterns in wrapper classes
- **NEVER** use magic values - always use constants
- **NEVER** duplicate test logic - use parameterized tests instead
- **NEVER** use logging statements in tests (info, debug) - only use for error/warning/critical messages when necessary for debugging
- **ALWAYS** search codebase for existing helpers before creating new ones
- **ALWAYS** verify tests pass after each phase
- **ALWAYS** verify linting passes before proceeding
- **ALWAYS** explain skipped tasks with clear reasoning
- **ALWAYS** follow existing patterns and conventions

---

## ERROR HANDLING

If at any point:

- Tests fail: **STOP immediately**, report to user, do NOT continue
- Linting errors appear: **STOP immediately**, fix errors before continuing
- User requests changes: **STOP immediately**, wait for new instructions
- Ambiguity detected: **STOP immediately**, ask user for clarification
- Breaking changes detected: **STOP immediately**, present impact analysis to user
- Baseline tests fail: **STOP immediately**, fix existing tests before refactoring

**DO NOT** attempt to "fix" things silently or continue with broken tests.

---

## PRE-REQUISITES CHECKLIST

Before starting refactoring, verify:

- [ ] Test file exists and is readable
- [ ] All existing tests pass (establish baseline)
- [ ] Linting tools are configured (Ruff, mypy)
- [ ] Wrapper class exists and is accessible (e.g., `BinanceWrapper`, `WrapperIndicator`)
- [ ] Test file follows unittest structure
- [ ] Test file has tests that can be refactored

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete test file
- [ ] **VERIFY**: Run existing tests to establish baseline (all tests MUST pass before starting)
- [ ] **SEARCH**: Review existing helpers in wrapper classes to understand patterns
- [ ] **SEARCH**: Check for similar test files to understand conventions
- [ ] Identify code smells (duplication, magic strings, long tests, missing type hints)
- [ ] Identify repeated values that should become constants
- [ ] Identify duplicated tests that can be parameterized
- [ ] Check test file structure and organization
- [ ] Document any breaking changes that might occur
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks (e.g., "No helpers needed to create" if Phase 2 is skipped)

**Common Issues to Check:**

- Test file not found or unreadable
- Baseline tests failing (must fix before refactoring)
- No existing helpers in wrapper classes to reference
- Missing context about test file purpose
- Unclear test structure or organization

### Phase 2: Reusable Helpers

- [ ] **REVIEW existing helpers in wrapper classes** to understand the established pattern
- [ ] **SEARCH**: Check if helpers already exist before creating new ones
- [ ] Create helpers in wrapper classes for common entities (create models, payloads)
- [ ] **FOLLOW the same pattern** of existing helpers (structure, parameters, documentation)
- [ ] Document helpers with complete docstrings (description, parameters, return type, examples) following the existing format
- [ ] Ensure helpers allow value override through `**kwargs` or optional parameters
- [ ] Add proper type hints to all helper methods
- [ ] DO NOT use the helpers yet - only create them
- [ ] Run tests to verify no regressions (baseline should still pass)
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if this phase is skipped (e.g., "All necessary helpers already exist in wrapper classes")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Creating helpers that already exist
- Not following existing helper patterns
- Missing docstring documentation
- Helpers don't allow value overrides
- Missing type hints
- Linting errors after creating helpers
- Tests failing after helper creation (should not happen if helpers aren't used yet)

### Phase 3: Constants and Common Values

- [ ] Identify repeated values (strings, magic numbers)
- [ ] **VERIFY**: Check if constants already exist before creating new ones
- [ ] Create constants with prefix **tied to the model** where they will be used (e.g., `_DEFAULT_ORDER_*` for Order, `_DEFAULT_USER_*` for User)
- [ ] Use class-level constants with underscore prefix (e.g., `_SYMBOL`, `_DEFAULT_VOLUME`)
- [ ] Place constants in appropriate location (class constants at the top of the class)
- [ ] Update helpers to use constants
- [ ] Run tests to verify no regressions
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no constants were needed (e.g., "No repeated values found, all values are unique or already use constants")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Creating constants with wrong prefix (not tied to model)
- Constants already exist but not used
- Constants placed in wrong location
- Missing underscore prefix for class constants
- Linting errors after adding constants
- Tests failing after constant changes

### Phase 4: Refactor Tests Using Helpers

- [ ] Replace manual model creation with helpers
- [ ] Replace manual payloads with payload helpers
- [ ] Use constants instead of hardcoded values
- [ ] **VERIFY**: Ensure test logic remains unchanged (only structure changes)
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no refactoring was needed (e.g., "All tests already use helpers and constants")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Accidentally changing test logic while refactoring
- Tests failing after helper integration
- Not using constants where they should be used
- Linting errors after refactoring
- Test assertions changed unintentionally

### Phase 5: Parameterized Tests

- [ ] Identify duplicated tests with similar logic
- [ ] Create parameterized test methods using `@unittest.parameterized` or `subTest()` context manager
- [ ] Document parameterized tests with complete docstrings
- [ ] Unify duplicated tests using parameterization
- [ ] **VERIFY**: Ensure all test cases are covered by parameterization
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no parameterization was needed (e.g., "No duplicated tests found, all tests are unique")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Missing docstrings on parameterized tests
- Parameterized test doesn't cover all original test cases
- Tests failing after parameterization
- Parameterization format incorrect
- Missing proper type hints for parameters

### Phase 6: File Organization

- [ ] Reorganize structure according to recommended order:
  1. Code review comment
  2. Imports
  3. Type checking imports (if TYPE_CHECKING)
  4. Class definition
  5. Constants
  6. Properties
  7. Setup/Teardown
  8. Public test methods grouped by functionality
  9. Private helper methods
- [ ] Add section separators (`# ───────────────────────────────────────────────────────────`)
- [ ] Group tests logically (Success Cases, Validation, Update, Auth, etc.)
- [ ] **VERIFY**: Ensure no test logic changed during reorganization
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "File structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Accidentally removing or modifying test code during reorganization
- Tests failing after reorganization
- Section separators missing or inconsistent
- Tests not grouped logically
- Wrong order of sections

### Phase 7: Type Hints and Documentation

- [ ] Add type hints to all methods (parameters and return types)
- [ ] Add docstrings to all helper methods
- [ ] Add docstrings to complex test methods explaining edge cases
- [ ] Ensure TYPE_CHECKING imports are used for forward references
- [ ] **VERIFY**: Ensure no type errors with mypy
- [ ] Run all tests and verify they pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if type hints were already complete (e.g., "All methods already have complete type hints")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Missing type hints on some methods
- Incorrect type hints causing mypy errors
- Missing docstrings for complex methods
- TYPE_CHECKING imports not used when needed
- Tests failing after adding type hints (should not happen)
- Linting errors from type hints

### Phase 8: Comment and Logging Cleanup

- [ ] Remove obvious comments that add no value
- [ ] Add comments only where they explain complex context or edge cases
- [ ] Verify test names are descriptive (no need for comments)
- [ ] **IDENTIFY** all logging statements in test methods
- [ ] **REMOVE** unnecessary logging statements (info, debug) from test methods
- [ ] **KEEP** only logging statements for error/warning/critical messages when necessary for debugging
- [ ] **VERIFY**: Ensure no important context was removed with comments or logs
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no cleanup was needed (e.g., "No unnecessary comments or logs found, all are meaningful")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Removing comments that explain important context
- Removing logs that are necessary for debugging errors/warnings
- Test names not descriptive enough after comment removal
- Tests failing after comment/logging cleanup (should not happen)
- Missing comments for complex edge cases
- Keeping unnecessary info/debug logs that don't add value

### Phase 9: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Verify structure and navigability
- [ ] Confirm complete documentation (docstrings on helpers, class)
- [ ] Verify there are no linting errors (Ruff)
- [ ] Verify there are no type errors (mypy)
- [ ] Compare test count before and after (should be same or more if parameterized)
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

**Common Issues to Check:**

- Code review comment format incorrect
- Tests failing in final verification
- Missing documentation
- Linting errors present
- Type errors present
- Test count changed unexpectedly

---

## TEST FILE STRUCTURE

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

import datetime
from typing import TYPE_CHECKING

from enums.order_side import OrderSide
from enums.order_type import OrderType
from tests.integration.wrappers.binance import BinanceWrapper

if TYPE_CHECKING:
    from models.order import OrderModel


class TestGatewayHandler(BinanceWrapper):
    # ───────────────────────────────────────────────────────────
    # CONSTANTS
    # ───────────────────────────────────────────────────────────
    _SYMBOL: str = "BTCUSDT"
    _DEFAULT_VOLUME: float = 0.002
    _POLLING_TIMEOUT_SECONDS: int = 70

    # ───────────────────────────────────────────────────────────
    # PROPERTIES
    # ───────────────────────────────────────────────────────────
    _handler: GatewayHandler

    # ───────────────────────────────────────────────────────────
    # PUBLIC METHODS
    # ───────────────────────────────────────────────────────────
    def setUp(self) -> None:
        super().setUp()
        self._log.setup(name="test_gateway_handler")
        self._handler = GatewayHandler(
            gateway=self._gateway,
            backtest=False,
        )

    def test_action_expected_result(self) -> None:
        """Test description explaining what is being tested."""
        # Test implementation

    # ───────────────────────────────────────────────────────────
    # PRIVATE METHODS
    # ───────────────────────────────────────────────────────────
    def _helper_method(self, param: str) -> None:
        """Helper method description.

        Args:
            param: Parameter description

        Returns:
            Return value description
        """
        # Helper implementation
```

---

## LOGGING IN TESTS

### Rules for Logging in Test Methods

**DO NOT use logging for informational purposes:**

- INCORRECT: `self._log.info("Placing a market order")` - Test name already describes this
- INCORRECT: `self._log.info(f"Order placed successfully: {order.id}")` - Redundant with test name
- INCORRECT: `self._log.debug("Starting test execution")` - Not needed in tests

**ONLY use logging for error tracking:**

- CORRECT: `self._log.warning("Order price is 0, attempting to get from gateway")` - Useful for debugging edge cases
- CORRECT: `self._log.error("Failed to retrieve order from gateway")` - Critical error tracking
- CORRECT: `self._log.critical("Gateway connection lost during test")` - Critical failure tracking

### Examples

**Bad: Unnecessary info logs**

```python
def test_place_order_market(self) -> None:
    self._log.info("Placing a market BUY order for BTCUSDT")  # INCORRECT: Redundant
    order = self._place_test_order(...)
    self._log.info(f"Order placed successfully: {order.id}")  # INCORRECT: Redundant
    self._assert_order_is_valid(order=order, expected_type=OrderType.MARKET)
```

**Good: No logs needed**

```python
def test_place_order_market(self) -> None:
    """Test placing a market BUY order for BTCUSDT."""
    order = self._place_test_order(...)
    self._assert_order_is_valid(order=order, expected_type=OrderType.MARKET)
```

**Good: Logging for error tracking**

```python
def test_open_order_with_polling(self) -> None:
    """Test order opening with status polling."""
    order = self._build_order_model(...)
    result = self._handler.open_order(order)

    if order.price == 0:
        self._log.warning("Order price is 0, attempting to get from gateway")  # CORRECT: Useful
        gateway_order = self._gateway.get_order(...)
        if gateway_order and gateway_order.price > 0:
            self._log.info(f"Retrieved price from gateway: {gateway_order.price}")  # CORRECT: Useful
        else:
            self._log.warning("Gateway order also has price 0")  # CORRECT: Useful for debugging
```

### Rationale

- **Test names are self-documenting**: A well-named test like `test_place_order_market` already tells you what it does
- **Reduces noise**: Unnecessary logs clutter test output and make it harder to find real issues
- **Focus on failures**: Logs should only appear when something unexpected happens (errors, warnings)
- **Better debugging**: When a test fails, you want to see error/warning logs, not info about normal flow

---

## WHAT TO DO

### Helpers and Reusability

- Review existing helpers in wrapper classes before creating new ones
- Follow the same pattern of structure, parameters, and documentation of existing helpers
- Create reusable helpers in wrapper classes for common entities
- Use helpers instead of creating models manually
- Create payload helpers with default values
- Allow value override through `**kwargs` or optional parameters
- Add complete type hints to all helper methods

### Constants

- Define constants for repeated values with prefix **tied to the model** where they will be used
- The prefix must correspond to the model/resource (e.g., `_DEFAULT_ORDER_*` for Order, `_DEFAULT_USER_*` for User)
- Use class-level constants with underscore prefix
- Use constants in helpers and tests
- Group related constants with the same prefix (same model)

### Organization

- Group tests by functionality (Success, Validation, Update, Auth)
- Use section separators for easy navigation
- Maintain order: Code review comment → Imports → Constants → Properties → Setup → Tests → Helpers

### Parameterized Tests

- Use `@unittest.parameterized` decorator or `subTest()` context manager for tests with similar logic
- Unify duplicated tests into parameterized tests
- Document parameterized tests with docstrings

### Type Hints and Documentation

- Add type hints to all methods (parameters and return types)
- Use `TYPE_CHECKING` imports for forward references
- Add docstrings to helper methods and complex test methods
- Follow existing documentation patterns

### Comments

- Add comments only to explain complex context or edge cases
- Keep test names descriptive (they don't need comments)
- Document helpers with complete docstrings

### Logging

- **DO NOT** use logging statements (info, debug) in test methods
- **ONLY** use logging for error/warning/critical messages when necessary for debugging or tracking failures
- Test names should be descriptive enough that info logs are redundant
- Remove informational logs that just repeat what the test name already describes

---

## WHAT NOT TO DO

### Duplication

- DO NOT repeat model creation code
- DO NOT repeat complete payloads in each test
- DO NOT duplicate tests with similar logic

### Magic Values

- DO NOT use hardcoded strings repeatedly
- DO NOT use magic numbers without constants
- DO NOT create unique values manually (use helpers)

### Organization

- DO NOT mix tests from different functionalities without grouping
- DO NOT put helpers before tests
- DO NOT omit section separators

### Comments

- DO NOT add obvious comments that repeat the code
- DO NOT comment every line of code
- DO NOT use comments as an excuse for unclear names

### Logging

- DO NOT use `self._log.info()` or `self._log.debug()` in test methods
- DO NOT add informational logs that just describe what the test is doing
- DO NOT use logs as a substitute for descriptive test names
- ONLY use `self._log.error()`, `self._log.warning()`, or `self._log.critical()` when necessary for debugging failures

### Tests

- DO NOT create tests without type hints
- DO NOT omit docstrings in helpers
- DO NOT advance to next phase without verifying tests pass
- DO NOT ignore mypy type errors
- DO NOT use logging statements (info, debug) in test methods
- DO NOT add informational logs that just repeat what the test name already describes
- ONLY use logging for error/warning/critical messages when necessary for debugging or tracking failures

---

## NAMING RULES

### Tests

- Format: `test_{action}_{expected_result}_{condition}`
- Examples:
  - `test_open_order_creates_order_successfully`
  - `test_open_order_validates_duplicate_order_id`
  - `test_open_order_denies_unauthorized_access`

### Helpers

- **IMPORTANT**: Review existing helpers in wrapper classes and follow the same pattern
- Create models: `_create_test_{model}()`
- Create payloads: `_get_{action}_{resource}_payload()`
- Existing examples: `_open_test_order()`, `_close_order_by_id()`, `_create_test_order()`
- Maintain consistency with structure, parameters, and documentation of existing helpers
- Use underscore prefix for private helper methods

### Constants

- Prefix **tied to the model**: `_DEFAULT_{MODEL}_{PROPERTY}`
- The `{MODEL}` prefix must correspond to the model/resource where the constant will be used
- Use underscore prefix for class constants
- Examples:
  - `_DEFAULT_ORDER_SYMBOL` (for Order)
  - `_DEFAULT_ORDER_VOLUME` (for Order)
  - `_DEFAULT_USER_EMAIL` (for User)
  - `_DEFAULT_GATEWAY_NAME` (for Gateway)

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] File organized according to recommended structure
- [ ] Section separators present
- [ ] Tests grouped logically
- [ ] Helpers at the end of the file

### Helpers

- [ ] Helpers reviewed in wrapper classes to understand existing pattern
- [ ] Helpers created following the same pattern as existing ones
- [ ] Helpers created in wrapper classes for common entities
- [ ] Helpers documented with complete docstrings (following existing format)
- [ ] Helpers used instead of manual creation
- [ ] Helpers allow value override through `**kwargs` or optional parameters
- [ ] Helpers have complete type hints

### Constants

- [ ] Constants defined for repeated values
- [ ] Prefixes **tied to the model** where they will be used (e.g., `_DEFAULT_ORDER_*` for Order)
- [ ] Constants used in helpers and tests
- [ ] Descriptive and consistent prefixes according to the model
- [ ] Constants use underscore prefix

### Tests

- [ ] All test methods have type hints
- [ ] Parameterized tests use appropriate unittest mechanisms
- [ ] Descriptive test names
- [ ] No logic duplication

### Documentation

- [ ] Only comments that explain complex context
- [ ] Self-documenting test names
- [ ] Complete docstrings in helpers
- [ ] Type hints on all methods

### Logging

- [ ] No unnecessary logging statements (info, debug) in test methods
- [ ] Only error/warning/critical logs when necessary for debugging
- [ ] Test names are descriptive enough (no need for info logs)

### Verification

- [ ] All tests pass
- [ ] No linting errors (Ruff)
- [ ] No type errors (mypy)
- [ ] Complete documentation

---

## ERROR HANDLING AND EDGE CASES

### Common Errors and Solutions

**Error: "Tests fail after helper creation"**

- **Cause**: Helper logic differs from original manual creation
- **Solution**: Review helper implementation, ensure it matches original behavior exactly
- **Prevention**: Test helpers independently before using in tests

**Error: "Constants cause test failures"**

- **Cause**: Constant values don't match original hardcoded values
- **Solution**: Verify constant values match original values exactly
- **Prevention**: Use constants that match existing values, don't change values during refactoring

**Error: "Parameterized test doesn't cover all cases"**

- **Cause**: Parameterized test missing test cases from original tests
- **Solution**: Review original tests, ensure all cases included in parameterization
- **Prevention**: List all original test cases before creating parameterized version

**Error: "Tests fail after reorganization"**

- **Cause**: Accidentally modified test code during reorganization
- **Solution**: Use version control to compare before/after, restore original logic
- **Prevention**: Only move code, never modify during reorganization

**Error: "Type errors after adding type hints"**

- **Cause**: Incorrect type hints or missing imports
- **Solution**: Verify type hints are correct, use TYPE_CHECKING for forward references
- **Prevention**: Run mypy after adding type hints, fix errors immediately

**Error: "Linting errors after refactoring"**

- **Cause**: Code style violations, missing type hints, or syntax errors
- **Solution**: Run Ruff, fix all errors before proceeding
- **Prevention**: Run linting after each phase, not just at the end

### Edge Cases to Handle

- **No existing helpers**: If wrapper classes have no helpers, create first helpers following Python conventions
- **All tests already refactored**: Document that refactoring was already complete
- **Tests use deprecated patterns**: Update to modern patterns (type hints, docstrings)
- **Mixed test styles**: Standardize all tests to follow same pattern
- **Missing test file**: Verify file exists before starting
- **Baseline tests fail**: Must fix existing tests before refactoring

### Troubleshooting

**If tests fail at any phase:**

1. **STOP immediately** - do not continue to next phase
2. **Identify the failure** - which test(s) failed and why
3. **Compare with baseline** - what changed since last passing state
4. **Revert changes** if necessary - use version control to restore working state
5. **Report to user** - explain what failed and why
6. **Wait for guidance** - do not attempt fixes without user approval

**If linting errors appear:**

1. **STOP immediately** - do not continue to next phase
2. **Run linting tool** - identify all errors
3. **Fix errors** - address each error systematically
4. **Verify fixes** - run linting again to confirm
5. **Run tests** - ensure fixes didn't break tests
6. **Continue** - only proceed when linting passes

**If type errors appear:**

1. **STOP immediately** - do not continue to next phase
2. **Run mypy** - identify all type errors
3. **Fix errors** - add correct type hints or use TYPE_CHECKING
4. **Verify fixes** - run mypy again to confirm
5. **Run tests** - ensure fixes didn't break tests
6. **Continue** - only proceed when type checking passes

**If user requests changes:**

1. **STOP immediately** - pause current work
2. **Understand request** - clarify what user wants changed
3. **Assess impact** - determine what needs to be modified
4. **Present plan** - show what will change and why
5. **Wait for approval** - do not proceed without confirmation

---

## COMMON ERRORS TO AVOID

### Error 1: Breaking Existing Tests

**Problem**: Refactoring breaks existing functionality
**Prevention**:

- Run tests BEFORE starting each phase
- Run tests AFTER completing each phase
- If tests fail, STOP and fix before continuing
- Never skip test verification
- Never modify test logic, only structure

### Error 2: Not Following Existing Patterns

**Problem**: Creating helpers or constants that don't match existing codebase patterns
**Prevention**:

- Always review wrapper class helpers first
- Search for similar patterns in codebase
- Follow existing naming conventions
- Match existing structure and documentation style

### Error 3: Changing Test Logic

**Problem**: Accidentally modifying test assertions or logic during refactoring
**Prevention**:

- Only refactor structure, never logic
- Use version control to compare changes
- Verify test count remains same (unless parameterizing)
- Review changes carefully before committing

### Error 4: Skipping Validation Steps

**Problem**: Not verifying tests/linting between phases
**Prevention**:

- Always run tests after each phase
- Always verify linting after each phase
- Always verify type checking after each phase
- Never proceed if validation fails
- Document all verification steps

### Error 5: Not Searching for Existing Code

**Problem**: Creating helpers or constants that already exist
**Prevention**:

- Always search wrapper classes before creating helpers
- Check for existing constants before creating new ones
- Review similar test files for patterns
- Never assume code doesn't exist

---

## FINAL OBJECTIVE

A test file must be:

- **Organized**: Clear and navigable structure
- **Reusable**: Helpers and constants to avoid duplication
- **Maintainable**: Easy to understand and modify
- **Type-safe**: Complete type hints for all methods
- **Documented**: Complete docstrings where necessary
- **Clean**: No unnecessary comments or logging statements, self-documenting code
- **Focused**: Only error/warning/critical logs when necessary for debugging
