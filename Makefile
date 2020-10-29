.PHONY: format mutants tests

format:
	./vendor/bin/phpcs
	./vendor/bin/phpcbf

mutants:
	@echo "Aqui va mutants"

tests:
	./vendor/bin/phpunit
