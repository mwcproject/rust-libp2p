# 0.27.0 [2021-01-12]

- Update dependencies.

# 0.26.0 [2020-12-17]

- Update `mwc-libp2p-swarm` and `mwc-libp2p-core`.

# 0.25.0 [2020-11-25]

- Update `mwc-libp2p-swarm` and `mwc-libp2p-core`.

# 0.24.0 [2020-11-09]

- Update dependencies.

# 0.23.0 [2020-10-16]

- Update `mwc-libp2p-swarm` and `mwc-libp2p-core`.

- Ensure the outbound ping is flushed before awaiting
  the response. Otherwise the behaviour depends on
  implementation details of the stream muxer used.
  The current behaviour resulted in stalls with Mplex.

# 0.22.0 [2020-09-09]

- Update `mwc-libp2p-swarm` and `mwc-libp2p-core`.

# 0.21.0 [2020-08-18]

- Refactor the ping protocol for conformity by (re)using
a single substream for outbound pings, addressing
[#1601](https://github.com/libp2p/rust-libp2p/issues/1601).

- Bump `mwc-libp2p-core` and `mwc-libp2p-swarm` dependencies.

# 0.20.0 [2020-07-01]

- Updated dependencies.

# 0.19.3 [2020-06-22]

- Updated dependencies.

# 0.19.2 [2020-06-18]

- Close substream in inbound upgrade
  [PR 1606](https://github.com/libp2p/rust-libp2p/pull/1606).

