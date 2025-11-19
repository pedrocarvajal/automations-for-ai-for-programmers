# Refactor Enums Guide

## MANDATORY PROCESS BEFORE STARTING

**BEFORE making any changes, THE AI MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process (task breakdown, planning, confirmations).

**THEN, follow these specific rules for enum refactoring:**

- **Verify PHP version**: Ensure PHP 8.1+ is being used (enums require PHP 8.1+)
- **Run tests** after each phase - verify all tests pass
- **Verify linting** after each phase - ensure no errors (PHPStan, Psalm, Laravel Pint)
- **EXPLAIN SKIPPED TASKS** - If any task within a phase was not executed, the AI MUST explain why it was skipped (e.g., "Task X was not executed because Y was already present/not needed")
- **ALWAYS review existing similar enums** in the codebase and follow the same pattern (structure, naming conventions, documentation style)

---

## REFACTORING PHASES

### Phase 1: Analysis and Planning

- [ ] Read the complete enum file
- [ ] Verify PHP 8.1+ requirement is met
- [ ] Identify code smells (magic strings, missing type hints, no docblocks, inconsistent values)
- [ ] Check if enum should be backed (string/int) or pure enum
- [ ] Verify enum cases follow naming conventions (UPPER_CASE)
- [ ] Check if enum needs methods, properties, or implements interfaces
- [ ] Review similar enums in codebase for consistency
- [ ] Check if enum needs Eloquent casting
- [ ] Present the plan to the user for approval
- [ ] **WAIT FOR USER CONFIRMATION** - Do not proceed until user explicitly approves the plan
- [ ] **EXPLAIN** any skipped tasks

### Phase 2: Structure and Organization

- [ ] Reorganize structure according to recommended order:
  1. Code review comment (if applicable)
  2. `declare(strict_types=1)` directive
  3. Namespace declaration
  4. Use statements (if any)
  5. Class-level PHPDoc
  6. Enum declaration (backed or pure)
  7. Enum cases (alphabetically or logically ordered)
  8. Methods (if any)
  9. Properties (if any)
  10. Traits (if any)
- [ ] Add section separators (`// ============================================`) if enum is large
- [ ] Verify enum cases are ordered logically
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if structure was already correct (e.g., "Enum structure was already organized correctly, no changes needed")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 3: Values and Cases

- [ ] Use backed enum (string/int) when values need to be stored in database
- [ ] Use pure enum when values don't need to be stored
- [ ] Ensure all cases use UPPER_CASE naming
- [ ] Verify values are meaningful and consistent
- [ ] Check if values should be strings (for API compatibility) or integers (for performance)
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no changes were needed (e.g., "All enum cases already follow best practices")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 4: Methods and Properties

- [ ] Add methods only if they encapsulate enum-related behavior
- [ ] Use descriptive method names (camelCase)
- [ ] Add type hints to all method parameters
- [ ] Add return types to all methods
- [ ] Use `self` or `static` return types when appropriate
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if no methods were needed (e.g., "Enum does not require additional methods")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 5: Documentation (PHPDoc)

- [ ] Add class-level PHPDoc explaining purpose
- [ ] Add PHPDoc to all methods (if any)
- [ ] Add inline comments for complex enum cases if needed
- [ ] Include `@param`, `@return`, `@throws` where applicable
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if documentation was already complete (e.g., "Enum already has complete PHPDoc")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 6: Type Safety

- [ ] Verify enum is properly typed (backed enum with type: `enum Name: string` or `enum Name: int`)
- [ ] Add type hints to all methods (if any)
- [ ] Add return types to all methods
- [ ] Use `declare(strict_types=1)` at the top of the file
- [ ] Verify PHPStan/Psalm passes with strict mode
- [ ] Verify there are no linting errors
- [ ] **EXPLAIN** if types were already complete (e.g., "Enum already has correct type annotations")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 7: Eloquent Integration (if applicable)

