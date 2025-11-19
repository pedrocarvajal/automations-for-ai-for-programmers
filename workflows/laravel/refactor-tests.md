# Refactor Tests Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Read task notes standard**: Read `standards/task-notes.md` for code review comment format.

2. **Understand the test file context**: Identify the test file to refactor, understand its purpose, and verify it exists and is readable.

**THEN, follow these specific rules for test refactoring:**

- **MUST** verify tests after each phase - run tests and confirm they pass
- **MUST** verify linting after each phase - ensure no errors (PHPStan, Psalm, Laravel Pint)
- **REQUIRED** to explain skipped tasks - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **MANDATORY** to review existing helpers in `Base.php` and follow the same pattern (structure, parameters, documentation, naming conventions) when creating new helpers, constants, or any new element
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
- **NEVER** create helpers without reviewing existing patterns in `Base.php`
- **NEVER** use magic values - always use constants
- **NEVER** duplicate test logic - use data providers instead
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
- [ ] Linting tools are configured (PHPStan, Psalm, Laravel Pint)
- [ ] `Base.php` file exists and is accessible
- [ ] Test file follows PHPUnit structure
- [ ] Test file has tests that can be refactored

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete test file
- [ ] **VERIFY**: Run existing tests to establish baseline (all tests MUST pass before starting)
- [ ] **SEARCH**: Review existing helpers in `Base.php` to understand patterns
- [ ] **SEARCH**: Check for similar test files to understand conventions
- [ ] Identify code smells (duplication, magic strings, long tests, missing groups)
- [ ] Identify repeated values that should become constants
- [ ] Identify duplicated tests that can be parameterized
- [ ] Identify missing PHPUnit groups
- [ ] Check test file structure and organization
- [ ] Document any breaking changes that might occur
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks (e.g., "No helpers needed to create" if Phase 2 is skipped)

**Common Issues to Check:**

- Test file not found or unreadable
- Baseline tests failing (must fix before refactoring)
- No existing helpers in `Base.php` to reference
- Missing context about test file purpose
- Unclear test structure or organization

### Phase 2: Reusable Helpers

