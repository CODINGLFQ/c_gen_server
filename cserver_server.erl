-module(cserver_server).

-behaviour(gen_server).


%%API
-export([start_link/1, stop/1, calculate/2, calculate1/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 
-record(state, {value}).



%%%==============
%%%API
%%%==============

start_link(X) ->
	% PName = random:seed(erlang:now()),
	S1 = "abc",
	S2 = integer_to_list(random:uniform(1000)),
	PName = S1 ++ S2,
	P = list_to_atom(PName),
	io:format("this is P's pid: ~p~n ", [P]),
	gen_server:start_link({local, P}, ?MODULE, [X], []). %% start server


stop(P) ->
	gen_server:cast(P, stop).	

calculate(Pid,Request) ->
	gen_server:call(Pid, {calculate, Request}).


calculate1(Pid, Request) ->
	gen_server:cast(Pid, {calculate1, Request}).
%%%==============
%%%gen_server callbacks
%%%==============

init([X]) ->
	process_flag(trap_exit,true),
	io:format("~p starting! ~n",[?MODULE]),
	io:format("this is a test~p~n ",[X]),
	{ok,#state{}}.


%%API


handle_call({calculate, Request}, _From, #state{} = State) ->
	timer:sleep(4000),
	io:format("this is a handle_call callbacks:~p~n", [Request]),
	{reply, cl(Request), State}.


handle_cast(stop, State) ->
	io:format("cast stop~p~n", [State]),
	% {noreply, State};
	{stop, normal, State};

handle_cast({calculate1, Request}, #state{} = State) ->
	timer:sleep(4000),
	io:format("this is a handle_cast callbacks:~p~n", [Request]),
	{noreply, State}.


handle_info(Reason, _State) ->
    io:format("terminate: ~p~n", [Reason]),
    timer:sleep(20000),
    ok.

terminate(_Reason, _State) ->
	io:format("~p stopping ! ~n", [?MODULE]),
	ok.

code_change(_OldVsn, State, _Extra) -> 
	{ok, State}.


cl(Request) ->
	case Request of
		{A, '+', B} ->
			io:format("the add result is ~p~n", [A + B]),
			A + B;
		{A, '-', B} ->
			io:format("the subtract result is ~p~n", [A - B]),
			A - B;
		{A, '*', B} ->
			io:format("the multiply result is ~p~n", [A * B]),
			A * B;
		{A, '/', B} ->
				 	% receive
				 	% 	_ ->
				 	% 		A div B

				 	% after 2000 ->
				 		io:format("will restart!!!the result is:~p~n",[A div B]),
				 		exit(Request)	
				 		
				 	% end	
					
				 	

					% try A div B of
					% 				_ ->
					% 					io:format("the division result is ~p~n", [A div B]),
					% 					A div B
					% 			catch
					% 				throw : X -> io:format("throw the Resson is ~p~n", [X]);
					% 				error : X -> io:format("error the Resson is ~p~n", [X]),
					% 							 exit(X),
					% 							 io:format("error exitting!!");
					% 				exit : X -> io:format("exit the Resson is ~p~n", [X])	
					% 			end			
	end.


%%%===================
%%%Internal functions
%%%===================
	






