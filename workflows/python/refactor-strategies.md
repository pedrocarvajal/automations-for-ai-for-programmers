# Refactor Strategies Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Read task notes standard**: Read `standards/task-notes.md` for code review comment format.

2. **Review similar refactoring guides**: Check `workflows/python/refactor-helpers.md` and `workflows/python/refactor-classes.md` for patterns and consistency.

3. **Search for strategy usage**: Search the codebase to find where the strategy is used. This provides crucial context about:
   - How the strategy is imported and instantiated
   - What methods are commonly called
   - Common patterns and usage scenarios
   - Integration points with other parts of the system
   - Edge cases and error handling needs
   - This context is essential for making informed refactoring decisions

4. **Review StrategyService base class**: Check `services/strategy/__init__.py` to understand which methods are framework methods that are already documented in the base class.

**THEN, follow these specific rules for strategy refactoring:**

- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (ruff, mypy)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar strategies** in the codebase and follow the same pattern (structure, naming conventions, documentation style)
- **CRITICAL**: Do NOT add docstrings to framework methods (`on_tick`, `on_new_minute`, `on_new_hour`, `on_new_day`, `on_new_week`, `on_new_month`, `on_transaction`, `on_end`) unless they contain complex logic that is not obvious from the code. These methods are already documented in `StrategyService` base class.

---

## CRITICAL RULES (NEVER VIOLATE)

- **NEVER** modify public method signatures without searching for all usages first
- **NEVER** remove a method without checking if it's used elsewhere
- **NEVER** change return types without updating all callers
- **NEVER** skip running tests between phases
- **NEVER** proceed to next phase if current phase has failing tests
- **NEVER** make changes silently - always explain what was changed and why
- **NEVER** ignore linting errors - fix them immediately
- **NEVER** add docstrings to simple framework method overrides (methods that just call `super()` and add simple logic)
- **ALWAYS** search codebase before making structural changes
- **ALWAYS** verify tests pass after each phase
- **ALWAYS** explain why a task was skipped
- **ALWAYS** wait for user confirmation before proceeding to next phase
- **ALWAYS** present a clear plan before starting refactoring

---

## FRAMEWORK METHODS (DO NOT DOCUMENT UNLESS COMPLEX)

The following methods are inherited from `StrategyService` and are already documented in the base class. **DO NOT add docstrings** to these methods unless they contain complex logic that is not obvious:

- `on_tick(self, tick: TickModel) -> None` - Handle new market tick
- `on_new_minute(self) -> None` - Handle new minute event
- `on_new_hour(self) -> None` - Handle new hour event
- `on_new_day(self) -> None` - Handle new day event
- `on_new_week(self) -> None` - Handle new week event
- `on_new_month(self) -> None` - Handle new month event
- `on_transaction(self, order: OrderModel) -> None` - Handle transaction event
- `on_end(self) -> None` - Handle end of strategy execution

**When to document framework methods:**
- Only if the method contains complex logic that is not obvious
- Only if the method has non-standard behavior that differs significantly from the base implementation
- Only if the method requires explanation of strategy-specific logic

**When NOT to document framework methods:**
- If the method just calls `super()` and assigns a value (e.g., `self._tick = tick`)
- If the method just calls `super()` and then calls a private method
- If the method's behavior is obvious from the code

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

1. **VERIFY**: Read the complete strategy file
2. **VERIFY**: Run existing tests to establish baseline (all tests must pass before starting)
3. **SEARCH**: Search for strategy usage in codebase:
   - Use `grep` or `codebase_search` to find all imports: `grep -r "from.*import.*StrategyName"` or `grep -r "import.*StrategyName"`
   - Find all instantiations: `grep -r "StrategyName("`
   - Find all method calls: `grep -r "\.method_name("`
   - Identify integration points and dependencies
4. **SEARCH**: Find similar strategies in codebase to understand patterns and conventions
5. **REVIEW**: Check `services/strategy/__init__.py` to identify framework methods
6. **ANALYZE**: Identify code smells (long methods, duplication, primitive obsession, feature envy)
7. **ANALYZE**: Identify responsibilities (SRP violations)
8. **ANALYZE**: Identify dependencies that need injection
9. **PLAN**: Create refactoring plan with:
   - List of code smells to fix
   - Dependencies to inject
   - Methods to extract/refactor
   - Framework methods that need documentation (if any)
   - Estimated impact (files that will need updates)
   - Risk assessment
