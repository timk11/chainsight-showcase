use uniswap_snapshotter_mainnet_bindings :: Snapshot as Snapshot_uniswap_snapshotter_mainnet ; algorithm_lens_finder ! ("uniswap_snapshotter_mainnet" , "proxy_get_top_snapshots" , Vec < Snapshot_uniswap_snapshotter_mainnet > , u64) ; use chainsight_cdk :: lens :: LensFinder ; use chainsight_cdk_macros :: algorithm_lens_finder ; async fn _get_target_proxy (target : candid :: Principal) -> candid :: Principal { let out : ic_cdk :: api :: call :: CallResult < (candid :: Principal ,) > = ic_cdk :: api :: call :: call (target , "get_proxy" , ()) . await ; out . unwrap () . 0 }