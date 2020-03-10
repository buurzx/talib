defmodule Talib.RSI do
  alias Talib.SMMA
  alias Talib.Utility

  @moduledoc ~S"""
  Defines RSI.
  """

  @doc """
  Gets the RSI of a list.

  Version: 1.0
  Source: http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:relative_strength_index_rsi
  Audited by:

  | Name         | Title             |
  | :----------- | :---------------- |
  |              |                   |

  """

  @typedoc """
  Defines a RSI index.

  * :period - The period of the RSI
  * :values - List of values resulting from the calculation
  """
  @type t :: %Talib.RSI{
          period: integer,
          values: [number]
        }
  defstruct period: 0,
            values: []

  @doc """
  Gets the RSI of a list.

  Raises `NoDataError` if the given list is an empty list.

  ## Examples

      iex>Talib.RSI.from_list([81, 24, 75], 2)
      {:ok, %Talib.RSI{
        period: 2,
        values: [
          0.0, 0.0, 64.15
        ]
      }}

      iex>Talib.RSI.from_list([], 2)
      {:error, :no_data}
  """
  @spec from_list([number], integer) ::
          {:ok, Talib.RSI.t()}
          | {:error, atom}
  def from_list(data, period \\ 14),
    do: calculate(data, period)

  @doc """
  Gets the RSI of a list.

  Raises `NoDataError` if the given list is an empty list.

  ## Examples

      iex>Talib.RSI.from_list!([10, 2, 30], 2)
      %Talib.RSI{
        period: 2,
        values: [
          0.0, 0.0, 87.5
        ]
      }

      iex>Talib.RSI.from_list([], 2)
      {:error, :no_data}
  """
  @spec from_list!([number], integer) ::
          Talib.RSI.t()
          | no_return
  def from_list!(data, period \\ 14) do
    case calculate(data, period) do
      {:ok, result} -> result
      {:error, :no_data} -> raise NoDataError
    end
  end

  @doc false
  @spec calculate([number], integer) ::
          {:ok, Talib.RSI.t()}
          | {:error, atom}
  defp calculate(data, period) do
    try do
      %SMMA{values: avg_gain} = SMMA.from_list!(Utility.gain!(data), period)
      %SMMA{values: avg_loss} = SMMA.from_list!(Utility.loss!(data), period)

      avg_gain_loss = Enum.zip(avg_gain, avg_loss)

      result =
        for {average_gain, average_loss} <- avg_gain_loss,
            !is_nil(average_gain) && !is_nil(average_loss) do
          relative_strength =
            case average_loss do
              0.0 -> 0.0
              0 -> 0.0
              _ -> average_gain / average_loss
            end

          (100 - 100 / (relative_strength + 1)) |> Float.round(2)
        end

      {:ok,
       %Talib.RSI{
         period: period,
         values: result
       }}
    rescue
      NoDataError -> {:error, :no_data}
    end
  end
end
