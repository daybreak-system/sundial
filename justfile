build:
    @mkdir -p bin
    @crystal build src/sundial.cr -o bin/sundial

test:
    @crystal spec

format:
    @crystal tool format

clean:
    @rm -rf bin
