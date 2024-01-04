#!/bin/bash
# init
dfx canister --network ic call shib_eth_1_relayer init_in '(variant { "Production" }, record {
                refueling_interval = 86400: nat64;
                vault_intial_supply = 500000000000: nat;
                indexer = record {
                    initial_supply = 0: nat;
                    refueling_amount = 500000000000: nat;
                    refueling_threshold = 250000000000: nat;
                };
                db = record {
                    initial_supply = 750000000000: nat;
                    refueling_amount = 500000000000: nat;
                    refueling_threshold = 250000000000: nat;
                };
                proxy = record {
                    initial_supply = 150000000000: nat;
                    refueling_amount = 50000000000: nat;
                    refueling_threshold = 50000000000: nat;
                };
        })' --with-cycles 1400000000000 --wallet --wallet $(dfx identity get-wallet --network ic)
# setup
dfx canister --network ic call shib_eth_1_relayer setup "(
    \"0xB5Ef491939A6dBf17287666768C903F03602c550\",
    record {
        url = \"https://ethereum-sepolia.blockpi.network/v1/rpc/public\";
        from = null;
        chain_id = 11155111;
        env = variant { Production };
    },
    \"$(dfx canister --network ic id shib_eth_1_indexer_lens)\",
    vec { \"$(dfx canister --network ic id shib_eth_1_indexer)\" },
)"
# set_task
dfx canister --network ic call shib_eth_1_relayer set_task '(14400, 10)'
