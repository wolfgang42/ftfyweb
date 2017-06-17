A simple wrapper around the Python [`ftfy`][] (&ldquo;fixes text for you&rdquo;) library,
which attempts to decode mojibake into what it's actually intended to mean.

[`ftfy`]: https://ftfy.readthedocs.io/en/latest/

# Setup
```sh
virtualenv -ppython3 venv
./venv/bin/pip3 install -r requirements.txt
./venv/bin/python3 -m bottle --debug --reload index
```
