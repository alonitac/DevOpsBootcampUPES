import json
from json import JSONDecodeError
from aiohttp import web
import uuid
import os
import random
import sys

# Generate self signed certificate by
# openssl req -x509 -nodes -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365


TEST = sys.argv[1] if len(sys.argv) > 1 else None

client_secrets = {}

with open('bob-cert.pem') as f:
    bob_cert = f.read()


with open('eve-cert.pem') as f:
    eve_cert = f.read()


async def flush_secrets(request):
    with open('secrets.json', 'w') as f:
        json.dump(client_secrets, f)
    return web.Response(text='flushed')


async def status(request):
    return web.Response(text="Hi! I'm available, let's start the TLS handshake\n")


async def client_hello(request):
    text = await request.text()
    try:
        data = await request.json()
    except JSONDecodeError as err:
        return web.Response(text=f"Bad JSON format: {err}\nOriginal request:\n{text}\n", status=400)

    headers = dict(request.headers)
    if headers['Content-Type'] != 'application/json':
        return web.Response(text="Bad request. Content-Type header should be application/json\n", status=400)

    client_id = str(uuid.uuid4()) if not TEST or len(client_secrets) > 0 else '71444da2-4e2d-4a32-8442-393eaaf593f4'
    if data.get('version') != "1.3":
        return web.Response(text="Bad request. Server works with version 1.3 clients only\n", status=400)

    if (not isinstance(data.get('ciphersSuites'), list)) or any([i not in ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305_SHA256"] for i in data.get('ciphersSuites')]):
        return web.Response(text="Bad request. ciphersSuites must be a list type. Allowed ciphers are 'TLS_AES_128_GCM_SHA256' or 'TLS_CHACHA20_POLY1305_SHA256' only.\n", status=400)

    if data.get('message') != "Client Hello":
        return web.Response(text="Bad Client Hello request\n", status=400)

    client_secrets[client_id] = None

    if random.randint(1, 5) == 5:
        cert = eve_cert
    else:
        cert = bob_cert

    if TEST:
        cert = eve_cert if TEST == 'eve' else bob_cert

    return web.json_response({
        "version": "1.3",
        "sessionID": client_id,
        "cipherSuite": "TLS_AES_128_GCM_SHA256",
        "serverCert": cert
    })


async def key_exchange(request):
    text = await request.text()
    try:
        data = await request.json()
    except JSONDecodeError as err:
        return web.Response(text=f"Bad JSON format: {err}\nOriginal request:\n{text}\n", status=400)

    headers = dict(request.headers)
    if headers['Content-Type'] != 'application/json':
        return web.Response(text=f"Bad request. Content-Type header should be application/json\nOriginal request:\n{text}\n", status=400)

    if not data.get('sessionID') or data['sessionID'] not in client_secrets:
        return web.Response(text=f"SessionID is missing or not found\nOriginal request:\n{text}\n", status=400)

    client_id = data['sessionID']
    if not data.get('masterKey'):
        return web.Response(text=f"Master-key is missing\nOriginal request:\n{text}\n", status=400)

    if not data.get('sampleMessage'):
        return web.Response(text=f"Client sample message is missing\nOriginal request:\n{text}\n", status=400)

    stream = os.popen(f'echo "{data.get("masterKey")}" | base64 -d | openssl smime -decrypt -inform DER -inkey key.pem')
    decrypted_master_key = str(stream.read()[:-1])

    client_secrets[client_id] = decrypted_master_key

    msg = data.get("sampleMessage")
    if TEST == 'bad-msg':
        msg = 'Server bad message'

    stream = os.popen(f'echo "{msg}" | openssl enc -e -aes-256-cbc -pbkdf2 -k "{decrypted_master_key}" | base64 -w 0')
    output = str(stream.read())

    return web.json_response({
        "sessionID": client_id,
        "encryptedSampleMessage": output
    })


def main():
    app = web.Application()
    app.add_routes([web.post('/clienthello', client_hello)])
    app.add_routes([web.post('/keyexchange', key_exchange)])
    app.add_routes([web.get('/flush', flush_secrets)])
    app.add_routes([web.get('/status', status)])
    web.run_app(app, host='0.0.0.0')


if __name__ == '__main__':
    main()
