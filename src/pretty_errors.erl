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
    {Mod, Func, Arity, [{file, File}, {line, Line}]} = Entry,
    Output = [
        Indent,
        atom_to_list(Mod),
        <<":">>,
        atom_to_list(Func),
        <<"/">>,
        integer_to_binary(Arity),
        <<" (">>,
        File,
        <<":">>,
        integer_to_binary(Line),
        <<")">>,
        io_lib:format("~n", [])
    ],
    [Output|stacktrace_pretty(Indent, Stacktrace)].
