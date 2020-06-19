defmodule Talib.SMA do
  @moduledoc ~S"""
  Defines a Simple Moving Average.

  ## History

  Version: 1.0
  Source: https://qkdb.wordpress.com/2013/04/22/simple-moving-average/
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @typedoc """
  Defines a Simple Moving Average.

  * :period - The period of the SMA
  * :values - List of values resulting from the calculation
  """
  @type t :: %Talib.SMA{period: integer, values: [number]}
  defstruct period: 0,
            values: []

  @doc """
  Gets the SMA of a list.

  Returns `{:ok, sma}`, otherwise `{:error, reason}`.

  ## Examples

      iex> Talib.SMA.from_list([17, 23, 44], 2)
      {:ok, %Talib.SMA{
        period: 2,
        values: [0, 0, 20.0, 33.5]
      }}

      iex> Talib.SMA.from_list([], 1)
      {:error, :no_data}

      iex> Talib.SMA.from_list([17], 0)
      {:error, :bad_period}
  """
  @spec from_list([number], integer) :: {:ok, Talib.SMA.t()} | {:error, atom}
  def from_list(data, period), do: calculate(data, period)

  @doc """
  Gets the SMA of a list.

  Raises `NoDataError` if the given list is an empty list.
  Raises `BadPeriodError` if the given period is 0.

  ## Examples

      iex> Talib.SMA.from_list!([9, 10, 11, 12, 13, 14], 5)
      %Talib.SMA{
        period: 5,
        values: [0, 0, 0, 0, 0, 11.0, 12.0]
      }

      iex> Talib.SMA.from_list!([], 1)
      ** (NoDataError) no data error

      iex> Talib.SMA.from_list!([17], 0)
      ** (BadPeriodError) bad period error
  """
  @spec from_list!([number], integer) :: Talib.SMA.t() | no_return
  def from_list!(data, period) do
    case calculate(data, period) do
      {:ok, result} -> result
      {:error, :no_data} -> raise NoDataError
      {:error, :bad_period} -> raise BadPeriodError
    end
  end

  @doc false
  @spec calculate([number], integer, [float], integer) ::
          {:ok, Talib.SMA.t()}
          | {:error, atom}
  defp calculate(data, period, results \\ [], index \\ 0)

  defp calculate([], _period, [], 0),
    do: {:error, :no_data}

  defp calculate(_data, 0, _results, 0),
    do: {:error, :bad_period}

  defp calculate([], period, results, _),
    do: {:ok, %Talib.SMA{period: period, values: results}}

  defp calculate([hd | tl] = data, period, results, index) do
    cond do
      # period = 14
      # if results size < 14 && 15 > 14
      # add [0] to results
      length(results) < period && length(data) > length(results) ->
        index = index + 1
        calculate(data, period, results ++ [0], index)

      # if data size < 14
      length(data) <= period ->
        calculate(tl, period, results, index)

      # for any nil cases, suddenly
      hd === nil ->
        calculate(tl, period, results ++ [0], index)

      # after first average counted
      # calculate rest of data
      length(results) >= period + 1 ->
        next_avg = (List.last(Enum.take(results, -1)) * 13 + Enum.at(data, index)) / period
        calculate(tl, period, results ++ [Float.round(next_avg, 6)], index)

      # after period calculate first average
      length(data) >= period ->
        result =
          data
          |> Enum.take(period)
          |> Enum.sum()
          |> Kernel./(period)

        calculate(tl, period, results ++ [Float.round(result, 6)], index)
    end
  end
end
