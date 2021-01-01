I := "⚪"
E := "🔴"
PROJ_NAME := $(notdir $(CURDIR))
PKG_NAME := $(shell echo $(notdir $(CURDIR)) | sed 's/-/_/g')
REPO_NAME := $(shell git config --get remote.origin.url | sed -r 's/.*(\@|\/\/)(.*)(\:|\/)([^:\/]*)\/([^\/\.]*)\.git/\4\/\5/')

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
	@sed -i "s|anton-yurchenko/python-module-starter-kit|$(REPO_NAME)|g" README.md && \
		sed -i "s|python-module-starter-kit|$(PROJ_NAME)|g" README.md
	@echo "$(I) creating environment"
	@pipenv install || (echo "$(E) error creating package"; exit 1)

.PHONY: active
active:
	@echo "$(I) activating virtual environment"
	@pipenv shell --fancy || (echo "$(E) error creating virtual environment"; exit 1)
