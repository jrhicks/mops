help: # Print this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

hygen-cli: # Install Hygen (Code Generation Tool) used by mops
	brew tap jondot/tap && \
	brew install hygen

mops-config: # Generate Inial Configuration
	hygen mops config

mops-project: # Generate Mops Project Code
	hygen mops project
