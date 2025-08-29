# LDAK in Docker

This repository provides a Docker image for running [LDAK](https://ldak.org), a tool for genetic data analysis.  
The image bundles the `ldak` binary together with reference resource files for convenience.

---

### Quick Start

Pull the image from GitHub:

``` 
git clone https://github.com/JasperHof/LDAK_docker.git
cd LDAK_docker
docker build -t ldak .
``` 

Alternatively, download this directory directly and build using `docker build -t ldak .`.

LDAK can then be run inside Docker, mounting your current working directory as the output location:

``` 
docker run --rm -v $(pwd):/output ldak --help
``` 

An example command generating a small genotype data set using LDAK:

```
docker run --rm \
    -v $(pwd):/output \
    ldak --make-snps geno --num-samples 1000 --num-snps 5000
```

### Resources included

The image include useful reference files inside /resources:

 - /resources/gene_annotation_grch37
 - /resources/gene_annotation_grch38
 - /resources/berisa.txt

ou can pass these directly to `ldak` using their short container paths. For example:

``` 
docker run --rm -v $(pwd):/output ldak \
    --kvik-step3 kvik \
    --bfile geno/ukb_merged \
    --genefile /resources/gene_annotation_grch37 \
    --max-threads 2
```

### Notes

 - All output is written to `/output` inside the container, which is mapped to your current working directory (`$(pwd)`).
 - The image runs as a non-root user by default for safety.
 - To avoid typing the long `docker run` command repeatedly, you can create a wrapper script:

``` 
#!/usr/bin/env bash
docker run --rm -v "$(pwd)":/output ldak "$@"
```

Save this as ldak-docker in your ~/.local/bin, make it executable (chmod +x ~/.local/bin/ldak-docker), and run:
ldak-docker --help. Alternatively, in a Linux system, it is possible to set

`alias ldak-docker='docker run --rm -v $(pwd):/output ldak'`

And continue to use direct commands like:

```
ldak-docker --make-snps geno --num-samples 1000 --num-snps 5000
```

### More info

Please visit [www.ldak.org](www.ldak.org) or [www.ldak-kvik.com](www.ldak-kvik.com) for LDAK documentation.