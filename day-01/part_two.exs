defmodule Trebuchet do
  @digit_regexes [
    {~r/one|1/, "1"},
    {~r/two|2/, "2"},
    {~r/three|3/, "3"},
    {~r/four|4/, "4"},
    {~r/five|5/, "5"},
    {~r/six|6/, "6"},
    {~r/seven|7/, "7"},
    {~r/eight|8/, "8"},
    {~r/nine|9/, "9"}
  ]

  def run(filename) do
    filename
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&replace_digits/1)
    |> Enum.map(&process_digits/1)
    |> Enum.sum()
  end

  def replace_digits(line) do
    @digit_regexes
    |> Enum.reduce([], fn {regex, digit}, acc ->
      case Regex.scan(regex, line, return: :index) do
        [] -> acc
        matches -> add_matches(matches, digit, acc)
      end
    end)
    |> Enum.sort_by(fn {index, _digit} -> index end)
    |> Enum.map(fn {_index, digit} -> digit end)
  end

  def add_matches(matches, digit, acc) do
    Enum.reduce(matches, acc, fn [{index, _}], acc ->
      [{index, digit} | acc]
    end)
  end

  def process_digits(digits) do
    first_digit = List.first(digits)
    last_digit = List.last(digits)

    String.to_integer(first_digit <> last_digit)
  end
end

IO.inspect(Trebuchet.run("input.txt"))
