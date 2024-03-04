# deploy.market

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
