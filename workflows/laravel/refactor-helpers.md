# Refactor Helpers Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

1. **Search for helper usage**: Search the codebase to find where the helper is used. This provides crucial context about:
   - How the helper function is imported and called
   - What parameters are commonly passed
   - Common patterns and operations performed with the helper
   - Integration points with other parts of the system (controllers, models, services, etc.)
   - Edge cases and error handling needs
   - This context is essential for making informed refactoring decisions

**THEN, follow these specific rules for helper refactoring:**

- **Verify PHP version**: Ensure PHP 8.0+ is being used (for modern type hints and features)
- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (PHPStan, Psalm, Laravel Pint)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar helpers** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete helper file
- [ ] **Search for helper usage** in the codebase to understand how it's used (controllers, models, services, views, etc.)
- [ ] Verify PHP 8.0+ requirement is met
- [ ] Identify code smells (missing type hints, no error handling, side effects, unclear naming)
- [ ] Check if helper should be pure function (no side effects) or can have side effects
- [ ] Verify function name follows naming conventions (snake_case)
- [ ] Check if helper needs to handle edge cases based on usage patterns found
- [ ] Review similar helpers in codebase for consistency
- [ ] Determine if helper belongs in global `helpers.php` or as static method in helper class
- [ ] Check if helper is registered in `composer.json` for autoloading
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks

### Phase 2: Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Code review comment (if applicable)
  2. `declare(strict_types=1)` directive
  3. Namespace declaration (if using helper class)
  4. Use statements (if any)
  5. Function definition with `if (! function_exists())` check (for global helpers)
  6. PHPDoc block
  7. Function signature with type hints
  8. Function implementation
- [ ] Verify helper is in correct location (`app/helpers.php` for global helpers or `app/Helpers/` for classes)
- [ ] Verify helper is registered in `composer.json` if it's a global function
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "Helper structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Function Signature and Type Safety

- [ ] Add complete type hints to all parameters
- [ ] Add return type declaration
- [ ] Use nullable types (`?Type`) when values can be null
- [ ] Use union types (`Type1|Type2`) when multiple types are possible (PHP 8.0+)
- [ ] Use `mixed` only when absolutely necessary (prefer specific types)
- [ ] Verify parameter names are descriptive and follow snake_case
- [ ] Check if default values are appropriate and well-typed
- [ ] Add `declare(strict_types=1)` at the top of the file
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no changes were needed (e.g., "All type hints were already complete")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Error Handling and Edge Cases

- [ ] Add handling for null values when appropriate
- [ ] Add handling for empty strings/arrays when appropriate
- [ ] Add handling for invalid input types
- [ ] Return sensible default values on error (0, 0.0, null, empty string, empty array, etc.)
- [ ] Avoid throwing exceptions unless absolutely necessary (prefer returning defaults)
- [ ] Use Laravel's validation helpers when appropriate
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no error handling was needed (e.g., "Helper already handles all edge cases appropriately")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Function Purity and Side Effects

- [ ] Verify helper is a pure function (no side effects) when possible
- [ ] If side effects are necessary, document them clearly
- [ ] Avoid modifying input parameters (prefer returning new values)
- [ ] Avoid global state mutations unless necessary
- [ ] Avoid database queries or external API calls unless helper is specifically for that purpose
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if side effects are intentional and necessary
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: Documentation (PHPDoc)

- [ ] Add function-level PHPDoc explaining purpose
- [ ] Document parameters with `@param` including type and description
- [ ] Document return value with `@return` including type and description
- [ ] Add `@throws` if function can throw exceptions
- [ ] Add `@example` if function behavior is non-obvious
- [ ] Add notes about edge cases or special behavior
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if documentation was already complete (e.g., "Helper already has complete PHPDoc")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: Composer Autoloading (Global Helpers Only)