- [ ] Check if enum is used in Eloquent models
- [ ] Add enum casting to model's `$casts` array
- [ ] Verify casting works correctly (database -> enum -> database)
- [ ] Test enum serialization/deserialization
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if this phase is skipped (e.g., "Enum is not used in Eloquent models")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 8: Validation Rules (if applicable)

- [ ] Check if enum is used in form requests
- [ ] Add `Enum` validation rule to request classes
- [ ] Verify validation works correctly
- [ ] Run tests and verify all pass
- [ ] **EXPLAIN** if this phase is skipped (e.g., "Enum is not used in form validation")
- [ ] **WAIT FOR USER CONFIRMATION** - Explicitly stop and wait for user approval before continuing

### Phase 9: Final Verification

- [ ] Add code review comment at the beginning of the file (see `standards/task-notes.md` for format)
- [ ] Run all tests and verify they pass
- [ ] Verify no linting errors (PHPStan, Psalm, Laravel Pint)
- [ ] Review enum structure and consistency with codebase
- [ ] Confirm complete documentation
- [ ] Verify `declare(strict_types=1)` is present
- [ ] **EXPLAIN** any verification issues found and how they were resolved
- [ ] **WAIT FOR USER CONFIRMATION** - Present final summary and wait for user approval

---

## ENUM FILE STRUCTURE

### Basic Backed Enum (String Values)

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents the possible states of an order in the system.
 */
enum OrderStatus: string
{
    case OPENING = 'opening';
    case OPEN = 'open';
    case CLOSING = 'closing';
    case CLOSED = 'closed';
    case CANCELLED = 'cancelled';
}
```

### Basic Backed Enum (Integer Values)

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents priority levels for tasks.
 */
enum Priority: int
{
    case LOW = 1;
    case MEDIUM = 2;
    case HIGH = 3;
    case CRITICAL = 4;
}
```

### Pure Enum (No Backing Values)

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents file permission types.
 */
enum FilePermission
{
    case READ;
    case WRITE;
    case EXECUTE;
}
```

### Enum with Methods

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents trading timeframes with their duration in seconds.
 */
enum Timeframe: string
{
    case ONE_MINUTE = '1m';
    case THREE_MINUTES = '3m';
    case FIVE_MINUTES = '5m';
    case FIFTEEN_MINUTES = '15m';
    case THIRTY_MINUTES = '30m';
    case ONE_HOUR = '1h';
    case TWO_HOURS = '2h';
    case FOUR_HOURS = '4h';
    case SIX_HOURS = '6h';
    case EIGHT_HOURS = '8h';
    case TWELVE_HOURS = '12h';
    case ONE_DAY = '1d';
    case THREE_DAYS = '3d';
    case ONE_WEEK = '1w';
    case ONE_MONTH = '1M';

    /**
     * Convert timeframe to seconds.
     *
     * @return int Number of seconds for the timeframe.
     *
     * @example
     * Timeframe::ONE_HOUR->toSeconds();
     * // Returns: 3600
     */
    public function toSeconds(): int
    {
        return match ($this) {
            self::ONE_MINUTE => 60,
            self::THREE_MINUTES => 180,
            self::FIVE_MINUTES => 300,
            self::FIFTEEN_MINUTES => 900,
            self::THIRTY_MINUTES => 1800,
            self::ONE_HOUR => 3600,
            self::TWO_HOURS => 7200,
            self::FOUR_HOURS => 14400,
            self::SIX_HOURS => 21600,
            self::EIGHT_HOURS => 28800,
            self::TWELVE_HOURS => 43200,
            self::ONE_DAY => 86400,
            self::THREE_DAYS => 259200,
            self::ONE_WEEK => 604800,
            self::ONE_MONTH => 2592000,
        };
    }
}
```

### Enum with Helper Methods

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents the side of an order (buy or sell).
 */
enum OrderSide: string
{
    case BUY = 'buy';
    case SELL = 'sell';

