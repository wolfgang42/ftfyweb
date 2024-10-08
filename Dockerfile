FROM python:3.13

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD [ "python", "-m", "bottle", "--bind=0.0.0.0:8080", "index" ]
