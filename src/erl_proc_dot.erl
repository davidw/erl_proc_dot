-module(erl_proc_dot).

%% API exports
-export([run/0, run/1]).

%%====================================================================
%% API functions
%%====================================================================

run() ->
    io:format("digraph Erlang {~n"),
    Processes = processes(),
    ProcessInfo = [{erlang:process_info(Pid), Pid} || Pid <- Processes],
    lists:foreach(fun({PI, Pid}) ->
                          Name = case proplists:get_value(registered_name, PI) of
                                     undefined -> Pid;
                                     RegName -> RegName
                                 end,
                          case proplists:get_value(dictionary, PI) of
                              undefined ->
                                  noop;
                              Dictionary ->
                                  case proplists:get_value('$ancestors', Dictionary) of
                                      undefined ->
                                          noop;
                                      Ancestors ->
                                          Parent = hd(Ancestors),
                                          io:format("\"~p\" -> \"~p\"~n", [Parent, Name])
                                  end
                          end
                          %% Leader = proplists:get_value(group_leader, PI),
                          %% Links = proplists:get_value(links, PI),
                  end, ProcessInfo),
    io:format("}~n").
