#!/usr/bin/sh
cd src
nim c --out:../nimcanoid -d:release --multimethods:on --opt:speed nimcanoid.nim
rm -rf nimcache
cd ..
./nimcanoid
