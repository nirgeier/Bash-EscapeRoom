---
title: "(Room 14) 🌐 The Web Crawler"
password: "link42"
title_prefix: "🌐 "
summary: "Use curl to fetch and process data from a local web server."
---

[![Room-14](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-14.yml/badge.svg)](https://github.com/nirgeier/Bash-EscapeRoom/actions/workflows/room-14.yml)

<div class="room-hero">
  <span class="room-badge">ROOM 14</span>
  <div class="room-title">
    <span class="room-title-accent">🌐 The</span>
    <span class="room-title-main">Web Crawler</span>
  </div>
</div>


---

<div class="summary" markdown="1">

Use curl to fetch and process data from a local web server.

- A local web server is hiding the password behind several endpoints.
- Use `curl` to fetch the right URL and extract the clue.

</div>

---

### SURF THE WEB!

<ol class="tasks">
  <li>Fetch the index page to see what endpoints are available. <code>curl http://localhost:3000/</code></li>
  <li>The server has a <code>/secret</code> endpoint - but it requires a custom header <code>X-Access-Key: escape</code>.</li>
  <li>The response contains a JSON body - extract the <code>password</code> field. pipe to <code>grep</code> or <code>jq</code></li>
  <li>The value of <code>password</code> in the response <strong>is</strong> the password.</li>
</ol>

---

### Key Commands

| Command | Purpose |
| --- | --- |
| `curl URL` | Fetch URL to stdout |
| `curl -o file URL` | Save output to file |
| `curl -O URL` | Save with remote filename |
| `curl -s URL` | Silent (no progress bar) |
| `curl -I URL` | Show response headers only |
| `curl -i URL` | Show headers + body |
| `curl -L URL` | Follow redirects |
| `curl -X POST URL` | HTTP POST request |
| `curl -d "key=val" URL` | POST with form data |
| `curl -H "Header: Val" URL` | Add custom header |
| `curl -u user:pass URL` | Basic authentication |
| `curl -k URL` | Skip SSL certificate verification |
| `curl --max-time 5 URL` | Timeout after 5 seconds |
| `curl -w "%{http_code}" URL` | Print HTTP status code |
| `curl -x proxy:port URL` | Use a proxy |
| `wget -q -O - URL` | wget alternative, output to stdout |
| `wget -O file URL` | wget: save to file |
| `wget --spider URL` | Check URL without downloading |

### How `curl` Works

```bash
# Basic fetch
curl https://example.com                        # fetch and print to stdout
curl -s https://example.com                     # silent (no progress meter)
curl -o output.html https://example.com         # save to file
curl -O https://example.com/file.tar.gz         # save with remote filename

# HTTP methods
curl -X GET https://api.example.com/data        # explicit GET (default)
curl -X POST https://api.example.com/data       # POST request
curl -X DELETE https://api.example.com/item/1  # DELETE request

# Headers and authentication
curl -H "Authorization: Bearer TOKEN" URL       # auth header
curl -H "Content-Type: application/json" URL    # content type header
curl -u username:password URL                   # basic auth
curl -b "session=abc123" URL                    # send cookie

# POST with data
curl -d "field1=value1&field2=value2" -X POST URL  # form data
curl -d '{"key":"value"}' -H "Content-Type: application/json" -X POST URL  # JSON body

# Follow redirects and inspect response
curl -L URL                                     # follow redirects
curl -I URL                                     # headers only (HEAD request)
curl -v URL                                     # verbose: show headers + body

# Download with progress
curl --progress-bar -o file.zip URL             # show progress bar
```


<div class="hints" markdown="1">

> Use `curl -s` to suppress the progress meter and get clean output.

> Custom headers use the `-H` flag: `curl -H "Header-Name: value" URL`.

</div>
---

!!! info "🔓 Unlock Room 15"

    Once you solve the puzzle, run:

    ```bash
    next <PASSWORD>
    ```
