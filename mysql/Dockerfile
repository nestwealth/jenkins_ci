FROM mysql

ENV MYSQL_ROOT_PASSWORD=nestwealth
ENV MYSQL_DATABASE=unittestnw

COPY ./localdb-run.sh /
RUN chmod 755 /localdb-run.sh

ENTRYPOINT ["/localdb-run.sh"]