    /**
     * Check if the order side is buy.
     *
     * @return bool True if order side is BUY, false otherwise.
     */
    public function isBuy(): bool
    {
        return $this === self::BUY;
    }

    /**
     * Check if the order side is sell.
     *
     * @return bool True if order side is SELL, false otherwise.
     */
    public function isSell(): bool
    {
        return $this === self::SELL;
    }

    /**
     * Get the opposite side.
     *
     * @return self The opposite order side.
     */
    public function opposite(): self
    {
        return match ($this) {
            self::BUY => self::SELL,
            self::SELL => self::BUY,
        };
    }
}
```

### Enum with Properties

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents HTTP status codes with their descriptions.
 */
enum HttpStatus: int
{
    case OK = 200;
    case CREATED = 201;
    case BAD_REQUEST = 400;
    case UNAUTHORIZED = 401;
    case FORBIDDEN = 403;
    case NOT_FOUND = 404;
    case INTERNAL_SERVER_ERROR = 500;

    /**
     * Check if status code represents a successful response.
     *
     * @return bool True if status is 2xx, false otherwise.
     */
    public function isSuccess(): bool
    {
        return $this->value >= 200 && $this->value < 300;
    }

    /**
     * Check if status code represents a client error.
     *
     * @return bool True if status is 4xx, false otherwise.
     */
    public function isClientError(): bool
    {
        return $this->value >= 400 && $this->value < 500;
    }

    /**
     * Check if status code represents a server error.
     *
     * @return bool True if status is 5xx, false otherwise.
     */
    public function isServerError(): bool
    {
        return $this->value >= 500 && $this->value < 600;
    }

    /**
     * Get the status code description.
     *
     * @return string Human-readable description of the status code.
     */
    public function description(): string
    {
        return match ($this) {
            self::OK => 'The request succeeded',
            self::CREATED => 'The request succeeded and a new resource was created',
            self::BAD_REQUEST => 'The server cannot process the request due to a client error',
            self::UNAUTHORIZED => 'Authentication is required',
            self::FORBIDDEN => 'The client does not have access rights',
            self::NOT_FOUND => 'The server cannot find the requested resource',
            self::INTERNAL_SERVER_ERROR => 'The server encountered an unexpected condition',
        };
    }
}
```

### Enum Implementing Interface

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents statuses that can be displayed with colors.
 */
interface Colorizable
{
    public function color(): string;
}

/**
 * Represents order statuses with color coding.
 */
enum OrderStatus: string implements Colorizable
{
    case PENDING = 'pending';
    case PROCESSING = 'processing';
    case COMPLETED = 'completed';
    case CANCELLED = 'cancelled';

    /**
     * Get the color associated with this status.
     *
     * @return string Hex color code.
     */
    public function color(): string
    {
        return match ($this) {
            self::PENDING => '#FFA500',      // Orange
            self::PROCESSING => '#0066CC',   // Blue
            self::COMPLETED => '#00CC00',     // Green
            self::CANCELLED => '#CC0000',     // Red
        };
    }
}
```

### Enum with Static Methods

```php
<?php

// Code reviewed on YYYY-MM-DD by {git_user_name}

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents user roles in the system.
 */
enum UserRole: string
{
    case ADMIN = 'admin';
    case EDITOR = 'editor';
    case VIEWER = 'viewer';

    /**
     * Get all roles that have admin privileges.
     *
     * @return array<self> Array of admin roles.
     */
    public static function adminRoles(): array
    {
        return [
            self::ADMIN,
        ];
    }

    /**
     * Check if a role has admin privileges.
     *
     * @param  self  $role  The role to check.
     * @return bool True if role has admin privileges, false otherwise.
     */
    public static function isAdmin(self $role): bool
    {
        return in_array($role, self::adminRoles(), true);
    }

