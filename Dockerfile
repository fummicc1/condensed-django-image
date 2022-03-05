# Database（PostgreSQL）
FROM postgres:12 as db
ENV POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=pass \
    POSTGRES_DB=anime_app
# `docker run -P`で接続
EXPOSE 5432
# `docker run -v`で接続
VOLUME "/var/lib/postgresql/data"


# Backend (Django application)
FROM python:3.7-slim as backend
WORKDIR /code
EXPOSE 8000
COPY ./ ./
RUN pip install -r requirements.txt
COPY --from=db /var/lib/postgresql/data db_data/
CMD bash -c \
    "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"    
