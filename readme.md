# My NixOS configuration

## Snippets

User home directory:

```nix
  home = config.users.users.${config.plusultra.user.name}.home;
```
