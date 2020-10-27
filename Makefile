.PHONY: fixed format mutants tests

format:
	./vendor/bin/phpcs
	./vendor/bin/phpcbf

mutants:
	@echo "Aqui va el mutants"
	
tests:
	@echo "Aqui va el test"