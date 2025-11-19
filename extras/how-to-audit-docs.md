# How to Audit Documentation Guides

## MANDATORY PROCESS BEFORE STARTING

**BEFORE auditing any documentation, THE AUDITOR MUST:**

0. **Read the execution guide first**: Read `standards/task-execution.md` to understand the general execution process and documentation standards.

1. **Understand the document's purpose**: Identify what the document is meant to accomplish and who the target audience is (AI assistants, developers, etc.).

2. **Review similar documents**: Check other documentation files in the same directory to understand the expected structure and style consistency.

**THEN, follow this comprehensive audit checklist:**

---

## AUDIT PHASES

### Phase 1: Structure and Organization

- [ ] Document has a clear, descriptive title using H1 (`# Title`)
- [ ] Document follows consistent heading hierarchy (H1 → H2 → H3)
- [ ] Document has a "MANDATORY PROCESS BEFORE STARTING" section if it's an execution guide
- [ ] Document is organized into logical sections/phases
- [ ] Each major section has a clear purpose
- [ ] Sections are numbered or named consistently
- [ ] Document uses horizontal rules (`---`) to separate major sections when appropriate
- [ ] Code blocks use proper language tags
- [ ] Lists use consistent formatting (bullets vs numbers)
- [ ] Checkboxes are used for actionable items (`- [ ]`)

**Common Issues to Check:**
- Missing or unclear title
- Inconsistent heading levels
- Sections without clear purpose
- Mixed list formatting
- Code blocks without language tags

---

### Phase 2: Clarity and Precision

- [ ] All instructions are clear and unambiguous
- [ ] Technical terms are defined when first introduced
- [ ] Acronyms are spelled out on first use
- [ ] Language is direct and specific (avoids vague terms like "maybe", "perhaps", "sometimes")
- [ ] Instructions use imperative mood ("Do X", "Verify Y", "Check Z")
- [ ] No contradictory statements exist
- [ ] Conditional logic is explicit ("If X, then Y, otherwise Z")
- [ ] Edge cases are explicitly mentioned

**Common Issues to Check:**
- Vague instructions ("try to do X")
- Undefined technical terms
- Contradictory guidance
- Missing edge case handling
- Ambiguous conditional statements

---

### Phase 3: Completeness and Context

- [ ] Document includes sufficient context for understanding
- [ ] Prerequisites are clearly stated
- [ ] Dependencies on other documents are referenced
- [ ] Required background knowledge is mentioned
- [ ] Document references related files/modules when relevant
- [ ] Examples are provided for complex concepts
- [ ] Both positive examples (what to do) and negative examples (what not to do) are included
- [ ] Real-world scenarios or use cases are described

**Common Issues to Check:**
- Missing prerequisites
- Unreferenced dependencies
- Lack of examples for complex instructions
- Missing context about when to use the document
- No negative examples showing what to avoid

---

### Phase 4: Explicit Constraints and Guardrails

- [ ] Document explicitly states what MUST be done
- [ ] Document explicitly states what MUST NOT be done
- [ ] Document includes a "WHAT TO DO" section
- [ ] Document includes a "WHAT NOT TO DO" section
- [ ] Restrictions are clearly marked (using keywords like MUST, MUST NOT, ALWAYS, NEVER)
- [ ] Optional vs required steps are clearly distinguished
- [ ] Validation requirements are specified
- [ ] Error handling requirements are stated
- [ ] Limits and boundaries are defined (e.g., "maximum 3 retries", "must complete within 5 minutes")

**Common Issues to Check:**
- Missing explicit restrictions
- Unclear distinction between required and optional steps
- No validation requirements
- Missing error handling guidance
- Vague boundaries or limits

---

### Phase 5: Step-by-Step Process

- [ ] Document breaks down complex tasks into phases or steps
- [ ] Each phase has a clear name and purpose
- [ ] Steps are numbered sequentially (1, 2, 3) or hierarchically (1.1, 1.2, 2.1)
- [ ] Each step has actionable checkboxes (`- [ ]`)
- [ ] Steps are in logical order (prerequisites first, then execution)
- [ ] Steps include success criteria or validation points
- [ ] User confirmation points are explicitly marked ("WAIT FOR USER CONFIRMATION")
- [ ] Steps that can be skipped have clear conditions ("If X is already done, skip to step Y")

**Common Issues to Check:**
- Steps not broken down enough
- Missing checkboxes for actionable items
- Steps out of logical order
- No success criteria for steps
- Missing user confirmation points
- Unclear skip conditions

---

### Phase 6: Examples and Code Samples

- [ ] Code examples are provided for key concepts
- [ ] Examples use proper syntax highlighting
- [ ] Examples are complete and runnable (or clearly marked as snippets)
- [ ] Before/after examples are provided when showing transformations
- [ ] Examples match the actual codebase style
- [ ] Negative examples (anti-patterns) are included
- [ ] Examples are commented when behavior is non-obvious
- [ ] File paths in examples are accurate and follow project structure

**Common Issues to Check:**
- Missing code examples
- Incomplete or broken code examples
- Examples that don't match project style
- No negative examples
- Incorrect file paths
- Uncommented complex examples

---

### Phase 7: Validation and Verification

- [ ] Document includes a final validation checklist
- [ ] Each phase includes verification steps
- [ ] Testing requirements are specified ("Run tests", "Verify linting")
- [ ] Success criteria are defined for each phase
- [ ] Document specifies what to do if validation fails
- [ ] Document includes a "Final Verification" or "Final Checklist" section
- [ ] Verification steps are actionable and measurable

**Common Issues to Check:**
- Missing final validation
- No verification steps in phases
- Vague success criteria
- No guidance on handling failures
- Non-measurable verification steps

