FROM ubuntu-dart AS dart-runtime

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD bin /app/bin/
RUN pub get --offline
RUN dart2native /app/bin/server.dart -o /app/server

FROM ubuntu

COPY --from=dart-runtime /app/server /server

CMD []
ENTRYPOINT ["/server"]

EXPOSE 8080
