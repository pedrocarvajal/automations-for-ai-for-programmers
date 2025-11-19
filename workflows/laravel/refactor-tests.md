# Refactor Tests Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

**THEN, follow these specific rules for test refactoring:**

- **Verify tests** after each phase - run tests and confirm they pass
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing helpers in `Base.php`** and follow the same pattern (structure, parameters, documentation, naming conventions) when creating new helpers, constants, or any new element

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete test file
- [ ] Identify code smells (duplication, magic strings, long tests)
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks (e.g., "No helpers needed to create" if Phase 2 is skipped)

### Phase 2: Reusable Helpers

- [ ] **REVIEW existing helpers in `Base.php`** to understand the established pattern
- [ ] Create helpers in `Base.php` for common entities (create models, payloads)
- [ ] **FOLLOW the same pattern** of existing helpers (structure, parameters, documentation)
- [ ] Document helpers with complete PHPDoc (description, parameters, examples) following the existing format
- [ ] DO NOT use the helpers yet - only create them
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if this phase is skipped (e.g., "All necessary helpers already exist in Base.php")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Constants and Common Values

- [ ] Identify repeated values (strings, magic numbers)
- [ ] Create constants with prefix **tied to the model** where they will be used (e.g., `DEFAULT_ACCOUNT_*` for Account, `DEFAULT_USER_*` for User)
- [ ] Update helpers to use constants
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if no constants were needed (e.g., "No repeated values found, all values are unique or already use constants")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Refactor Tests Using Helpers

- [ ] Replace manual model creation with helpers
- [ ] Replace manual payloads with payload helpers
- [ ] Use constants instead of hardcoded values
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no refactoring was needed (e.g., "All tests already use helpers and constants")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Parameterized Tests

- [ ] Identify duplicated tests with similar logic
- [ ] Create data providers for repeated cases
- [ ] Unify duplicated tests using `#[DataProvider]` attribute
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no parameterization was needed (e.g., "No duplicated tests found, all tests are unique")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: File Organization

- [ ] Reorganize structure according to recommended order:
  1. Properties
  2. Setup/Teardown
  3. Data Providers
  4. Tests grouped by functionality
  5. Helper Methods
- [ ] Add section separators (`// ============================================`)
- [ ] Group tests logically (Success Cases, Validation, Update, Auth, etc.)
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if structure was already correct (e.g., "File structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: PHPUnit Groups

- [ ] Add `#[Group]` attributes to all tests according to their category
- [ ] Add required imports: `use PHPUnit\Framework\Attributes\Group;` and `use PHPUnit\Framework\Attributes\DataProvider;`
- [ ] Document available groups in class PHPDoc (without @group syntax)
- [ ] Verify groups work by running tests by group
- [ ] **EXPLAIN** if groups were already present (e.g., "All tests already have #[Group] attributes")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 8: Comment Cleanup

- [ ] Remove obvious comments that add no value
- [ ] Add comments only where they explain complex context or edge cases
- [ ] Verify test names are descriptive (no need for comments)
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no cleanup was needed (e.g., "No unnecessary comments found, all comments are meaningful")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 9: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Run tests by individual groups
- [ ] Verify structure and navigability
- [ ] Confirm complete documentation
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

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

## FINAL OBJECTIVE

A test file must be:

- **Organized**: Clear and navigable structure
- **Reusable**: Helpers and constants to avoid duplication
- **Maintainable**: Easy to understand and modify
- **Executable**: Grouped tests for selective execution
- **Documented**: Complete PHPDoc where necessary
- **Clean**: No unnecessary comments, self-documenting code
