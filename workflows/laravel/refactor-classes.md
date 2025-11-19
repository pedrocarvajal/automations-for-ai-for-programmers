# Refactor Classes Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Read task notes standard**: Read `standards/task-notes.md` for code review comment format.

2. **Search for class usage**: Search the codebase to find where the class is used. This provides crucial context about:
   - How the class is imported and instantiated
   - What methods are commonly called
   - Common patterns and usage scenarios
   - Integration points with other parts of the system
   - Edge cases and error handling needs
   - This context is essential for making informed refactoring decisions

**THEN, follow these specific rules for class refactoring:**

- **MUST** run tests after each phase - verify all tests pass
- **MUST** verify linting after each phase - ensure no errors
- **REQUIRED** to explain skipped tasks - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **MANDATORY** to review existing similar classes in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## CRITICAL RULES (NEVER VIOLATE)

- **NEVER** modify public method signatures without searching for all usages first
- **NEVER** remove a method without checking if it's used elsewhere
- **NEVER** change return types without updating all callers
- **NEVER** skip running tests between phases
- **NEVER** proceed to next phase if current phase has failing tests
- **NEVER** make changes silently - always explain what was changed and why
- **NEVER** ignore linting errors - fix them immediately
- **NEVER** skip user confirmations - always wait for explicit approval
- **ALWAYS** search codebase before making structural changes
- **ALWAYS** verify tests pass after each phase
- **ALWAYS** verify linting passes before proceeding
- **ALWAYS** explain skipped tasks with clear reasoning

---

## PRE-REQUISITES CHECKLIST

Before starting refactoring, verify:

