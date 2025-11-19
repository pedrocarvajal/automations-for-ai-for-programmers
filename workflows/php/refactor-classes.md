# Refactor Classes Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

**THEN, follow these specific rules for class refactoring:**

- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar classes** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete class file
- [ ] Identify code smells (long methods, duplication, primitive obsession, feature envy)
- [ ] Identify responsibilities (SRP violations)
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks (e.g., "No services needed to extract" if Phase 2 is skipped)

### Phase 2: Extract Services (if needed)

- [ ] **REVIEW existing services** to understand the established pattern
- [ ] Identify business logic that should be in services
- [ ] Create service classes following existing patterns
- [ ] Document services with complete PHPDoc
- [ ] DO NOT modify controller yet - only create services
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if this phase is skipped (e.g., "No business logic needs extraction, all logic is already in services")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Dependency Injection

- [ ] Identify dependencies that should be injected
- [ ] Use constructor injection with property promotion (`private readonly`)
- [ ] Remove direct instantiation of dependencies
- [ ] Verify dependency injection works correctly
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if any dependency injection tasks were skipped (e.g., "No dependencies needed injection, class has no dependencies")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Class Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Class-level PHPDoc
  2. Constructor
  3. Public methods
  4. Protected methods
  5. Private methods
- [ ] Add section separators (`// ============================================`)
- [ ] Group methods logically by functionality
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "Class structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Method Refactoring

- [ ] Extract long methods into smaller, focused methods
- [ ] Remove code duplication
- [ ] Apply Single Responsibility Principle
- [ ] Use descriptive method names
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no refactoring was needed (e.g., "All methods are already small and focused, no extraction needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: Documentation (PHPDoc)

- [ ] Add class-level PHPDoc explaining purpose
- [ ] Add PHPDoc to all public methods
- [ ] Add PHPDoc to protected methods
- [ ] Add PHPDoc to complex private methods
- [ ] Include `@param`, `@return`, `@throws`, `@example` where appropriate
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if documentation was already complete (e.g., "All methods already have complete PHPDoc")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: Swagger Documentation (Controllers only)

- [ ] Add `@OA\*` annotations for all public endpoints
- [ ] Use standard response references (`ref="#/components/responses/..."`)
- [ ] Document request bodies with all fields
- [ ] Document all possible response codes
- [ ] Regenerate Swagger docs and verify
- [ ] **EXPLAIN** if this phase is skipped (e.g., "This is not a controller, Swagger documentation not applicable")
- [ ] **EXPLAIN** if Swagger was already complete (e.g., "All endpoints already have complete Swagger documentation")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 8: Laravel Policies and Authorization (Controllers only)

- [ ] **REVIEW existing policies** to understand the established pattern
- [ ] Identify which roles can access each endpoint/method
- [ ] For each public method, ask: "Which roles should have access to this endpoint?"
- [ ] Verify if a Policy class exists for the resource model
- [ ] Create or update Policy class following existing patterns (e.g., `AccountPolicy`, `UserPolicy`)
- [ ] Add authorization checks in controller methods using `$this->authorize()` or `authorize()`
- [ ] Use standard Policy methods: `viewAny`, `view`, `create`, `update`, `delete`
- [ ] Use role checks from User model methods: `isSuperAdmin()`, `isAdmin()`, `isLeader()`, `isSupervisor()`, `isPlatform()`
- [ ] Register Policy in `AuthServiceProvider` if new Policy was created
- [ ] Verify authorization works correctly (test with different roles)
- [ ] Document authorized roles in PHPDoc comments for each method
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if this phase is skipped (e.g., "This is not a controller, authorization policies not applicable")
- [ ] **EXPLAIN** if authorization was already complete (e.g., "All endpoints already have proper authorization checks")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 9: Type Hints and Return Types

- [ ] Add type hints to all method parameters
- [ ] Add return types to all methods
- [ ] Use strict types (`declare(strict_types=1)` if applicable)
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if types were already complete (e.g., "All methods already have complete type hints and return types")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 10: Final Verification

- [ ] Add code review comment at the beginning of the file with:
  - Note indicating this file was code reviewed
  - Date (YYYY-MM-DD format only, no time) from local system date
  - Git user name from git configuration (`git config user.name`)
  - Format: `// Code reviewed on YYYY-MM-DD by {git_user_name}`
- [ ] Run all tests and verify they pass
- [ ] Verify no linting errors
- [ ] Verify Swagger documentation generates correctly (controllers)
- [ ] Review code structure and navigability
- [ ] Confirm complete documentation
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

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

### Swagger Documentation (Controllers)

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
- DO NOT duplicate Swagger documentation

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
    // No authorization check - security risk!
    // Implementation
}
```

### Bad: Manual Role Checks in Controller

```php
public function store(StoreAccountRequest $request): JsonResponse
{
    if (!$user->isSuperAdmin() && !$user->isAdmin()) {
        abort(403);
    }
    // Should use Policy instead
}
```

### Bad: Policy Not Registered

```php
// Policy exists but not registered in AuthServiceProvider
// Will not work automatically
```

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
    $service = app()->make(AccountService::class);
}
```

### Bad: Direct Instantiation

```php
public function store(Request $request)
{
    $service = new AccountService();
}
```

### Bad: Static Methods

```php
public function store(Request $request)
{
    AccountService::handle($request);
}
```

---

## SWAGGER DOCUMENTATION PATTERNS

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
 *     // ... repeated in every endpoint
 * )
 */
```

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

### Swagger (Controllers)

- [ ] All endpoints documented with `@OA\*` annotations
- [ ] Using standard response references
- [ ] Request bodies documented with all fields
- [ ] All response codes documented
- [ ] Swagger docs regenerate successfully

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
- **Documented**: Complete PHPDoc and Swagger docs (controllers)
- **Authorized**: Proper Laravel Policy checks for all endpoints (controllers)
- **Injected**: Dependencies injected via constructor
- **Type-safe**: All type hints and return types present
- **Maintainable**: Easy to understand and modify
- **Testable**: Logic extracted to services when needed
- **Clean**: No code smells, no duplication, self-documenting code

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
