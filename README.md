# Installation
- [certora-cli](https://docs.certora.com/en/latest/docs/user-guide/getting-started/install.html)
- [slither](https://github.com/crytic/slither#how-to-install)
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [solc-select](https://github.com/crytic/solc-select)(optional)

# How to run

- Install dependencies and compile contracts
```
forge install
forge build
```

- Run slither
```
slither ./src
```

- Run certora
```
sh run.sh
```