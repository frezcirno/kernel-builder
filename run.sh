#!/bin/bash
set -e

BASE=$(realpath $(dirname $0))
SRCDIR=$BASE/src
PATCHDIR=$BASE/patches

if [ $# != 1 ]; then
	echo "usage: $0 <kernel_version>"
	echo "	eg: $0 5.16.4"
	exit 1
fi

VERSION=$1
SOURCE_URL=https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-$VERSION.tar.xz
SOURCE=$SRCDIR/linux-$VERSION

if [ ! -d $SOURCE ]; then
	wget -qO- $SOURCE_URL | tar -C $SRCDIR -Jxvf -
fi

for f in $PATCHDIR/*; do
	patch -p1 -N -d $SOURCE < $f || true
done

if [ ! -f $SOURCE/.config ]; then
	cp $SRCDIR/.config $SOURCE/.config
fi

docker run --rm -v $SRCDIR:/src kernel-builder:latest \
	make V=1 -C /src/linux-$VERSION -j$(nproc) deb-pkg
