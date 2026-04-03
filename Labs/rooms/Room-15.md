---
title: "(Room 15) 📦 The JSON Vault"
password: "webfetch"
title_prefix: "📦 "
summary: "Parse a JSON data file using jq to extract the hidden password."
---

[![Room-15](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-15.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-15.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 15</span>
  <div class="room-title">
    <span class="room-title-accent">📦 The</span>
    <span class="room-title-main">JSON Vault</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Parse a JSON data file using jq to extract the hidden password.

- The database has been exported as a JSON file.
- The password is buried inside nested fields - only `jq` can crack it open.

</div>

---

### CRACK THE JSON VAULT!

<ol class="tasks">
  <li>First, explore the top-level keys. <code>jq 'keys' database.json</code></li>
  <li>The password is stored at <code>.agents[] | select(.status == "active") | .code</code> - find all active agents' codes. <code>jq '.agents[] | select(.status == "active") | .code' database.json</code></li>
  <li>Sort the codes alphabetically and concatenate them (no separator). pipe to <code>sort</code> and <code>tr -d '
'</code></li>
  <li>Remove the surrounding quotes from the <code>jq</code> output. use <code>jq -r</code> for raw output (no quotes)</li>
  <li>The concatenated result <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command                      | Purpose                |
| ---------------------------- | ---------------------- |
| `jq '.'`                     | Pretty-print JSON      |
| `jq '.key'`                  | Access a field         |
| `jq '.arr[]'`                | Iterate over an array  |
| `jq 'select(.field == val)'` | Filter elements        |
| `jq -r`                      | Raw output (no quotes) |

### How `jq` Works

```bash
# Basic access
jq '.' file.json                            # pretty-print the whole file
jq '.name' file.json                        # access top-level field
jq '.user.email' file.json                  # nested field access
jq '.items[0]' file.json                    # first element of array
jq '.items[-1]' file.json                   # last element of array

# Array operations
jq '.items[]' file.json                     # iterate: print each element
jq '.items | length' file.json              # count array elements
jq '[.items[] | .name]' file.json           # extract field from each element

# Filtering with select
jq '.users[] | select(.active == true)' file.json       # filter by boolean
jq '.users[] | select(.age > 30)' file.json             # filter by number
jq '.users[] | select(.role == "admin")' file.json      # filter by string

# Transforming output
jq -r '.name' file.json                     # raw output (no quotes around strings)
jq '.items[] | "\(.name): \(.value)"' file.json  # string interpolation
jq '{name: .user.name, id: .user.id}' file.json  # create new object

# Combining fields
jq '.items[] | .name' file.json | sort | tr -d '\n'   # extract, sort, join
jq -r '[.items[] | .name] | sort | join("")' file.json  # same using jq built-ins
```


<div class="hints" markdown="1">

> Use `jq -r` (raw output) to get strings without surrounding quotes.

> `jq '.agents[] | select(.status == "active") | .code' database.json` is the key filter.

> Sort the extracted codes before concatenating to ensure the right order.

</div>
---

!!! info "🔓 Unlock Room 16"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_16/README -out ../room_16/README.txt -pass pass:PASSWORD
    cat ../room_16/README.txt
    ```