- [ ] Verify helper file is registered in `composer.json` under `autoload.files`
- [ ] Verify file path in `composer.json` is correct
- [ ] Run `composer dump-autoload` to regenerate autoload files
- [ ] Verify helper is accessible globally
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if this phase is skipped (e.g., "Helper is a static method in a class, autoloading not needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 8: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Verify no linting errors (PHPStan, Psalm, Laravel Pint)
- [ ] Review helper structure and consistency with codebase
- [ ] Confirm complete type annotations
- [ ] Verify error handling is appropriate
- [ ] Verify `declare(strict_types=1)` is present
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

---

## HELPER FILE STRUCTURE

### Global Helper Function (helpers.php)

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

if (! function_exists('parse_int')) {
    /**
     * Parse a value to integer, returning 0 on failure.
     *
     * @param  mixed  $value  The value to parse
     * @return int The parsed integer value, or 0 on failure
     */
    function parse_int(mixed $value): int
    {
        if ($value === null) {
            return 0;
        }

        if (is_int($value)) {
            return $value;
        }

        if (is_string($value)) {
            return (int) (float) $value;
        }

        return (int) $value;
    }
}
```

### Global Helper with Nullable Return

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

if (! function_exists('get_env')) {
    /**
     * Get an environment variable value.
     *
     * @param  string  $key  The environment variable key
     * @param  string|null  $default  The default value if key doesn't exist
     * @return string|null The environment variable value or default
     */
    function get_env(string $key, ?string $default = null): ?string
    {
        return $_ENV[$key] ?? $default;
    }
}
```

### Global Helper with Complex Logic (with PHPDoc)

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

if (! function_exists('format_currency')) {
    /**
     * Format a number as currency string.
     *
     * @param  float  $amount  The amount to format
     * @param  string  $currency  The currency code (default: USD)
     * @param  int  $decimals  Number of decimal places (default: 2)
     * @return string The formatted currency string
     *
     * @example
     * format_currency(1234.56, 'USD')
     * // Returns: '$1,234.56'
     */
    function format_currency(float $amount, string $currency = 'USD', int $decimals = 2): string
    {
        if ($amount === 0.0) {
            return '0.00 ' . $currency;
        }

        $formatted = number_format($amount, $decimals, '.', ',');

        return match ($currency) {
            'USD' => '$' . $formatted,
            'EUR' => '€' . $formatted,
            'GBP' => '£' . $formatted,
            default => $formatted . ' ' . $currency,
        };
    }
}
```

### Helper Class with Static Methods

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Helpers;

/**
 * Helper class for parsing operations.
 */
class ParseHelper
{
    /**
     * Parse a value to integer, returning 0 on failure.
     *
     * @param  mixed  $value  The value to parse
     * @return int The parsed integer value, or 0 on failure
     */
    public static function int(mixed $value): int
    {
        if ($value === null) {
            return 0;
        }

        if (is_int($value)) {
            return $value;
        }

        if (is_string($value)) {
            return (int) (float) $value;
        }

        return (int) $value;
    }

    /**
     * Parse a value to float, returning 0.0 on failure.
     *
     * @param  mixed  $value  The value to parse
     * @return float The parsed float value, or 0.0 on failure
     */
    public static function float(mixed $value): float
    {
        if ($value === null) {
            return 0.0;
        }

        if (is_float($value)) {
            return $value;
        }

        if (is_string($value) || is_int($value)) {
            return (float) $value;
        }

        return 0.0;
    }
}
```

### Helper Returning Array/Tuple

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

if (! function_exists('has_api_error')) {
    /**
     * Check if API response contains an error.
     *
     * @param  array<string, mixed>  $response  The API response array
     * @return array{bool, string|null, int|null} Tuple of [has_error, error_message, error_code]
     */
    function has_api_error(array $response): array
    {
        if (! isset($response['code'])) {
            return [false, null, null];
        }

        $errorMsg = $response['msg'] ?? 'Unknown error';
        $errorCode = $response['code'];

        return [true, $errorMsg, $errorCode];
    }
}
```

### Helper with Optional Parameters

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

if (! function_exists('get_slug')) {
    /**
     * Generate a URL-friendly slug from a title.
     *
     * @param  string  $title  The title to convert
     * @param  string  $separator  The separator character (default: '-')
     * @param  array<string, string>|null  $dictionary  Custom replacement dictionary
     * @return string The generated slug
     */
    function get_slug(string $title, string $separator = '-', ?array $dictionary = null): string
    {
        $dictionary = $dictionary ?? ['@' => 'at'];

        $title = \Illuminate\Support\Str::ascii($title);
        $flip = $separator === '-' ? '_' : '-';
        $title = preg_replace('/[' . preg_quote($flip, '/') . ']+/', $separator, $title);

        foreach ($dictionary as $key => $value) {
            $title = str_replace($key, $separator . $value . $separator, $title);
        }

        $title = strtolower($title);
        $title = preg_replace('/[^' . preg_quote($separator, '/') . '\w\s]+/', '', $title);
        $title = preg_replace('/[' . preg_quote($separator, '/') . '\s]+/', $separator, $title);

        return trim($title, $separator);
    }
}
```

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Missing Type Hints

**Problem**: Function parameters and return values lack type declarations
**Solution**: Add complete type hints using PHP 8.0+ type system

### 2. No Error Handling

**Problem**: Function doesn't handle null, empty values, or invalid inputs
**Solution**: Add appropriate checks and return sensible defaults

### 3. Side Effects

**Problem**: Function modifies global state or input parameters
**Solution**: Make function pure (no side effects) when possible, or document side effects clearly

### 4. Unclear Naming

**Problem**: Function name doesn't clearly describe what it does
**Solution**: Use descriptive names following snake_case convention

### 5. Magic Values

**Problem**: Hard-coded values without explanation
**Solution**: Use named constants or parameters

### 6. Missing Default Values

**Problem**: Required parameters that should have defaults
**Solution**: Add sensible default values when appropriate

### 7. Wrong Location

**Problem**: Global helper should be in class or vice versa
**Solution**: Move to correct location (`app/helpers.php` for global, `app/Helpers/` for classes)

### 8. Missing Composer Registration

**Problem**: Global helper not registered in `composer.json`
**Solution**: Add to `composer.json` under `autoload.files` and run `composer dump-autoload`

### 9. Overly Complex Function

**Problem**: Function does too many things
**Solution**: Split into smaller, focused functions

### 10. No Documentation

**Problem**: Function lacks PHPDoc explaining behavior
**Solution**: Add PHPDoc with `@param`, `@return`, and `@example` when needed

### 11. Missing `function_exists()` Check

**Problem**: Global helper doesn't check if function already exists
**Solution**: Wrap function definition in `if (! function_exists())` check

### 12. Missing `declare(strict_types=1)`

**Problem**: File doesn't declare strict types
**Solution**: Add `declare(strict_types=1);` at the top of the file

---

## WHAT TO DO

### Structure and Organization

- Place global helpers in `app/helpers.php` file
- Place helper classes in `app/Helpers/` directory
- One function per helper, or group related functions in same file
- Order: code review comment, `declare(strict_types=1)`, namespace (if class), use statements, function definition
- Add `if (! function_exists())` check for global helpers
- Register global helpers in `composer.json` under `autoload.files`

### Naming

- Use `snake_case` for function names (Laravel convention)
- Use descriptive prefixes:
  - `get_*` for retrieving/returning values
  - `parse_*` for conversion/parsing
  - `has_*` for boolean checks
  - `is_*` for validation checks
  - `format_*` for formatting operations
  - `calculate_*` for calculations
  - `convert_*` for type conversions
- Use descriptive parameter names in `snake_case`

### Type Safety

- Add type hints to all parameters
- Add return type declarations
- Use nullable types (`?Type`) for nullable values
- Use union types (`Type1|Type2`) for multiple possible types (PHP 8.0+)
- Avoid `mixed` when specific type is known
- Use generic array types (`array<string, mixed>`) when appropriate
- Add `declare(strict_types=1);` at the top of the file

### Error Handling

- Handle null values appropriately
- Handle empty strings/arrays when relevant
- Return sensible defaults (0, 0.0, null, empty string, empty array)
- Avoid throwing exceptions unless necessary
- Validate input types when needed
- Use Laravel's validation helpers when appropriate

### Function Purity

- Prefer pure functions (no side effects)
- Don't modify input parameters
- Don't mutate global state
- Return new values instead of modifying existing ones
- Document side effects if they're necessary
- Avoid database queries or external API calls unless helper is specifically for that purpose

### Documentation

- Add PHPDoc for all functions
- Document parameters with `@param` including type and description
- Document return values with `@return` including type and description
- Add `@throws` if function can throw exceptions
- Add `@example` for non-obvious behavior
- Note edge cases and special behavior

### Composer Autoloading

- Register global helpers in `composer.json` under `autoload.files`
- Use correct file paths relative to project root
- Run `composer dump-autoload` after adding helpers
- Verify helpers are accessible globally

---

## WHAT NOT TO DO

### Structure

- DO NOT mix global helpers and helper classes without clear reason
- DO NOT create helpers with too many responsibilities
- DO NOT omit type hints
- DO NOT place helpers in wrong directory
- DO NOT forget `function_exists()` check for global helpers
- DO NOT omit `declare(strict_types=1)`

### Naming

- DO NOT use camelCase or PascalCase for functions (use snake_case)
- DO NOT use abbreviations unless widely understood
- DO NOT use vague names like `process`, `handle`, `do`
- DO NOT use single-letter parameter names

### Type Safety

- DO NOT omit type hints
- DO NOT use `mixed` when specific type is known
- DO NOT omit return type declarations
- DO NOT use untyped parameters
- DO NOT forget `declare(strict_types=1)`

### Error Handling

- DO NOT throw exceptions for common edge cases
- DO NOT ignore null values when they're possible
- DO NOT return null when 0 or empty string is more appropriate
- DO NOT crash on invalid input without handling

### Function Purity

- DO NOT modify input parameters
- DO NOT mutate global state unnecessarily
- DO NOT create functions with hidden side effects
- DO NOT mix pure and impure operations
- DO NOT perform database queries or API calls unless helper is specifically for that

### Documentation

- DO NOT omit PHPDoc blocks
- DO NOT omit `@param` tags
- DO NOT omit `@return` tags
- DO NOT write obvious comments that repeat the code
- DO NOT use comments as excuse for unclear code

### Code Quality

- DO NOT create helpers that do too many things
- DO NOT duplicate logic that exists elsewhere
- DO NOT create helpers that are only used once
- DO NOT mix business logic with utility functions

### Composer

- DO NOT forget to register global helpers in `composer.json`
- DO NOT use incorrect file paths in `composer.json`
- DO NOT forget to run `composer dump-autoload` after changes

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
- Avoid single letters except for common conventions (`$i`, `$j` for loops)

### File Names

- Use `snake_case`: `helpers.php` for global helpers
- Use `PascalCase` for helper classes: `ParseHelper.php`, `FormatHelper.php`
- Match function purpose: `helpers.php` contains multiple global helpers

### Class Names

- Use `PascalCase`: `ParseHelper`, `FormatHelper`, `ValidationHelper`
- Use descriptive names: `ParseHelper` not `Helper`
- Suffix with `Helper` when appropriate: `ParseHelper`, `FormatHelper`

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Helper in correct location (`app/helpers.php` or `app/Helpers/`)
- [ ] `declare(strict_types=1)` present at top of file
- [ ] Code review comment at top of file
- [ ] `if (! function_exists())` check for global helpers
- [ ] Imports/use statements ordered correctly

### Naming

- [ ] Function name in `snake_case` with appropriate prefix
- [ ] Parameter names descriptive and in `snake_case`
- [ ] Class name in `PascalCase` if using helper class

### Type Safety

- [ ] All parameters have type hints
- [ ] Return type declaration present
- [ ] Nullable types (`?Type`) used for nullable values
- [ ] Union types used for multiple types when needed
- [ ] `mixed` avoided when specific type is known
- [ ] `declare(strict_types=1)` present

### Error Handling

- [ ] Null values handled appropriately
- [ ] Empty values handled when relevant
- [ ] Invalid input types handled
- [ ] Sensible defaults returned on error
- [ ] Exceptions only thrown when necessary

### Function Purity

- [ ] Function is pure (no side effects) when possible
- [ ] Input parameters not modified
- [ ] Global state not mutated unnecessarily
- [ ] Side effects documented if necessary
- [ ] No database queries or API calls unless specifically for that purpose

### Documentation

- [ ] PHPDoc present for all functions
- [ ] Parameters documented with `@param` including type
- [ ] Return value documented with `@return` including type
- [ ] `@throws` included if function can throw exceptions
- [ ] `@example` included for non-obvious behavior
- [ ] Edge cases noted

### Composer

- [ ] Global helpers registered in `composer.json` under `autoload.files`
- [ ] File paths correct in `composer.json`
- [ ] `composer dump-autoload` run after changes
- [ ] Helpers accessible globally

### Testing

- [ ] All tests pass
- [ ] No linting errors (PHPStan, Psalm, Laravel Pint)
- [ ] Helper is maintainable and readable

---

## FINAL OBJECTIVE

A helper file must be:

- **Organized**: Clear structure with proper ordering and `declare(strict_types=1)`
- **Typed**: Complete type annotations on parameters and return values
- **Safe**: Handles edge cases and errors gracefully
- **Pure**: No side effects when possible, documented when necessary
- **Documented**: Complete PHPDoc with `@param`, `@return`, `@example`
- **Named**: Descriptive names following Laravel conventions (snake_case)
- **Located**: In correct directory (`app/helpers.php` for global, `app/Helpers/` for classes)
- **Registered**: Properly registered in `composer.json` for global helpers
- **Protected**: Wrapped in `if (! function_exists())` check for global helpers
- **Maintainable**: Easy to understand, test, and extend

---

## COMMON REFACTORING PATTERNS

### Add Type Hints

**Before:**

```php
function parse_int($value)
{
    if ($value === null) {
        return 0;
    }
    return (int) $value;
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('parse_int')) {
    function parse_int(mixed $value): int
    {
        if ($value === null) {
            return 0;
        }
        return (int) $value;
    }
}
```

### Add Error Handling

**Before:**

```php
function get_duration($start_at, $end_at)
{
    $total_seconds = ($end_at - $start_at)->total_seconds;
    return $total_seconds . ' seconds';
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('get_duration')) {
    function get_duration(\DateTime $start_at, \DateTime $end_at): string
    {
        $total_seconds = $end_at->getTimestamp() - $start_at->getTimestamp();
        $seconds_in_minute = 60;
        $seconds_in_hour = 3600;
        $seconds_in_day = 86400;

        if ($total_seconds < $seconds_in_minute) {
            return $total_seconds . ' seconds';
        }

        if ($total_seconds < $seconds_in_hour) {
            $minutes = (int) ($total_seconds / $seconds_in_minute);
            return $minutes . ' minutes';
        }

        if ($total_seconds < $seconds_in_day) {
            $hours = (int) ($total_seconds / $seconds_in_hour);
            return $hours . ' hours';
        }

        $days = (int) ($total_seconds / $seconds_in_day);
        return $days . ' days';
    }
}
```

### Fix Naming Convention

**Before:**

```php
function GetUserData($userId)
{
    // Implementation
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('get_user_data')) {
    function get_user_data(string $user_id): ?array
    {
        // Implementation
    }
}
```

### Add Default Values

**Before:**

```php
function get_slug($title, $separator, $dictionary)
{
    // Implementation
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('get_slug')) {
    function get_slug(string $title, string $separator = '-', ?array $dictionary = null): string
    {
        $dictionary = $dictionary ?? ['@' => 'at'];
        // Implementation
    }
}
```

### Make Function Pure

**Before:**

```php
$result_list = [];

function process_data($data)
{
    global $result_list;
    $result_list[] = $data;
    return count($result_list);
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('process_data')) {
    /**
     * Process data and return updated list.
     *
     * @param  string  $data  The data to process
     * @param  array<string>  $existing_results  Existing results array
     * @return array<string> Updated results array
     */
    function process_data(string $data, array $existing_results): array
    {
        return [...$existing_results, $data];
    }
}
```

### Add PHPDoc for Complex Function

**Before:**

```php
function get_sharpe_ratio($nav_history, $risk_free_rate = 0.0)
{
    // Complex calculation logic
    return $result;
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('get_sharpe_ratio')) {
    /**
     * Calculate Sharpe Ratio (annualized risk-adjusted return).
     *
     * @param  array<float>  $nav_history  List of Net Asset Values over time
     * @param  float  $risk_free_rate  Risk-free rate as daily decimal (default: 0.0)
     * @return float Annualized Sharpe Ratio, or 0.0 if insufficient data or zero volatility
     *
     * @example
     * get_sharpe_ratio([100.0, 105.0, 110.0], 0.0)
     * // Returns: calculated Sharpe ratio
     */
    function get_sharpe_ratio(array $nav_history, float $risk_free_rate = 0.0): float
    {
        // Complex calculation logic
        return $result;
    }
}
```

### Register Helper in composer.json

**Before:**

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        }
    }
}
```

**After:**

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        },
        "files": [
            "app/helpers.php"
        ]
    }
}
```

