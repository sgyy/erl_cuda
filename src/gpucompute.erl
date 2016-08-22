-module(gpucompute).

-behaviour(gen_server).

% =======
%   API
% =======
-export([
	start_link/0,
	compute/2
]).

% ===============================
%      gen_server callbacks
% ===============================
-export([
	init/1,
	handle_call/3,
	handle_cast/2,
	handle_info/2,
	terminate/2,
	code_change/3
]).

-record(state,{}).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

compute(A, B) ->
	gen_server:call(?MODULE, {compute, A, B}).

init([]) ->
  erlang:load_nif("./priv/gpucompute_drv", 0),
  {ok, #state{}}.

handle_call({compute, A, B}, _From, #state{} = State) ->
  	Reply = gpu_compute(A, B),
	io:format("compute result ~p~n", [Reply]),
  	{reply, ok, State}.

handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	ok.

code_change(_, _, _) ->
	ok.

gpu_compute(_A, _B) ->
    {error, nif_not_loaded}.
