# Refactor Enums Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Search for enum usage**: Search the codebase to find where the enum is used. This provides crucial context about:
   - How the enum values are accessed and used
   - What methods or properties might be needed
   - Common patterns and operations performed with the enum
   - Integration points with other parts of the system
   - This context is essential for making informed refactoring decisions

**THEN, follow these specific rules for enum refactoring:**

- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (ruff, mypy)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar enums** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete enum file
- [ ] **Search for enum usage** in the codebase to understand how it's used (imports, method calls, comparisons, etc.)
- [ ] Identify code smells (missing `@unique`, no docstrings, inconsistent values, magic strings)
- [ ] Check if enum values are meaningful or should use `auto()`
- [ ] Verify enum members follow naming conventions (UPPER_CASE)
- [ ] Check if enum needs methods or properties based on usage patterns found
- [ ] Review similar enums in codebase for consistency
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks

**Common Issues to Check:**

- Enum used in multiple places but not found in search
- Enum has unclear purpose or name
- Enum structure doesn't match codebase patterns
- Missing context about enum's role in the system
- Similar enums exist with different patterns

### Phase 2: Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Code review comment (if applicable)
  2. Imports (standard library: `from enum import Enum, unique, auto`)
  3. Class-level docstring
  4. Enum members (alphabetically or logically ordered)
  5. Methods (if any)
  6. Properties (if any)
- [ ] Add `@unique` decorator if values are unique
- [ ] Verify enum members are ordered logically
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "Enum structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Imports not in correct order
- Missing code review comment
- Enum members not logically ordered
- Methods/properties in wrong position
- Missing `@unique` decorator when values are unique
- Linting errors after reorganization

### Phase 3: Values and Members

- [ ] Use meaningful values (strings, ints) or `auto()` if values don't matter
- [ ] Ensure all members use UPPER_CASE naming
- [ ] Verify no duplicate values exist (use `@unique` to enforce)
- [ ] Check if values should be strings (for API compatibility) or integers
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no changes were needed (e.g., "All enum members already follow best practices")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Enum members not in UPPER_CASE
- Duplicate values exist
- Meaningless values when `auto()` would be better
- String values needed for API but not used
- Integer values used when strings would be better
- Tests failing after value changes

### Phase 4: Methods and Properties

- [ ] Add methods only if they encapsulate enum-related behavior
- [ ] Use descriptive method names (snake_case)
- [ ] Add type hints to all method parameters
- [ ] Add return type annotations to all methods
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no methods were needed (e.g., "Enum does not require additional methods")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Methods don't encapsulate enum-related behavior
- Method names not descriptive (snake_case)
- Missing type hints on method parameters
- Missing return type annotations
- Methods that should be properties instead
- Tests failing after adding methods

### Phase 5: Documentation (Docstrings)

- [ ] Add class-level docstring explaining purpose (Google style)
- [ ] Add docstrings to all methods (if any)
- [ ] Add inline comments for complex enum members if needed
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if documentation was already complete (e.g., "Enum already has complete docstrings")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Missing class-level docstring
- Docstrings not in Google style
- Missing docstrings on methods
- Incomplete docstrings (missing Returns, Examples)
- Obvious comments that repeat code
- Complex members without inline comments

### Phase 6: Type Safety

- [ ] Verify enum inherits from `Enum` correctly
- [ ] Consider `str, Enum` if enum values are strings and need string operations
- [ ] Add type hints to all methods (if any)
- [ ] Verify mypy passes with strict mode
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if types were already complete (e.g., "Enum already has correct type annotations")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

**Common Issues to Check:**

- Enum doesn't inherit from `Enum` correctly
- Should inherit from `str, Enum` but doesn't
- Missing type hints on methods
- Missing return types on methods
- mypy errors in strict mode
- Linting errors after type changes

### Phase 7: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Verify no linting errors (ruff, mypy)
- [ ] Review enum structure and consistency with codebase
- [ ] Confirm complete documentation
- [ ] Verify `@unique` decorator is present (if applicable)
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

**Common Issues to Check:**

- Missing code review comment
- Tests failing
- Linting errors (ruff, mypy)
- Enum structure inconsistent with codebase
- Missing `@unique` decorator
- Incomplete documentation
- Type safety issues

---

## ENUM FILE STRUCTURE

### Basic Enum (String Values)

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from enum import Enum, unique


@unique
class OrderStatus(Enum):
    """Represents the possible states of an order in the system."""

    OPENING = "opening"
    OPEN = "open"
    CLOSING = "closing"
    CLOSED = "closed"
    CANCELLED = "cancelled"
