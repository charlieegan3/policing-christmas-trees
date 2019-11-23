FROM openpolicyagent/opa:0.15.1-rootless

COPY *.rego /policy/

ENTRYPOINT ["/opa"]
CMD ["run", "--server", "-a", "0.0.0.0:8081", "/policy", "--log-level=debug"]
