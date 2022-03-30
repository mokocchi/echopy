FROM alpine:3.9

RUN apk update && apk add python3 py-pip py-virtualenv uwsgi-python3

RUN pip3 install --upgrade pip
COPY ./requirements.txt /application/requirements.txt

WORKDIR /application

RUN pip3 install -r requirements.txt

COPY ./application /application

ENTRYPOINT [ "python3" ]

CMD [ "entrypoint.py" ]