10. **PRESENT**: Present the plan to the user using the format in "EXAMPLE: Presenting Analysis Plan" section
11. **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
12. **EXPLAIN** any skipped tasks

### Phase 2: Dependency Injection

**Execute in this exact order:**

1. **VERIFY**: No tests are broken before starting (run tests first)
2. **VERIFY**: Current strategy structure is understood
3. **ANALYZE**: List all current dependencies (imports, instantiations)
4. **ANALYZE**: Check if dependencies are already injected (constructor parameters)
5. **ANALYZE**: Identify which dependencies should be injected vs created internally:
   - Used in multiple methods → should be injected
   - Needs to be mockable for testing → should be injected
   - Is a service/repository → should be injected
   - Is a simple value/config → can be created internally
   - **CRITICAL**: Services like `LoggingService` should be instantiated directly inside the constructor, NOT injected as parameters
6. **REFACTOR**: For each dependency to inject:
   - Add parameter to `__init__`
   - Store as private attribute (prefixed with `_`)
   - Remove direct instantiation
   - Update all callers if needed (check from Phase 1 search)
7. **REFACTOR**: For services that should be created internally (like LoggingService):
   - Keep instantiation inside the constructor
   - Do NOT add as constructor parameter
   - Do NOT make it optional/injectable
8. **VERIFY**: All existing tests still pass
9. **VERIFY**: No new linting errors introduced
10. **VERIFY**: Dependency injection works correctly
11. **EXPLAIN** if any dependency injection tasks were skipped (e.g., "No dependencies needed injection, strategy has no dependencies")
12. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Strategy Structure and Organization

**Execute in this exact order:**

1. **VERIFY**: All tests pass before starting
2. **REORGANIZE**: Imports (standard library → third-party → local)
3. **REORGANIZE**: Add class-level docstring (if missing) explaining the strategy's trading logic
4. **REORGANIZE**: Class properties/attributes with blank lines separating blocks:
   - Mandatory variables (from StrategyService base class: `_enabled`, `_name`)
   - Class variables (strategy-specific: `_settings`, `_tick`, etc.)
   - Dependency injections (services: `_log`, etc.)
5. **REORGANIZE**: Methods in order:
   - Constructor (`__init__`)
   - Framework methods (on_tick, on_new_minute, etc.) - only if overridden
   - Public methods (custom methods)
   - Protected methods (`_method`)
   - Private methods (`__method`)
6. **REORGANIZE**: Group related methods together by functionality
7. **FORMAT**: Add section separators (`# ───────────────────────────────────────────────────────────`)
8. **VERIFY**: All tests still pass
9. **VERIFY**: No linting errors introduced
10. **EXPLAIN** if structure was already correct (e.g., "Strategy structure was already organized correctly, no changes needed")
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
2. **ADD**: Class-level docstring with concise trading rules (Entry Rules, Exit Rules, Special Conditions) if missing
   - **DO NOT** include Attributes section or implementation details
   - **DO** focus on what the strategy does, not how it's implemented
   - **DO** explain entry conditions, exit conditions, and special behaviors
3. **EVALUATE**: Constructor docstring:
   - **DO NOT** add docstring to constructor unless it has non-standard behavior
   - Constructor behavior is obvious from the code (calls super, sets up logging, initializes settings)
4. **EVALUATE**: For each framework method override:
   - If method only calls `super()` and assigns values → **DO NOT add docstring**
   - If method only calls `super()` and then calls a private method → **DO NOT add docstring**
   - If method contains complex logic → **ADD docstring** explaining the complex behavior
4. **ADD**: Docstrings to all custom public methods (required)
5. **ADD**: Docstrings to protected methods (recommended)
6. **ADD**: Docstrings to complex private methods (if behavior is non-obvious)
7. **VERIFY**: All docstrings include:
   - `Args:` section with parameter descriptions (if method has parameters)
   - `Returns:` section with return type and description (if method returns something)
   - `Raises:` section if method raises exceptions
   - `Example:` section for complex methods
