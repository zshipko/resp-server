resp-server — An OCaml library for building servers that speak RESP
-------------------------------------------------------------------------------
%%VERSION%%

resp-server is an OCaml library for building servers that communicate using the Redis serialization protocol.

resp-server is distributed under the ISC license.

Homepage: https://github.com/zshipko/resp-server

## Installation

resp-server can be installed with `opam`:

    opam install resp-server

If you don't use `opam` consult the [`opam`](opam) file for build
instructions.

## Getting started

To create a new server using `resp-server` you need to define a few modules.

1) `BACKEND` - defines the request context and client types
2) `AUTH` - defines authentication types

## Tests

In the distribution sample programs and tests are located in the
[`test`](test) directory. They can be built and run
with:

    jbuilder runtest
