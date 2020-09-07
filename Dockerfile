FROM ubuntu:18.04
RUN apt-get update -qq
RUN apt-get install python3-pip -qq
ADD . /simpleApp
WORKDIR /simpleApp
COPY . .
RUN apt-get update -qq
RUN pip3 install -r requirements.txt
RUN python3.6 manage.py makemigrations
RUN python3.6 manage.py migrate
EXPOSE 8000
CMD ["python3.6", "manage.py", "runserver", "0.0.0.0:8000"]
