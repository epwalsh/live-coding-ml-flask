app = petesapp
test := $(app)
env = local.env
image = petesapp
tag = latest

.PHONY : lint
lint :
	@echo "Running linter (pylint):"
	@pylint --rcfile=.pylintrc -f colorized $(app)

.PHONY : typecheck
typecheck :
	@echo "Running typechecker (mypy):"
	@mypy $(app) --ignore-missing-imports

.PHONY : unit-tests
unit-tests :
	@echo "Running unit tests (pytest):"
	@export $$(grep -Ev "^$$|^#." $(env) | xargs) && python -m pytest -vv --color=yes $(test)

.PHONY : test
test : lint typecheck unit-tests

.PHONY : docker-build
docker-build :
	docker build -t $(image):$(tag) -f Dockerfile .

.PHONY : docker-run
docker-run :
	docker run -p 5000:5000 --env-file $(env) --rm $(image):$(tag)
