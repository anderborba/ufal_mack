FROM ubuntu:18.04
COPY . /
RUN apt-get update -y && apt-get install -y python3-dev python3-pip
RUN apt-get install -y nginx
RUN ln -s /figuras /var/www/html/imagens
RUN echo "<meta http-equiv='refresh' content='0;URL=http://localhost:8080/imagens/'/>" > /var/www/html/index.html
RUN pip3 install scikit-image
ENV DATA ./Data/AirSAR_Flevoland_Enxuto.mat
RUN python3 main.py $DATA
EXPOSE 80
CMD echo "Acesse http://localhost:8080" && nginx -g 'daemon off;'