    /**
     * Get all available roles as an array.
     *
     * @return array<self> All enum cases.
     */
    public static function all(): array
    {
        return self::cases();
    }
}
```

---

## CODE SMELLS TO IDENTIFY AND FIX

### 1. Magic Strings/Numbers

**Problem**: Using raw strings or numbers instead of enums
**Solution**: Replace with enum cases

### 2. No Documentation

**Problem**: Enum lacks PHPDoc explaining its purpose
**Solution**: Add class-level PHPDoc

### 3. Inconsistent Naming

**Problem**: Enum cases not in UPPER_CASE
**Solution**: Rename cases to follow convention

### 4. Missing Type Safety

**Problem**: Enum not properly typed or missing type hints on methods
**Solution**: Add proper type annotations and `declare(strict_types=1)`

### 5. Unordered Cases

**Problem**: Enum cases in random order
**Solution**: Order alphabetically or logically

### 6. Missing Backed Enum When Needed

**Problem**: Using pure enum when values need to be stored in database
**Solution**: Convert to backed enum (string or int)

### 7. Missing Methods for Common Operations

**Problem**: Repeated logic for enum operations
**Solution**: Add methods to encapsulate enum-related behavior

### 8. No Eloquent Casting

**Problem**: Manually converting database values to/from enum
**Solution**: Add enum casting to model's `$casts` array

---

## WHAT TO DO

### Structure and Organization

- Use `declare(strict_types=1)` at the top of every enum file
- Order enum cases alphabetically or logically
- Group related cases together
- Use section separators if enum is large (>10 cases)

### Values

- Use backed enum (`enum Name: string` or `enum Name: int`) when values need to be stored
- Use pure enum when values don't need to be stored
- Use string-backed enums for API compatibility and readability
- Use int-backed enums for performance and database efficiency
- Use meaningful values that convey purpose

### Documentation

- Add class-level PHPDoc explaining purpose
- Document methods with complete PHPDoc
- Add inline comments for complex cases if needed
- Include `@param`, `@return`, `@throws` in method docblocks

### Type Safety

- Always use `declare(strict_types=1)`
- Add type hints to all methods
- Add return types to all methods
- Use `self` or `static` return types when appropriate

### Methods

- Add methods only when they encapsulate enum-related behavior
- Use descriptive method names (camelCase)
- Keep methods focused and small
- Use `match` expressions for pattern matching

### Eloquent Integration

- Add enum casting to model's `$casts` array
- Use backed enums for database storage
- Test serialization/deserialization

### Validation

- Use `Illuminate\Validation\Rules\Enum` rule in form requests
- Validate enum values in API requests

### Naming

- Use UPPER_SNAKE_CASE for enum cases
- Use PascalCase for enum class names
- Use descriptive names that convey meaning
- Avoid abbreviations unless widely understood
- Use singular nouns for enum class names

---

## WHAT NOT TO DO

### Structure

- DO NOT omit `declare(strict_types=1)`
- DO NOT mix different value types in backed enums
- DO NOT create enums with too many responsibilities
- DO NOT omit PHPDoc

### Values

- DO NOT use magic strings/numbers instead of enums
- DO NOT use pure enum when values need database storage
- DO NOT use lowercase for enum case names
- DO NOT create duplicate values

### Documentation

- DO NOT omit class-level PHPDoc
- DO NOT add obvious comments that repeat the code
- DO NOT omit method PHPDoc when methods exist
- DO NOT use comments as excuse for unclear names

### Code Quality

- DO NOT create enums with hundreds of cases (consider splitting)
- DO NOT add methods that don't relate to the enum
- DO NOT use enums for configuration that changes frequently
- DO NOT mix business logic with enum definitions unnecessarily

### Type Safety

- DO NOT omit type hints on methods
- DO NOT omit return types
- DO NOT forget `declare(strict_types=1)`
- DO NOT use `mixed` when a specific type is known

### Eloquent

- DO NOT manually convert enum values in models
- DO NOT forget to add casting when using enums in models
- DO NOT use pure enums for database storage

---

## NAMING RULES

### Enum Classes

- Use PascalCase: `OrderStatus`, `HttpStatus`, `Timeframe`
- Use singular nouns: `OrderStatus` not `OrderStatuses`
- Be descriptive: `GatewayOrderStatus` not `GOS`
- Prefix with domain when needed: `GatewayOrderStatus` vs `OrderStatus`

### Enum Cases

- Use UPPER_SNAKE_CASE: `ONE_MINUTE`, `BAD_REQUEST`, `OPEN`
- Be descriptive: `ONE_MINUTE` not `M1`
- Use consistent naming patterns within enum
- Avoid abbreviations unless widely understood

### Methods

- Use camelCase: `toSeconds()`, `isSuccess()`, `isBuy()`
- Use descriptive verbs: `toSeconds()` not `seconds()`
- Prefix boolean methods with `is`: `isSuccess()`, `isBuy()`
- Prefix conversion methods with `to`: `toSeconds()`, `toString()`

---

## CODE REVIEW CHECKLIST

### Structure

- [ ] Enum organized according to recommended structure
- [ ] `declare(strict_types=1)` present
- [ ] Cases ordered logically or alphabetically
- [ ] No duplicate values

### Values

- [ ] Backed enum used when values need database storage
- [ ] Pure enum used when values don't need storage
- [ ] String values used for API compatibility when needed
- [ ] Integer values used for performance when needed

### Documentation

- [ ] Class-level PHPDoc present
- [ ] Methods have PHPDoc (if any)
- [ ] Complex cases have inline comments (if needed)
- [ ] PHPDoc includes `@param`, `@return` where applicable

### Code Quality

- [ ] All cases use UPPER_CASE naming
- [ ] Methods are focused and enum-related
- [ ] No magic strings or numbers
- [ ] Descriptive case and method names

### Type Safety

- [ ] `declare(strict_types=1)` present
- [ ] Methods have type hints
- [ ] Methods have return types
- [ ] PHPStan/Psalm passes with strict mode

### Eloquent Integration

- [ ] Enum casting added to models (if applicable)
- [ ] Serialization/deserialization tested

### Validation

- [ ] Enum validation rules added (if applicable)

### Testing

- [ ] All tests pass
- [ ] No linting errors (PHPStan, Psalm, Laravel Pint)
- [ ] Enum is maintainable and readable

---

## FINAL OBJECTIVE

An enum file must be:

- **Organized**: Clear structure with logical case ordering
- **Typed**: Proper type annotations and `declare(strict_types=1)`
- **Documented**: Complete PHPDoc
- **Type-safe**: Proper type hints and return types
- **Maintainable**: Easy to understand and extend
- **Consistent**: Follows codebase naming conventions
- **Clean**: No magic strings, no duplication, self-documenting code

---

## COMMON REFACTORING PATTERNS

### Replace Magic Strings with Enum

**Before:**

```php
public function processOrder(string $status): void
{
    if ($status === 'open') {
        // Process open order
    }
}
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents the possible states of an order.
 */
