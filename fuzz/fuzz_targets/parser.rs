#![no_main]
use libfuzzer_sys::fuzz_target;

use redis::parse_redis_value;

fuzz_target!(|data: &[u8]| {
    let _ = parse_redis_value(data);
});
