FROM python:3.7-alpine

LABEL maintainer="Cintia Fumi <cintiafumi@gmail.com>"

WORKDIR /opt/app/ecom-app
COPY /app .

# -- Install dependencies:
RUN apk update && \
  apk upgrade && \
  apk --no-cache add gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev build-base linux-headers build-base curl-dev \
  && pip3 install --upgrade pip \
  && pip3 install -r /opt/app/ecom-app/requirements.txt \
  && pip3 install flask_wtf

EXPOSE 5000

ENV FLASK_APP=main.py
ENV FLASK_ENV=development

# Create a group and user
RUN adduser -S ecom_front
USER ecom_front

ENTRYPOINT ["python", "run.py"]