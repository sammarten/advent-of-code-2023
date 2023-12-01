defmodule Trebuchet do
  def run(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&process_digits/1)
    |> Enum.sum()
  end

  def process_digits(line) do
    digits =
      line
      |> String.graphemes()
      |> Enum.reduce([], &reduce_to_digits/2)
      |> Enum.reverse()

    first_digit = List.first(digits)
    last_digit = List.last(digits)

    String.to_integer(first_digit <> last_digit)
  end

  def reduce_to_digits(c, acc) do
    case Integer.parse(c) do
      {_, _} -> [c | acc]
      :error -> acc
    end
  end
end

IO.inspect(Trebuchet.run("input.txt"))
