fn main() {
    println!("{}", two_track_computation("1000"));
    println!("{}", two_track_computation("A grand"));
    println!("{}", two_track_computation("0"));
}

fn two_track_computation(input : &str) -> String {
    parse_number(input)
        .map_err(|e| format!("Could not parse \"{}\": {}", input, e))
        .and_then(ensure_positive)
        .map(double)
        .map_or_else(|error| format!("Failure: {}.", error),
                     |number| format!("Success: computed {}.", number))
}

fn parse_number(value : &str) -> Result<u32, std::num::ParseIntError> {
    value.parse::<u32>()
}

fn ensure_positive(number : u32) -> Result<u32, String> {
    if number > 0 {
        Ok(number)
    } else {
        Err(format!("{} is not positive", number))
    }
}

fn double(number : u32) -> u32 {
    number * 2
}
