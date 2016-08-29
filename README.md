## GPU Compute

using erlang/otp to publish data on GPU(CUDA) to compute

* compile:

> `rebar compile`

* cuda compile

> `make`

> `mv simadd ../priv`

* run

> ```
rebar -pa ebin

    Erlang R16B (erts-5.10.1) [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false]
    Eshell V5.10.1  (abort with ^G)
    1> application:start(gpucompute).
    ok
    2> gpucompute:compute(2,3).
    "5"
    ok
  ```


 ```
 1> application:start(gpucompute).
 ok
 2> gpucompute_sup:start_link().    
 {ok,<0.38.0>}
 3> {ok, Pid} = gpucompute_sup:start_compute_worker().
 {ok,<0.41.0>}
 4> gpucompute:compute(Pid, 1, 2).
 "5"
 ok

 ```

 the final task: move the riak_pipe send output call in the child process