enum OrderStatus: string
{
    case OPEN = 'open';
    case CLOSED = 'closed';
    case CANCELLED = 'cancelled';
}

public function processOrder(OrderStatus $status): void
{
    if ($status === OrderStatus::OPEN) {
        // Process open order
    }
}
```

### Convert Pure Enum to Backed Enum

**Before:**

```php
enum Priority
{
    case LOW;
    case MEDIUM;
    case HIGH;
    case CRITICAL;
}
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents priority levels for tasks.
 */
enum Priority: int
{
    case LOW = 1;
    case MEDIUM = 2;
    case HIGH = 3;
    case CRITICAL = 4;
}
```

### Add Methods for Common Operations

**Before:**

```php
enum OrderSide: string
{
    case BUY = 'buy';
    case SELL = 'sell';
}

// Repeated logic throughout codebase
if ($order->side === OrderSide::BUY) {
    // Handle buy order
}
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Enums;

/**
 * Represents the side of an order.
 */
enum OrderSide: string
{
    case BUY = 'buy';
    case SELL = 'sell';

    /**
     * Check if the order side is buy.
     *
     * @return bool True if order side is BUY, false otherwise.
     */
    public function isBuy(): bool
    {
        return $this === self::BUY;
    }

    /**
     * Check if the order side is sell.
     *
     * @return bool True if order side is SELL, false otherwise.
     */
    public function isSell(): bool
    {
        return $this === self::SELL;
    }
}

