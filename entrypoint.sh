#!/bin/bash -e

if [ ! -e ${CONF_DIR}/federations.toml ]; then
  node_vss_list=(${NODE_VSS_LIST})
  node_vss_array=$(printf ",\"%s\"" "${node_vss_list[@]}")
  node_vss_array=${node_vss_array:1}

  cat << EOS > ${CONF_DIR}/federations.toml
[[federation]]
block-height = 0
threshold = ${THRESHOLD}
aggregated-public-key = "${AGGREGATED_PUBLIC_KEY}"
node-vss = [${node_vss_array}]
EOS
fi

if [ ! -e ${CONF_DIR}/signer.toml ]; then
  cat << EOS > ${CONF_DIR}/signer.toml
[general]
round-duration = ${ROUND_DURATION:-60}
round-limit = ${ROUND_LIMIT:-15}
log-quiet = false
log-level = "info"
daemon = false
skip-waiting-ibd = true

[signer]
to-address = "${TO_ADDRESS}"
public-key = "${PUBLIC_KEY}"
federations-file = "${CONF_DIR}/federations.toml"

[rpc]
rpc-endpoint-host = "${TAPYRUS_CORE_HOST:-127.0.0.1}"
rpc-endpoint-port = ${TAPYRUS_CORE_PORT:-2377}
rpc-endpoint-user = "${TAPYRUS_RPC_USER:-rpcuser}"
rpc-endpoint-pass = "${TAPYRUS_RPC_PASS:-rpcpassword}"

[redis]
redis-host = "${REDIS_HOST:-127.0.0.1}"
redis-port = ${REIDS_PORT:-6379}
EOS
fi

exec bash -c "$*"
