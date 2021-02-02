#!/usr/bin/sh
cd src
nim c --out:../nimcanoid nimcanoid.nim
cd ..
./nimcanoid