```

### Enum with Auto Values

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from enum import Enum, unique, auto


@unique
class Priority(Enum):
    """Represents priority levels for tasks."""

    LOW = auto()
    MEDIUM = auto()
    HIGH = auto()
    CRITICAL = auto()
```

### Enum with Methods

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from enum import Enum, unique


@unique
class Timeframe(Enum):
    """Represents trading timeframes with their duration in seconds."""

    ONE_MINUTE = "1m"
    THREE_MINUTES = "3m"
    FIVE_MINUTES = "5m"
    FIFTEEN_MINUTES = "15m"
    THIRTY_MINUTES = "30m"
    ONE_HOUR = "1h"
    TWO_HOURS = "2h"
    FOUR_HOURS = "4h"
    SIX_HOURS = "6h"
    EIGHT_HOURS = "8h"
    TWELVE_HOURS = "12h"
    ONE_DAY = "1d"
    THREE_DAYS = "3d"
    ONE_WEEK = "1w"
    ONE_MONTH = "1M"

    def to_seconds(self) -> int:
        """
        Convert timeframe to seconds.

        Returns:
            int: Number of seconds for the timeframe.

        Example:
            >>> Timeframe.ONE_HOUR.to_seconds()
            3600
        """
        mapping = {
            "1m": 60,
            "3m": 180,
            "5m": 300,
            "15m": 900,
            "30m": 1800,
            "1h": 3600,
            "2h": 7200,
            "4h": 14400,
            "6h": 21600,
            "8h": 28800,
            "12h": 43200,
            "1d": 86400,
            "3d": 259200,
            "1w": 604800,
            "1M": 2592000,
        }
        return mapping[self.value]
```

### String Enum (for API compatibility)

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from enum import Enum, unique


@unique
class OrderSide(str, Enum):
    """
    Represents the side of an order (buy or sell).

    Inherits from str to allow direct string operations and JSON serialization.
    """

    BUY = "buy"
    SELL = "sell"

    def is_buy(self) -> bool:
        """
        Check if the order side is buy.

        Returns:
            bool: True if order side is BUY, False otherwise.
        """
        return self == OrderSide.BUY

    def is_sell(self) -> bool:
        """
        Check if the order side is sell.

        Returns:
            bool: True if order side is SELL, False otherwise.
        """
        return self == OrderSide.SELL
```

### Enum with Properties

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from enum import Enum, unique


@unique
class HttpStatus(Enum):
    """Represents HTTP status codes with their descriptions."""

    OK = 200
    CREATED = 201
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    FORBIDDEN = 403
    NOT_FOUND = 404
    INTERNAL_SERVER_ERROR = 500

    @property
    def is_success(self) -> bool:
        """
        Check if status code represents a successful response.

        Returns:
            bool: True if status is 2xx, False otherwise.
        """
        return 200 <= self.value < 300

    @property
    def is_client_error(self) -> bool:
        """
        Check if status code represents a client error.

        Returns:
            bool: True if status is 4xx, False otherwise.
        """
        return 400 <= self.value < 500

    @property
    def is_server_error(self) -> bool:
        """
        Check if status code represents a server error.

        Returns:
            bool: True if status is 5xx, False otherwise.
        """
        return 500 <= self.value < 600
