ARG LAST_STAGE_REPO=quay.io/openshifttest
ARG LAST_STAGE_BASE=base-alpine:multiarch

FROM golang:1.17 AS builder
WORKDIR /gitserver/
COPY ./gitserver.go ./
COPY ./go.mod ./
#RUN git config --add --global url."git@github.com:".insteadOf https://github.com
#RUN mkdir -p /root/.ssh
#RUN chmod 600 /root/.ssh
#RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
#RUN ls -shal ~/.ssh/
#RUN cat ~/.ssh/known_hosts
#RUN git config --add --global url."git@bitbucket.org:".insteadOf https://bitbucket.org
#RUN git config --add --global url."git@gitlab.com:".insteadOf https://gitlab.com
RUN go mod tidy
RUN ls -shal

RUN CGO_ENABLED=0 GOOS=linux go build -o gitserver gitserver.go