- [ ] Class file exists and is readable
- [ ] Tests exist for this class (or note if they don't)
- [ ] Linting is configured and working (`phpstan`, `phpcs`, or project-specific linter)
- [ ] Git repository is in clean state (or note uncommitted changes)
- [ ] User has approved starting the refactoring
- [ ] All dependencies are installed (`composer install`)
- [ ] Database is set up (if class uses database)
- [ ] Codebase has been searched for class usage
- [ ] Similar classes have been reviewed for patterns

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete class file
- [ ] **VERIFY**: File exists and is readable
- [ ] **VERIFY**: Class is not in use in production without tests (check if tests exist)
- [ ] Search codebase for all usages of this class (imports, instantiations, method calls)
- [ ] Identify code smells (long methods, duplication, primitive obsession, feature envy)
- [ ] Identify responsibilities (SRP violations)
- [ ] Review similar classes in codebase for consistency patterns
- [ ] **VALIDATE**: Plan includes all identified issues
- [ ] **VALIDATE**: Plan considers all usages found in codebase search
- [ ] Present the plan to the user for approval
- [ ] **STOP AND WAIT** - Present summary of analysis findings
- [ ] **VERIFY** - Confirm all usages have been identified
- [ ] **EXPLAIN** - Describe what code smells were found and proposed solutions
- [ ] **ASK** - "Proceed with refactoring plan?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly says "yes" or "proceed"
- [ ] **EXPLAIN** any skipped tasks (e.g., "No services needed to extract" if Phase 2 is skipped)

### Phase 2: Extract Services (if needed)

- [ ] **REVIEW existing services** to understand the established pattern
- [ ] **VERIFY**: Services directory exists and follows project structure
- [ ] Identify business logic that should be in services
- [ ] Create service classes following existing patterns
- [ ] Document services with complete PHPDoc
- [ ] **CRITICAL**: DO NOT modify controller yet - only create services
- [ ] Run tests to verify new services work independently
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of services created
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what services were created and why
- [ ] **EXPLAIN** if this phase is skipped (e.g., "No business logic needs extraction, all logic is already in services")
- [ ] **ASK** - "Proceed to Phase 3?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 3: Dependency Injection

- [ ] Identify dependencies that should be injected
- [ ] **VERIFY**: All dependencies exist and are accessible
- [ ] Use constructor injection with property promotion (`private readonly`)
- [ ] Remove direct instantiation of dependencies
- [ ] **VERIFY**: Laravel service container can resolve all dependencies
- [ ] Run tests to verify dependency injection works correctly
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of dependency injection changes
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what dependencies were injected and why
- [ ] **EXPLAIN** if any dependency injection tasks were skipped (e.g., "No dependencies needed injection, class has no dependencies")
- [ ] **ASK** - "Proceed to Phase 4?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 4: Class Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Class-level PHPDoc
  2. Constructor
  3. Public methods
  4. Protected methods
  5. Private methods
- [ ] Add section separators (`// ============================================`)
- [ ] Group methods logically by functionality
- [ ] **VERIFY**: All methods are in correct sections
- [ ] **VERIFY**: Section separators are consistent with codebase style
- [ ] Run tests to verify reorganization didn't break anything
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of structure changes
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe how structure was reorganized
- [ ] **EXPLAIN** if structure was already correct (e.g., "Class structure was already organized correctly, no changes needed")
- [ ] **ASK** - "Proceed to Phase 5?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 5: Method Refactoring

- [ ] Extract long methods into smaller, focused methods
- [ ] Remove code duplication
- [ ] Apply Single Responsibility Principle
- [ ] Use descriptive method names
- [ ] **VERIFY**: All extracted methods follow naming conventions
- [ ] **VERIFY**: No methods exceed 50 lines
- [ ] **VERIFY**: Code duplication has been eliminated
- [ ] Run tests and verify all pass
- [ ] **STOP AND WAIT** - Present summary of method refactoring
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what methods were extracted and why
- [ ] **EXPLAIN** if no refactoring was needed (e.g., "All methods are already small and focused, no extraction needed")
- [ ] **ASK** - "Proceed to Phase 6?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 6: Documentation (PHPDoc)

- [ ] Add class-level PHPDoc explaining purpose
- [ ] Add PHPDoc to all public methods
- [ ] Add PHPDoc to protected methods
- [ ] Add PHPDoc to complex private methods
- [ ] Include `@param`, `@return`, `@throws`, `@example` where appropriate
- [ ] **VERIFY**: All PHPDoc follows project style (check similar classes)
- [ ] **VERIFY**: All parameters are documented
- [ ] **VERIFY**: All return types are documented
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of documentation added
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what documentation was added
- [ ] **EXPLAIN** if documentation was already complete (e.g., "All methods already have complete PHPDoc")
- [ ] **ASK** - "Proceed to Phase 7?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 7: Swagger Documentation (Laravel projects with l5-swagger plugin only)

**NOTE**: This phase only applies if:

- The project is using Laravel framework
- The `darkaonline/l5-swagger` package is installed and configured
- The class is a Controller with public endpoints

- [ ] **VERIFY**: l5-swagger plugin is installed (`composer show darkaonline/l5-swagger`)
- [ ] **VERIFY**: This is a Controller class (skip if not)
- [ ] Add `@OA\*` annotations for all public endpoints
- [ ] Use standard response references (`ref="#/components/responses/..."`)
- [ ] Document request bodies with all fields
- [ ] Document all possible response codes
- [ ] **VERIFY**: Swagger annotations follow project patterns (check other controllers)
- [ ] Regenerate Swagger docs and verify (`php artisan l5-swagger:generate`)
- [ ] **VERIFY**: Swagger generation succeeds without errors
- [ ] **STOP AND WAIT** - Present summary of Swagger documentation added
- [ ] **VERIFY** - Confirm Swagger docs generate successfully
- [ ] **EXPLAIN** - Describe what Swagger documentation was added
- [ ] **EXPLAIN** if this phase is skipped (e.g., "This is not a Laravel project with l5-swagger, Swagger documentation not applicable" or "This is not a controller, Swagger documentation not applicable")
- [ ] **EXPLAIN** if Swagger was already complete (e.g., "All endpoints already have complete Swagger documentation")
- [ ] **ASK** - "Proceed to Phase 8?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 8: Laravel Policies and Authorization (Controllers only)

- [ ] **VERIFY**: This is a Controller class (skip if not)
- [ ] **REVIEW existing policies** to understand the established pattern
- [ ] Identify which roles can access each endpoint/method
- [ ] For each public method, ask: "Which roles should have access to this endpoint?"
- [ ] Verify if a Policy class exists for the resource model
- [ ] Create or update Policy class following existing patterns (e.g., `AccountPolicy`, `UserPolicy`)
- [ ] Add authorization checks in controller methods using `$this->authorize()` or `authorize()`
- [ ] Use standard Policy methods: `viewAny`, `view`, `create`, `update`, `delete`
- [ ] Use role checks from User model methods: `isSuperAdmin()`, `isAdmin()`, `isLeader()`, `isSupervisor()`, `isPlatform()`
- [ ] Register Policy in `AuthServiceProvider` if new Policy was created
- [ ] **VERIFY**: Policy is properly registered in `AuthServiceProvider`
- [ ] **VERIFY**: Authorization checks are in place for all public methods
- [ ] Run tests to verify authorization works correctly (test with different roles)
- [ ] Document authorized roles in PHPDoc comments for each method
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of authorization changes
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what authorization was added and which roles have access
- [ ] **EXPLAIN** if this phase is skipped (e.g., "This is not a controller, authorization policies not applicable")
- [ ] **EXPLAIN** if authorization was already complete (e.g., "All endpoints already have proper authorization checks")
- [ ] **ASK** - "Proceed to Phase 9?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 9: Type Hints and Return Types

- [ ] Add type hints to all method parameters
- [ ] Add return types to all methods
- [ ] Use strict types (`declare(strict_types=1)` if applicable)
- [ ] **VERIFY**: All parameters have type hints
- [ ] **VERIFY**: All methods have return types
- [ ] **VERIFY**: Nullable types (`?Type`) used where appropriate
- [ ] **VERIFY**: Union types (`string|int`) used where needed
- [ ] Run tests to verify type changes don't break anything
- [ ] Verify there are no linting errors
- [ ] **STOP AND WAIT** - Present summary of type hints added
- [ ] **VERIFY** - Confirm all tests pass
- [ ] **VERIFY** - Confirm no linting errors
- [ ] **EXPLAIN** - Describe what type hints were added
- [ ] **EXPLAIN** if types were already complete (e.g., "All methods already have complete type hints and return types")
- [ ] **ASK** - "Proceed to Phase 10?" and wait for explicit user approval
- [ ] **DO NOT CONTINUE** until user explicitly approves

### Phase 10: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] **VERIFY**: Code review comment format is correct (YYYY-MM-DD, git user name)
- [ ] Run all tests and verify they pass
- [ ] **VERIFY**: No tests are failing
- [ ] Verify no linting errors
- [ ] **VERIFY**: All linting checks pass
- [ ] Verify Swagger documentation generates correctly (Laravel projects with l5-swagger plugin only)
- [ ] **VERIFY**: Swagger docs generate without errors (if applicable)
- [ ] Review code structure and navigability
- [ ] **VERIFY**: Structure matches recommended pattern
- [ ] Confirm complete documentation
- [ ] **VERIFY**: All public methods have PHPDoc
- [ ] **VERIFY**: All phases were completed or properly skipped
- [ ] **STOP AND WAIT** - Present final summary of all changes
- [ ] **EXPLAIN** - Describe all changes made across all phases
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **ASK** - "Refactoring complete. Review and approve?" and wait for explicit user approval
- [ ] **DO NOT CONSIDER TASK COMPLETE** until user explicitly approves

---

## CLASS FILE STRUCTURE

### Controllers

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

namespace App\Http\Controllers\Api\V2;

use App\Enums\HttpStatus;
use App\Http\Requests\Api\V2\{Resource}\{Action}Request;
use App\Models\{Model};
use App\Services\{Service};
use Illuminate\Http\JsonResponse;
use OpenApi\Annotations as OA;

/**
 * Controller for managing {resource} operations.
 *
 * Handles {brief description of responsibilities}.
 */
class {Resource}Controller extends BaseController
{
    // ============================================
    // CONSTRUCTOR
    // ============================================

    public function __construct(
        private readonly {Service} $service
    ) {}

    // ============================================
    // PUBLIC METHODS
    // ============================================

    /**
     * @OA\{Method}(
     *     path="/api/v2/{resource}",
     *     summary="{Brief description}",
     *     description="{Detailed description}",
     *     operationId="{operationId}",
     *     tags={"Resources"},
     *     security={{"bearerAuth": {}}},
     *     ...
     * )
     *
     * {Method description}.
     *
     * @param  {Request}  $request  Validated request data
     * @return JsonResponse
     */
    public function {action}({Request} $request): JsonResponse
    {
        // Implementation
    }

    // ============================================
    // PRIVATE METHODS
    // ============================================

    /**
     * {Method description}.
     *
     * @param  {Type}  $param  Parameter description
     * @return {Type} Return description
     */
    private function {helperMethod}({Type} $param): {Type}
    {
        // Implementation
    }
}
```

### Services

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

namespace App\Services;

use App\Models\{Model};

/**
 * Service for handling {domain} operations.
 *
 * {Brief description of service responsibilities}.
 */
class {Domain}Service
{
    // ============================================
    // PUBLIC METHODS
    // ============================================

    /**
     * {Method description}.
     *
     * @param  {Type}  $param  Parameter description
     * @return {Type} Return description
     *
     * @example
     * $service = new {Domain}Service();
     * $result = $service->{method}($param);
     * // Returns: {example result}
     */
    public function {method}({Type} $param): {Type}
    {
        // Implementation
    }

    // ============================================
    // PRIVATE METHODS
    // ============================================

    /**
     * {Method description}.
     *
     * @param  {Type}  $param  Parameter description
     * @return {Type} Return description
     */
    private function {helperMethod}({Type} $param): {Type}
    {
        // Implementation
    }
}
```

---

## EDGE CASES AND SPECIAL SITUATIONS

### If class has no dependencies:

- **SKIP** Phase 3 (Dependency Injection)
- **EXPLAIN**: "Class has no dependencies, Phase 3 skipped"
- **VERIFY**: No dependencies are needed before skipping

### If class is already well-structured:

- **VERIFY** structure matches recommended pattern
- **EXPLAIN**: "Class structure already follows best practices, no reorganization needed"
- **STILL** verify documentation, type hints, and tests
- **STILL** complete other phases (documentation, type hints, etc.)

### If class is used in multiple places:

- **SEARCH** all usages before making changes
- **VERIFY** changes won't break existing code
- **CONSIDER** backward compatibility
- **TEST** all integration points
- **EXPLAIN** impact of changes on other parts of codebase

### If class has no tests:

- **NOTE** this in Phase 1 analysis
- **ASK** user if tests should be created
- **DO NOT** create tests unless explicitly asked (this is refactoring, not test creation)
- **EXPLAIN** that refactoring without tests is risky

### If Swagger is not installed:

- **SKIP** Phase 7 (Swagger Documentation)
- **VERIFY** l5-swagger is not installed before skipping
- **EXPLAIN**: "l5-swagger package not installed, Swagger documentation phase skipped"

### If class is not a Controller:

- **SKIP** Phase 7 (Swagger Documentation) - only for controllers
- **SKIP** Phase 8 (Authorization) - only for controllers
- **EXPLAIN** why phases were skipped
- **FOCUS** on other phases (structure, documentation, type hints, etc.)

### If tests fail during refactoring:

- **STOP** immediately - do not proceed to next phase
- **IDENTIFY** the failing test - read error message carefully
- **CHECK** if change broke existing functionality - review diff
- **REVERT** if necessary - if change was incorrect, revert and replan
- **EXPLAIN** to user what failed and why
- **WAIT** for user confirmation before attempting fix

---

## TROUBLESHOOTING

### If tests fail after a phase:

1. **STOP immediately** - Do not proceed to next phase
2. **Identify the failing test** - Read error message carefully
3. **Check if change broke existing functionality** - Review diff
4. **Revert if necessary** - If change was incorrect, revert and replan
5. **Explain to user** - Report what failed and why
6. **WAIT FOR USER CONFIRMATION** - Before attempting fix

### If linting errors appear:

1. **Fix immediately** - Do not ignore linting errors
2. **Check if error is pre-existing** - If yes, note it but don't fix unless asked
3. **Verify fix doesn't break tests** - Run tests after fixing
4. **Explain the fix** - Tell user what was fixed and why
5. **VERIFY** - Confirm linting passes before proceeding

### If Swagger generation fails:

1. **CHECK** l5-swagger package is installed correctly
2. **VERIFY** Swagger annotations syntax is correct
3. **CHECK** for missing response references
4. **REVIEW** other controllers for correct patterns
5. **EXPLAIN** error to user and ask for guidance

### If Policy registration fails:

1. **VERIFY** Policy class exists and follows naming convention
2. **CHECK** `AuthServiceProvider` registration format
3. **VERIFY** model class name matches Policy naming convention
4. **TEST** authorization manually if needed
5. **EXPLAIN** issue to user

### If dependency injection fails:

1. **VERIFY** all dependencies exist and are accessible
2. **CHECK** Laravel service container can resolve dependencies
3. **VERIFY** constructor parameter types are correct
4. **CHECK** if dependencies need to be bound in service provider
5. **EXPLAIN** issue to user

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Long Method

**Problem**: Methods with too many lines (>30-50 lines)
**Solution**: Extract methods, apply Single Responsibility Principle

### 2. Long Class

**Problem**: Classes with too many responsibilities
**Solution**: Split into multiple classes, extract services

### 3. Code Duplication

**Problem**: Same code repeated in multiple places
**Solution**: Extract to private methods or services

### 4. Primitive Obsession

**Problem**: Using primitives instead of value objects/enums
**Solution**: Create enums or value objects (e.g., `SubscriptionStatus` enum instead of `0/1`)

### 5. Feature Envy

**Problem**: Method accesses data from another object more than its own
**Solution**: Move method to the object it's accessing

### 6. Data Clumps

**Problem**: Groups of data passed together repeatedly
**Solution**: Create DTOs or value objects

### 7. Large Class

**Problem**: Class has too many methods/properties
**Solution**: Split responsibilities, extract services

### 8. God Object

**Problem**: Class knows/does too much
**Solution**: Break down into smaller, focused classes

### 9. Inappropriate Intimacy

**Problem**: Classes access private members of other classes
**Solution**: Use proper encapsulation, add public methods

### 10. Comments as Excuse

**Problem**: Comments explaining what code does (code should be self-documenting)
**Solution**: Refactor code to be clearer, remove unnecessary comments

---

## WHAT TO DO

### Structure and Organization

- Use section separators (`// ============================================`) for clear navigation
- Organize methods: Constructor → Public → Protected → Private
- Group related methods together
- Keep methods focused on single responsibility
- Use descriptive method and variable names

### Dependency Injection

- Use constructor injection with property promotion
- Mark injected dependencies as `private readonly`
- Inject services, repositories, and other dependencies
- Avoid direct instantiation (`new Class()`)
- Use Laravel's service container

### Documentation

- Add class-level PHPDoc explaining purpose and responsibilities
- Document all public methods with complete PHPDoc
- Include `@param`, `@return`, `@throws` where applicable
- Add `@example` for complex methods
- Use descriptive descriptions, not just type information

### Swagger Documentation (Laravel projects with l5-swagger plugin only)

**NOTE**: Only applies if the project uses Laravel and has `darkaonline/l5-swagger` package installed.

- Document all public endpoints with `@OA\*` annotations
- Use standard response references: `ref="#/components/responses/..."`
- Document request bodies with all fields and validation rules
- Document all possible response codes (200, 201, 401, 403, 422, 500)
- Include examples in request/response documentation
- Regenerate docs after changes: `php artisan l5-swagger:generate`

### Type Safety

- Add type hints to all method parameters
- Add return types to all methods
- Use nullable types (`?Type`) when appropriate
- Use union types when needed (`string|int`)
- Avoid `mixed` type when possible

### Method Design

- Keep methods small and focused (< 30 lines ideally)
- Use descriptive names that explain what the method does
- Extract complex logic into private methods
- Avoid deep nesting (> 3 levels)
- Use early returns to reduce nesting

### Error Handling

- Use appropriate exceptions
- Document exceptions with `@throws`
- Don't catch exceptions unless you can handle them
- Let exceptions bubble up when appropriate
- Use custom exceptions for domain-specific errors

---

## WHAT NOT TO DO

### Structure

- DO NOT mix public and private methods randomly
- DO NOT put helpers before public methods
- DO NOT omit section separators
- DO NOT create god classes with too many responsibilities

### Dependency Injection

- DO NOT use service locator pattern (`app()->make()`)
- DO NOT instantiate dependencies directly (`new Service()`)
- DO NOT use static methods for dependencies
- DO NOT inject facades when you can inject the underlying class

### Documentation

- DO NOT add obvious comments that repeat the code
- DO NOT comment every line of code
- DO NOT use comments as an excuse for unclear names
- DO NOT omit PHPDoc on public methods
- DO NOT duplicate Swagger documentation (Laravel projects with l5-swagger plugin only)

### Code Quality

- DO NOT create methods longer than 50 lines
- DO NOT duplicate code - extract to methods/services
- DO NOT use magic numbers - use constants or enums
- DO NOT use magic strings - use constants or enums
- DO NOT mix business logic with HTTP concerns in controllers

### Type Safety

- DO NOT omit type hints on parameters
- DO NOT omit return types
- DO NOT use `mixed` when a specific type is known
- DO NOT use `array` without specifying structure when possible

---

## NAMING RULES

### Classes

- **Controllers**: `{Resource}Controller` (e.g., `AccountController`)
- **Services**: `{Domain}Service` (e.g., `AccountSubscriptionService`)
- **Requests**: `{Action}{Resource}Request` (e.g., `StoreAccountRequest`)
- Use PascalCase

### Methods

- **Controllers**: Use action verbs (`store`, `update`, `destroy`, `index`)
- **Services**: Use descriptive verbs (`handleSubscriptionChanges`, `validateBroker`)
- Use camelCase
- Be descriptive: `updateAccountFields()` not `updateFields()`

### Variables

- Use camelCase
- Be descriptive: `$oldSubscription` not `$old`
- Use plural for collections: `$accounts` not `$accountList`

### Constants

- Use UPPER_SNAKE_CASE
- Prefix tied to domain: `DEFAULT_ACCOUNT_*`, `MAX_SUBSCRIPTION_*`

---

## LARAVEL POLICIES AND AUTHORIZATION PATTERNS

### Good: Using authorize() in Controller

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    $this->authorize('create', Account::class);

    // Implementation
}
```

### Good: Using authorize() with Model Instance

```php
public function update(UpdateAccountRequest $request, Account $account): JsonResponse
{
    $this->authorize('update', $account);

    // Implementation
}
```

### Good: Policy with Role Checks

```php
class AccountPolicy
{
    public function create(User $user): bool
    {
        return $user->isSuperAdmin() || $user->isAdmin() || $user->isPlatform();
    }