// Cleaner usage
if ($order->side->isBuy()) {
    // Handle buy order
}
```

### Add Eloquent Casting

**Before:**

```php
class Order extends Model
{
    // Manual conversion
    public function getStatusAttribute($value): OrderStatus
    {
        return OrderStatus::from($value);
    }

    public function setStatusAttribute($value): void
    {
        $this->attributes['status'] = $value instanceof OrderStatus
            ? $value->value
            : $value;
    }
}
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Models;

use App\Enums\OrderStatus;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $casts = [
        'status' => OrderStatus::class,
    ];
}
```

### Add Validation Rules

**Before:**

```php
$request->validate([
    'role' => ['required', 'in:admin,editor,viewer'],
]);
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use App\Enums\UserRole;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Enum;

class UpdateUserRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'role' => ['required', new Enum(UserRole::class)],
        ];
    }
}
```

### Use Match Expressions

**Before:**

```php
public function getColor(OrderStatus $status): string
{
    if ($status === OrderStatus::PENDING) {
        return '#FFA500';
    } elseif ($status === OrderStatus::PROCESSING) {
        return '#0066CC';
    } elseif ($status === OrderStatus::COMPLETED) {
        return '#00CC00';
    } else {
        return '#CC0000';
    }
}
```

**After:**

```php
<?php

declare(strict_types=1);

namespace App\Enums;

enum OrderStatus: string
{
    case PENDING = 'pending';
    case PROCESSING = 'processing';
    case COMPLETED = 'completed';
    case CANCELLED = 'cancelled';

    /**
     * Get the color associated with this status.
     *
     * @return string Hex color code.
     */
    public function color(): string
    {
        return match ($this) {
            self::PENDING => '#FFA500',      // Orange
            self::PROCESSING => '#0066CC',  // Blue
            self::COMPLETED => '#00CC00',    // Green
            self::CANCELLED => '#CC0000',    // Red
        };
    }
}
```

---

## LARAVEL-SPECIFIC BEST PRACTICES

### Use Backed Enums for Database Storage

Always use backed enums when values need to be stored in the database:

```php
<?php

declare(strict_types=1);

namespace App\Enums;

enum OrderStatus: string
{
    case PENDING = 'pending';
    case PROCESSING = 'processing';
    case COMPLETED = 'completed';
}
```

### Add Eloquent Casting

Add enum casting to model's `$casts` array for automatic conversion:

```php
<?php

declare(strict_types=1);

namespace App\Models;

use App\Enums\OrderStatus;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $casts = [
        'status' => OrderStatus::class,
    ];
}
```

### Use Enum Validation Rules

Use Laravel's `Enum` validation rule in form requests:

```php
<?php

declare(strict_types=1);

namespace App\Http\Requests;

use App\Enums\UserRole;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Enum;

class UpdateUserRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'role' => ['required', new Enum(UserRole::class)],
        ];
    }
}
```

### Use Match Expressions

Prefer `match` expressions over `switch` or `if/elseif` chains:

```php
public function toSeconds(): int
{
    return match ($this) {
        self::ONE_MINUTE => 60,
        self::ONE_HOUR => 3600,
        self::ONE_DAY => 86400,
    };
}
```

### Add Static Methods for Collections

Add static methods to get all cases or filter cases:

```php
<?php

declare(strict_types=1);

namespace App\Enums;

enum UserRole: string
{
    case ADMIN = 'admin';
    case EDITOR = 'editor';
    case VIEWER = 'viewer';

    /**
     * Get all available roles.
     *
     * @return array<self> All enum cases.
     */
    public static function all(): array
    {
        return self::cases();
    }

