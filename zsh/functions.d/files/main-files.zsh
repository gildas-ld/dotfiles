#!/usr/bin/zsh

_mkenv() {
	# Add 'venv/' to .gitignore if not already present
	if [ -f ".gitignore" ]; then
		grep -qxF "venv/" .gitignore || echo "venv/" >> .gitignore
	else
		echo "venv/" > .gitignore
	fi

	# Create the virtual environment if it doesn't exist
	if [ ! -d "venv" ]; then
		print -P "%F{yellow}Creating virtual environment...%f"
		python3 -m venv venv
	fi

	# Activate the virtual environment
	if [ -f "./venv/bin/activate" ]; then
		source ./venv/bin/activate
		print -P "%F{green}Virtual environment activated at: $VIRTUAL_ENV%f"
	else
		print -P "%F{red}Failed to activate virtual environment.%f" >&2
		return 1
	fi
}

# Define alias for easy use
alias mkvenv=_mkenv

_senv() {
	# Add 'venv/' to .gitignore if not already present
	if [ -f ".gitignore" ]; then
		grep -qxF "venv/" .gitignore || echo "venv/" >> .gitignore
	else
		echo "venv/" > .gitignore
	fi

	# Activate the virtual environment
	if [ -f "./venv/bin/activate" ]; then
		source ./venv/bin/activate
		print -P "%F{green}Virtual environment activated at: $VIRTUAL_ENV%f"
	else
		print -P "%F{red}Failed to activate virtual environment.%f" >&2
		return 1
	fi
}

# Define alias for easy use
alias senv=_senv