8. **VERIFY**: No linting errors
9. **EXPLAIN** if documentation was already complete or framework methods were correctly skipped (e.g., "Framework methods correctly skipped, custom methods already have complete docstrings")
10. **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

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
5. **VERIFY**: Framework methods do NOT have docstrings (unless complex logic)
6. **VERIFY**: All custom public methods have docstrings
7. **VERIFY**: All methods have type hints and return types
8. **VERIFY**: Dependencies are injected (no direct instantiation of services/repositories, except LoggingService)
9. **VERIFY**: Methods are < 50 lines each
10. **VERIFY**: No code duplication detected
11. **VERIFY**: Section separators present
12. **REVIEW**: Code structure and navigability
13. **REVIEW**: Complete documentation (framework methods correctly skipped)
14. **EXPLAIN** any verification issues found and how they were resolved
15. **PRESENT**: Final summary with all changes made
16. **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

---

## STRATEGY FILE STRUCTURE

### Example Strategy

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}

import datetime
from typing import Any, Dict, Optional

from enums.order_side import OrderSide
from enums.order_status import OrderStatus
from models.order import OrderModel
from models.tick import TickModel
from services.logging import LoggingService
from services.strategy import StrategyService


class MyStrategy(StrategyService):
    """
    Brief strategy description.

    Entry Rules:
    - Condition 1 for entering trades
    - Condition 2 for entering trades
    - Any additional entry requirements

    Exit Rules:
    - Take profit condition
    - Stop loss condition
    - Trailing stop or other exit mechanisms

    Special Conditions:
    - Any special behaviors (e.g., closes existing orders before opening new ones)
    - Risk management rules
    - Position sizing rules
    """

    # ───────────────────────────────────────────────────────────
    # PROPERTIES
    # ───────────────────────────────────────────────────────────
    # Mandatory variables (from StrategyService base class)
    _enabled = True
    _name = "MyStrategy"

    # Class variables
    _settings: Dict[str, Any]
    _tick: Optional[TickModel]

    # Dependency injections
    _log: LoggingService

    # ───────────────────────────────────────────────────────────
    # CONSTRUCTOR
    # ───────────────────────────────────────────────────────────
    def __init__(self, **kwargs: Any) -> None:
        super().__init__(**kwargs)
        self._log = LoggingService()
        self._log.setup("my_strategy")

        self._settings = kwargs.get("settings", {})
        self._tick = None

    # ───────────────────────────────────────────────────────────
    # PUBLIC METHODS (Framework Methods - Only override if needed)
    # ───────────────────────────────────────────────────────────
    def on_tick(self, tick: TickModel) -> None:
        super().on_tick(tick)
        self._tick = tick

    def on_new_minute(self) -> None:
        super().on_new_minute()
        self._check_entry_conditions()

    def on_transaction(self, order: OrderModel) -> None:
        super().on_transaction(order)

        if order.status.is_open():
            self._log.info(f"Order: {order.id}, was opened.")

        if order.status.is_closed():
            self._handle_order_closed(order)

    # ───────────────────────────────────────────────────────────
    # PRIVATE METHODS
    # ───────────────────────────────────────────────────────────
    def _check_entry_conditions(self) -> None:
        """
        Check if entry conditions are met and open order if needed.

        Validates market conditions and opens a new order if all
        criteria are satisfied.
        """
        if not self._tick:
            return

        if not self._should_open_order():
            return

        self._open_order()

    def _should_open_order(self) -> bool:
        """
        Determine if conditions are met to open a new order.

        Returns:
            True if order should be opened, False otherwise.
        """
        # Implementation
        return True

    def _open_order(self) -> None:
        """
        Open a new trading order with calculated parameters.

        Calculates order prices and volume, then opens the order
        through the orderbook handler.
        """
        # Implementation
        pass

    def _handle_order_closed(self, order: OrderModel) -> None:
        """
        Handle logic when an order is closed.

        Args:
            order: The closed order model.
        """
        profit = order.profit
        self._log.info(f"Order: {order.id}, closed with profit: {profit:.2f}")
