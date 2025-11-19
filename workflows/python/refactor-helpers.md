# Refactor Helpers Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Search for helper usage**: Search the codebase to find where the helper is used. This provides crucial context about:
   - How the helper function is imported and called
   - What parameters are commonly passed
   - Common patterns and operations performed with the helper
   - Integration points with other parts of the system
   - Edge cases and error handling needs
   - This context is essential for making informed refactoring decisions

**THEN, follow these specific rules for helper refactoring:**

- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (ruff, mypy)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar helpers** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete helper file
- [ ] **Search for helper usage** in the codebase to understand how it's used (imports, function calls, parameter patterns, return value usage)
- [ ] Identify code smells (missing type hints, no error handling, side effects, unclear naming)
- [ ] Check if helper should be pure function (no side effects) or can have side effects
- [ ] Verify function name follows naming conventions (snake_case, appropriate prefix)
- [ ] Check if helper needs to handle edge cases based on usage patterns found
- [ ] Review similar helpers in codebase for consistency
- [ ] Determine if helper belongs in generic `helpers/` or domain-specific `services/{domain}/helpers/`
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks

### Phase 2: Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Code review comment (if applicable)
  2. Imports (standard library first)
  3. Imports from third-party packages
  4. Imports from local modules
  5. Helper functions (one function per file, or grouped by theme)
- [ ] Verify helper is in correct location (`helpers/` for generic, `services/{domain}/helpers/` for domain-specific)
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "Helper structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Function Signature and Type Safety

- [ ] Add complete type hints to all parameters
- [ ] Add return type annotation
- [ ] Use `Optional` or `Union` types when values can be None or multiple types
- [ ] Use `Any` only when absolutely necessary (prefer specific types)
- [ ] Verify parameter names are descriptive and follow snake_case
- [ ] Check if default values are appropriate and well-typed
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no changes were needed (e.g., "All type hints were already complete")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Error Handling and Edge Cases

- [ ] Add handling for None values when appropriate
- [ ] Add handling for empty strings/lists when appropriate
- [ ] Add handling for invalid input types
- [ ] Return sensible default values on error (0, 0.0, None, empty string, etc.)
- [ ] Avoid raising exceptions unless absolutely necessary (prefer returning defaults)
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no error handling was needed (e.g., "Helper already handles all edge cases appropriately")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Function Purity and Side Effects

- [ ] Verify helper is a pure function (no side effects) when possible
- [ ] If side effects are necessary, document them clearly
- [ ] Avoid modifying input parameters (prefer returning new values)
- [ ] Avoid global state mutations unless necessary
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if side effects are intentional and necessary
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: Documentation (Docstrings)

- [ ] Add function-level docstring explaining purpose (Google style) if function is complex
- [ ] Document parameters with types and descriptions
- [ ] Document return value with type and description
- [ ] Add examples if function behavior is non-obvious
- [ ] Add notes about edge cases or special behavior
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if documentation was already complete or not needed (e.g., "Helper is simple and self-documenting, docstring not required")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: Export and Integration

- [ ] Verify helper is exported in `__init__.py` if in subdirectory
- [ ] Add helper to `__all__` list in `__init__.py` for explicit exports
- [ ] Verify imports work correctly from expected locations
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if export was already correct (e.g., "Helper was already properly exported")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 8: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Verify no linting errors (ruff, mypy)
- [ ] Review helper structure and consistency with codebase
- [ ] Confirm complete type annotations
- [ ] Verify error handling is appropriate
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

---

## HELPER FILE STRUCTURE

### Basic Helper (Simple Function)

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import Optional


def get_env(key: str, default: Optional[str] = None) -> str:
    return os.getenv(key, default)
```

### Helper with Error Handling

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import Any


def parse_int(value: Any) -> int:
    if value is None:
        return 0

    if isinstance(value, int):
        return value

    if isinstance(value, str):
        return int(float(value))

    return int(value)
```

### Helper with Complex Logic (with Docstring)

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import List


