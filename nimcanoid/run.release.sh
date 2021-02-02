#!/usr/bin/sh
cd src
nim c --out:../nimcanoid -d:release --opt:speed nimcanoid.nim
rm -rf nimcache
cd ..