```

**Key Points:**
- Class-level docstring is concise and focused on trading rules (Entry Rules, Exit Rules, Special Conditions)
- Constructor does NOT have docstring (behavior is obvious from code)
- Framework methods (`on_tick`, `on_new_minute`, `on_transaction`) do NOT have docstrings because they only call `super()` and add simple logic
- Custom private methods (`_check_entry_conditions`, `_should_open_order`, etc.) HAVE docstrings because they contain strategy-specific logic

---

## EXAMPLE: Presenting Analysis Plan

When presenting the refactoring plan to user, use this format:

```
## Refactoring Plan for MyStrategy

### Code Smells Identified:
1. **Long Method**: `_check_entry_conditions()` (87 lines) → Extract into 4 methods:
   - `_validate_market_conditions()`
   - `_calculate_entry_price()`
   - `_calculate_risk_parameters()`
   - `_execute_order()`

2. **Code Duplication**: Price calculation logic repeated 3 times → Extract to `_calculate_order_prices()`

3. **Primitive Obsession**: Status checks as string comparisons → Use OrderStatus enum methods

### Dependencies to Inject:
- None (LoggingService correctly instantiated internally ✓)

### Methods to Extract:
- `_check_entry_conditions()` → 4 smaller methods (see above)
- `_calculate_order_prices()` → Extract from duplicated code

### Framework Methods Documentation:
- `on_tick()` - No docstring needed (only calls super() and assigns tick)
- `on_new_minute()` - No docstring needed (only calls super() and private method)
- `on_transaction()` - No docstring needed (only calls super() and simple logic)

### Proposed Changes:
- Extract 4 methods from `_check_entry_conditions()`
- Extract `_calculate_order_prices()` helper method
- Add class-level docstring explaining strategy logic
- Add docstrings to custom private methods

### Files That Will Need Updates:
- `strategies/my_strategy/__init__.py` (main refactoring)
- No other files (no API signature changes)

### Risk Assessment:
- **Low Risk**: Method extraction (internal refactoring)
- **Low Risk**: Documentation additions (non-breaking)

### Estimated Impact:
- 1 file will be updated
- No breaking changes expected
- All existing tests should pass

**Proceed with this plan? [Y/N]**
```

---

## SUCCESS CRITERIA

A refactored strategy is considered successful when:

- [ ] **All tests pass** (100% pass rate, zero failures)
- [ ] **Zero linting errors** (ruff, mypy - strict mode)
- [ ] **Class-level docstring present** (Google style, explains trading logic)
- [ ] **Framework methods do NOT have docstrings** (unless complex logic)
- [ ] **All custom public methods have docstrings** (Google style, complete)
- [ ] **All methods have type hints** (parameters and return types)
- [ ] **Dependencies are injected** (no direct instantiation except LoggingService)
- [ ] **Methods are < 50 lines each** (ideally < 30 lines)
- [ ] **No code duplication** (DRY principle applied)
- [ ] **Structure follows recommended order** (imports → docstring → properties → constructor → framework methods → custom methods → private methods)
- [ ] **Properties organized with blank lines** (Mandatory variables → Class variables → Dependency injections)
- [ ] **Section separators present** (clear navigation)
- [ ] **Code review comment added** (at beginning of file)
- [ ] **Single Responsibility Principle applied** (strategy has one clear purpose)
- [ ] **No code smells** (as identified in Phase 1)

---

## COMMON ERRORS TO AVOID

### Error 1: Verbose Class-Level Docstrings

**Problem**: Adding verbose class-level docstrings with Attributes sections or implementation details
**Prevention**:
- Focus on trading rules (Entry Rules, Exit Rules, Special Conditions)
- Do NOT include Attributes section (implementation detail)
- Do NOT include implementation details (how it works internally)
- Keep it concise and focused on what the strategy does

**Example:**

```python
# Bad: Verbose docstring with Attributes and implementation details
class MyStrategy(StrategyService):
    """
    Trading strategy description.

    This strategy implements [brief description of trading logic]:
    - Key feature 1
    - Key feature 2

    Attributes:
        _enabled: Whether the strategy is enabled (default: True).
        _name: Strategy name identifier.
        _settings: Dictionary containing strategy configuration parameters.
        _tick: Current market tick data.
        _log: Logging service instance for logging operations.
    """

