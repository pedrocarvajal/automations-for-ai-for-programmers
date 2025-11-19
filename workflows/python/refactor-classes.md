# Refactor Classes Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Read task notes standard**: Read `standards/task-notes.md` for code review comment format.

2. **Review similar refactoring guides**: Check `workflows/python/refactor-helpers.md` for patterns and consistency.

3. **Search for class usage**: Search the codebase to find where the class is used. This provides crucial context about:
   - How the class is imported and instantiated
   - What methods are commonly called
   - Common patterns and usage scenarios
   - Integration points with other parts of the system
   - Edge cases and error handling needs
   - This context is essential for making informed refactoring decisions

**THEN, follow these specific rules for class refactoring:**

- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (ruff, mypy)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar classes** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## CRITICAL RULES (NEVER VIOLATE)

- **NEVER** modify public method signatures without searching for all usages first
- **NEVER** remove a method without checking if it's used elsewhere
- **NEVER** change return types without updating all callers
- **NEVER** skip running tests between phases
- **NEVER** proceed to next phase if current phase has failing tests
- **NEVER** make changes silently - always explain what was changed and why
- **NEVER** ignore linting errors - fix them immediately
- **ALWAYS** search codebase before making structural changes
- **ALWAYS** verify tests pass after each phase
- **ALWAYS** explain why a task was skipped
- **ALWAYS** wait for user confirmation before proceeding to next phase
- **ALWAYS** present a clear plan before starting refactoring

---

## ERROR HANDLING

If at any point:
- Tests fail: **STOP immediately**, report to user, do NOT continue
- Linting errors appear: **STOP immediately**, fix errors before continuing
- User requests changes: **STOP immediately**, wait for new instructions
- Ambiguity detected: **STOP immediately**, ask user for clarification
- Breaking changes detected: **STOP immediately**, present impact analysis to user

**DO NOT** attempt to "fix" things silently or continue with broken tests.

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

**Execute in this exact order:**

1. **VERIFY**: Read the complete class file
2. **VERIFY**: Run existing tests to establish baseline (all tests must pass before starting)
3. **SEARCH**: Search for class usage in codebase:
   - Use `grep` or `codebase_search` to find all imports: `grep -r "from.*import.*ClassName"` or `grep -r "import.*ClassName"`
   - Find all instantiations: `grep -r "ClassName("`
   - Find all method calls: `grep -r "\.method_name("`
   - Identify integration points and dependencies
4. **SEARCH**: Find similar classes in codebase to understand patterns and conventions
5. **ANALYZE**: Identify code smells (long methods, duplication, primitive obsession, feature envy)
6. **ANALYZE**: Identify responsibilities (SRP violations)
7. **ANALYZE**: Identify dependencies that need injection
8. **PLAN**: Create refactoring plan with:
   - List of code smells to fix
   - Dependencies to inject
   - Methods to extract/refactor
   - Estimated impact (files that will need updates)
   - Risk assessment
9. **PRESENT**: Present the plan to the user using the format in "EXAMPLE: Presenting Analysis Plan" section
10. **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
11. **EXPLAIN** any skipped tasks

### Phase 2: Dependency Injection

**Execute in this exact order:**

1. **VERIFY**: No tests are broken before starting (run tests first)
2. **VERIFY**: Current class structure is understood
3. **ANALYZE**: List all current dependencies (imports, instantiations)
4. **ANALYZE**: Check if dependencies are already injected (constructor parameters)
5. **ANALYZE**: Identify which dependencies should be injected vs created internally:
   - Used in multiple methods → should be injected
   - Needs to be mockable for testing → should be injected
   - Is a service/repository → should be injected
   - Is a simple value/config → can be created internally
6. **REFACTOR**: For each dependency to inject:
   - Add parameter to `__init__`
   - Store as private attribute (prefixed with `_`)
   - Remove direct instantiation
   - Update all callers if needed (check from Phase 1 search)
7. **VERIFY**: All existing tests still pass
8. **VERIFY**: No new linting errors introduced
9. **VERIFY**: Dependency injection works correctly
10. **EXPLAIN** if any dependency injection tasks were skipped (e.g., "No dependencies needed injection, class has no dependencies")
11. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Class Structure and Organization

**Execute in this exact order:**