def get_sharpe_ratio(
    nav_history: List[float],
    risk_free_rate: float = 0.0,
) -> float:
    """
    Calculate Sharpe Ratio (annualized risk-adjusted return).

    Args:
        nav_history: List of Net Asset Values over time
        risk_free_rate: Risk-free rate as daily decimal (default 0.0)

    Returns:
        Annualized Sharpe Ratio
        Returns 0.0 if insufficient data or zero volatility

    Interpretation:
        Measures excess return per unit of total volatility
        > 3.0: Excellent risk-adjusted returns
        2.0-3.0: Very good
        1.0-2.0: Good
        0.0-1.0: Subpar
        < 0.0: Losing money with volatility
        Industry standard: > 1.0 is acceptable
    """
    returns = []
    min_observations = 2
    min_returns_for_variance = 2

    if len(nav_history) < min_observations:
        return 0.0

    for i in range(1, len(nav_history)):
        if nav_history[i - 1] == 0:
            continue

        previous_nav = nav_history[i - 1]
        current_nav = nav_history[i]
        daily_return = (current_nav - previous_nav) / previous_nav
        returns.append(daily_return)

    if len(returns) <= min_returns_for_variance:
        return 0.0

    mean_return = sum(returns) / len(returns)
    variance = sum((r - mean_return) ** 2 for r in returns) / (len(returns) - 1)
    std_dev = variance**0.5

    if std_dev == 0:
        return 0.0

    excess_return = mean_return - risk_free_rate
    days_per_year = 365
    annualization_factor = days_per_year**0.5

    return (excess_return / std_dev) * annualization_factor
```

### Helper Returning Tuple

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

from typing import Any, Optional, Tuple


def has_api_error(response: Any) -> Tuple[bool, Optional[str], Optional[int]]:
    if not isinstance(response, dict):
        return False, None, None

    if "code" not in response:
        return False, None, None

    error_msg = response.get("msg", "Unknown error")
    error_code = response.get("code")

    return True, error_msg, error_code
```

### Helper with Optional Parameters

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

import re
import unicodedata
from typing import Dict, Optional


def get_slug(
    title: str,
    separator: str = "-",
    dictionary: Optional[Dict[str, str]] = None,
) -> str:
    if dictionary is None:
        dictionary = {"@": "at"}

    title = ascii(title)
    flip = "_" if separator == "-" else "-"
    title = re.sub(rf"[{re.escape(flip)}]+", separator, title)

    dict_with_separators = {
        k: f"{separator}{v}{separator}" for k, v in dictionary.items()
    }
    for key, val in dict_with_separators.items():
        title = title.replace(key, val)

    title = title.lower()
    allowed = rf"[^{re.escape(separator)}\w\s]+"
    title = re.sub(allowed, "", title, flags=re.UNICODE)
    title = re.sub(rf"[{re.escape(separator)}\s]+", separator, title, flags=re.UNICODE)

    return title.strip(separator)
