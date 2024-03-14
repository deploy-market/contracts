# deploy.market

[![codecov](https://codecov.io/gh/deploy-market/contracts/graph/badge.svg?token=C4LP39DKG4)](https://codecov.io/gh/deploy-market/contracts)

A Verifiable Craigslist for transactions.

## Development

This project uses Foundry for development.

### Testing and generating coverage

```bash
forge test
forge coverage --report lcov
```

### Building for deployment (bytecode, ABI)
  
```bash
forge build --extra-output abi
```
