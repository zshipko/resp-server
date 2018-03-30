resp-server — A library for servers that speaks RESP
-------------------------------------------------------------------------------
%%VERSION%%

resp-server is a library for building servers in OCaml that communicate using the Redis serialization protocol

resp-server is distributed under the ISC license.

Homepage: https://github.com/zshipko/resp-server

## Installation

resp-server can be installed with `opam`:

    opam install resp-server

If you don't use `opam` consult the [`opam`](opam) file for build
instructions.

## Documentation

The documentation and API reference is generated from the source
interfaces. It can be consulted [online][doc] or via `odig doc
resp-server`.

[doc]: https://github.com/zshipko/resp-server/doc

## Tests

In the distribution sample programs and tests are located in the
[`test`](test) directory. They can be built and run
with:

    jbuilder runtest