```

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Missing Type Hints

**Problem**: Function parameters and return values lack type annotations
**Solution**: Add complete type hints using `typing` module

### 2. No Error Handling

**Problem**: Function doesn't handle None, empty values, or invalid inputs
**Solution**: Add appropriate checks and return sensible defaults

### 3. Side Effects

**Problem**: Function modifies global state or input parameters
**Solution**: Make function pure (no side effects) when possible, or document side effects clearly

### 4. Unclear Naming

**Problem**: Function name doesn't clearly describe what it does
**Solution**: Use descriptive names with appropriate prefixes (`get_`, `parse_`, `has_`, `is_`)

### 5. Magic Values

**Problem**: Hard-coded values without explanation
**Solution**: Use named constants or parameters

### 6. Missing Default Values

**Problem**: Required parameters that should have defaults
**Solution**: Add sensible default values when appropriate

### 7. Wrong Location

**Problem**: Generic helper in domain-specific folder or vice versa
**Solution**: Move to correct location (`helpers/` for generic, `services/{domain}/helpers/` for domain-specific)

### 8. Missing Export

**Problem**: Helper not exported in `__init__.py` when in subdirectory
**Solution**: Add to `__init__.py` with `__all__` list

### 9. Overly Complex Function

**Problem**: Function does too many things
**Solution**: Split into smaller, focused functions

### 10. No Documentation for Complex Logic

**Problem**: Complex function lacks docstring explaining behavior
**Solution**: Add docstring with parameters, return value, and examples

---

## WHAT TO DO

### Structure and Organization

- Place generic helpers in `helpers/` directory
- Place domain-specific helpers in `services/{domain}/helpers/` directory
- One function per file, or group related functions in same file
- Order imports: standard library, third-party, local
- Add code review comment at top of file

### Naming

- Use `snake_case` for function names
- Use descriptive prefixes:
  - `get_*` for retrieving/returning values
  - `parse_*` for conversion/parsing
  - `has_*` for boolean checks
  - `is_*` for validation checks
  - `format_*` for formatting operations
  - `calculate_*` for calculations
- Use descriptive parameter names in `snake_case`

### Type Safety

- Add type hints to all parameters
- Add return type annotations
- Use `Optional[T]` for nullable values
- Use `Union[T, U]` for multiple possible types
- Avoid `Any` when specific type is known
- Use generic types (`List[T]`, `Dict[K, V]`) appropriately

### Error Handling

- Handle None values appropriately
- Handle empty strings/lists when relevant
- Return sensible defaults (0, 0.0, None, empty string)
- Avoid raising exceptions unless necessary
- Validate input types when needed

### Function Purity

- Prefer pure functions (no side effects)
- Don't modify input parameters
- Don't mutate global state
- Return new values instead of modifying existing ones
- Document side effects if they're necessary

### Documentation

- Add docstrings for complex functions (Google style)
- Document parameters with types and descriptions
- Document return values with types and descriptions
- Add examples for non-obvious behavior
- Note edge cases and special behavior

### Export

- Export helpers in `__init__.py` when in subdirectory
- Use `__all__` for explicit exports
- Re-export related helpers from other modules when appropriate

---

## WHAT NOT TO DO

### Structure

- DO NOT mix generic and domain-specific helpers
- DO NOT create helpers with too many responsibilities
- DO NOT omit type hints
- DO NOT place helpers in wrong directory

### Naming

- DO NOT use camelCase or PascalCase for functions
- DO NOT use abbreviations unless widely understood
- DO NOT use vague names like `process`, `handle`, `do`
- DO NOT use single-letter parameter names

### Type Safety

- DO NOT omit type hints
- DO NOT use `Any` when specific type is known
- DO NOT omit return type annotations
- DO NOT use untyped parameters

### Error Handling

- DO NOT raise exceptions for common edge cases
- DO NOT ignore None values when they're possible
- DO NOT return None when 0 or empty string is more appropriate
- DO NOT crash on invalid input without handling

### Function Purity

- DO NOT modify input parameters
- DO NOT mutate global state unnecessarily
- DO NOT create functions with hidden side effects
- DO NOT mix pure and impure operations

### Documentation

- DO NOT add docstrings for trivial functions
- DO NOT omit docstrings for complex functions
- DO NOT write obvious comments that repeat the code
- DO NOT use comments as excuse for unclear code

### Code Quality

- DO NOT create helpers that do too many things
- DO NOT duplicate logic that exists elsewhere
- DO NOT create helpers that are only used once
- DO NOT mix business logic with utility functions

---

## NAMING RULES

### Function Names

- Use `snake_case`: `get_env`, `parse_int`, `has_api_error`
- Use descriptive prefixes:
  - `get_*`: Retrieve/return values (`get_env`, `get_duration`)
  - `parse_*`: Convert/parse values (`parse_int`, `parse_float`)
  - `has_*`: Boolean checks (`has_api_error`, `has_permission`)
  - `is_*`: Validation checks (`is_valid`, `is_empty`)
  - `format_*`: Formatting operations (`format_currency`, `format_date`)
  - `calculate_*`: Calculations (`calculate_total`, `calculate_average`)
  - `convert_*`: Type conversions (`convert_to_int`, `convert_to_string`)
- Be descriptive: `get_user_by_id` not `get_user`
- Avoid abbreviations unless widely understood

### Parameter Names

- Use `snake_case`: `user_id`, `start_date`, `risk_free_rate`
- Be descriptive: `nav_history` not `nav` or `data`
- Use full words: `separator` not `sep`
- Avoid single letters except for common conventions (`i`, `j` for loops)

### File Names

- Use `snake_case`: `get_env.py`, `parse.py`, `has_api_error.py`
- Match function name when one function per file: `get_env.py` contains `get_env()`
- Use descriptive names for multi-function files: `parse.py` contains parsing functions

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Helper in correct location (`helpers/` or `services/{domain}/helpers/`)
- [ ] Imports ordered correctly (standard, third-party, local)
- [ ] Code review comment at top of file
- [ ] One function per file or logical grouping

### Naming

- [ ] Function name in `snake_case` with appropriate prefix
- [ ] Parameter names descriptive and in `snake_case`
- [ ] File name matches function name or is descriptive

### Type Safety

- [ ] All parameters have type hints
- [ ] Return type annotation present
- [ ] `Optional` used for nullable values
- [ ] `Union` used for multiple types when needed
- [ ] `Any` avoided when specific type is known

### Error Handling

- [ ] None values handled appropriately
- [ ] Empty values handled when relevant
- [ ] Invalid input types handled
- [ ] Sensible defaults returned on error
- [ ] Exceptions only raised when necessary

### Function Purity

- [ ] Function is pure (no side effects) when possible
- [ ] Input parameters not modified
- [ ] Global state not mutated unnecessarily
- [ ] Side effects documented if necessary

### Documentation

- [ ] Docstring present for complex functions (Google style)
- [ ] Parameters documented with types
- [ ] Return value documented with type
- [ ] Examples included for non-obvious behavior
- [ ] Edge cases noted

### Export

- [ ] Helper exported in `__init__.py` if in subdirectory
- [ ] `__all__` list includes helper
- [ ] Imports work from expected locations

### Testing

- [ ] All tests pass
- [ ] No linting errors (ruff, mypy)
- [ ] Helper is maintainable and readable

---

## FINAL OBJECTIVE

A helper file must be:

- **Organized**: Clear structure with proper import ordering
- **Typed**: Complete type annotations on parameters and return values
- **Safe**: Handles edge cases and errors gracefully
- **Pure**: No side effects when possible, documented when necessary
- **Documented**: Docstrings for complex functions (Google style)
- **Named**: Descriptive names following conventions with appropriate prefixes
- **Located**: In correct directory (generic vs domain-specific)
- **Exported**: Properly exported in `__init__.py` when in subdirectory
- **Maintainable**: Easy to understand, test, and extend

---

## COMMON REFACTORING PATTERNS

### Add Type Hints

**Before:**

```python
def parse_int(value):
    if value is None:
        return 0
    return int(value)
