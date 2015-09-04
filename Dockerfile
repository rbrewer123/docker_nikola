# build command:
#  docker build -t rbrewer123/nikola .

FROM debian:sid


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nikola

COPY runasuser.sh /root/
RUN chmod a+x /root/runasuser.sh
    
ENTRYPOINT ["/root/runasuser.sh"]
