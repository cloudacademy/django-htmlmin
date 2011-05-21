dependencies: coverage django BeautifulSoup specloud

clean:
	@find . -name "*.pyc" -delete

coverage:
	@python -c 'import coverage' 2>/dev/null || pip install coverage

django:
	@python -c 'import django' 2>/dev/null || pip install django

BeautifulSoup:
	@python -c 'import BeautifulSoup' 2>/dev/null || pip install BeautifulSoup

specloud:
	@python -c 'import specloud' 2>/dev/null || pip install specloud

test: dependencies clean
	@specloud --with-xunit --xunit-file=nose.xml --with-coverage --cover-erase --cover-package=htmlmin --verbosity=2 --where=htmlmin/tests

pico_django:
	@cd htmlmin/tests && PYTHONPATH=../..:.:$$PYTHONPATH django-admin.py runserver 0.0.0.0:8000 --settings=pico_django

kill_pico_django:
	@kill -9 `ps aux | grep "django-admin.py runserver 0.0.0.0:8000" | awk '{print $$2}'`
