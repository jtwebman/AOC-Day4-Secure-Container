defmodule Password do
  def solve() do
    254_032..789_860
    |> Enum.map(&to_charlist/1)
    |> Enum.filter(&always_increasing/1)
    |> Enum.filter(&not_large_adjacent/1)
    |> Enum.count()
  end

  def solve_part1() do
    254_032..789_860
    |> Enum.map(&to_charlist/1)
    |> Enum.filter(&always_increasing/1)
    |> Enum.filter(&adjacent_same/1)
    |> Enum.count()
  end

  def always_increasing(num) do
    {passed, _} =
      Enum.reduce_while(num, {true, 0}, fn code, {_, last} ->
        case last <= code do
          false -> {:halt, {false, code}}
          _ -> {:cont, {true, code}}
        end
      end)

    passed
  end

  def adjacent_same(num) do
    {passed, _} =
      Enum.reduce_while(num, {false, 0}, fn code, {_, last} ->
        case last == code do
          true -> {:halt, {true, code}}
          _ -> {:cont, {false, code}}
        end
      end)

    passed
  end

  def not_large_adjacent(num) do
    {passed, _, count} =
      Enum.reduce_while(num, {false, 0, 0}, fn code, {_, last, count} ->
        case last != code and count == 2 do
          true ->
            {:halt, {true, code, 0}}

          _ ->
            case last == code do
              true ->
                {:cont, {false, code, count + 1}}

              _ ->
                {:cont, {false, code, 1}}
            end
        end
      end)

    case count == 2 do
      true -> true
      _ -> passed
    end
  end
end