1. **VERIFY**: All tests pass before starting
2. **REORGANIZE**: Imports (standard library → third-party → local)
3. **REORGANIZE**: Add class-level docstring (if missing)
4. **REORGANIZE**: Class properties/attributes (type annotations)
5. **REORGANIZE**: Methods in order:
   - Constructor (`__init__`)
   - Public methods
   - Protected methods (`_method`)
   - Private methods (`__method`)
6. **REORGANIZE**: Group related methods together by functionality
7. **FORMAT**: Add section separators (`# ───────────────────────────────────────────────────────────`)
8. **VERIFY**: All tests still pass
9. **VERIFY**: No linting errors introduced
10. **EXPLAIN** if structure was already correct (e.g., "Class structure was already organized correctly, no changes needed")
11. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Method Refactoring

**Execute in this exact order:**

1. **VERIFY**: All tests pass before starting
2. **IDENTIFY**: Long methods (>30-50 lines) to extract
3. **IDENTIFY**: Code duplication to remove
4. **IDENTIFY**: Methods violating Single Responsibility Principle
5. **REFACTOR**: Extract long methods into smaller, focused methods:
   - Use descriptive method names (snake_case)
   - Keep methods < 30 lines ideally
   - Each method should do one thing
6. **REFACTOR**: Remove code duplication by extracting common logic
7. **REFACTOR**: Apply Single Responsibility Principle
8. **VERIFY**: All tests still pass (critical - refactoring can break functionality)
9. **VERIFY**: No linting errors
10. **EXPLAIN** if no refactoring was needed (e.g., "All methods are already small and focused, no extraction needed")
11. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Documentation (Docstrings)

**Execute in this exact order:**

1. **VERIFY**: All tests pass before starting
2. **ADD**: Class-level docstring explaining purpose (Google style) if missing
3. **ADD**: Docstrings to all public methods (required)
4. **ADD**: Docstrings to protected methods (recommended)
5. **ADD**: Docstrings to complex private methods (if behavior is non-obvious)
6. **VERIFY**: All docstrings include:
   - `Args:` section with parameter descriptions
   - `Returns:` section with return type and description
   - `Raises:` section if method raises exceptions
   - `Example:` section for complex methods
7. **VERIFY**: No linting errors
8. **EXPLAIN** if documentation was already complete (e.g., "All methods already have complete docstrings")
9. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: Type Hints and Return Types

**Execute in this exact order:**

1. **VERIFY**: All tests pass before starting
2. **ADD**: Type hints to all method parameters
3. **ADD**: Return type annotations to all methods
4. **VERIFY**: Use `typing` module for complex types (`Optional`, `Union`, `Dict`, `List`, `Tuple`, etc.)
5. **VERIFY**: Use `Optional[Type]` or `Type | None` for nullable types
6. **VERIFY**: Use `Union[Type1, Type2]` or `Type1 | Type2` for union types
7. **VERIFY**: Avoid `Any` type when specific type is known (use `grep` to find actual types)
8. **VERIFY**: Use `from __future__ import annotations` if needed (Python < 3.10)
9. **VERIFY**: mypy passes with strict mode
10. **VERIFY**: No linting errors (ruff, mypy)
11. **EXPLAIN** if types were already complete (e.g., "All methods already have complete type hints and return types")
12. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: Final Verification

**Execute in this exact order:**

1. **ADD**: Code review comment at the beginning of the file (see `standards/task-notes.md` for format)
2. **VERIFY**: Run all tests and verify 100% pass rate
3. **VERIFY**: No linting errors (ruff, mypy) - zero tolerance
4. **VERIFY**: Code structure follows recommended order
5. **VERIFY**: All public methods have docstrings
6. **VERIFY**: All methods have type hints and return types
7. **VERIFY**: Dependencies are injected (no direct instantiation)
8. **VERIFY**: Methods are < 50 lines each
9. **VERIFY**: No code duplication detected
10. **VERIFY**: Section separators present
11. **REVIEW**: Code structure and navigability
12. **REVIEW**: Complete documentation
13. **EXPLAIN** any verification issues found and how they were resolved
14. **PRESENT**: Final summary with all changes made
15. **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

---

## CLASS FILE STRUCTURE

### Services

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import Any, Dict, List, Optional

from interfaces.service import ServiceInterface
from models.resource import ResourceModel
from services.logging import LoggingService