Then run: `composer dump-autoload`

### Add function_exists() Check

**Before:**

```php
function parse_int(mixed $value): int
{
    // Implementation
}
```

**After:**

```php
declare(strict_types=1);

if (! function_exists('parse_int')) {
    function parse_int(mixed $value): int
    {
        // Implementation
    }
}
```

---

## PYTHON-SPECIFIC BEST PRACTICES

### Use Type Hints

Always add type hints for better IDE support and type checking:

```php
declare(strict_types=1);

if (! function_exists('get_env')) {
    function get_env(string $key, ?string $default = null): ?string
    {
        return $_ENV[$key] ?? $default;
    }
}
```

### Handle Edge Cases Gracefully

Return sensible defaults instead of throwing exceptions:

```php
declare(strict_types=1);

if (! function_exists('parse_int')) {
    function parse_int(mixed $value): int
    {
        if ($value === null) {
            return 0;
        }

        if (is_int($value)) {
            return $value;
        }

        if (is_string($value)) {
            return (int) (float) $value;
        }

        try {
            return (int) $value;
        } catch (\TypeError $e) {
            return 0;
        }
    }
}
```

### Use Appropriate Prefixes

Choose prefixes that clearly indicate function purpose:

```php
// Retrieval
function get_user_by_id(string $user_id): ?array
{
    // Implementation
}

// Parsing/Conversion
function parse_float(mixed $value): float
{
    // Implementation
}

// Boolean checks
function has_permission(array $user, string $permission): bool
{
    // Implementation
}

// Validation
function is_valid_email(string $email): bool
{
    // Implementation
}

// Formatting
function format_currency(float $amount, string $currency = 'USD'): string
{
    // Implementation
}
```