    public function update(User $user, Account $account): bool
    {
        return $user->isSuperAdmin() || $user->isAdmin() || $user->isPlatform();
    }

    public function viewAny(User $user): bool
    {
        return $user->isSuperAdmin()
            || $user->isAdmin()
            || $user->isPlatform()
            || $user->isLeader()
            || $user->isSupervisor();
    }
}
```

### Good: Policy with before() Hook

```php
class UserPolicy
{
    public function before(User $user, string $ability)
    {
        // Leaders don't have access to Users
        if ($user->isLeader()) {
            return false;
        }
    }
}
```

### Bad: Missing Authorization

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    // SECURITY RISK: No authorization check allows unauthorized access
    // This violates Laravel security best practices
    $account = Account::create($request->validated());
    return response()->json($account, 201);
}
```

**Why this is bad:**

- Any authenticated user can create accounts
- No role-based access control
- Violates principle of least privilege
- Security vulnerability that could lead to unauthorized data access

### Bad: Manual Role Checks in Controller

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    // ANTI-PATTERN: Manual role checks in controller
    // Should use Laravel Policies instead
    if (!$user->isSuperAdmin() && !$user->isAdmin()) {
        abort(403);
    }
    // Implementation
}
```

**Why this is bad:**

- Duplicates authorization logic across controllers
- Harder to maintain and test
- Violates DRY principle
- Should use centralized Policy classes instead

### Bad: Policy Not Registered

```php
// Policy exists but not registered in AuthServiceProvider
// Will not work automatically - Laravel won't find the Policy
```

**Why this is bad:**

- Policy class exists but Laravel can't find it
- Authorization checks will fail silently
- Must register in `AuthServiceProvider::$policies` array
- Missing registration breaks authorization system

---

## DEPENDENCY INJECTION PATTERNS

### Good: Constructor Injection with Property Promotion

```php
public function __construct(
    private readonly AccountSubscriptionService $subscriptionService
) {}
```

### Good: Multiple Dependencies

```php
public function __construct(
    private readonly AccountService $accountService,
    private readonly SubscriptionService $subscriptionService,
    private readonly EmailService $emailService
) {}
```

### Bad: Service Locator

```php
public function store(Request $request)
{
    // ANTI-PATTERN: Service locator pattern
    // Hides dependencies and makes testing difficult
    $service = app()->make(AccountService::class);
}
```

**Why this is bad:**

- Hides dependencies - not clear what class depends on
- Makes unit testing difficult (can't easily mock)
- Violates dependency inversion principle
- Harder to understand class dependencies

### Bad: Direct Instantiation

```php
public function store(Request $request)
{
    // ANTI-PATTERN: Direct instantiation
    // Creates tight coupling and prevents dependency injection
    $service = new AccountService();
}
```

**Why this is bad:**

- Creates tight coupling between classes
- Prevents dependency injection
- Makes testing difficult (can't inject mocks)
- Violates dependency inversion principle
- Service can't be swapped or mocked

### Bad: Static Methods

```php
public function store(Request $request)
{
    // ANTI-PATTERN: Static method calls
    // Prevents dependency injection and makes testing difficult
    AccountService::handle($request);
}
```

**Why this is bad:**

- Can't inject dependencies into static methods
- Makes unit testing nearly impossible
- Creates hidden dependencies
- Violates dependency inversion principle
- Can't be mocked in tests

---

## SWAGGER DOCUMENTATION PATTERNS

**NOTE**: These patterns only apply to Laravel projects with `darkaonline/l5-swagger` package installed.

### Good: Using Standard Responses

```php
/**
 * @OA\Post(
 *     path="/api/v2/account",
 *     ...
 *     @OA\Response(response=401, ref="#/components/responses/Unauthorized"),
 *     @OA\Response(response=403, ref="#/components/responses/Forbidden"),
 *     @OA\Response(response=422, ref="#/components/responses/ValidationError"),
 *     @OA\Response(response=500, ref="#/components/responses/ServerError")
 * )
 */
