work:
	sudo darwin-rebuild switch --flake .#work

personal:
	sudo darwin-rebuild switch --flake .#personal

.PHONY: work personal
