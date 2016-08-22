## GPU Compute

using erlang/otp to publish data on GPU(CUDA) to compute

* compile:

> `rebar compile`

* cuda compile

> `make`
> `mv simadd ../priv`

* run

> `rebar -pa ebin`

> ```
    Erlang R16B (erts-5.10.1) [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
    Eshell V5.10.1  (abort with ^G)
    1> application:start(gpucompute).
    ok
    2> gpucompute:compute(2,7).
    result = 9
    ok
  ```
