defmodule Talib.SMATest do
  use ExUnit.Case
  alias Talib.SMA

  doctest Talib.SMA

  defmodule Fixtures do
    def numbers do
      [
        89,
        77,
        53,
        64,
        78,
        67,
        30,
        6,
        24,
        53,
        46,
        30,
        100,
        48,
        34,
        69,
        40,
        44,
        66,
        89
      ]
    end

    def numbers_sma_10 do
      [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        54.1,
        49.8,
        45.1,
        49.8,
        48.2,
        43.8,
        44.0,
        45.0,
        48.8,
        53.0,
        56.6
      ]
    end

    def numbers_14 do
      # 16
      [
        0,
        0,
        0.059500,
        0,
        0.715400,
        0.498600,
        0.269100,
        0.329000,
        0.418800,
        0.239300,
        0,
        0.139700,
        0,
        0.668000,
        0,
        0,
        0.030000,
        0.378800,
        0.000000,
        0.000000,
        0.568300,
        0.039900,
        0.000000,
        0.737800,
        0.000000,
        0.000000,
        0.000000,
        0.149500,
        0.039800,
        0.349100,
        0.000000,
        0.000000,
        0.468600
      ]
    end

    def gains_sma_14 do
      [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0.238386,
        0.221358,
        0.20769,
        0.219912,
        0.204204,
        0.189618,
        0.216667,
        0.204041,
        0.189467,
        0.228634,
        0.212303,
        0.197138,
        0.183057,
        0.18066,
        0.170599,
        0.183349,
        0.170253,
        0.158092,
        0.180271
      ]
    end
  end

  test "from_list/2" do
    assert SMA.from_list(Fixtures.numbers(), 10) ==
             {:ok,
              %Talib.SMA{
                period: 10,
                values: Fixtures.numbers_sma_10()
              }}

    assert SMA.from_list([nil, 87, 77], 2) ==
             {:ok,
              %Talib.SMA{
                period: 2,
                values: [0, 0, 0, 82.0]
              }}

    assert SMA.from_list([3], 3) ==
             {:ok,
              %Talib.SMA{
                period: 3,
                values: [0]
              }}

    assert SMA.from_list([], 1) === {:error, :no_data}
    assert SMA.from_list([3], 0) === {:error, :bad_period}
  end

  test "from_list!/2" do
    assert SMA.from_list!(Fixtures.numbers(), 10) ==
             %Talib.SMA{
               period: 10,
               values: Fixtures.numbers_sma_10()
             }

    assert SMA.from_list!([nil, 87, 77], 2) ==
             %Talib.SMA{
               period: 2,
               values: [0, 0, 0, 82.0]
             }

    assert SMA.from_list!([3], 3) ==
             %Talib.SMA{
               period: 3,
               values: [0]
             }

    assert_raise NoDataError, fn -> SMA.from_list!([], 1) end
    assert_raise BadPeriodError, fn -> SMA.from_list!([3], 0) end
  end

  # [ 44.34, 44.09, 44.15, 43.61, 44.33, 44.83, 45.10, 45.42, 45.84, 46.08, 45.89, 46.03, 45.61, 46.28, 46.28, 46.00 ]
  # [ 0 ]
  # [ 0,     0 ]
  # [ 0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0.24 ]
  # [ 0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0.24,  0.22]

  test "for rsi" do
    # gains = Fixtures.numbers_14() |> Talib.Utility.gain!()
    # losses = Fixtures.numbers_14() |> Talib.Utility.loss!()

    assert SMA.from_list!(Fixtures.numbers_14(), 14) ==
             %Talib.SMA{
               period: 14,
               values: Fixtures.gains_sma_14()
             }
  end
end
