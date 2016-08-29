-module(gpucompute).

-behaviour(gen_server).

% =======
%   API
% =======
-export([
	start_link/0,
	compute/3
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
-opaque state() :: #state{}.
-export_type([state/0]).

-spec start_link() -> ok.
start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

-spec compute(pid(), integer(), integer()) -> ok.
compute(Pid, A, B) ->
	gen_server:call(Pid, {compute, A, B}).

-spec init(state()) -> {ok, state()}.
init([]) ->
  erlang:load_nif("./priv/gpucompute_drv", 0),
  {ok, #state{}}.

-spec handle_call({atom(), integer(), integer()}, term(), state()) -> {reply, ok, state()}.
handle_call({compute, A, B}, _From, #state{} = State) ->
  	 f(Pid), f(OsPid), {ok, Pid, OsPid} = exec:run("/home/llin/dev/erl_cuda/cuda/simadd 1 2", [{stdout, fun(Stream,OsPid,Data) -> io:format("Got ~w from ~w: ~p\n", [Stream,OsPid,Data]), {reply, ok, Data}. end}]).  

-spec handle_cast(term(), state()) -> {atom(), state()}.
handle_cast(_Msg, State) ->
	{noreply, State}.

-spec handle_info(term(), state()) -> {noreply, state()}.
handle_info(_Info, State) ->
	{noreply, State}.

-spec terminate(term(), term()) -> ok.
terminate(_Reason, _State) ->
	ok.

-spec code_change(term(), term(), term()) -> ok.
code_change(_, _, _) ->
	ok.

-spec gpu_compute(integer(), integer()) -> {error, nif_not_loaded}.
gpu_compute(_A, _B) ->
    {error, nif_not_loaded}.
