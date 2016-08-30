## GPU Compute

using erlang/otp to publish data on GPU(CUDA) to compute

* compile:

> `./rebar get-deps compile`

* cuda compile

> `make`

> `mv simadd ../priv`

* run

```
erl -pa deps/*/ebin ebin

1>  application:start(gpucompute).
ok
2> application:start(erlexec).
ok
3> {ok, Pid} = gpucompute_sup:start_compute_worker().           
{ok,<0.46.0>}
4> gpucompute:compute(Pid, 1, 2).
ok
5> Got stdout from 1604: <<"3">>

  ```
TODO: intgrate with riak_pipe 