### Prefer Pure Functions

Make functions pure (no side effects) when possible:

```php
// Good: Pure function
function calculate_total(array $prices): float
{
    return array_sum($prices);
}

// Bad: Side effects
$total = 0;
function calculate_total(array $prices): float
{
    global $total;
    $total = array_sum($prices);
    return $total;
}
```

### Use Nullable Types for Nullable Values

Use `?Type` when values can be null:

```php
declare(strict_types=1);

if (! function_exists('get_user_by_id')) {
    function get_user_by_id(string $user_id): ?array
    {
        // Returns array or null
    }
}
```

### Group Related Helpers

Group related functions in the same file:

```php
// app/helpers.php
declare(strict_types=1);

if (! function_exists('parse_int')) {
    function parse_int(mixed $value): int
    {
        // Implementation
    }
}

if (! function_exists('parse_float')) {
    function parse_float(mixed $value): float
    {
        // Implementation
    }
}

if (! function_exists('parse_string')) {
    function parse_string(mixed $value): string
    {
        // Implementation
    }
}
```

### Document Complex Functions

Add PHPDoc for functions with non-obvious behavior:

```php
declare(strict_types=1);

if (! function_exists('get_sharpe_ratio')) {
    /**
     * Calculate Sharpe Ratio (annualized risk-adjusted return).
     *
     * @param  array<float>  $nav_history  List of Net Asset Values over time
     * @param  float  $risk_free_rate  Risk-free rate as daily decimal (default: 0.0)
     * @return float Annualized Sharpe Ratio, or 0.0 if insufficient data or zero volatility
     *
     * @example
     * get_sharpe_ratio([100.0, 105.0, 110.0], 0.0)
     * // Returns: calculated Sharpe ratio
     */
    function get_sharpe_ratio(array $nav_history, float $risk_free_rate = 0.0): float
    {
        // Implementation
    }
}
```

