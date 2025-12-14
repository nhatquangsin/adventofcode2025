-module(day2).

-export([day2/0, is_repeated/1, min_half/1, full_from_half/1, find_repeated/4]).

day2() ->
    io:format("Start day 2~n"),
    case file_utils:read_file_lines("./inputs/day2.txt") of
    % case file_utils:read_file_lines("./inputs/day2-test.txt") of
        {ok, [Input | _]} ->
            [Trim | _] = string:split(Input, "\n", leading),
            List = string:split(Trim, ",", all),
            % io:format("~p~n", [List]),

            List1 = [string:split(Item, "-", all) ||Item <- List],
            List2 = [[list_to_integer(Left), list_to_integer(Right)] ||[Left, Right] <- List1],
            io:format("~p~n", [List2]),

            day2_part1(List2);
        {err, Reason} ->
            io:format("Error ~s~n", Reason)
    end.

day2_part1(List) ->
    Calculated = [find_repeated(0, min_half(Start), Start, End) ||[Start, End] <- List],
    io:format("~p~n", [Calculated]),
    io:format("~p~n", [lists:sum(Calculated)]).

day2_part2(List) ->

find_repeated(Sum, Num, Start, End) ->
    FullNum = full_from_half(Num),
    case FullNum =< End of
        false ->
            io:format("start ~p, sum ~p, end ~p~n", [Start, Sum, End]),
            Sum;
        true ->
            NextSum =
                if FullNum >= Start andalso FullNum =< End ->
                        io:format("start ~p, success ~p, end ~p~n", [Start, FullNum, End]),
                        Sum + FullNum;
                    true ->
                        Sum
                end,
            find_repeated(NextSum, Num + 1, Start, End)
    end.

min_half(Num) ->
    DigitCount = digit_count(Num),
    case DigitCount rem 2 of
        1 ->
            min_half(trunc(math:pow(10, DigitCount)));
        0 ->
            Base = trunc(math:pow(10, DigitCount / 2)),
            Left = Num rem Base,
            Right = Num div Base,
            Result = case Left < Right of
                true -> Left;
                false -> Right
            end,
            case Result =:= 0 of
                true -> trunc(Base / 10);
                false -> Result
            end
    end.

full_from_half(Num) ->
    DigitCount = digit_count(Num),
    Num * trunc(math:pow(10, DigitCount)) + Num.

is_repeated(Num) ->
    DigitCount = digit_count(Num),
    case DigitCount rem 2 of
        1 -> false;
        0 ->
            Base = trunc(math:pow(10, DigitCount / 2)),
            Num rem Base =:= Num div Base
    end.


digit_count(N) when N >= 0 ->
    digit_count(N, 0).

digit_count(0, Count) when Count > 0 ->
    Count;
digit_count(0, 0) ->
    1;
digit_count(N, Count) ->
    digit_count(N div 10, Count + 1).
