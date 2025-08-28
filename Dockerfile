# Start from a very small Linux image
FROM alpine:latest

# Set working directory inside the container
WORKDIR /data

# Set environment for resources
ENV RESOURCES=/usr/local/bin

ADD https://github.com/dougspeed/LDAK/blob/main/Resources/berisa.txt /usr/local/bin/berisa.txt

# Copy your executable into the container
COPY src/ldak6.1.linux /usr/local/bin/ldak
COPY src/gene_annotation_grch37 /usr/local/bin/gene_annotation_grch37
COPY src/gene_annotation_grch38 /usr/local/bin/gene_annotation_grch38

# Make it executable
RUN chmod a+x /usr/local/bin/ldak

# Run it when the container starts
#CMD ["./ldak6.1.linux"]
#CMD ["echo", "test"]

ENTRYPOINT ["ldak"]