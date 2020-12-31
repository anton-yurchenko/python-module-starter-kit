I := "⚪"
E := "🔴"
PKG_NAME := $(notdir $(CURDIR))

PIPENV := /usr/local/bin/pipenv
$(PIPENV):
	@echo "$(I) installing pipenv"
	@pip install pipenv || (echo "$(E) error installing pipenv"; exit 1)

.PHONY: init
init:
	@echo "$(I) creating package"
	@mv python_module_starter_kit/python_module_starter_kit.py python_module_starter_kit/$(PKG_NAME).py && \
		mv python_module_starter_kit $(PKG_NAME) && \
		mv tests/test_python_module_starter_kit.py tests/test_$(PKG_NAME).py
	@echo "$(I) creating environment"
	@pipenv install || (echo "$(E) error creating package"; exit 1)

.PHONE: active
active:
	@echo "$(I) activating virtual environment"
	@pipenv shell --fancy || (echo "$(E) error creating virtual environment"; exit 1)
