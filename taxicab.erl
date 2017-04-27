-module(taxicab).

-export([do/0]).

do() ->
    Instructions = <<"R3, L5, R2, L2, R1, L3, R1, R3, L4, R3, L1, L1, R1, L3, R2, L3, L2, R1, R1, L1, R4, L1, L4, R3, L2, L2, R1, L1, R5, R4, R2, L5, L2, R5, R5, L2, R3, R1, R1, L3, R1, L4, L4, L190, L5, L2, R4, L5, R4, R5, L4, R1, R2, L5, R50, L2, R1, R73, R1, L2, R191, R2, L4, R1, L5, L5, R5, L3, L5, L4, R4, R5, L4, R4, R4, R5, L2, L5, R3, L4, L4, L5, R2, R2, R2, R4, L3, R4, R5, L3, R5, L2, R3, L1, R2, R2, L3, L1, R5, L3, L5, R2, R4, R1, L1, L5, R3, R2, L3, L4, L5, L1, R3, L5, L2, R2, L3, L4, L1, R1, R4, R2, R2, R4, R2, R2, L3, L3, L4, R4, L4, L4, R1, L4, L4, R1, L2, R5, R2, R3, R3, L2, L5, R3, L3, R5, L2, R3, R2, L4, L3, L1, R2, L2, L3, L5, R3, L1, L3, L4, L3">>,
    Start = {0, 0, north},
    do(Instructions, Start).

do(Instructions, Start) ->
    List = binary:split(Instructions, <<", ">>, [global]),
    Pos = {X, Y, _} = lists:foldl(fun make_turn/2, Start, List),
    Dist = abs(X) + abs(Y),
    {Pos, Dist}.

%% The fold fun
make_turn(<<Turn:1/binary, Steps/binary>>, {X, Y, Direction}) ->
    walk(turn(Direction, Turn), X, Y, list_to_integer(binary_to_list(Steps))).

%% Apply the steps after the turn
walk(north, X, Y, Steps) -> {X, Y + Steps, north};
walk(west, X, Y, Steps) -> {X - Steps, Y, west};
walk(south, X, Y, Steps) -> {X, Y - Steps, south};
walk(east, X, Y, Steps) -> {X + Steps, Y, east}.

%% Make the turn from one direction to another
turn(north, <<"L">>) -> west;
turn(west, <<"L">>) -> south;
turn(south, <<"L">>) -> east;
turn(east, <<"L">>) -> north;
turn(north, <<"R">>) -> east;
turn(east, <<"R">>) -> south;
turn(south, <<"R">>) -> west;
turn(west, <<"R">>) -> north.

