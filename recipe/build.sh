#! /usr/bin/bash
set -e

# curl and plain tar: macOS has no wget, and its tar has no GNU --transform.
curl -fsSLO https://www.roma1.infn.it/~bonvini/hell/downloads/HELL-data.v3.tgz
tar -xzf HELL-data.v3.tgz
curl -fsSLO https://www.roma1.infn.it/~bonvini/hell/downloads/HELL-data-aux.v3.tgz
tar -xzf HELL-data-aux.v3.tgz
cp -R HELL/. .
rm -rf HELL


NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC

mkdir -p ${PREFIX}/lib
cp -R libhell.a ${PREFIX}/lib
mkdir -p ${PREFIX}/include
cp -R include/* ${PREFIX}/include
mkdir -p share/hell.v3
cp -R data ${PREFIX}/share/hell.v3/
mkdir -p share/bin
cp -R examples/* ${PREFIX}/bin