```

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Missing `@unique` Decorator

**Problem**: Enum may have duplicate values without enforcement
**Solution**: Add `@unique` decorator to prevent duplicate values

### 2. Magic Strings/Numbers

**Problem**: Using raw strings or numbers instead of enums
**Solution**: Replace with enum members

### 3. No Documentation

**Problem**: Enum lacks docstring explaining its purpose
**Solution**: Add class-level docstring

### 4. Inconsistent Naming

**Problem**: Enum members not in UPPER_CASE
**Solution**: Rename members to follow convention

### 5. Meaningless Values

**Problem**: Values don't convey meaning or aren't used
**Solution**: Use `auto()` if values don't matter, or use meaningful values

### 6. Missing Type Safety

**Problem**: Enum not properly typed or missing type hints on methods
**Solution**: Add proper type annotations

### 7. Unordered Members

**Problem**: Enum members in random order
**Solution**: Order alphabetically or logically

### 8. Missing Methods for Common Operations

**Problem**: Repeated logic for enum operations (e.g., checking status)
**Solution**: Add methods to encapsulate enum-related behavior

---

## ERROR HANDLING AND EDGE CASES

### Common Edge Cases to Handle

When refactoring enums, consider these edge cases:

- **Invalid enum values**: When converting from strings/ints to enum, handle invalid values gracefully
- **None values**: Check if enum can be None and handle appropriately
- **String comparison**: When using string enums, ensure case-insensitive comparison if needed
- **Value serialization**: Ensure enum values serialize correctly for APIs/databases
- **Backward compatibility**: When changing enum values, ensure existing code still works

### Error Handling Best Practices

- **Validation**: Validate enum values when converting from external sources (APIs, databases)
- **Default values**: Provide sensible defaults when enum value is invalid
- **Type checking**: Use type hints and mypy to catch enum-related type errors
- **Testing**: Test enum methods with edge cases (None, invalid values, boundary conditions)

### Troubleshooting Common Issues

**Issue**: Tests fail after adding `@unique` decorator
- **Cause**: Enum has duplicate values
- **Solution**: Remove duplicates or use `auto()` if values don't matter

**Issue**: mypy errors after refactoring
- **Cause**: Type hints missing or incorrect
- **Solution**: Add proper type annotations, use `str, Enum` if needed

**Issue**: Enum values don't serialize correctly
- **Cause**: Enum doesn't inherit from `str` when needed
- **Solution**: Use `str, Enum` inheritance for string enums

**Issue**: Import errors after refactoring
- **Cause**: Enum moved or renamed
- **Solution**: Update all imports, search codebase for enum usage

**Issue**: Enum comparison fails
- **Cause**: Comparing enum with string/int directly
- **Solution**: Use `enum.value` for comparison or convert to enum first

---

## WHAT TO DO

### Structure and Organization

- Use `@unique` decorator to enforce unique values
- Order enum members alphabetically or logically
- Group related members together
- Use section separators if enum is large (>10 members)

### Values

- Use meaningful string values for API compatibility
- Use `auto()` when values don't matter
- Use integers when enum represents numeric constants
- Consider `str, Enum` inheritance for string enums that need string operations

### Documentation

- Add class-level docstring explaining purpose (Google style)
- Document methods with complete docstrings
- Add inline comments for complex members if needed
- Include `Returns:`, `Example:` in method docstrings

### Type Safety

- Inherit from `Enum` correctly
- Use `str, Enum` when enum values are strings and need string operations
- Add type hints to all methods
- Use return type annotations

### Methods

- Add methods only when they encapsulate enum-related behavior
- Use descriptive method names (snake_case)
- Keep methods focused and small
- Use properties for computed attributes

### Naming

- Use UPPER_SNAKE_CASE for enum members
- Use descriptive names that convey meaning
- Avoid abbreviations unless widely understood
- Use singular nouns for enum class names

---

## WHAT NOT TO DO

### Structure

- DO NOT omit `@unique` decorator when values should be unique
- DO NOT mix different value types (strings and ints) unless necessary
- DO NOT create enums with too many responsibilities
- DO NOT omit docstrings

### Values

- DO NOT use meaningless values when `auto()` would be better
- DO NOT use magic strings/numbers instead of enums
- DO NOT create duplicate values without `@unique`
- DO NOT use lowercase for enum member names

### Documentation

- DO NOT omit class-level docstrings
- DO NOT add obvious comments that repeat the code
- DO NOT omit method docstrings when methods exist
- DO NOT use comments as excuse for unclear names

### Code Quality

- DO NOT create enums with hundreds of members (consider splitting)
- DO NOT add methods that don't relate to the enum
- DO NOT use enums for configuration that changes frequently
- DO NOT mix business logic with enum definitions unnecessarily

### Type Safety

- DO NOT omit type hints on methods
- DO NOT omit return types
- DO NOT use `Any` when a specific type is known
- DO NOT forget to inherit from `Enum`

---

## NAMING RULES

### Enum Classes

- Use PascalCase: `OrderStatus`, `HttpStatus`, `Timeframe`
- Use singular nouns: `OrderStatus` not `OrderStatuses`
- Be descriptive: `GatewayOrderStatus` not `GOS`
- Prefix with domain when needed: `GatewayOrderStatus` vs `OrderStatus`

### Enum Members

- Use UPPER_SNAKE_CASE: `ONE_MINUTE`, `BAD_REQUEST`, `OPEN`
- Be descriptive: `ONE_MINUTE` not `M1`
- Use consistent naming patterns within enum
- Avoid abbreviations unless widely understood

### Methods

- Use snake_case: `to_seconds()`, `is_success()`, `is_buy()`
- Use descriptive verbs: `to_seconds()` not `seconds()`
- Prefix boolean methods with `is_`: `is_success()`, `is_buy()`
- Prefix conversion methods with `to_`: `to_seconds()`, `to_string()`

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Enum organized according to recommended structure
- [ ] `@unique` decorator present (if applicable)
- [ ] Members ordered logically or alphabetically
- [ ] No duplicate values

### Values

- [ ] Values are meaningful or `auto()` is used appropriately
- [ ] String values used for API compatibility when needed
- [ ] Integer values used for numeric constants when needed
- [ ] `str, Enum` inheritance used when string operations needed

### Documentation

- [ ] Class-level docstring present (Google style)
- [ ] Methods have docstrings (if any)
- [ ] Complex members have inline comments (if needed)
- [ ] Docstrings include `Returns:`, `Example:` where applicable

### Code Quality

- [ ] All members use UPPER_CASE naming
- [ ] Methods are focused and enum-related
- [ ] No magic strings or numbers
- [ ] Descriptive member and method names

### Type Safety

- [ ] Enum inherits from `Enum` correctly
- [ ] Methods have type hints
- [ ] Methods have return types
- [ ] mypy passes with strict mode

### Testing

- [ ] All tests pass
- [ ] No linting errors (ruff, mypy)
- [ ] Enum is maintainable and readable

---

## FINAL OBJECTIVE

An enum file must be:

- **Organized**: Clear structure with logical member ordering
- **Unique**: `@unique` decorator prevents duplicate values
- **Documented**: Complete docstrings (Google style)
- **Type-safe**: Proper type annotations and inheritance
- **Maintainable**: Easy to understand and extend
- **Consistent**: Follows codebase naming conventions
- **Clean**: No magic strings, no duplication, self-documenting code

---

## COMMON REFACTORING PATTERNS

### Add `@unique` Decorator

**Before:**

```python
from enum import Enum

