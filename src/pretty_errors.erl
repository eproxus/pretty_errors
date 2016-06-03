-module(pretty_errors).

% API
-export([stacktrace/1]).
-export([stacktrace/2]).

%--- API ----------------------------------------------------------------------

stacktrace(Stacktrace) -> stacktrace(Stacktrace, [{indent, 4}]).

stacktrace(Stacktrace, Options) ->
    Indent = lists:duplicate(proplists:get_value(indent, Options), <<" ">>),
    stacktrace_pretty(Indent, Stacktrace).

stacktrace_pretty(_Indent, []) ->
    [];
stacktrace_pretty(Indent, [Entry|Stacktrace]) ->
    {Mod, Func, ArityOrArgs, Location} = Entry,
    Arity = case ArityOrArgs of
        N when is_integer(N) -> N;
        Args -> length(Args)
    end,
    LocationOutput = case Location of
        [{file, File}, {line, Line}] -> 
            [<<" (">>, File, <<":">>, integer_to_binary(Line), <<")">>];
        _ -> []
    end,
    Output =
        [Indent, atom_to_list(Mod), <<":">>, atom_to_list(Func), <<"/">>, integer_to_binary(Arity)]
        ++ LocationOutput ++
        [io_lib:format("~n", [])],
    [Output|stacktrace_pretty(Indent, Stacktrace)].
