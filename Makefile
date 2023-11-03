.PHONY: test
PWD := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

test :; docker run -v $(PWD):/app foundry "forge test --root /app -vvvv"
