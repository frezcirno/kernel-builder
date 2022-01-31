# Docker image for building the Kernel

# Usage

1. Build docker image

```
cd image
docker build -t kernel-builder .
```

2. Run

```
./run.sh 5.16.4
```

If success, the output deb packages will be in `src` directory.

# Patch

Place your patches into `patches`, if you want to change the kernel.