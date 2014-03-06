-module(pe).

% API
-export([st/1]).
-export([st/2]).
-export([stacktrace/1]).
-export([stacktrace/2]).

%--- API ----------------------------------------------------------------------

st(S)            -> pretty_errors:stacktrace(S).
st(S, O)         -> pretty_errors:stacktrace(S, O).
stacktrace(S)    -> pretty_errors:stacktrace(S).
stacktrace(S, O) -> pretty_errors:stacktrace(S, O).
