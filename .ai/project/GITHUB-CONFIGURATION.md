# GitHub Configuration — Waheed

## Current Status
- **Local Git**: ✅ Initialized, initial commit completed
- **Remote repository**: ❌ Not configured
- **GitHub connection**: ❌ Not established

## Intended Lifecycle

### Repository Policy
- **Visibility**: Private (default)
- **Remote setup**: Requires explicit user authorization (approval gate)
- **First push**: Only after final validation of committed content

### Safety Policy
- No blind `git push --force`
- No destructive Git operations (`reset --hard`, `clean -fd` on untracked) without approval
- No force push to main/master branch
- All secrets must be excluded before any push (`.gitignore` enforced)

### Secret Protection
The following are excluded via `.gitignore`:
- `.env`, `.env.*` (except `.env.example`)
- `android/local.properties`
- `*.jks`, `*.keystore`, `key.properties`

Before first remote push, verify:
- [ ] No API keys in source code
- [ ] No tokens or passwords in committed files
- [ ] No private production data
- [ ] `.gitignore` covers all sensitive files
- [ ] `git log` does not contain secrets in history

### Branching Strategy
Not yet defined. Recommended options (to be selected by user):
- **Simple**: Work directly on `main`, tag releases
- **Feature branches**: `main` + `feature/*` branches, merge via PR
- **Gitflow**: `main` + `develop` + `feature/*` + `release/*`

### Push Authorization
- Automatic push: **Disabled** until explicitly authorized by user
- Manual push: User-initiated only
- Future automation: Requires explicit opt-in

## Required User Actions for GitHub Setup
1. Create a private repository on GitHub
2. Add remote: `git remote add origin <url>`
3. Authorize first push
4. (Optional) Configure branch protection rules
5. (Optional) Set up CI/CD

## Notes
- The AI Engineering System will never push to remote without authorization.
- The AI Engineering System will never create a GitHub repository without approval.
- All `.ai/` and `.agents/` files are committed to the repository for persistence.
