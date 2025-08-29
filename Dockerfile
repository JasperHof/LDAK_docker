# Start from a very small Linux image
FROM alpine:latest

LABEL maintainer="Jasper Hof <jasper.hof@qgg.au.dk>" \
      description="Docker image for LDAK" \
      version="6.1"

# Set working directory inside the container
VOLUME ["/output"]
WORKDIR /output

# Set environment for resources
ENV RESOURCES=/usr/local/bin

ADD https://github.com/dougspeed/LDAK/blob/main/Resources/berisa.txt /usr/local/bin/berisa.txt

# Copy your executable into the container
COPY src/ldak6.1.linux /usr/local/bin/ldak
COPY src/gene_annotation_grch37 /usr/local/bin/gene_annotation_grch37
COPY src/gene_annotation_grch38 /usr/local/bin/gene_annotation_grch38

# Make it executable
RUN chmod a+x /usr/local/bin/ldak

# Create a dedicated output directory and user
RUN adduser -D ldakuser \
    && mkdir -p /output \
    && chown ldakuser:ldakuser /output

# Switch to non-root user
USER ldakuser

ENTRYPOINT ["ldak"]

CMD ["--help"]