FROM python:3.11-slim-bookworm

USER root

WORKDIR /app

COPY /api ./api
COPY /assets ./assets
COPY pyproject.toml .
COPY Makefile .

RUN apt-get update && apt-get install -y git make

RUN make

EXPOSE 8000
ENV LISTEN_PORT = 8000

CMD ["uvicorn", "api.main:app", "--host=0.0.0.0", "--proxy-headers"]