FROM python:3.10-alpine as kubectl-build
RUN apk add --no-cache curl \
        && cd /usr/local/bin/ \
        && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
        && chmod +x kubectl \
        && mkdir ~/.kube \
        && apk del curl
FROM python:3.10-alpine
RUN apk add --no-cache jq \
        && pip install --no-cache-dir yq
COPY --from=kubectl-build /usr/local/bin/kubectl /usr/local/bin/kubectl
RUN mkdir ~/.kube
