FROM alpine:3.15

RUN apk update && apk add --no-cache python3 py-pip py-virtualenv python3-dev
RUN apk add --no-cache\
		gcc \
		libc-dev \
		linux-headers \
	;

WORKDIR /echopy

COPY ./requirements.txt requirements.txt

RUN mkdir -p /.local/bin

RUN chown -R 1000:1000 /.local

USER 1000

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/.local/bin

COPY ./echopy /echopy

RUN source /echopy/bin/activate

RUN pip3 install --no-cache-dir --user -r requirements.txt

EXPOSE 5000

WORKDIR /echopy/app

ENTRYPOINT [ "uwsgi" ]

CMD [ "--socket", "0.0.0.0:5000", "--protocol=http", "-w", "wsgi:app"]