.PHONY: format tests mutants

format:
	./vendor/bin/phpcs
	
tests:
	@echo "Aqui va el test"

mutants:
	@echo "Aqui va el mutants"