[octopin](https://github.com/eclipse-csi/octopin)

```
$ nix shell git+https://github.com/raboof/octopin?ref=nix --no-write-lock-file
$ octopin
Usage: octopin [OPTIONS] COMMAND [ARGS]...
Try 'octopin --help' for help.
╭─ Error ────────────────────────────────────────────────────╮
│ Missing command.                                           │
╰────────────────────────────────────────────────────────────╯
```

or

```
$ nix run git+https://github.com/raboof/octopin?ref=nix --no-write-lock-file -- pin --inplace .github/workflows/*
```
