FROM debian:latest
RUN apt-get update && apt-get install -y nginx && apt-get install -y python3 && apt-get install -y pip && apt-get install -y curl && apt-get install -y tesseract-ocr && apt-get install -y libtesseract-dev
RUN pip install -I gunicorn && apt-get install -y gunicorn && pip install flask && pip install pytesseract && pip install pillow
RUN useradd -m projet --shell /bin/bash && mkdir /home/projet/app
ADD /structure/app /home/projet/app
RUN chown projet:projet -R /home/projet
ADD /structure/default /etc/nginx/sites-enabled/default
RUN service nginx start
WORKDIR "/home/projet/app" 
ENTRYPOINT gunicorn -w 3 wsgi:app -u projet -D && service nginx start && tail -f /dev/null