### Register Helpers Properly

Use `composer.json` for explicit registration:

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        },
        "files": [
            "app/helpers.php"
        ]
    }
}
```

Then run: `composer dump-autoload`

### Use function_exists() Check

Always wrap global helpers in `function_exists()` check:

```php
declare(strict_types=1);

if (! function_exists('my_helper')) {
    function my_helper(string $param): string
    {
        // Implementation
    }
}
```

---

## WHEN TO USE HELPERS

### Use Helpers When:

- Function is reusable across multiple parts of the application
- Function performs a single, well-defined task
- Function is a pure transformation (input -> output)
- Function encapsulates common utility logic
- Function handles edge cases that would be repeated
- Function doesn't require state management
- Function doesn't need dependency injection

### Don't Use Helpers When:

- Function is only used in one place (consider inline or private method)
- Function contains complex business logic (use service class)
- Function requires state management (use class)
- Function is tightly coupled to specific domain (use domain service)
- Function would be better as a method of a class
- Function needs dependency injection (use service class)
- Function performs database queries or external API calls (use repository or service)

---

## HELPER LOCATION GUIDELINES

### Global Helpers (`app/helpers.php`)

Place in `app/helpers.php` when:
- Function is used across multiple domains/modules
- Function is a general utility (parsing, formatting, validation)
- Function has no domain-specific knowledge
- Function is framework-agnostic
- Function should be accessible globally without imports

Examples:
- `parse_int()` - Generic parsing function
- `get_env()` - Environment variable access
- `format_currency()` - Currency formatting
- `get_slug()` - URL slug generation

### Helper Classes (`app/Helpers/`)

Place in `app/Helpers/` when:
- Multiple related helper functions should be grouped
- Helper functions are domain-specific but still utilities
- You want to use static methods instead of global functions
- Helper functions need to be organized by category

Examples:
- `app/Helpers/ParseHelper.php` - Parsing operations
- `app/Helpers/FormatHelper.php` - Formatting operations
- `app/Helpers/ValidationHelper.php` - Validation operations

---

## INTEGRATION WITH TYPE CHECKERS

### PHPStan Configuration

Ensure helpers work correctly with PHPStan:

```php
declare(strict_types=1);

