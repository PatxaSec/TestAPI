# TestAPI

An API Endpoint Response Tester, Based on wordlist fuzzing engine and developed on BASH.
---

## Function API_Scan

The API_Scan function takes one argument, `$URL`, which is the URL to scan. The function does the following:

Iterates over the endpoints specified in the `$ENDPOINTS` variable using a for loop.
For each endpoint, it constructs the full URL by concatenating the base URL ($1) with the endpoint.
It then sends a request to the full URL using curl with the following options:
-k ignores SSL certificate verification.
-is shows the response headers and status code.
-X specifies the HTTP method (e.g., GET, POST, etc.).
-H sets the Accept header to application/ld+json.
The response status code is extracted using `head -n 1` and `awk '{print $2}'`.
Depending on the response status code, the function prints a message in a specific color:
- If the status code is 200, it prints a green message indicating the endpoint is accessible.
- If the status code is 401, it prints a yellow message indicating that a Bearer token is required.
- If the status code is anything else, it prints a red message indicating an error, but only if the `v` flag is provided (more on this later).

---

## Main Script

The main script does the following:

Checks if the first argument ($URL) is a file. If it is, it assumes it's a file containing a list of URLs, one per line.
If the file exists, it iterates over the URLs in the file using a for loop and calls the `API_Scan` function for each URL.
If the first argument is not a file, it assumes it's a single URL and calls the `API_Scan` function with that URL.

---

## Usage

To use this script, you'll need to provide the following arguments:

The URL or file containing URLs to scan.
The file containing the endpoints to test (e.g., /api/users, /api/orders, etc.).
An optional `v` flag to enable verbose mode, which shows more detailed error messages.
Example usage:

```
bash API_responder.sh https://example.com endpoints.txt v
```

In this example:

`https://example.com` is the base URL to scan.
endpoints.txt is a file containing the endpoints to test, one per line (e.g., /api/users, /api/orders, etc.).
The `v` flag enables verbose mode, which shows more detailed error messages.

---

## output example

```
bash API_responder.sh target.txt endpoints.txt
===================================================================>>>> https://vapi.app
[+] /swagger/index.html -> GET -> https://vapi.app/swagger/index.html
[+] /swagger/v1/swagger.json -> GET -> https://vapi.app/swagger/v1/swagger.json
[!] /api/v1/account/register/user -> POST -> [401] Bearer needed
[!] /api/v1/account/register/staff -> POST -> [401] Bearer needed
[!] /api/v1/account/delete/user/{email} -> DELETE -> [401] Bearer needed
[!] /api/v1/account/mobile/user/password -> PUT -> [401] Bearer needed
[!] /api/v1/client/newclient -> POST -> [401] Bearer needed
[!] /api/v1/login/allpermissions -> GET -> [401] Bearer needed
[!] /api/v1/login/acceptterms -> POST -> [401] Bearer needed
[+] /api/v1/Wall -> GET -> https://vapi.app/api/v1/Wall
[+] /api/v1/Wall -> POST -> https://vapi.app/api/v1/Wall
[+] /api/v1/Wall -> PUT -> https://vapi.app/api/v1/Wall
[+] /api/v1/UserMember -> GET -> https://vapi.app/api/v1/UserMember
[+] /api/v1/UserMember -> PUT -> https://vapi.app/api/v1/UserMember
[!] /api/v1/Receiver/communicationEvents -> POST -> [401] Bearer needed
[!] /api/v1/Receiver/lockEvents -> POST -> [401] Bearer needed
[!] /api/v1/Receiver/scan -> POST -> [401] Bearer needed
[!] /api/v1/Receiver/ocsConfigurations -> POST -> [401] Bearer needed
[!] /api/v1/Receiver/lockEvents -> POST -> [401] Bearer needed
[+] /api/v1/Client -> GET -> https://vapi.app/api/v1/Client
[+] /api/v1/Client -> POST -> https://vapi.app/api/v1/Client
[+] /api/v1/Client -> PUT -> https://vapi.app/api/v1/Client
```
