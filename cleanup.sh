#!/bin/bash

set -e

rm -rf mongo-backup-* *.tar.gz

# Optional: uninstall packages (use with caution)
# sudo apt remove -y mongodb-clients awscli
# sudo apt autoremove -y
