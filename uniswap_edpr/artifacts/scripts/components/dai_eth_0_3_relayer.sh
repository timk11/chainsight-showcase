#!/bin/bash
# init
dfx canister --network ic call dai_eth_0_3_relayer init_in '(variant { "Production" }, record {
                refueling_interval = 86400: nat64;
                vault_intial_supply = 1000000000000: nat;
                indexer = record { 
                    initial_supply = 0: nat;
                    refueling_amount = 1000000000000: nat;
                    refueling_threshold = 500000000000: nat;
                };
                db = record { 
                    initial_supply = 1500000000000: nat;
                    refueling_amount = 1000000000000: nat;
                    refueling_threshold = 500000000000: nat;
                };
                proxy = record { 
                    initial_supply = 300000000000: nat;
                    refueling_amount = 100000000000: nat;
                    refueling_threshold = 100000000000: nat;
                };
        })' --with-cycles 2800000000000 --wallet $(dfx identity get-wallet --network ic)
# setup
dfx canister --network ic call dai_eth_0_3_relayer setup "(
    \"0xB5Ef491939A6dBf17287666768C903F03602c550\",
    record {
        url = \"https://ethereum-sepolia.blockpi.network/v1/rpc/public\";
        from = null;
        chain_id = 11155111;
        env = variant { Production };
    },
    \"$(dfx canister --network ic id dai_eth_0_3_indexer_lens)\",
    vec { \"cj6ax-baaaa-aaaag-qczmq-cai\" },
)"
# set_task
dfx canister --network ic call dai_eth_0_3_relayer set_task '(14400, 10)'
