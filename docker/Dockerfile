FROM python:3.8.5-slim-buster

COPY . /

RUN apt-get update \
  && apt-get install -y mariadb-server --no-install-recommends \
  && apt-get install -y libmariadbclient-dev --no-install-recommends \
  && apt-get install -y gcc --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install -r requirements.txt && pip install gunicorn

RUN chmod +x /runserver.sh
ENTRYPOINT ["/runserver.sh"]