# Good: Concise docstring focused on trading rules
class MyStrategy(StrategyService):
    """
    Brief strategy description.

    Entry Rules:
    - Condition 1 for entering trades
    - Condition 2 for entering trades

    Exit Rules:
    - Take profit condition
    - Stop loss condition

    Special Conditions:
    - Any special behaviors or risk management rules
    """
```

### Error 2: Documenting Constructor

**Problem**: Adding docstring to constructor when behavior is obvious
**Prevention**:
- Constructor behavior is obvious from code (calls super, sets up logging, initializes settings)
- Only add docstring if constructor has non-standard behavior
- Do NOT document kwargs that are passed to parent class

**Example:**

```python
# Bad: Unnecessary constructor docstring
def __init__(self, **kwargs: Any) -> None:
    """
    Initialize the strategy.

    Args:
        **kwargs: Additional keyword arguments passed to parent class:
            id: Unique identifier for the strategy.
            allocation: Capital allocation for this strategy.
            leverage: Leverage multiplier for trading.
            enabled: Whether the strategy is enabled.
            settings: Optional dictionary with strategy settings.
    """
    super().__init__(**kwargs)
    self._log = LoggingService()
    self._log.setup("my_strategy")
    self._settings = kwargs.get("settings", {})

# Good: No docstring needed, behavior is obvious
def __init__(self, **kwargs: Any) -> None:
    super().__init__(**kwargs)
    self._log = LoggingService()
    self._log.setup("my_strategy")
    self._settings = kwargs.get("settings", {})
```

### Error 3: Documenting Simple Framework Methods

**Problem**: Adding docstrings to framework methods that only call `super()` and add simple logic
**Prevention**:
- Check if method only calls `super()` and assigns values → No docstring needed
- Check if method only calls `super()` and then calls a private method → No docstring needed
- Only add docstring if method contains complex logic that needs explanation
- Review `StrategyService` base class to see existing documentation

**Example:**

```python
# Bad: Unnecessary docstring for simple override
def on_tick(self, tick: TickModel) -> None:
    """
    Handle a new market tick event.

    Updates the current tick data for use in order decision logic.

    Args:
        tick: The current market tick data.
    """
    super().on_tick(tick)
    self._tick = tick

# Good: No docstring needed, behavior is obvious
def on_tick(self, tick: TickModel) -> None:
    super().on_tick(tick)
    self._tick = tick
```

### Error 2: Breaking Existing Tests

**Problem**: Refactoring breaks existing functionality
**Prevention**:
- Run tests BEFORE starting each phase
- Run tests AFTER completing each phase
- If tests fail, STOP and fix before continuing
- Never skip test verification

### Error 3: Changing Public API Without Review

**Problem**: Modifying method signatures without considering callers
**Prevention**:
- Search codebase for all usages first (Phase 1)
- Present API changes to user before implementing
- Update all callers in same phase if signature changes
- Never change return types without updating callers

### Error 4: Incomplete Type Hints

**Problem**: Adding `Any` types instead of specific types
**Prevention**:
- Use `grep` to find actual types used in codebase
- Check return types of dependencies
- Use `Union` or `Optional` when appropriate
- Verify with mypy strict mode

### Error 5: Skipping Validation Steps

**Problem**: Not verifying tests/linting between phases
**Prevention**:
- Always run tests after each phase
- Always verify linting after each phase
- Never proceed if validation fails
- Document all verification steps

### Error 6: Not Searching for Usage

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

### 2. Code Duplication

**Problem**: Same code repeated in multiple places
**Solution**: Extract to private methods, use helper functions

### 3. Primitive Obsession

**Problem**: Using primitives instead of value objects/enums
**Solution**: Use enum methods (e.g., `order.status.is_open()` instead of `order.status == "open"`)

### 4. Feature Envy

**Problem**: Method accesses data from another object more than its own
**Solution**: Move method to the object it's accessing

### 5. Data Clumps

**Problem**: Groups of data passed together repeatedly
**Solution**: Create dataclasses or Pydantic models

### 6. Magic Numbers/Strings

**Problem**: Hard-coded values without explanation
**Solution**: Use named constants or settings dictionary

---

## WHAT TO DO

### Structure and Organization

- Use section separators (`# ───────────────────────────────────────────────────────────`) for clear navigation
- Organize properties with blank lines separating blocks:
  - Mandatory variables (from StrategyService base class: `_enabled`, `_name`)
  - Class variables (strategy-specific: `_settings`, `_tick`, etc.)
  - Dependency injections (services: `_log`, etc.)