class ResourceService(ServiceInterface):
    """
    Service for handling {domain} operations.

    {Brief description of service responsibilities}.

    Attributes:
        _dependency: Description of dependency.
        _log: Logging service instance for logging operations.
    """

    # ───────────────────────────────────────────────────────────
    # PROPERTIES
    # ───────────────────────────────────────────────────────────
    _dependency: DependencyType
    _log: LoggingService

    # ───────────────────────────────────────────────────────────
    # CONSTRUCTOR
    # ───────────────────────────────────────────────────────────
    def __init__(
        self,
        dependency: DependencyType,
        logging_service: Optional[LoggingService] = None,
    ) -> None:
        """
        Initialize the service.

        Args:
            dependency: Description of dependency.
            logging_service: Optional logging service instance. If not provided,
                a new LoggingService instance will be created.

        Raises:
            ValueError: If dependency is invalid.
        """
        self._dependency = dependency
        self._log = logging_service or LoggingService()
        self._log.setup(name="resource_service")

    # ───────────────────────────────────────────────────────────
    # PUBLIC METHODS
    # ───────────────────────────────────────────────────────────
    def process_resource(
        self,
        resource_id: str,
        data: Dict[str, Any],
    ) -> ResourceModel:
        """
        Process a resource with the given data.

        Args:
            resource_id: Unique identifier for the resource.
            data: Dictionary containing resource data to process.

        Returns:
            ResourceModel: The processed resource model instance.

        Raises:
            ValueError: If resource_id is invalid.
            NotFoundError: If resource is not found.

        Example:
            >>> service = ResourceService(dependency)
            >>> result = service.process_resource("123", {"field": "value"})
            >>> print(result.id)
            "123"
        """
        # Implementation
        pass

    # ───────────────────────────────────────────────────────────
    # PRIVATE METHODS
    # ───────────────────────────────────────────────────────────
    def _validate_resource(
        self,
        resource_id: str,
    ) -> bool:
        """
        Validate that a resource exists and is accessible.

        Args:
            resource_id: Unique identifier for the resource.

        Returns:
            bool: True if resource is valid, False otherwise.
        """
        # Implementation
        pass
```

### API Controllers/Handlers (FastAPI example)

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import Any, Dict, List

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel

from services.resource import ResourceService
from dependencies.auth import get_current_user


router = APIRouter(prefix="/api/v1/resources", tags=["resources"])


class ResourceCreateRequest(BaseModel):
    """Request model for creating a resource."""

    field1: str
    field2: int


class ResourceResponse(BaseModel):
    """Response model for resource operations."""

    id: str
    field1: str
    field2: int


# ───────────────────────────────────────────────────────────
# ENDPOINTS
# ───────────────────────────────────────────────────────────
@router.post(
    "/",
    response_model=ResourceResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Create a new resource",
    description="Creates a new resource with the provided data.",
    responses={
        201: {"description": "Resource created successfully"},
        400: {"description": "Invalid request data"},
        401: {"description": "Unauthorized"},
        403: {"description": "Forbidden"},
        422: {"description": "Validation error"},
        500: {"description": "Internal server error"},
    },
)
async def create_resource(
    request: ResourceCreateRequest,
    service: ResourceService = Depends(),
    current_user: Any = Depends(get_current_user),
) -> ResourceResponse:
    """
    Create a new resource.

    This endpoint allows authorized users to create a new resource.
    Only users with 'admin' or 'creator' roles can access this endpoint.

    Args:
        request: Validated request data containing resource information.
        service: Injected ResourceService instance.
        current_user: Current authenticated user from dependency.

    Returns:
        ResourceResponse: The created resource data.

    Raises:
        HTTPException: If user is not authorized or validation fails.
    """
    # Authorization check
    if not (current_user.is_admin() or current_user.is_creator()):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not authorized to create resources",
        )

    # Implementation
    pass
```

---

## EXAMPLE: Presenting Analysis Plan

When presenting the refactoring plan to user, use this format:

