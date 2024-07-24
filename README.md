# Pod-Shop-App-Configs
the public app config repo

so we are currently trying to setup a git proxy that pushes the commit to a private repo, to get tested before any code/sensible data even be visible in our public repo. the reason was that i noticed that terraform and vault provider is kinda fucked and i dont want to leak any sensible data, so i decided to choose a zero trust approach for this, so nobody can even do any dumb shit.

- pre commit hook seals the code, sets up a pr and sends code to a private repo
- pull request and its sealed code awaits status check
- another hook pushes back into the pr including test results
- another review is required to unseal code in public pr

- added credentials to sign intoo private repo and process iac configuration checks in a private repo before pushing to publlic

k
