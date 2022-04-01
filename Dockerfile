FROM alpine:3.15

RUN apk update && apk add --no-cache python3 py-pip py-virtualenv python3-dev

RUN apk add postgresql-client

WORKDIR /app

COPY ./requirements.txt requirements.txt

RUN mkdir venv
RUN mkdir log
RUN touch log/error.log
RUN touch log/access.log
RUN chown 1000140001 venv log/error.log log/access.log

USER 1000140001

COPY ./app .

ENV VIRTUAL_ENV=venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD gunicorn app:app -b 0.0.0.0:5000 --error-logfile log/error.log --access-logfile log/access.log