```
## Refactoring Plan for ResourceService

### Code Smells Identified:
1. **Long Method**: `update_resource()` (87 lines) → Extract into 4 methods:
   - `_update_resource_fields()`
   - `_update_resource_passwords()`
   - `_validate_and_update_broker()`
   - `_update_request_info()`

2. **Code Duplication**: Validation logic repeated 3 times → Extract to `_validate_resource()`

3. **Primitive Obsession**: Status as string → Create `ResourceStatus` enum

4. **Feature Envy**: `_calculate_total()` accesses `subscription` object more than `self` → Move to `Subscription` class

### Dependencies to Inject:
- `EmailService` (currently instantiated directly in `send_notification()`)
- `LoggingService` (already injected ✓)

### Methods to Extract:
- `update_resource()` → 4 smaller methods (see above)
- `process_payment()` → Extract validation logic

### Proposed Changes:
- Extract 4 methods from `update_resource()`
- Create `ResourceStatus` enum in `enums/resource_status.py`
- Inject `EmailService` via constructor
- Move `_calculate_total()` to `Subscription` class

### Files That Will Need Updates:
- `services/resource.py` (main refactoring)
- `enums/resource_status.py` (new file)
- `tests/unit/test_resource_service.py` (update tests)
- `services/subscription.py` (add `calculate_total()` method)
- `handlers/resource_handler.py` (update to use enum)

### Risk Assessment:
- **Low Risk**: Method extraction (internal refactoring)
- **Medium Risk**: Enum creation (requires updating callers)
- **Medium Risk**: Dependency injection (requires updating instantiation)

### Estimated Impact:
- 5 files will need updates
- 2 new files (enum, extracted methods)
- All existing tests should pass with minor updates

**Proceed with this plan? [Y/N]**
```

---

## SUCCESS CRITERIA

A refactored class is considered successful when:

- [ ] **All tests pass** (100% pass rate, zero failures)
- [ ] **Zero linting errors** (ruff, mypy - strict mode)
- [ ] **All public methods have docstrings** (Google style, complete)
- [ ] **All methods have type hints** (parameters and return types)
- [ ] **Dependencies are injected** (no direct instantiation of services/repositories)
- [ ] **Methods are < 50 lines each** (ideally < 30 lines)
- [ ] **No code duplication** (DRY principle applied)
- [ ] **Structure follows recommended order** (imports → docstring → properties → constructor → public → protected → private)
- [ ] **Section separators present** (clear navigation)
- [ ] **Code review comment added** (at beginning of file)
- [ ] **Single Responsibility Principle applied** (class has one clear purpose)
- [ ] **No code smells** (as identified in Phase 1)

---

## COMMON ERRORS TO AVOID

### Error 1: Breaking Existing Tests
**Problem**: Refactoring breaks existing functionality
**Prevention**: 
- Run tests BEFORE starting each phase
- Run tests AFTER completing each phase
- If tests fail, STOP and fix before continuing
- Never skip test verification

### Error 2: Changing Public API Without Review
**Problem**: Modifying method signatures without considering callers
**Prevention**:
- Search codebase for all usages first (Phase 1)
- Present API changes to user before implementing
- Update all callers in same phase if signature changes
- Never change return types without updating callers

### Error 3: Incomplete Type Hints
**Problem**: Adding `Any` types instead of specific types
**Prevention**:
- Use `grep` to find actual types used in codebase
- Check return types of dependencies
- Use `Union` or `Optional` when appropriate
- Verify with mypy strict mode

### Error 4: Skipping Validation Steps
**Problem**: Not verifying tests/linting between phases
**Prevention**:
- Always run tests after each phase
- Always verify linting after each phase
- Never proceed if validation fails
- Document all verification steps

### Error 5: Not Searching for Usage
**Problem**: Making changes without understanding impact
**Prevention**:
- Always search codebase before structural changes
- Understand all callers before modifying methods
- Present impact analysis to user
- Never assume a method is unused

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Long Method

**Problem**: Methods with too many lines (>30-50 lines)
**Solution**: Extract methods, apply Single Responsibility Principle

### 2. Long Class

**Problem**: Classes with too many responsibilities
**Solution**: Split into multiple classes, refactor responsibilities

### 3. Code Duplication

**Problem**: Same code repeated in multiple places
**Solution**: Extract to private methods, use helper functions

### 4. Primitive Obsession

**Problem**: Using primitives instead of value objects/enums
**Solution**: Create enums or dataclasses (e.g., `Status` enum instead of `"active"/"inactive"`)

### 5. Feature Envy

**Problem**: Method accesses data from another object more than its own
**Solution**: Move method to the object it's accessing

### 6. Data Clumps

**Problem**: Groups of data passed together repeatedly
**Solution**: Create dataclasses or Pydantic models

