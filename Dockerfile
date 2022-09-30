FROM balenalib/raspberry-pi-debian

ENV NEO4J_HOME="/var/lib/neo4j"

RUN apt-get update
RUN apt-get install wget gosu

RUN wget -O - https://debian.neo4j.com/neotechnology.gpg.key | sudo apt-key add -
RUN echo 'deb https://debian.neo4j.com stable 3.5' | sudo tee /etc/apt/sources.list.d/neo4j.list

RUN apt-get update
RUN apt-get install neo4j

ENV NEO4J_EDITION="standard"

COPY docker-entrypoint.sh .
RUN chmod u+x docker-entrypoint.sh
COPY neo4j.conf /var/lib/neo4j/conf/neo4j.conf

VOLUME /data /logs

EXPOSE 7474 7473 7687

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]