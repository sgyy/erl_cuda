
-module(gpucompute_sup).
-behaviour(supervisor).

%% API
-export([start_link/0, start_compute_worker/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================
-spec start_link() -> ok.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

-spec start_compute_worker() -> {ok, pid()}.
start_compute_worker() ->
	Id         = erlang:now(),
	StartFunc  = {gpucompute, start_link, []},
	Restart    = permanent,
	Shutdown   = 2000,
	Type       = worker,
	Modules    = [gpucompute],
    ChildSpec  = {Id, StartFunc, Restart, Shutdown, Type, Modules},
    {ok, Pid}  = supervisor:start_child(?MODULE, ChildSpec).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

% init([]) ->
%   GpucomputeChild = {gpucompute,{gpucompute, start_link, []},
%               permanent, 2000, worker, [gpucompute]},
%   {ok,{{one_for_one,2,5}, [GpucomputeChild]}}.
-spec init(list()) -> ok.
init([]) ->
    {ok, { {one_for_one, 10, 3600}, []} }.
