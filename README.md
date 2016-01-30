# crystal-string-scrub

Crystal: String#scrub and String#valid_encoding?

## Installation

`shard.yml`:

```yaml
dependencies:
  string-scrub:
    github: tmtm/crystal-string-scrub
```

execute `shards install`.

## Usage

```crystal
require "string-scrub"

"日本語".scrub #=> "日本語"
"日本語".byte_slice(1, 6).scrub #=> "??本?"
"日本語".byte_slice(1, 6).scrub('〓') #=> "〓〓本〓"
"日本語".byte_slice(1, 6).scrub("<invalid>") #=> "<invalid><invalid>本<invalid>"

"日本語".valid_encoding? #=> true
"日本語".byte_slice(1, 6).valid_encoding? #=> false
```

## License

MIT