```

**After:**

```python
from typing import Any


def parse_int(value: Any) -> int:
    if value is None:
        return 0
    return int(value)
```

### Add Error Handling

**Before:**

```python
def get_duration(start_at, end_at):
    total_seconds = (end_at - start_at).total_seconds()
    return f"{total_seconds} seconds"
```

**After:**

```python
import datetime


def get_duration(start_at: datetime.datetime, end_at: datetime.datetime) -> str:
    total_seconds = (end_at - start_at).total_seconds()
    seconds_in_minute = 60
    seconds_in_hour = 3600
    seconds_in_day = 86400

    if total_seconds < seconds_in_minute:
        seconds = int(total_seconds)
        return f"{seconds} seconds"

    if total_seconds < seconds_in_hour:
        minutes = int(total_seconds / seconds_in_minute)
        return f"{minutes} minutes"

    if total_seconds < seconds_in_day:
        hours = int(total_seconds / seconds_in_hour)
        return f"{hours} hours"

    days = int(total_seconds / seconds_in_day)
    return f"{days} days"
```

### Fix Naming Convention

**Before:**

```python
def GetUserData(userId):
    # Implementation
    pass
```

**After:**

```python
from typing import Optional


def get_user_data(user_id: str) -> Optional[dict]:
    # Implementation
    pass
```

### Add Default Values

**Before:**

```python
def get_slug(title, separator, dictionary):
    # Implementation
    pass
```

**After:**

```python
from typing import Dict, Optional


def get_slug(
    title: str,
    separator: str = "-",
    dictionary: Optional[Dict[str, str]] = None,
) -> str:
    if dictionary is None:
        dictionary = {"@": "at"}
    # Implementation
    pass
```

### Make Function Pure

**Before:**

```python
result_list = []

def process_data(data):
    result_list.append(data)
    return len(result_list)
```

**After:**

```python
from typing import List


def process_data(data: str, existing_results: List[str]) -> List[str]:
    return existing_results + [data]
```

### Add Docstring for Complex Function

**Before:**

```python
def get_sharpe_ratio(nav_history, risk_free_rate=0.0):
    # Complex calculation logic
    return result
```

**After:**

```python
from typing import List


def get_sharpe_ratio(
    nav_history: List[float],
    risk_free_rate: float = 0.0,
) -> float:
    """
    Calculate Sharpe Ratio (annualized risk-adjusted return).

    Args:
        nav_history: List of Net Asset Values over time
        risk_free_rate: Risk-free rate as daily decimal (default 0.0)

    Returns:
        Annualized Sharpe Ratio
        Returns 0.0 if insufficient data or zero volatility
    """
    # Complex calculation logic
    return result
```

### Export Helper in __init__.py

**Before:**

```python
# services/gateway/helpers/__init__.py
# Empty file
```

**After:**

```python
# services/gateway/helpers/__init__.py
from .has_api_error import has_api_error

__all__ = [
    "has_api_error",
]
```

---

## PYTHON-SPECIFIC BEST PRACTICES

### Use Type Hints

Always add type hints for better IDE support and type checking:

```python
from typing import Optional


def get_env(key: str, default: Optional[str] = None) -> str:
    return os.getenv(key, default)
```

### Handle Edge Cases Gracefully

Return sensible defaults instead of raising exceptions:

```python
from typing import Any


def parse_int(value: Any) -> int:
    if value is None:
        return 0

    if isinstance(value, int):
        return value

    if isinstance(value, str):
        try:
            return int(float(value))
        except (ValueError, TypeError):
            return 0

    try:
        return int(value)
    except (ValueError, TypeError):
        return 0