### 7. Large Class

**Problem**: Class has too many methods/properties
**Solution**: Split responsibilities, refactor into smaller focused classes

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

- Use section separators (`# ───────────────────────────────────────────────────────────`) for clear navigation
- Organize methods: Constructor → Public → Protected → Private
- Group related methods together
- Keep methods focused on single responsibility
- Use descriptive method and variable names (snake_case)

### Dependency Injection

- Use constructor injection (pass dependencies to `__init__`)
- Store dependencies as private attributes (prefixed with `_`)
- Inject services, repositories, and other dependencies
- Avoid direct instantiation (`Class()`)
- Use dependency injection frameworks when appropriate (FastAPI `Depends`, etc.)

### Documentation

- Add class-level docstring explaining purpose and responsibilities (Google style)
- Document all public methods with complete docstrings
- Include `Args:`, `Returns:`, `Raises:` where applicable
- Add `Example:` for complex methods
- Use descriptive descriptions, not just type information

### Type Safety

- Add type hints to all method parameters
- Add return type annotations to all methods
- Use `Optional[Type]` or `Type | None` for nullable types
- Use `Union[Type1, Type2]` or `Type1 | Type2` for union types
- Avoid `Any` type when possible
- Use `typing` module for complex types (`Dict`, `List`, `Tuple`, etc.)

### Method Design

- Keep methods small and focused (< 30 lines ideally)
- Use descriptive names that explain what the method does
- Extract complex logic into private methods
- Avoid deep nesting (> 3 levels)
- Use early returns to reduce nesting

### Error Handling

- Use appropriate exceptions (built-in or custom)
- Document exceptions with `Raises:` in docstrings
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

- DO NOT use global state or singletons unnecessarily
- DO NOT instantiate dependencies directly (`Service()`)
- DO NOT use class methods for dependencies when instance methods are appropriate
- DO NOT hardcode dependencies

### Documentation

- DO NOT add obvious comments that repeat the code
- DO NOT comment every line of code
- DO NOT use comments as an excuse for unclear names
- DO NOT omit docstrings on public methods

### Code Quality

- DO NOT create methods longer than 50 lines
- DO NOT duplicate code - extract to methods or helper functions
- DO NOT use magic numbers - use constants or enums
- DO NOT use magic strings - use constants or enums
- DO NOT mix business logic with HTTP concerns in controllers

### Type Safety

- DO NOT omit type hints on parameters
- DO NOT omit return types
- DO NOT use `Any` when a specific type is known
- DO NOT use `Dict` or `List` without specifying value types when possible (`Dict[str, int]`)

---

## NAMING RULES

### Classes

- **Services**: `{Domain}Service` (e.g., `AccountService`)
- **Controllers/Views**: `{Resource}Controller` or `{Resource}ViewSet` (e.g., `AccountController`)
- **Models**: `{Resource}Model` (e.g., `AccountModel`)
- **Interfaces/Protocols**: `{Resource}Interface` or `{Resource}Protocol` (e.g., `AccountInterface`)
- Use PascalCase

### Methods

- **Services**: Use descriptive verbs (`process_subscription`, `validate_broker`)
- **Controllers**: Use action verbs (`create`, `update`, `delete`, `list`)
- Use snake_case
- Be descriptive: `update_account_fields()` not `update_fields()`

### Variables

- Use snake_case
- Be descriptive: `old_subscription` not `old`
- Use plural for collections: `accounts` not `account_list`
- Prefix private attributes with `_`: `_dependency`

### Constants

- Use UPPER_SNAKE_CASE
- Prefix tied to domain: `DEFAULT_ACCOUNT_*`, `MAX_SUBSCRIPTION_*`

---

## AUTHORIZATION PATTERNS

### Good: Using Decorators (FastAPI)

```python
from fastapi import Depends, HTTPException, status
from dependencies.auth import get_current_user, require_role

@router.post("/resources")
async def create_resource(
    request: ResourceCreateRequest,
    current_user: Any = Depends(get_current_user),
) -> ResourceResponse:
    require_role(current_user, ["admin", "creator"])
    # Implementation
```

### Good: Using Decorators (Django)