```

### Good: Custom Response with Data

```php
/**
 * @OA\Post(
 *     ...
 *     @OA\Response(
 *         response=201,
 *         description="Account created successfully",
 *         ref="#/components/responses/Created",
 *         @OA\JsonContent(
 *             type="object",
 *             @OA\Property(property="success", type="boolean", example=true),
 *             @OA\Property(
 *                 property="data",
 *                 type="object",
 *                 @OA\Property(property="id", type="integer", example=123)
 *             )
 *         )
 *     )
 * )
 */
```

### Bad: Duplicated Responses

```php
/**
 * @OA\Post(
 *     ...
 *     @OA\Response(
 *         response=401,
 *         description="Unauthorized",
 *         @OA\JsonContent(
 *             @OA\Property(property="success", type="boolean", example=false),
 *             @OA\Property(property="message", type="string", example="Unauthenticated")
 *         )
 *     ),
 *     // ANTI-PATTERN: Duplicated response definitions
 *     // Should use ref="#/components/responses/Unauthorized" instead
 *     // ... repeated in every endpoint
 * )
 */
```

**Why this is bad:**

- Duplicates response definitions across endpoints
- Violates DRY principle
- Harder to maintain (changes require updates in multiple places)
- Should use standard response references instead
- Increases documentation size unnecessarily

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Class organized according to recommended structure
- [ ] Section separators present (`// ============================================`)
- [ ] Methods grouped logically (Public → Protected → Private)
- [ ] No god classes (too many responsibilities)

