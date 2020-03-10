# TODO: Stochastic
defmodule Talib.Indicator do
  alias Talib.SMMA
  alias Talib.Utility

  @moduledoc ~S"""
  Module containing indicator functions, such as the RSI.
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

  @spec rsi([number], integer) :: [number, ...] | nil
  def rsi(data, period \\ 14), do: calculate_rsi(data, period)

  @spec calculate_rsi([number], integer) :: [number, ...] | nil
  def calculate_rsi(data, period) when length(data) <= period, do: nil
  def calculate_rsi(_data, 0), do: nil

  def calculate_rsi(data, period) do
    avg_gain =
      data
      |> Utility.gain!()
      |> SMMA.from_list!(period)

    avg_loss =
      data
      |> Utility.loss!()
      |> SMMA.from_list!(period)

    # require IEx
    # IEx.pry()
    avg_gain_loss = Enum.zip(avg_gain.values, avg_loss.values)

    for {average_gain, average_loss} <- avg_gain_loss,
        !is_nil(average_gain) && !is_nil(average_loss) do
      relative_strength =
        case average_loss do
          0.0 -> 100
          _ -> average_gain / average_loss
        end

      100 - 100 / (relative_strength + 1)
    end
  end
end