    /**
     * Get roles that have admin privileges.
     *
     * @return array<self> Admin roles.
     */
    public static function adminRoles(): array
    {
        return [
            self::ADMIN,
        ];
    }
}
```

### Use Enums in Policies

Use enums in authorization policies for better type safety:

```php
<?php

declare(strict_types=1);

namespace App\Policies;

use App\Enums\UserRole;
use App\Models\User;

class PostPolicy
{
    public function update(User $user): bool
    {
        return $user->role === UserRole::ADMIN
            || $user->role === UserRole::EDITOR;
    }
}
```

### Use Enums in Migrations

When creating migrations, use string or integer columns for enum values:

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('status'); // For string-backed enums
            // or
            $table->integer('priority'); // For int-backed enums
            $table->timestamps();
        });
    }
};
```

**Note**: Do NOT use database `ENUM` types. Use `string` or `integer` columns instead for better portability.

### Use Enums in API Resources

Use enums in API resources for consistent serialization:

```php
<?php

declare(strict_types=1);

namespace App\Http\Resources;

use App\Enums\OrderStatus;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'status' => $this->status->value, // Serialize enum value
            'status_label' => $this->status->name, // Serialize enum name
        ];
    }
}
```

---

## WHEN TO USE ENUMS

### Use Enums When:

- You have a fixed set of related constants
- Values represent states, types, or categories
- You need type safety and IDE autocomplete
- Values are used in multiple places
- You want to prevent typos and magic strings
- Values need to be stored in database (use backed enum)

### Don't Use Enums When:

- Values change frequently (use configuration instead)
- You have hundreds of cases (consider splitting)
- Values are not related to each other
- You need dynamic values at runtime
- Values are user-configurable

---

## INTEGRATION WITH TYPE CHECKERS

### PHPStan Configuration

Ensure enums work correctly with PHPStan:

```php
<?php

declare(strict_types=1);

namespace App\Enums;

enum OrderStatus: string
{
    case OPEN = 'open';
    case CLOSED = 'closed';
}

// PHPStan will catch errors
function processStatus(OrderStatus $status): void
{
    // Implementation
}

processStatus('open'); // Error: Expected OrderStatus, got string
processStatus(OrderStatus::OPEN); // OK
```

### Type Narrowing

Use enums for better type narrowing:

```php
public function handleStatus(OrderStatus $status): void
{
    if ($status === OrderStatus::OPEN) {
        // PHPStan knows status is OPEN here
    } elseif ($status === OrderStatus::CLOSED) {
        // PHPStan knows status is CLOSED here
    }
}
```

---

## PERFORMANCE CONSIDERATIONS

### String vs Integer Backed Enums

- **String-backed enums**: Better for readability, API compatibility, debugging
- **Integer-backed enums**: Better for performance, database storage efficiency

Choose based on your needs:

```php
// String-backed: Better for APIs and readability
enum OrderStatus: string
{
    case PENDING = 'pending';
}

// Integer-backed: Better for performance
enum Priority: int
{
    case LOW = 1;
}
```

### Database Storage

When storing enums in database:

- Use `string` columns for string-backed enums
- Use `integer` columns for int-backed enums
- Add indexes on enum columns if frequently queried
- Consider using int-backed enums for large datasets

---

## MIGRATION FROM CONSTANTS

### Before (Constants)

```php
<?php

namespace App\Constants;

class OrderStatus
{
    public const PENDING = 'pending';
    public const PROCESSING = 'processing';
    public const COMPLETED = 'completed';
}
```

### After (Enum)

```php
<?php

declare(strict_types=1);

namespace App\Enums;

enum OrderStatus: string
{
    case PENDING = 'pending';
    case PROCESSING = 'processing';
    case COMPLETED = 'completed';
}
```

**Benefits:**

- Type safety
- IDE autocomplete
- Better refactoring support
- Can add methods
- Laravel integration (casting, validation)