---

### Phase 8: User Interaction and Confirmation

- [ ] Document specifies when to wait for user confirmation
- [ ] Confirmation points are explicitly marked ("WAIT FOR USER CONFIRMATION")
- [ ] Document explains what information to present before waiting
- [ ] Document specifies when to ask for user preferences
- [ ] Document includes guidance on handling user feedback
- [ ] Document explains when to proceed without confirmation (if applicable)

**Common Issues to Check:**
- Missing confirmation points
- Unclear what to present before confirmation
- No guidance on user interaction
- Missing user preference questions

---

### Phase 9: Error Prevention and Edge Cases

- [ ] Document addresses common mistakes or pitfalls
- [ ] Edge cases are explicitly mentioned
- [ ] Document includes "Common Issues to Check" sections
- [ ] Error scenarios are described
- [ ] Recovery procedures are provided for errors
- [ ] Document explains how to handle unexpected situations
- [ ] Document includes troubleshooting guidance

**Common Issues to Check:**
- Missing common pitfalls section
- No edge case handling
- No error recovery guidance
- Missing troubleshooting information

---

### Phase 10: Consistency and Standards

- [ ] Document follows the same structure as similar documents
- [ ] Document uses consistent terminology throughout
- [ ] Document follows naming conventions (file names, function names, etc.)
- [ ] Document references standards documents when applicable
- [ ] Document uses consistent formatting (markdown, code blocks, lists)
- [ ] Document follows the project's documentation style guide
- [ ] Document is consistent with `standards/task-execution.md` format

**Common Issues to Check:**
- Inconsistent structure compared to other docs
- Terminology inconsistencies
- Formatting inconsistencies
- Not following project standards
- Missing references to standards

---

## AUDIT CHECKLIST SUMMARY

### Critical Requirements (Must Have)

- [ ] Clear title and structure
- [ ] MANDATORY section if it's an execution guide
- [ ] Step-by-step phases with checkboxes
- [ ] Explicit constraints (MUST/MUST NOT)
- [ ] Examples (positive and negative)
- [ ] Validation steps
- [ ] User confirmation points
- [ ] Final verification checklist

### Important Requirements (Should Have)

- [ ] Prerequisites section
- [ ] Context and background
- [ ] References to related documents
- [ ] Error handling guidance
- [ ] Edge case handling
- [ ] Common pitfalls section
- [ ] Troubleshooting guidance

### Nice to Have (Optional)

- [ ] Visual diagrams or flowcharts
- [ ] Quick reference section
- [ ] FAQ section
- [ ] Related resources links
- [ ] Version history

---

## AUDIT REPORT TEMPLATE

After completing the audit, create a report with:

```
# Audit Report: [Document Name]

## Overall Assessment
- [ ] Passes all critical requirements
- [ ] Passes all important requirements
- [ ] Overall quality score: [X/10]

## Issues Found

### Critical Issues (Must Fix)
1. [Issue description]
   - Location: [Section/Line]
   - Impact: [Why it matters]
   - Recommendation: [How to fix]

### Important Issues (Should Fix)
1. [Issue description]
   - Location: [Section/Line]
   - Impact: [Why it matters]
   - Recommendation: [How to fix]

### Minor Issues (Nice to Fix)
1. [Issue description]
   - Location: [Section/Line]
   - Recommendation: [How to fix]

## Strengths
- [What the document does well]

## Recommendations
- [Specific improvements to consider]
```

---

## COMMON PATTERNS TO VERIFY

### Pattern 1: Execution Guides
Should have:
- MANDATORY PROCESS BEFORE STARTING section
- Phases with checkboxes
- WAIT FOR USER CONFIRMATION points
- Final verification section

### Pattern 2: Standards Documents
Should have:
- Clear definition of the standard
- Examples of correct usage
- Examples of incorrect usage
- Reference to related standards

### Pattern 3: Workflow Documents
Should have:
- Prerequisites
- Step-by-step process
- Decision points
- Validation steps
- Error handling

---

## VALIDATION QUESTIONS

Before marking a document as "audited", ask:

1. **Clarity**: Can an AI assistant understand and execute this without ambiguity?
2. **Completeness**: Are all necessary steps, constraints, and examples included?
3. **Consistency**: Does this follow the same patterns as other documentation?
4. **Actionability**: Can someone follow this step-by-step and achieve the goal?
5. **Error Prevention**: Does this prevent common mistakes and handle edge cases?
6. **User Experience**: Does this guide the user through the process smoothly?

---

## FINAL OBJECTIVE

A well-audited documentation guide must be:

- **Clear**: Unambiguous instructions that leave no room for misinterpretation
- **Complete**: All necessary information, examples, and constraints included
- **Consistent**: Follows project standards and matches similar documents
- **Actionable**: Step-by-step process with checkboxes and validation points
- **Robust**: Handles edge cases, errors, and common pitfalls
- **User-Friendly**: Guides users through the process with confirmation points
- **Maintainable**: Easy to update and extend as requirements change

---

## QUICK REFERENCE: RED FLAGS

If you see any of these, the document needs improvement:

- ❌ Vague instructions ("try to", "maybe", "sometimes")
- ❌ Missing checkboxes for actionable steps
- ❌ No examples or only positive examples
- ❌ No explicit constraints (MUST/MUST NOT)
- ❌ Missing user confirmation points
- ❌ No validation or verification steps
- ❌ Contradictory statements
- ❌ Undefined technical terms
- ❌ Steps out of logical order
- ❌ Missing final checklist
- ❌ Inconsistent formatting
- ❌ No error handling guidance

