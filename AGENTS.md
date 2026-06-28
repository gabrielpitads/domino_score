# AGENTS.md

**Version:** 3.44

## Commit Best Practices

- Follow [Conventional Commits](https://www.conventionalcommits.org/): `<type>(<scope>): <description>`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `chore`, `perf`, `ci`
- Scope examples: `ui`, `data`, `api`, `auth`, `core`, `bloc`, `widgets`
- Keep commits small and focused — one logical change per commit
- Write descriptions in imperative mood: "add login screen" not "added login screen"
- Reference issue numbers when applicable: `fix(auth): handle token expiry (#42)`
- No commits that break the build or leave the app in a broken state
- Squash fixup commits before merging

## Code Quality Best Practices

### General
- Run `dart format .` before every commit
- Run `dart analyze` and resolve all warnings and errors — no exceptions
- Strict lint rules: prefer `package:flutter_lints/flutter.yaml` or `very_good_analysis`
- Keep methods short (< 20 lines where possible); extract widgets into small, focused methods
- Avoid nested ternary operators; prefer `if/else` or early returns
- Use `const` constructors everywhere possible
- Avoid `dynamic` — prefer explicit types, `Object?`, or generics

### State Management
- Use a consistent approach (e.g., BLoC, Riverpod, Provider) across the entire app
- Keep business logic out of widgets — use controllers/cubits/blocs
- UI files should only contain layout and bindings, no logic

### Testing
- **Unit tests:** Cover all controllers, blocs, repositories, and services
- **Widget tests:** Cover every screen's main states (loading, empty, error, data)
- **Integration tests:** Cover critical user flows (login, checkout, etc.)
- All tests must pass before committing: `flutter test`
- Maintain >80% code coverage on core business logic

### Architecture
- Follow a layered architecture: `presentation` → `domain` → `data`
- Use repositories as the single source of truth for data access
- Prefer immutable models with `freezed` or `equatable`
- Inject dependencies (service locator or constructor injection)

### Widgets
- Prefer `StatelessWidget` over `StatefulWidget` unless state is required
- Extract reusable widgets into their own files
- Use `MediaQuery` / `LayoutBuilder` for responsiveness
- Use semantic widgets (`Semantics`, `Tooltip`) for accessibility

## Review Checklist
- [ ] `dart format .` passes
- [ ] `dart analyze` has zero issues
- [ ] `flutter test` passes
- [ ] No `print()` or `debugPrint()` left in production code
- [ ] No hardcoded strings — use `AppLocalizations`
- [ ] No magic numbers/strings — define constants
- [ ] New widgets have corresponding tests