```python
from django.contrib.auth.decorators import user_passes_test
from rest_framework.decorators import permission_classes
from rest_framework.permissions import IsAuthenticated

def is_admin_or_creator(user):
    return user.is_admin() or user.is_creator()

@permission_classes([IsAuthenticated])
@user_passes_test(is_admin_or_creator)
def create_resource(request):
    # Implementation
```

### Good: Manual Check in Method

```python
def create_resource(self, request: Any) -> Response:
    if not (request.user.is_admin() or request.user.is_creator()):
        raise PermissionDenied("Not authorized to create resources")
    # Implementation
```

### Bad: Missing Authorization

**Why it's bad**: Security vulnerability, allows unauthorized access, violates security best practices
**Impact**: Unauthorized users can perform actions, data breach risk, compliance violations
**Example:**

```python
def create_resource(self, request: Any) -> Response:
    # ❌ No authorization check - security risk!
    # Implementation
```

### Bad: Hardcoded Role Checks

**Why it's bad**: Magic strings are error-prone, hard to maintain, violates DRY principle
**Impact**: Typos cause bugs, role changes require code changes, less flexible
**Example:**

```python
def create_resource(self, request: Any) -> Response:
    if request.user.role != "admin":  # ❌ Should use method or enum
        raise PermissionDenied()
    # Implementation
```

---

## DEPENDENCY INJECTION PATTERNS

### Good: Constructor Injection

```python
class ResourceService:
    def __init__(
        self,
        dependency: DependencyType,
        logging_service: Optional[LoggingService] = None,
    ) -> None:
        self._dependency = dependency
        self._log = logging_service or LoggingService()
```

### Good: Multiple Dependencies

```python
class ResourceService:
    def __init__(
        self,
        account_service: AccountService,
        subscription_service: SubscriptionService,
        email_service: EmailService,
    ) -> None:
        self._account_service = account_service
        self._subscription_service = subscription_service
        self._email_service = email_service
```

### Good: FastAPI Dependency Injection

```python
from fastapi import Depends

def get_resource_service() -> ResourceService:
    return ResourceService(dependency)

@router.post("/resources")
async def create_resource(
    service: ResourceService = Depends(get_resource_service),
) -> ResourceResponse:
    # Implementation
```

### Bad: Direct Instantiation

**Why it's bad**: Creates tight coupling, makes testing difficult, violates dependency inversion principle
**Impact**: Cannot mock dependencies in tests, cannot swap implementations, harder to maintain
**Example:**

```python
def process_resource(self, resource_id: str) -> ResourceModel:
    service = ResourceService()  # ❌ Hard-coded dependency
    return service.process(resource_id)
```

### Bad: Global State

**Why it's bad**: Creates hidden dependencies, makes testing difficult, violates dependency injection principles
**Impact**: Cannot test in isolation, shared state can cause bugs, harder to reason about code
**Example:**

```python
# Global variable - avoid ❌
_resource_service = ResourceService()

def process_resource(self, resource_id: str) -> ResourceModel:
    return _resource_service.process(resource_id)
```

### Bad: Class Methods for Dependencies

**Why it's bad**: Hides dependency creation, makes testing difficult, violates dependency injection
**Impact**: Cannot inject different implementations, harder to mock, less flexible
**Example:**

```python
class ResourceService:
    @classmethod
    def create(cls) -> "ResourceService":
        return cls(dependency)  # ❌ Should use constructor injection
```

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Class organized according to recommended structure
- [ ] Section separators present (`# ───────────────────────────────────────────────────────────`)
- [ ] Methods grouped logically (Public → Protected → Private)
- [ ] No god classes (too many responsibilities)

### Dependency Injection

- [ ] Dependencies injected via constructor
- [ ] Dependencies stored as private attributes (prefixed with `_`)
- [ ] No direct instantiation (`Class()`)
- [ ] No global state or singletons

### Documentation

- [ ] Class-level docstring present (Google style)
- [ ] All public methods have docstrings
- [ ] Protected methods have docstrings
- [ ] Complex private methods have docstrings
- [ ] Docstrings include `Args:`, `Returns:`, `Raises:` where applicable

### Code Quality

- [ ] No methods longer than 50 lines
- [ ] No code duplication
- [ ] Single Responsibility Principle applied
- [ ] No magic numbers or strings
- [ ] Descriptive method and variable names

### Type Safety

- [ ] All parameters have type hints
- [ ] All methods have return types
- [ ] No unnecessary `Any` types
- [ ] Optional types used appropriately
- [ ] mypy passes with strict mode

