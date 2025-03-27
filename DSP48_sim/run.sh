#!/bin/bash

sed -i 's/\r$//' ./build
chmod +x ./build

./build
