FROM gcr.io/distroless/static-debian11:nonroot
ENTRYPOINT ["/baton-snipe-it"]
COPY baton-snipe-it /