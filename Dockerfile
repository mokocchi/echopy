FROM alpine:3.15

RUN apk update && apk add --no-cache python3 py-pip py-virtualenv python3-dev

RUN apk add postgresql-client

WORKDIR /app

COPY ./requirements.txt requirements.txt

RUN mkdir venv

RUN chown 0 venv

USER 0

COPY ./app .

ENV VIRTUAL_ENV=venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD gunicorn app:app -b 0.0.0.0:5000