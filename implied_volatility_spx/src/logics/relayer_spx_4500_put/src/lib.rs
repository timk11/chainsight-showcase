mod types;
pub type CallCanisterResponse = types::ResponseType;
pub fn filter(_: &CallCanisterResponse) -> bool {
    true
}
