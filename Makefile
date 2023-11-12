.PHONY: test anvil
PWD := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

test :; docker run -v $(PWD):/app foundry "forge test --root /app -vvvv"
anvil :; docker run -v $(PWD):/app foundry "anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/CvNn9Y-yl8QXHM7k62LYW9sXoicqzPOp"
