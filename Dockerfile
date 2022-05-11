# Build Stage
FROM --platform=linux/amd64 rustlang/rust:nightly as builder

ENV DEBIAN_FRONTEND=noninteractive
## Install build dependencies.
RUN apt-get update 
RUN apt-get install -y cmake clang
RUN cargo install afl

## Add source code to the build stage.
ADD . /redis-rs/

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.

WORKDIR /redis-rs/afl/parser/
RUN cargo afl build

FROM --platform=linux/amd64 rustlang/rust:nightly

## TODO: Change <Path in Builder Stage>
COPY --from=builder /redis-rs/afl/parser/target/debug/fuzz-target /