- [ ] **REVIEW existing helpers in `Base.php`** to understand the established pattern
- [ ] **SEARCH**: Check if helpers already exist before creating new ones
- [ ] Create helpers in `Base.php` for common entities (create models, payloads)
- [ ] **FOLLOW the same pattern** of existing helpers (structure, parameters, documentation)
- [ ] Document helpers with complete PHPDoc (description, parameters, examples) following the existing format
- [ ] Ensure helpers allow value override through `$attributes` or `$overrides` parameters
- [ ] DO NOT use the helpers yet - only create them
- [ ] Run tests to verify no regressions (baseline should still pass)
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if this phase is skipped (e.g., "All necessary helpers already exist in Base.php")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Creating helpers that already exist
- Not following existing helper patterns
- Missing PHPDoc documentation
- Helpers don't allow value overrides
- Linting errors after creating helpers
- Tests failing after helper creation (should not happen if helpers aren't used yet)

### Phase 3: Constants and Common Values

- [ ] Identify repeated values (strings, magic numbers)
- [ ] **VERIFY**: Check if constants already exist before creating new ones
- [ ] Create constants with prefix **tied to the model** where they will be used (e.g., `DEFAULT_ACCOUNT_*` for Account, `DEFAULT_USER_*` for User)
- [ ] Place constants in appropriate location (class constants or `Base.php` constants)
- [ ] Update helpers to use constants
- [ ] Run tests to verify no regressions
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no constants were needed (e.g., "No repeated values found, all values are unique or already use constants")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Creating constants with wrong prefix (not tied to model)
- Constants already exist but not used
- Constants placed in wrong location
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
- [ ] Create data providers for repeated cases
- [ ] Document data providers with complete PHPDoc
- [ ] Unify duplicated tests using `#[DataProvider]` attribute
- [ ] **VERIFY**: Ensure all test cases are covered by data provider
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no parameterization was needed (e.g., "No duplicated tests found, all tests are unique")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Missing PHPDoc on data providers
- Data provider doesn't cover all original test cases
- Tests failing after parameterization
- Data provider format incorrect
- Missing `#[DataProvider]` attribute import

### Phase 6: File Organization

- [ ] Reorganize structure according to recommended order:
  1. Properties
  2. Setup/Teardown
  3. Data Providers
  4. Tests grouped by functionality
  5. Helper Methods
- [ ] Add section separators (`// ============================================`)
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

### Phase 7: PHPUnit Groups

- [ ] Add `#[Group]` attributes to all tests according to their category
- [ ] Add required imports: `use PHPUnit\Framework\Attributes\Group;` and `use PHPUnit\Framework\Attributes\DataProvider;`
- [ ] Document available groups in class PHPDoc (without @group syntax)
- [ ] **VERIFY**: Ensure no deprecated `@group` annotations remain
- [ ] Verify groups work by running tests by group (e.g., `phpunit --group account-create`)
- [ ] Run all tests and verify they pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if groups were already present (e.g., "All tests already have #[Group] attributes")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Missing `#[Group]` attribute on some tests
- Using deprecated `@group` annotation instead of `#[Group]`
- Missing required imports
- Groups not documented in class PHPDoc
- Tests failing when run by group
- Group names inconsistent or unclear

### Phase 8: Comment Cleanup

- [ ] Remove obvious comments that add no value
- [ ] Add comments only where they explain complex context or edge cases
- [ ] Verify test names are descriptive (no need for comments)
- [ ] **VERIFY**: Ensure no important context was removed with comments
- [ ] Run tests and verify all pass
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no cleanup was needed (e.g., "No unnecessary comments found, all comments are meaningful")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Removing comments that explain important context
- Test names not descriptive enough after comment removal
- Tests failing after comment cleanup (should not happen)
- Missing comments for complex edge cases

### Phase 9: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Run tests by individual groups to verify grouping works
- [ ] Verify structure and navigability
- [ ] Confirm complete documentation (PHPDoc on helpers, data providers, class)
- [ ] Verify there are no linting errors
- [ ] Compare test count before and after (should be same or more if parameterized)
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

**Common Issues to Check:**

- Code review comment format incorrect
- Tests failing in final verification
- Groups not working correctly
- Missing documentation
- Linting errors present
- Test count changed unexpectedly

---

## TEST FILE STRUCTURE

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

namespace Tests\Feature\Api\V2\{Resource};

use App\Enums\HttpStatus;
use App\Enums\Role;
use App\Models\{Model};
use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\Attributes\Group;
use Tests\Feature\Api\V2\Base;

/**
 * Test suite for {Controller} {endpoint}.
 *
 * PHPUnit Groups:
 * - {resource}-create: Tests for successful creation
 * - {resource}-validation: Tests for validation rules
 * - {resource}-update: Tests for updates
 * - {resource}-authentication: Tests for authentication
 * - {resource}-authorization: Tests for authorization
 */
class {Controller}Test extends Base
{
    // ============================================
    // PROPERTIES
    // ============================================

    private string $property;

    // ============================================
    // SETUP
    // ============================================

    protected function setUp(): void { }

    // ============================================
    // DATA PROVIDERS
    // ============================================

    public static function providerName(): array { }

    // ============================================
    // {ACTION} - {Category}
    // ============================================

    #[Group('{resource}-{category}')]
    public function test_action_expected_result() { }

    #[Group('{resource}-{category}')]
    #[Group('{resource}-authorization')]
    #[DataProvider('providerName')]
    public function test_parameterized_test($data) { }

    // ============================================
    // HELPER METHODS
    // ============================================

    private function helperMethod() { }
}
```

---

## WHAT TO DO

### Helpers and Reusability

- Review existing helpers in `Base.php` before creating new ones
- Follow the same pattern of structure, parameters, and documentation of existing helpers
- Create reusable helpers in `Base.php` for common entities
- Use helpers instead of creating models manually
- Create payload helpers with default values
- Allow value override through `$attributes` or `$overrides` parameters

### Constants

- Define constants for repeated values with prefix **tied to the model** where they will be used
- The prefix must correspond to the model/resource (e.g., `DEFAULT_ACCOUNT_*` for Account, `DEFAULT_USER_*` for User)
- Use constants in helpers and tests
- Group related constants with the same prefix (same model)

### Organization

- Group tests by functionality (Success, Validation, Update, Auth)
- Use section separators for easy navigation
- Maintain order: Properties → Setup → Data Providers → Tests → Helpers

### Parameterized Tests

- Use `#[DataProvider]` attribute for tests with similar logic
- Import required attribute: `use PHPUnit\Framework\Attributes\DataProvider;`
- Unify duplicated tests into parameterized tests
- Document data providers with PHPDoc

### PHPUnit Groups

- Add `#[Group]` attribute to all tests according to category
- Import required attribute: `use PHPUnit\Framework\Attributes\Group;`
- Document available groups in class PHPDoc (without @group syntax)
- Use descriptive names for groups (e.g., `resource-action`)
- Multiple groups can be added using multiple `#[Group]` attributes

### Comments

- Add comments only to explain complex context or edge cases
- Keep test names descriptive (they don't need comments)
- Document helpers with complete PHPDoc

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

### Tests

- DO NOT create tests without `#[Group]` attribute
- DO NOT use deprecated `@group` or `@dataProvider` annotations (use PHP 8 attributes instead)
- DO NOT omit PHPDoc in data providers
- DO NOT advance to next phase without verifying tests pass

---

## NAMING RULES

### Tests

- Format: `test_{action}_{expected_result}_{condition}`
- Examples:
  - `test_store_creates_account_successfully`
  - `test_store_validates_duplicate_account_number`
  - `test_store_denies_unauthorized_roles_on_create`

### Helpers

- **IMPORTANT**: Review existing helpers in `Base.php` and follow the same pattern
- Create models: `createTest{Model}()`
- Create payloads: `get{Action}{Resource}Payload()`
- Existing examples: `createTestBroker()`, `createTestBrokerServer()`, `getCreateAccountPayload()`, `getUpdateAccountPayload()`
- Maintain consistency with structure, parameters, and documentation of existing helpers

### Constants

- Prefix **tied to the model**: `DEFAULT_{MODEL}_{PROPERTY}`
- The `{MODEL}` prefix must correspond to the model/resource where the constant will be used
- Examples:
  - `DEFAULT_ACCOUNT_BROKER_NAME` (for Account)
  - `DEFAULT_ACCOUNT_PASSWORD` (for Account)
  - `DEFAULT_USER_EMAIL` (for User)
  - `DEFAULT_BROKER_NAME` (for Broker)

### PHPUnit Groups

- Format: `{resource}-{category}`
- Examples: `account-create`, `account-validation`, `account-update`

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] File organized according to recommended structure
- [ ] Section separators present
- [ ] Tests grouped logically
- [ ] Helpers at the end of the file

### Helpers

- [ ] Helpers reviewed in `Base.php` to understand existing pattern
- [ ] Helpers created following the same pattern as existing ones
- [ ] Helpers created in `Base.php` for common entities
- [ ] Helpers documented with complete PHPDoc (following existing format)
- [ ] Helpers used instead of manual creation
- [ ] Helpers allow value override through `$attributes` or `$overrides`

### Constants

- [ ] Constants defined for repeated values
- [ ] Prefixes **tied to the model** where they will be used (e.g., `DEFAULT_ACCOUNT_*` for Account)
- [ ] Constants used in helpers and tests
- [ ] Descriptive and consistent prefixes according to the model

### Tests

- [ ] All tests have `#[Group]` attribute
- [ ] Required imports added: `use PHPUnit\Framework\Attributes\Group;` and `use PHPUnit\Framework\Attributes\DataProvider;`
- [ ] Parameterized tests use `#[DataProvider]` attribute
- [ ] No deprecated `@group` or `@dataProvider` annotations used
- [ ] Descriptive test names
- [ ] No logic duplication

### Comments

- [ ] Only comments that explain complex context
- [ ] Self-documenting test names
- [ ] Complete PHPDoc in helpers and data providers

### Verification

- [ ] All tests pass
- [ ] Tests executable by groups
- [ ] No linting errors
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

- **Cause**: Data provider missing test cases from original tests
- **Solution**: Review original tests, ensure all cases included in data provider
- **Prevention**: List all original test cases before creating data provider

**Error: "Tests fail after reorganization"**

- **Cause**: Accidentally modified test code during reorganization
- **Solution**: Use version control to compare before/after, restore original logic
- **Prevention**: Only move code, never modify during reorganization

**Error: "PHPUnit groups not working"**

- **Cause**: Missing imports or incorrect attribute syntax
- **Solution**: Verify imports are correct, use `#[Group]` not `@group`
- **Prevention**: Check existing test files for correct group syntax

**Error: "Linting errors after refactoring"**

- **Cause**: Type hints missing, syntax errors, or code style violations
- **Solution**: Run linting tool, fix all errors before proceeding
- **Prevention**: Run linting after each phase, not just at the end

### Edge Cases to Handle

- **No existing helpers**: If `Base.php` has no helpers, create first helpers following Laravel conventions
- **All tests already refactored**: Document that refactoring was already complete
- **Tests use deprecated patterns**: Update to modern patterns (attributes vs annotations)
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
- Always review `Base.php` helpers first
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
- Never proceed if validation fails
- Document all verification steps

### Error 5: Not Searching for Existing Code
**Problem**: Creating helpers or constants that already exist
**Prevention**:
- Always search `Base.php` before creating helpers
- Check for existing constants before creating new ones
- Review similar test files for patterns
- Never assume code doesn't exist

---

## FINAL OBJECTIVE

A test file must be:

- **Organized**: Clear and navigable structure
- **Reusable**: Helpers and constants to avoid duplication
- **Maintainable**: Easy to understand and modify
- **Executable**: Grouped tests for selective execution
- **Documented**: Complete PHPDoc where necessary
- **Clean**: No unnecessary comments, self-documenting code
