FROM alpine:3
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
RUN apk -Uuv add curl ca-certificates jq
ENTRYPOINT [ "/bin/script.sh" ]