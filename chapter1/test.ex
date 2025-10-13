defmodule Test do
  def list_len([]), do: 0
  def list_len([_ | tail]) do
    1 + list_len(tail)
  end
  

  def range(from, from), do: [from]
  def range(from, to) when from <= to do
    [from | range(from+1, to)]
  end

  def positive([]), do: []
  def positive([head | tail]) do
    if head > 0 do 
      [ head | positive(tail) ]
    else 
      positive(tail)
    end
  end

  def line_lengths!(path) do
    File.stream!(path)
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.length/1)
      |> Enum.to_list()
  end

  def longest_line_length!(path) do
    {_, idx} = path
      |> line_lengths!()
      |> Enum.with_index()
      |> Enum.max()

    idx + 1
  end

  def longest_line!(path) do
    idx = longest_line_length!(path) - 1

    File.stream!(path)
      |> Stream.map(&String.trim/1)
      |> Enum.at(idx)
  end

  def words_per_line!(path) do
    path
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.map(&word_count/1)
      |> Enum.to_list()
  end

  defp word_count(line) do
    line 
      |> String.split()
      |> length()
  end
end
