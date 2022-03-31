FROM alpine:3.9

RUN apk update && apk add python3 py-pip py-virtualenv uwsgi-python3

RUN pip3 install --upgrade pip

WORKDIR /app

COPY ./requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY ./app /app

USER 1000

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]