if (! function_exists('get_user_by_id')) {
    /**
     * @param  string  $user_id
     * @return array<string, mixed>|null
     */
    function get_user_by_id(string $user_id): ?array
    {
        // Implementation
    }
}

// PHPStan will catch errors
$user = get_user_by_id(123); // Error: Expected string, got int
$user = get_user_by_id('123'); // OK, returns ?array

if ($user !== null) {
    // PHPStan knows $user is array here
    $name = $user['name'];
}
```

### Type Narrowing

Use type hints for better type narrowing:

```php
declare(strict_types=1);

if (! function_exists('parse_optional_float')) {
    /**
     * @param  mixed  $value
     * @return float|null
     */
    function parse_optional_float(mixed $value): ?float
    {
        if ($value === null || $value === '') {
            return null;
        }
        // PHPStan knows $value is not null here
        return (float) $value;
    }
}

$result = parse_optional_float('123.45');
if ($result !== null) {
    // PHPStan knows $result is float here
    $total = $result * 2;
}
```

---

## COMPOSER.JSON CONFIGURATION

### Registering Global Helpers

Add helpers file to `composer.json`:

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        },
        "files": [
            "app/helpers.php"
        ]
    }
}
```

### Multiple Helper Files

If you have multiple helper files:

```json
{
    "autoload": {
        "psr-4": {
            "App\\": "app/"
        },
        "files": [
            "app/helpers.php",
            "app/helpers/validation.php",
            "app/helpers/formatting.php"
        ]
    }
}
```

