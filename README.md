# Automations for AI for Programmers

A collection of structured workflows and standards for AI assistants to execute code refactoring and quality improvement tasks consistently and reliably.

## Structure

```
automations-for-ai-for-programmers/
├── workflows/              # Step-by-step procedures for specific tasks
│   ├── laravel/
│   │   ├── refactor-classes.md
│   │   └── refactor-tests.md
│   └── python/
│       └── refactor-classes.md
├── standards/              # General execution standards and rules
│   ├── task-execution.md
│   └── task-notes.md
└── README.md               # This file
```

## Workflows

Workflows are language-specific procedures that guide AI assistants through complex refactoring tasks:

### Laravel

- **[Refactor Classes](workflows/laravel/refactor-classes.md)**: Comprehensive guide for refactoring Laravel/PHP classes (controllers, services, etc.) following best practices
- **[Refactor Tests](workflows/laravel/refactor-tests.md)**: Guide for refactoring Laravel/PHP test files to improve maintainability and reusability

### Python

- **[Refactor Classes](workflows/python/refactor-classes.md)**: Comprehensive guide for refactoring Python classes following best practices

## Standards

Standards define the general execution framework that all workflows follow:

- **[Task Execution](standards/task-execution.md)**: Core process for breaking down tasks, creating plans, and handling user confirmations

## Setup

To use this project as a submodule in your repository and configure Cursor to detect only the workflows for your technology stack:

### 1. Add as Git Submodule

Add this repository as a submodule in your project's `docs/` directory:

```bash
git submodule add https://github.com/pedrocarvajal/ai-refactoring-workflows.git docs/ai-refactoring-workflows
```

### 2. Create Symbolic Link

Create a symbolic link in `.cursor/commands/` pointing to the workflows for your technology:

**For Python projects:**
```bash
ln -s ../../docs/ai-refactoring-workflows/workflows/python .cursor/commands/workflows
```

**For Laravel projects:**
```bash
ln -s ../../docs/ai-refactoring-workflows/workflows/laravel .cursor/commands/workflows
```

### 3. Verify Configuration

Verify that the symlink is correctly set up:

```bash
ls -la .cursor/commands/workflows/
```

You should see only the workflow files for your selected technology (e.g., `refactor-classes.md`, `refactor-enums.md`, etc.).

### 4. Update Submodule

When you need to pull the latest workflows:

```bash
git submodule update --remote docs/ai-refactoring-workflows
```

## Usage

When executing a refactoring task:

1. **Read the execution standard first**: Start with `standards/task-execution.md` to understand the general process
2. **Select the appropriate workflow**: Choose the workflow that matches your task (e.g., `workflows/laravel/refactor-classes.md`)
3. **Follow the workflow phases**: Execute each phase sequentially, waiting for user confirmation between phases

## Contributing

When adding new workflows:

- Place them in the appropriate language directory under `workflows/`
- Follow the naming convention: `refactor-{target}.md`
- Always reference `standards/task-execution.md` at the beginning
- Include phase-by-phase checklists with clear success criteria

## License

This repository contains automation guides and standards for AI-assisted code refactoring.