```

### Use Appropriate Prefixes

Choose prefixes that clearly indicate function purpose:

```python
# Retrieval
def get_user_by_id(user_id: str) -> Optional[dict]:
    pass

# Parsing/Conversion
def parse_float(value: Any) -> float:
    pass

# Boolean checks
def has_permission(user: dict, permission: str) -> bool:
    pass

# Validation
def is_valid_email(email: str) -> bool:
    pass

# Formatting
def format_currency(amount: float, currency: str = "USD") -> str:
    pass
```

### Prefer Pure Functions

Make functions pure (no side effects) when possible:

```python
# Good: Pure function
def calculate_total(prices: List[float]) -> float:
    return sum(prices)

# Bad: Side effects
total = 0
def calculate_total(prices: List[float]) -> float:
    global total
    total = sum(prices)
    return total
```

### Use Optional for Nullable Values

Use `Optional[T]` when values can be None:

```python
from typing import Optional


def get_user_by_id(user_id: str) -> Optional[dict]:
    # Returns dict or None
    pass
```

### Group Related Helpers

Group related functions in the same file:

```python
# helpers/parse.py
def parse_int(value: Any) -> int:
    pass

def parse_float(value: Any) -> float:
    pass

def parse_optional_float(value: Any) -> Optional[float]:
    pass
```

### Document Complex Functions

Add docstrings for functions with non-obvious behavior:

```python
def get_sharpe_ratio(
    nav_history: List[float],
    risk_free_rate: float = 0.0,
) -> float:
    """
    Calculate Sharpe Ratio (annualized risk-adjusted return).

    Args:
        nav_history: List of Net Asset Values over time
        risk_free_rate: Risk-free rate as daily decimal (default 0.0)

    Returns:
        Annualized Sharpe Ratio
        Returns 0.0 if insufficient data or zero volatility
    """
    # Implementation
    pass
```

### Export Helpers Properly

Use `__all__` for explicit exports:

```python
# services/gateway/helpers/__init__.py
from helpers.parse import (
    parse_float,
    parse_int,
    parse_optional_float,
)
from .has_api_error import has_api_error

__all__ = [
    "has_api_error",
    "parse_int",
    "parse_float",
    "parse_optional_float",
]
```

---

## WHEN TO USE HELPERS

### Use Helpers When:

- Function is reusable across multiple modules
- Function performs a single, well-defined task
- Function is a pure transformation (input -> output)
- Function encapsulates common utility logic
- Function handles edge cases that would be repeated

### Don't Use Helpers When:

- Function is only used in one place (consider inline)
- Function contains complex business logic (use service class)
- Function requires state management (use class)
- Function is tightly coupled to specific domain (use domain service)
- Function would be better as a method of a class

---

## HELPER LOCATION GUIDELINES

### Generic Helpers (`helpers/`)

Place in `helpers/` when:
- Function is used across multiple domains/services
- Function is a general utility (parsing, formatting, validation)
- Function has no domain-specific knowledge
- Function is framework-agnostic

Examples:
- `parse.py` - Generic parsing functions
- `get_env.py` - Environment variable access
- `get_slug.py` - URL slug generation
- `get_duration.py` - Time formatting

### Domain-Specific Helpers (`services/{domain}/helpers/`)

Place in `services/{domain}/helpers/` when:
- Function is specific to one domain/service
- Function uses domain-specific types or interfaces
- Function implements domain-specific logic
- Function is only used within that domain

Examples:
- `services/gateway/helpers/has_api_error.py` - Gateway-specific error checking
- `services/analytic/helpers/get_sharpe_ratio.py` - Financial calculation
- `services/strategy/helpers/get_truncated_timeframe.py` - Strategy-specific logic

---

## INTEGRATION WITH TYPE CHECKERS

### mypy Configuration

Ensure helpers work correctly with mypy:

```python
from typing import Optional


def get_user_by_id(user_id: str) -> Optional[dict]:
    # Implementation
    pass

# Type checker will catch errors
user = get_user_by_id(123)  # Error: Expected str, got int
user = get_user_by_id("123")  # OK, returns Optional[dict]

if user:
    # Type checker knows user is dict here
    name = user.get("name")
```

### Type Narrowing

Use type hints for better type narrowing:

```python
from typing import Optional


def parse_optional_float(value: Any) -> Optional[float]:
    if value is None or value == "":
        return None
    # Type checker knows value is not None here
    return float(value)

result = parse_optional_float("123.45")
if result is not None:
    # Type checker knows result is float here
    total = result * 2
```

