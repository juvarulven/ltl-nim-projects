#!/usr/bin/sh
cd src
nim c --out:../nimcanoid --multimethods:on nimcanoid.nim
cd ..
./nimcanoid
