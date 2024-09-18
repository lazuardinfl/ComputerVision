#!/bin/bash

# .env file and minimum one file inside ca directory
# must exist to prevent container build error

# create .env file if not exist
if [ ! -f .devcontainer/.env ]; then
    touch .devcontainer/.env
fi

# create ca directory if not exist
mkdir -p .devcontainer/ca

# create file inside ca directory
cat << EOF > .devcontainer/ca/README.md
put root CA file here with \`.crt\` extension \\
don't delete this file
EOF

# copy custom root CA from default linux ca directory
\cp /usr/local/share/ca-certificates/* .devcontainer/ca/ 2>/dev/null || true