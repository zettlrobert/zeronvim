# Git

Show local branches:

```sh
git branch
```

List all remote branches

```sh
git branch -r
```

List all local and remote branches

```sh
git branch -a
```

Show detailed information

```sh
git branch -vv
bit branch -vva
```

## Edge Case

Fetch all remote branches, and pull them to local

```sh
git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
```