- Organize methods: Constructor → Framework Methods → Custom Public → Protected → Private
- Group related methods together
- Keep methods focused on single responsibility
- Use descriptive method and variable names (snake_case)

### Dependency Injection

- Use constructor injection (pass dependencies to `__init__`) for dependencies that need to be mockable or swapped
- Store dependencies as private attributes (prefixed with `_`)
- **CRITICAL**: Services like `LoggingService` should be instantiated directly inside the constructor, NOT injected as parameters
- Avoid direct instantiation (`Class()`) for dependencies that need to be mockable

### Documentation

- Add concise class-level docstring with trading rules (Entry Rules, Exit Rules, Special Conditions)
- **DO NOT** include Attributes section or implementation details in class docstring
- **DO NOT** add docstring to constructor (behavior is obvious from code)
- **DO NOT** add docstrings to framework methods unless they contain complex logic
- Document all custom public methods with complete docstrings
- Document protected and complex private methods
- Include `Args:`, `Returns:`, `Raises:` where applicable
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

---

## WHAT NOT TO DO

### Documentation

- **DO NOT** add verbose class-level docstrings with Attributes sections or implementation details
- **DO NOT** add docstring to constructor (behavior is obvious from code)
- **DO NOT** add docstrings to framework methods that only call `super()` and add simple logic
- **DO NOT** add docstrings to methods whose behavior is obvious from the code
- **DO NOT** add obvious comments that repeat the code
- **DO NOT** comment every line of code
- **DO NOT** use comments as an excuse for unclear names

### Structure

- DO NOT mix properties without blank line separators
- DO NOT omit blank lines between property blocks (Mandatory variables, Class variables, Dependency injections)
- DO NOT mix framework methods and custom methods randomly
- DO NOT put helpers before framework methods
- DO NOT omit section separators
- DO NOT create god classes with too many responsibilities

### Dependency Injection

- DO NOT inject `LoggingService` as constructor parameter - instantiate it directly inside the constructor
- DO NOT use global state or singletons unnecessarily
- DO NOT use class methods for dependencies when instance methods are appropriate

### Code Quality

- DO NOT create methods longer than 50 lines
- DO NOT duplicate code - extract to methods or helper functions
- DO NOT use magic numbers - use constants or settings dictionary
- DO NOT use magic strings - use enums or constants

### Type Safety

- DO NOT omit type hints on parameters
- DO NOT omit return types
- DO NOT use `Any` when a specific type is known
- DO NOT use `Dict` or `List` without specifying value types when possible (`Dict[str, int]`)

---

## NAMING RULES

### Classes

- **Strategies**: `{Name}Strategy` (e.g., `EMA5BreakoutStrategy`, `TestStrategy`)
- Use PascalCase

### Methods

- **Custom methods**: Use descriptive verbs (`_check_entry_conditions`, `_calculate_order_prices`)
- Use snake_case
- Be descriptive: `_calculate_order_volume()` not `_calc_vol()`

### Variables

- Use snake_case
- Be descriptive: `current_price` not `price`
- Use plural for collections: `open_orders` not `order_list`
- Prefix private attributes with `_`: `_tick`, `_settings`

### Constants

- Use UPPER_SNAKE_CASE
- Prefer settings dictionary over constants for strategy configuration

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Strategy organized according to recommended structure
- [ ] Section separators present (`# ───────────────────────────────────────────────────────────`)
- [ ] Properties organized with blank lines (Mandatory variables → Class variables → Dependency injections)
- [ ] Methods grouped logically (Framework → Custom Public → Protected → Private)
- [ ] No god classes (too many responsibilities)

