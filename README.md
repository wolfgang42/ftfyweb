A simple wrapper around the Python [`ftfy`][] (&ldquo;fixes text for you&rdquo;) library,
which attempts to decode mojibake into what it's actually intended to mean.

[`ftfy`]: https://ftfy.readthedocs.io/en/latest/

# Setup
```sh
virtualenv -ppython3 venv
./venv/bin/pip3 install -r requirements.txt
./venv/bin/python3 -m bottle --debug --reload index
```

# Testing
Smoke tests to make sure we seem to be doing the right thing:
```sh
python3 ./test.py localhost:8080
```
