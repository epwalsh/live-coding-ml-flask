app = petesapp
test := $(app)
env = local.env

.PHONY : lint
lint :
	@echo "Running linter (pylint):"
	@pylint --rcfile=.pylintrc -f colorized $(app)

.PHONY : typecheck
typecheck :
	@echo "Running typechecks (mypy):"
	@mypy $(app) --ignore-missing-imports

.PHONY : unit-tests
unit-tests :
	@echo "Running unit tests (pytest):"
	@export $$(cat $(env) | grep -Ev "^$$|^#." | xargs) && python -m pytest -vv --color=yes $(test)

.PHONY : test
test : lint typecheck unit-tests
