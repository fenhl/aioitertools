build:
	python3 setup.py build

dev:
	python3 setup.py develop

setup:
	pip3 install -U black mypy pylint twine

venv:
	python3 -m virtualenv .venv
	source .venv/bin/activate && make setup dev
	echo 'run `source .venv/bin/activate` to use virtualenv'

release: lint test clean
	python3 setup.py sdist
	python3 -m twine upload dist/*

black:
	black aioitertools setup.py

lint:
	black --check aioitertools setup.py
	pylint --rcfile .pylint aioitertools setup.py
	-mypy --ignore-missing-imports --python-version 3.6 .

test:
	python3 -m unittest -v aioitertools.tests

clean:
	rm -rf build dist README MANIFEST .venv *.egg-info
