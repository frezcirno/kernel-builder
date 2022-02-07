#!/bin/bash
set -e

BASE=$(realpath $(dirname $0))
SRCDIR=$BASE/src
PATCHDIR=$BASE/patches

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--extension)
            EXTENSION="$2"
            shift # past argument
            shift # past value
            ;;
        -j)
            NPROC="$2"
            shift # past argument
            shift # past value
            ;;
        -d|--debug)
            DEBUG=YES
            shift # past argument
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done

if [ ${#POSITIONAL_ARGS[@]} != 1 ]; then
    echo "usage: $0 <kernel_version>"
    echo "	eg: $0 5.16.4"
    exit 1
fi

VERSION=${POSITIONAL_ARGS[0]}
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

rm $SOURCE/vmlinux-gdb.py || true
rm -rf $SOURCE/debian || true

if [ -z $DEBUG ]; then
    docker run --rm -v $SRCDIR:/src kernel-builder:latest make -C /src/linux-$VERSION -j${NPROC:-$(nproc)} deb-pkg |& tee build.log
else
    docker run --rm -it -v $SRCDIR:/src kernel-builder:latest bash
fi
