help: # Print this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

cc: # Print Mops Copyright Info
	@echo 'MOPS (c) MIT 2023' # Makefile hack to make all recipes look un-built

hygen: cc # Install Hygen - Code Generation Tool
	brew tap jondot/tap && \
	brew install hygen

config: cc # Initialze Source Code for a New Project
	hygen mops config

mops: cc # Generate Mops Project Code
	hygen mops project

