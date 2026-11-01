# demo-api

The sample Api that [Launchpad](https://launchpad.mattjarrett.dev) puts in each guest sandbox.

- `GET /` says hello and probes every binding the sandbox attached, such as Sql, Cache, NoSql, ObjectStorage, Topic and Subscription. Each probe does a real round-trip and reports how long it took.
- `GET /healthz` answers the readiness probe.
- `GET /readyz` is ready only once every binding answers.

Bindings are read from files under `SERVICE_BINDING_ROOT` (default `/bindings`).

Image: `ghcr.io/cujarrett/demo-api`. Each push to `main` builds `:latest`, which the next sandbox pulls.