### Dependency Injection

- [ ] Dependencies injected via constructor
- [ ] Using property promotion (`private readonly`)
- [ ] No direct instantiation (`new Class()`)
- [ ] No service locator pattern

### Documentation

- [ ] Class-level PHPDoc present
- [ ] All public methods have PHPDoc
- [ ] Protected methods have PHPDoc
- [ ] Complex private methods have PHPDoc
- [ ] PHPDoc includes `@param`, `@return`, `@throws` where applicable

### Swagger (Laravel projects with l5-swagger plugin only)

**NOTE**: Only applies if the project uses Laravel and has `darkaonline/l5-swagger` package installed.

- [ ] Verify l5-swagger plugin is installed
- [ ] All endpoints documented with `@OA\*` annotations
- [ ] Using standard response references
- [ ] Request bodies documented with all fields
- [ ] All response codes documented
- [ ] Swagger docs regenerate successfully (`php artisan l5-swagger:generate`)

### Authorization (Controllers)

- [ ] Policy class exists for the resource model
- [ ] All endpoints have authorization checks (`$this->authorize()`)
- [ ] Policy methods follow standard Laravel naming (viewAny, view, create, update, delete)
- [ ] Role checks use User model methods (isSuperAdmin, isAdmin, etc.)
- [ ] Policy registered in AuthServiceProvider
- [ ] Authorized roles documented in PHPDoc