### Dependency Injection

- [ ] LoggingService instantiated directly in constructor (NOT injected)
- [ ] Other dependencies injected via constructor if needed
- [ ] Dependencies stored as private attributes (prefixed with `_`)
- [ ] No global state or singletons

### Documentation

- [ ] Class-level docstring present (concise, focused on Entry Rules, Exit Rules, Special Conditions)
- [ ] Class-level docstring does NOT include Attributes section or implementation details
- [ ] Constructor does NOT have docstring (unless non-standard behavior)
- [ ] Framework methods do NOT have docstrings (unless complex)
- [ ] All custom public methods have docstrings
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
- [ ] Strategy is maintainable and readable

---

## FINAL OBJECTIVE

A strategy file must be:

- **Organized**: Clear structure with section separators
- **Focused**: Single Responsibility Principle applied
- **Documented**: Concise class-level docstring with trading rules (no Attributes section, no constructor docstring, framework methods correctly skipped)
- **Injected**: Dependencies handled correctly (LoggingService instantiated internally)
- **Type-safe**: All type hints and return types present
- **Maintainable**: Easy to understand and modify
- **Testable**: Well-structured and easy to test
- **Clean**: No code smells, no duplication, self-documenting code

---

## COMMON REFACTORING PATTERNS

### Extract Method

**Before:**

```python
def _check_entry_conditions(self) -> None:
    # 100 lines of mixed logic
    if self._tick:
        # Calculate prices
        # Validate conditions
        # Open order
```

**After:**

```python
def _check_entry_conditions(self) -> None:
    if not self._tick:
        return

    if not self._should_open_order():
        return

    self._open_order()

def _should_open_order(self) -> bool:
    # Validation logic
    return True

def _open_order(self) -> None:
    # Order opening logic
    pass
```

### Framework Method Override (Simple - No Docstring)

**Before:**

```python
def on_tick(self, tick: TickModel) -> None:
    """
    Handle a new market tick event.

    Args:
        tick: The current market tick data.
    """
    super().on_tick(tick)
    self._tick = tick
```

**After:**

```python
def on_tick(self, tick: TickModel) -> None:
    super().on_tick(tick)
    self._tick = tick
```

### Framework Method Override (Complex - Needs Docstring)

**Before:**

```python
def on_transaction(self, order: OrderModel) -> None:
    super().on_transaction(order)
    # Complex recovery logic that's not obvious
    if order.status.is_closed() and order.profit < 0:
        # Multi-layer recovery system
        # Complex calculations
        # Non-obvious behavior
```

**After:**

```python
def on_transaction(self, order: OrderModel) -> None:
    """
    Handle transaction with multi-layer recovery system.

    When an order closes with a loss, this method implements a
    recovery strategy that opens additional orders based on the
    loss amount and current market conditions.

    Args:
        order: The order model representing the transaction.
    """
    super().on_transaction(order)
    # Complex recovery logic
```

---

## PYTHON-SPECIFIC BEST PRACTICES

### Use Settings Dictionary

```python
self._settings = kwargs.get(
    "settings",
    {
        "volume_percentage": 0.01,
        "take_profit_percentage": 0.02,
        "stop_loss_percentage": 0.01,
        "interval_minutes": 10,
    },
)
```

### Use Enum Methods Instead of String Comparisons

```python
# Good: Use enum methods
if order.status.is_open():
    # Handle open order

# Bad: String comparison
if order.status == "open":
    # Handle open order
```

### Code Formatting: Trailing Commas

When function calls, class instantiations, or definitions span multiple lines, always include a trailing comma after the last parameter.

**Good: Multi-line with trailing comma**

```python
self.open_order(
    OrderSide.BUY,
    current_price,
    take_profit_price,
    stop_loss_price,
    volume,
)
```

**Bad: Multi-line without trailing comma**

```python
self.open_order(
    OrderSide.BUY,
    current_price,
    take_profit_price,
    stop_loss_price,
    volume
)
```

