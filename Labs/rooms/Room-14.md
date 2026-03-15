---
password: "link42"
title_prefix: "🌐 "
summary: "Use curl to fetch and process data from a local web server."
---

**SURF THE WEB!**

---

## 🌐 The Web Crawler

- A local web server is hiding the password behind several endpoints.
- Use `curl` to fetch the right URL and extract the clue.

---

!!! abstract "📜 Mission Briefing"

    A local web server is running at `http://localhost:8080`.

    1. Fetch the index page to see what endpoints are available.
       > hint: `curl http://localhost:8080/`
    2. The server has a `/secret` endpoint - but it requires a custom header `X-Access-Key: escape`.
       > hint: `curl -H "X-Access-Key: escape" http://localhost:8080/secret`
    3. The response contains a JSON body - extract the `password` field.
       > hint: pipe to `grep` or `jq`
    4. The value of `password` in the response **is** the password.

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

### Hints

!!! tip "Hint 1"

    Use `curl -s` to suppress the progress meter and get clean output.

!!! tip "Hint 2"

    Custom headers use the `-H` flag: `curl -H "Header-Name: value" URL`.

---

!!! info "🔓 Unlock Room 15"

    Once you have the password, decrypt the next room's README:

    ```bash
    openssl enc -aes-256-cbc -d -a -pbkdf2 \
      -in ../room_15/README -out ../room_15/README.txt -pass pass:PASSWORD
    cat ../room_15/README.txt
    ```