### Code Quality

- [ ] No methods longer than 50 lines
- [ ] No code duplication
- [ ] Single Responsibility Principle applied
- [ ] No magic numbers or strings
- [ ] Descriptive method and variable names

### Type Safety

- [ ] All parameters have type hints
- [ ] All methods have return types
- [ ] No unnecessary `mixed` types
- [ ] Nullable types used appropriately

### Testing

- [ ] All tests pass
- [ ] No linting errors
- [ ] Code is maintainable and readable

---

## FINAL OBJECTIVE

A class file must be:

- **Organized**: Clear structure with section separators
- **Focused**: Single Responsibility Principle applied
- **Documented**: Complete PHPDoc and Swagger docs (Laravel projects with l5-swagger plugin only)
- **Authorized**: Proper Laravel Policy checks for all endpoints (controllers)
- **Injected**: Dependencies injected via constructor
- **Type-safe**: All type hints and return types present
- **Maintainable**: Easy to understand and modify
- **Testable**: Logic extracted to services when needed
- **Clean**: No code smells, no duplication, self-documenting code
- **Verified**: All tests pass, no linting errors, all phases completed

---

## REFERENCE DOCUMENTS

When executing this workflow, refer to:

- **`standards/task-execution.md`** - General execution process (task breakdown, planning, confirmations)
- **`standards/task-notes.md`** - Code review comment format
- **`workflows/laravel/refactor-tests.md`** - For test refactoring patterns (if tests need refactoring)
- **`workflows/laravel/refactor-helpers.md`** - For helper function refactoring patterns
- **`workflows/laravel/refactor-enums.md`** - For enum refactoring patterns
- **Existing similar classes in codebase** - For consistency patterns

