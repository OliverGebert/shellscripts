#!/bin/bash

# this script displays various information to the screen

# Display "hello"

echo "hello world"

# assign value to variable and echo

WORD='script'
ENDING='ed'

echo "$WORD"
echo '$WORD'
echo "this is a shell $WORD"
echo "this is a shell ${WORD}"
echo "${WORD}ing is fun!"
echo "This is ${WORD}${ENDING}"

ENDING='ing'

echo "${WORD}${ENDING} is fun!"