class OrderStatus(Enum):
    OPEN = "open"
    CLOSED = "closed"
    CANCELLED = "cancelled"
```

**After:**

```python
from enum import Enum, unique

@unique
class OrderStatus(Enum):
    OPEN = "open"
    CLOSED = "closed"
    CANCELLED = "cancelled"
```

### Replace Magic Strings with Enum

**Before:**

```python
def process_order(status: str) -> None:
    if status == "open":
        # Process open order
        pass
```

**After:**

```python
from enum import Enum, unique

@unique
class OrderStatus(Enum):
    """Represents the possible states of an order."""

    OPEN = "open"
    CLOSED = "closed"
    CANCELLED = "cancelled"

def process_order(status: OrderStatus) -> None:
    if status == OrderStatus.OPEN:
        # Process open order
        pass
```

### Use `auto()` for Meaningless Values

**Before:**

```python
from enum import Enum

class Priority(Enum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4
```

**After:**

```python
from enum import Enum, unique, auto

@unique
class Priority(Enum):
    """Represents priority levels for tasks."""

    LOW = auto()
    MEDIUM = auto()
    HIGH = auto()
    CRITICAL = auto()
```

### Add Methods for Common Operations

**Before:**

```python
from enum import Enum, unique

@unique
class OrderSide(Enum):
    BUY = "buy"
    SELL = "sell"

# Repeated logic throughout codebase
if order.side == OrderSide.BUY:
    # Handle buy order
    pass
```

**After:**

```python
from enum import Enum, unique

@unique
class OrderSide(Enum):
    """Represents the side of an order."""

    BUY = "buy"
    SELL = "sell"

    def is_buy(self) -> bool:
        """
        Check if the order side is buy.

        Returns:
            bool: True if order side is BUY, False otherwise.
        """
        return self == OrderSide.BUY

    def is_sell(self) -> bool:
        """
        Check if the order side is sell.

        Returns:
            bool: True if order side is SELL, False otherwise.
        """
        return self == OrderSide.SELL

# Cleaner usage
if order.side.is_buy():
    # Handle buy order
    pass
```

### Use String Enum for API Compatibility

**Before:**

```python
from enum import Enum, unique

@unique
class OrderSide(Enum):
    BUY = "buy"
    SELL = "sell"

# Need to convert to string for API
api_data = {"side": order.side.value}
```

**After:**

```python
from enum import Enum, unique

@unique
class OrderSide(str, Enum):
    """
    Represents the side of an order.

    Inherits from str to allow direct string operations and JSON serialization.
    """

    BUY = "buy"
    SELL = "sell"

# Can use directly as string
api_data = {"side": order.side}  # Automatically serializes to "buy" or "sell"
```

### Add Properties for Computed Attributes

**Before:**

```python
from enum import Enum, unique

@unique
class HttpStatus(Enum):
    OK = 200
    BAD_REQUEST = 400
    INTERNAL_SERVER_ERROR = 500

# Repeated logic
if 200 <= status.value < 300:
    # Handle success
    pass
```

**After:**

```python
from enum import Enum, unique

@unique
class HttpStatus(Enum):
    """Represents HTTP status codes."""

    OK = 200
    BAD_REQUEST = 400
    INTERNAL_SERVER_ERROR = 500

    @property
    def is_success(self) -> bool:
        """
        Check if status code represents a successful response.

        Returns:
            bool: True if status is 2xx, False otherwise.
        """
        return 200 <= self.value < 300

# Cleaner usage
if status.is_success:
    # Handle success
    pass
```

---

## PYTHON-SPECIFIC BEST PRACTICES

### Use `@unique` Decorator

Always use `@unique` to prevent accidental duplicate values:

```python
from enum import Enum, unique

@unique
class Status(Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
```

### Use `auto()` for Meaningless Values

When values don't matter, use `auto()`:

```python
from enum import Enum, unique, auto

@unique
class Priority(Enum):
    LOW = auto()
    MEDIUM = auto()
    HIGH = auto()
```

### Use String Enum for API Compatibility

When enum values are strings and need to work with APIs, inherit from `str`:

```python
from enum import Enum, unique

@unique
class OrderSide(str, Enum):
    BUY = "buy"
    SELL = "sell"
```

### Add Methods for Enum-Related Behavior

Add methods that encapsulate behavior related to the enum:

```python
from enum import Enum, unique

@unique
class Timeframe(Enum):
    ONE_MINUTE = "1m"
    ONE_HOUR = "1h"

    def to_seconds(self) -> int:
        """Convert timeframe to seconds."""
        mapping = {"1m": 60, "1h": 3600}
        return mapping[self.value]
```

### Use Properties for Computed Attributes

Use `@property` for computed attributes:

```python
from enum import Enum, unique

@unique
class HttpStatus(Enum):
    OK = 200
    BAD_REQUEST = 400

    @property
    def is_success(self) -> bool:
        return 200 <= self.value < 300
```

### Order Members Logically

Order enum members alphabetically or by logical grouping:

```python
from enum import Enum, unique

@unique
class OrderStatus(Enum):
    """Order statuses in lifecycle order."""

    OPENING = "opening"  # First
    OPEN = "open"
    CLOSING = "closing"
    CLOSED = "closed"  # Last
    CANCELLED = "cancelled"  # Exception
```

### Document Enum Purpose

Always add a docstring explaining the enum's purpose:

```python
from enum import Enum, unique

@unique
class OrderStatus(Enum):
    """
    Represents the possible states of an order in the trading system.

    Orders progress through states: OPENING -> OPEN -> CLOSING -> CLOSED.
    CANCELLED can occur at any point before CLOSED.
    """
```

---

## WHEN TO USE ENUMS

### Use Enums When:

- You have a fixed set of related constants
- Values represent states, types, or categories
- You need type safety and IDE autocomplete
- Values are used in multiple places
- You want to prevent typos and magic strings

### Don't Use Enums When:

- Values change frequently (use configuration instead)
- You have hundreds of members (consider splitting)
- Values are not related to each other
- You need dynamic values at runtime

---

## INTEGRATION WITH TYPE CHECKERS

### mypy Configuration

Ensure enums work correctly with mypy:

```python
from enum import Enum, unique
from typing import Literal

@unique
class OrderStatus(Enum):
    OPEN = "open"
    CLOSED = "closed"

def process_status(status: OrderStatus) -> None:
    pass

# Type checker will catch errors
process_status("open")  # Error: Expected OrderStatus, got str
process_status(OrderStatus.OPEN)  # OK
```

### Type Narrowing

Use enums for better type narrowing:

```python
from enum import Enum, unique

@unique
class OrderStatus(Enum):
    OPEN = "open"
    CLOSED = "closed"

def handle_status(status: OrderStatus) -> None:
    if status == OrderStatus.OPEN:
        # Type checker knows status is OPEN here
        pass
    elif status == OrderStatus.CLOSED:
        # Type checker knows status is CLOSED here
        pass
```