---

## COMMON REFACTORING PATTERNS

### Extract Service

**Before:**

```php
public function store(Request $request)
{
    // 50+ lines of business logic
    if ($oldSubscriptionId !== $newSubscriptionId) {
        $oldSubscription = Subscription::find($oldSubscriptionId);
        $newSubscription = Subscription::find($newSubscriptionId);
        // Complex comparison logic...
    }
}
```

**After:**

```php
public function __construct(
    private readonly AccountSubscriptionService $subscriptionService
) {}

public function store(Request $request)
{
    // Simple delegation
    $this->subscriptionService->handleSubscriptionChanges(...);
}
```

### Extract Method

**Before:**

```php
public function updateAccount(Account $account, array $data)
{
    // 100 lines of mixed logic
}
```

**After:**

```php
public function updateAccount(Account $account, array $data)
{
    $this->updateAccountFields($account, $data);
    $this->updateAccountPasswords($account, $data);
    $this->validateAndUpdateBroker($account, $data);
    $this->updateRequestInfo($account, $request);
}
```

### Use Enums Instead of Primitives

**Before:**

```php
$account->subscription_status = (int) $data['subscription_status'] ? 1 : 0;
```

**After:**

```php
use App\Enums\SubscriptionStatus;

$account->subscription_status = SubscriptionStatus::from($data['subscription_status']);
```

### Add Authorization Checks

**Before:**

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    // No authorization check
    $account = Account::create($request->validated());
    return response()->json($account, 201);
}
```

**After:**

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    $this->authorize('create', Account::class);

    $account = Account::create($request->validated());
    return response()->json($account, 201);
}
```

**Policy (AccountPolicy.php):**

```php
public function create(User $user): bool
{
    return $user->isSuperAdmin() || $user->isAdmin() || $user->isPlatform();
}
```
