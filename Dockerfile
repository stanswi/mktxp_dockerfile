FROM python:3.8-slim

RUN apt-get update && apt-get install -y vim
RUN pip install --upgrade pip

RUN groupadd -g 1000 user
RUN useradd -r -u 1000 -g 1000 user
WORKDIR /home/user
RUN mkdir /home/user/mktxp
RUN chown -R user:user /home/user
USER user

RUN pip install --user mktxp
WORKDIR /home/user/mktxp

COPY --chown=user:user mktxp.conf .
COPY --chown=user:user _mktxp.conf .
RUN chmod 644 /home/user/mktxp/mktxp.conf && chmod 644 /home/user/mktxp/_mktxp.conf

ENV PATH="/home/user/.local/bin:${PATH}"

EXPOSE 49090/tcp
VOLUME ["/home/user/mktxp"]

CMD ["mktxp", "export"]
