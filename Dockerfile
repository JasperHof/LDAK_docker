# Start from a very small Linux image
FROM alpine:latest

LABEL maintainer="Jasper Hof <jasper.hof@qgg.au.dk>" \
      description="Docker image for LDAK" \
      version="6.1"

# Set working directory inside the container
WORKDIR /output

# Set environment for resources
ENV LDAK_RESOURCES=/resources

# Create resources directory
RUN mkdir -p $LDAK_RESOURCES

# Download resource file
ADD https://raw.githubusercontent.com/dougspeed/LDAK/main/Resources/berisa.txt $LDAK_RESOURCES/berisa.txt

# Copy your executables and resources
COPY src/ldak6.1.linux /usr/local/bin/ldak
COPY src/gene_annotation_grch37 $LDAK_RESOURCES/gene_annotation_grch37
COPY src/gene_annotation_grch38 $LDAK_RESOURCES/gene_annotation_grch38

# Make the binary executable
RUN chmod a+x /usr/local/bin/ldak
RUN pwd

# Create a dedicated output directory and user
RUN adduser -D ldakuser \
    && mkdir -p /output \
    && chown ldakuser:ldakuser /output \
    && chown -R ldakuser:ldakuser $LDAK_RESOURCES

# Switch to non-root user
USER ldakuser

# Default entrypoint
ENTRYPOINT ["ldak"]