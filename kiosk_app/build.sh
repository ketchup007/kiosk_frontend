#!/bin/bash

# Extract messages
pybabel extract -F babel.cfg -o messages.pot .

# Update translations
pybabel update -i messages.pot -d translations

# Compile translations
pybabel compile -d translations