### Testing

- [ ] All tests pass
- [ ] No linting errors (ruff, mypy)
- [ ] Code is maintainable and readable

---

## FINAL OBJECTIVE

A class file must be:

- **Organized**: Clear structure with section separators
- **Focused**: Single Responsibility Principle applied
- **Documented**: Complete docstrings (Google style)
- **Injected**: Dependencies injected via constructor
- **Type-safe**: All type hints and return types present
- **Maintainable**: Easy to understand and modify
- **Testable**: Well-structured and easy to test
- **Clean**: No code smells, no duplication, self-documenting code

---

## COMMON REFACTORING PATTERNS

### Extract Method

**Before:**

```python
def update_resource(self, resource: ResourceModel, data: Dict[str, Any]) -> None:
    # 100 lines of mixed logic
```

**After:**

```python
def update_resource(self, resource: ResourceModel, data: Dict[str, Any]) -> None:
    self._update_resource_fields(resource, data)
    self._update_resource_passwords(resource, data)
    self._validate_and_update_broker(resource, data)
    self._update_request_info(resource, data)
```

### Use Enums Instead of Primitives

**Before:**

```python
resource.status = "active" if data.get("status") else "inactive"
```

**After:**

```python
from enum import Enum

class ResourceStatus(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"

resource.status = ResourceStatus.ACTIVE if data.get("status") else ResourceStatus.INACTIVE
```

### Add Authorization Checks

**Before:**

```python
@router.post("/resources")
async def create_resource(request: ResourceCreateRequest) -> ResourceResponse:
    # No authorization check
    resource = ResourceModel.create(request.dict())
    return ResourceResponse.from_orm(resource)
```

**After:**

```python
@router.post("/resources")
async def create_resource(
    request: ResourceCreateRequest,
    current_user: Any = Depends(get_current_user),
) -> ResourceResponse:
    if not (current_user.is_admin() or current_user.is_creator()):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not authorized to create resources",
        )

    resource = ResourceModel.create(request.dict())
    return ResourceResponse.from_orm(resource)
```

---

## PYTHON-SPECIFIC BEST PRACTICES

### Use Dataclasses for Data Transfer Objects

```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class ResourceData:
    """Data transfer object for resource operations."""

    id: str
    name: str
    status: ResourceStatus
    metadata: Optional[Dict[str, Any]] = None
```

### Use Pydantic Models for Validation

```python
from pydantic import BaseModel, Field, validator

class ResourceCreateRequest(BaseModel):
    """Request model for creating a resource."""

    name: str = Field(..., min_length=1, max_length=100)
    status: ResourceStatus

    @validator("name")
    def validate_name(cls, v: str) -> str:
        if not v.strip():
            raise ValueError("Name cannot be empty")
        return v.strip()
```

### Use Type Aliases for Complex Types

```python
from typing import Dict, List, TypeAlias

ResourceDict: TypeAlias = Dict[str, Any]
ResourceList: TypeAlias = List[ResourceDict]
```

### Use Context Managers for Resource Management

```python
def process_with_context(self, resource_id: str) -> None:
    with self._get_resource_context(resource_id) as resource:
        # Process resource
        pass
```

### Use Property Decorators for Computed Attributes

```python
@property
def full_name(self) -> str:
    """Get the full name of the resource."""
    return f"{self.first_name} {self.last_name}"
```

### Code Formatting: Trailing Commas

When function calls, class instantiations, or definitions span multiple lines, always include a trailing comma after the last parameter. This improves readability and makes diffs cleaner when adding new parameters.

**Good: Multi-line with trailing comma**

```python
model_config = ConfigDict(
    arbitrary_types_allowed=True,
    str_strip_whitespace=True,
)

def process_resource(
    resource_id: str,
    data: Dict[str, Any],
) -> ResourceModel:
    pass

service = ResourceService(
    dependency=dependency,
    logging_service=logging_service,
)
```

**Bad: Single line or multi-line without trailing comma**

```python
model_config = ConfigDict(arbitrary_types_allowed=True, str_strip_whitespace=True)

model_config = ConfigDict(
    arbitrary_types_allowed=True,
    str_strip_whitespace=True
)

def process_resource(
    resource_id: str,
    data: Dict[str, Any]
) -> ResourceModel:
    pass
```