### After Modifying composer.json

Always run:

```bash
composer dump-autoload
```

This regenerates the autoload files and makes your helpers available globally.

---

## LARAVEL-SPECIFIC CONSIDERATIONS

### Using Laravel Helpers

Laravel provides many built-in helpers. Check if a helper already exists before creating your own:

- `config()` - Get configuration values
- `env()` - Get environment variables
- `asset()` - Generate asset URLs
- `route()` - Generate route URLs
- `url()` - Generate URLs
- `view()` - Get view instance
- `auth()` - Get authenticated user
- `cache()` - Cache operations
- `session()` - Session operations

### Using Laravel Collections

For array operations, consider using Laravel Collections:

```php
use Illuminate\Support\Collection;

// Instead of custom helper
function filter_array(array $items, callable $callback): array
{
    return array_filter($items, $callback);
}

// Use Laravel Collection
Collection::make($items)->filter($callback)->toArray();
```

### Using Laravel Str Helper

For string operations, use Laravel's `Str` helper:

```php
use Illuminate\Support\Str;

// Instead of custom slug helper
function get_slug(string $title): string
{
    // Custom implementation
}

// Use Laravel Str helper
Str::slug($title);
```

### Using Laravel Validator

For validation, use Laravel's Validator:

```php
use Illuminate\Support\Facades\Validator;

// Instead of custom validation helper
function is_valid_email(string $email): bool
{
    // Custom implementation
}

// Use Laravel Validator
Validator::make(['email' => $email], ['email' => 'required|email'])->passes();
```

