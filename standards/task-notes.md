# Task Notes Standard

## Code Review Comment

When completing a task that involves code review, add a code review comment at the beginning of the file:

- Note indicating this file was code reviewed
- Date (YYYY-MM-DD format only, no time) from local system date
- Git user name from git configuration (`git config user.name`)

### Format by Language

**PHP:**

```php
// Code reviewed on YYYY-MM-DD by {git_user_name}
```

**Python:**

```python
# Code reviewed on YYYY-MM-DD by {git_user_name}
```

**Other languages:** Use the appropriate comment syntax for the language.
