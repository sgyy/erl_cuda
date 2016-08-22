## GPU Compute

using erlang/otp to publish data on GPU(CUDA) to compute

* compile:

> `rebar compile`

* run:

> `erl -pa ebin`

* exec:

> `application:start(gpucompute).`

`gpucompute:compute(2,5).`

* cuda compile

> `make`
