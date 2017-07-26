init:
	pip install pipenv
	pipenv install --three

run:
	pipenv run python ./hosts.py

clean:
	pipenv --rm
