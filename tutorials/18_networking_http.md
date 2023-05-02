# HTTP Protocol 

The Hypertext Transfer Protocol (HTTP) is an application-level protocol that is being widely used over the Web.
HTTP is a **request/response** protocol, which means, the client sends a request to the server in the form of a request method, URI, protocol version, followed by headers, and possible body content.
The server responds with a status code line, a success or error code, followed by server headers information, and possible entity-body content.

![](../.img/client-server2.png)

Under the hood, HTTP requests and responses are sent over a TCP socket with default port of 80 (in the server side).
The HTTP client first initiates a TCP connection with the server, once the connection is established, the client and the server access TCP through their each socket interfaces.

Here we see one of the great advantages of the layered architecture of the OSI model — HTTP doesn't need to worry about data loss and integrity. This is the job of TCP and other protocols in lower layers. 

HTTP is said to be a **stateless protocol**.
The server sends the requested content to clients without storing any information about the client.
If a particular client sends the same request twice in a period of a few seconds, the server does not respond by saying that it just served the same request to the client.
Instead, the server re-sends the data, as it has completely forgotten what it did earlier.

Nevertheless, although HTTP itself is stateless by design, most modern servers have a complex backend logic that stores information about logged-in clients, and by this mean, we can say that those servers are **stateful**. 

## HTTP Request and Response 

We can learn a lot by taking a closer look on a raw HTTP request and response that sent over the network:

```shell
curl -v http://httpbin.org/html
```

Below is the actual raw HTTP request sent by `curl` to the server:

```http
GET /html HTTP/1.1
Host: httpbin.org
User-Agent: curl/7.58.0
Accept: */*
```

The server response is:

```http
HTTP/1.1 200 OK
Date: Wed, 05 Apr 2023 12:43:42 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 3741
Connection: keep-alive
Server: gunicorn/19.9.0
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true

<!DOCTYPE html>
<html>
  <head>
....
```

The MDN web docs [specifies the core components of request nad response objects](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview#http_flow), read this resource for more information. 


## Status code 

HTTP response status codes indicate how a specific HTTP request was completed.

Responses are grouped in five classes:

- Informational (100–199)
- Successful (200–299)
- Redirection (300–399)
- Client error (400–499)
- Server error (500–599)

Try yourself to perform the below two HTTP requests, and [read](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) about the meaning of each status code. 

```shell
curl -i httpbin.org/status/0
```

```shell
curl -v -X PUT httpbin.org/path/to/nowhere
```

## Flask webserver  

So far we've seen how to communicate with a server as **clients**. 

The below exercise demonstrates how a **server** might look and operate. 

We'll run a simple Flask Python server, and communicate with the server locally from the same machine. 
The client will be the old good `curl`.

1. Since it's the first time we run a Python program, let's create a Python virtual environment in PyCharm:
   - In our shared repo PyCharm project, click the [Python interpreter selector](https://www.jetbrains.com/help/pycharm/configuring-python-interpreter.html#widget) (bottom right, close to the Git branches button), choose **Interpreter Settings...**. 
   - Click the settings wheel icon in the top right corner of the dialog, then **Add**. 
   - In the left-hand pane of the **Add Python Interpreter** dialog, select **Virtualenv Environment**.
   - Click **OK** to complete the task.
   - Mind the `venv` dir that was created in your project files. You should completely ignore this folder, never delete/create files there. 

   The idea of Python virtual environments (venv) is simple: instead of using the same Python interpreter for all applications in your machine, you create an isolated Python "environment" for every project. By doing this you'll enjoy easier dependency management, and reproducibility in case you've messed up your env.   

2. The Python server is based of a Python package called [Flask](https://flask.palletsprojects.com/en/2.2.x/quickstart/#). Let's install this package: 
   - Click the **Terminal** button in the bottom bar to open a new terminal session in PyCharm.
   - Make sure that your terminal is using the Python interpreter you've just configured by:
     ```console
     (venv) myuser@hostname:~/path/to/project$ which python
     /home/myuser/path/to/project/venv/bin/python
                  ^^^^^^^^^^^^^^^^^^^^--------------- path to venv dir in your project files  
     ```
   - Install the flask package by: `pip install flask`.

3. Review the code in `simple_flask_webserver/app.py`. Above every function, you can find the server endpoint (e.g. `/upload`) and the `curl` command to request this endpoint.
4. In your terminal, `cd simple_flask_webserver`, and run the server by: `python app.py`.
5. The default endpoint `/` can be accessed using your browser. Use `curl` to trigger the other endpoints as specified in `app.py`.

Take a closer look on the output you've got from the `/api/upload` endpoint, this is the so-called **JSON** format. 
JavaScript Object Notation (JSON) is a standard text-based format for representing structured data based on JavaScript object syntax.
It is commonly used for transmitting data in web applications. JSON can be used independently from JavaScript, and many programming environments feature the ability to read and generate JSON.

> ### :pencil2: Exercise - Practice HTTP protocol
>
> #### HTTP Headers
> 
> Use `curl` to perform an HTTP GET request to `http://httpbin.org/image`.
> Add an `Accept` header to your request to inform the server that you anticipate a `png` image.
> Which animal appear in the served image?
> 
> #### HTTP `Moved` status code
> 
> Perform an HTTP GET request by `curl google.com`
> What does the server status code mean? Follow the response headers and body to get the real Google’s home page.
> 
> #### HTTP Version 
> 
> Which HTTP version does the server use in the response for `curl -v http://www.github.com`?
> 
> #### Closing the TCP connection after server response
> 
> The server of `http://httpbin.org` uses `keep-alive` connection by default, indicating that the server would like to keep the TCP connection open, so further requests to the server will use the same underlying TCP socket.
> Perform an HTTP POST request to the `/anything` endpoint and tell the server that the client (you) would like to close the connection immediately after the server has responded.
> Make sure the server’s response contains the `Connection: close` header which means that the TCP connection used to serve the request was closed.
> 
> #### Send data to the server
> 
> Perform an HTTP POST request to `http://httpbin.org/anything`. You should send the following json to the server:
> 
> ```json
> {"test": "me"}
> ```
> 
> Upon success request, the response body will be a json format with a “json” key and your data as a value, as follows:
> ```json
> "json": {
>  "test": "me"
> }
> ```
>
> 

## What is API  

An API (Application Programming Interface) can be thought of as a collection of all server endpoints that together define the functionality that is exposed to the client.
Each endpoint typically accepts input parameters in a specific format and returns output data in a standard format such as JSON or XML.

For example, a web API for a social media platform might include endpoints for retrieving a user's profile information, posting a new status update, or searching for other users. Each endpoint would have a unique URL and a specific set of input parameters and output data.

Many platforms that we will be learning during the course, expose a rich API as well as GUI. 

### Introducing Postman

Postman is a powerful and user-friendly tool for testing, debugging, and documenting APIs.

https://learning.postman.com/docs/getting-started/overview/

> ### :pencil2: Exercise - Experimenting with APIs
>
> Use Postman to retrieve data from some interesting free API:   
> https://github.com/public-apis/public-apis
> 



