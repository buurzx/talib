defmodule Talib.EMATest do
  use ExUnit.Case
  alias Talib.EMA

  doctest Talib.EMA

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

    def numbers_ema_2 do
      [
        89.000000000000000,
        81.000000000000000,
        62.333333333333330,
        63.444444444444440,
        73.148148148148150,
        69.049382716049380,
        43.016460905349795,
        18.338820301783265,
        22.112940100594420,
        42.704313366864800,
        44.901437788954940,
        34.967145929651650,
        78.322381976550550,
        58.107460658850190,
        42.035820219616724,
        60.011940073205580,
        46.670646691068530,
        44.890215563689510,
        58.963405187896505,
        78.987801729298840
      ]
    end

    def numbers_3 do
      [
        22.27000,
        22.19000,
        22.08000,
        22.17000,
        22.18000,
        22.13000,
        22.23000,
        22.43000,
        22.24000,
        22.29000
      ]
    end

    def numbers_ema_3 do
      [
        22.27,
        22.255454545454544,
        22.22355371900826,
        22.213816679188575,
        22.20766819206338,
        22.19354670259731,
        22.200174574852344,
        22.24196101578828,
        22.241604467463137,
        22.25040365519711
      ]
    end
  end

  test "from_list/2" do
    assert EMA.from_list(Fixtures.numbers(), 2) ==
             {:ok,
              %Talib.EMA{
                period: 2,
                values: Fixtures.numbers_ema_2()
              }}

    assert EMA.from_list(Fixtures.numbers_3(), 10) ==
             {:ok,
              %Talib.EMA{
                period: 10,
                values: Fixtures.numbers_ema_3()
              }}

    assert EMA.from_list([3], 3) ==
             {:ok,
              %Talib.EMA{
                period: 3,
                values: [3.0]
              }}

    assert EMA.from_list([], 1) === {:error, :no_data}
  end

  test "from_list!/2" do
    assert EMA.from_list!(Fixtures.numbers(), 2) ==
             %Talib.EMA{
               period: 2,
               values: Fixtures.numbers_ema_2()
             }

    assert EMA.from_list!([3], 3) ==
             %Talib.EMA{
               period: 3,
               values: [3.0]
             }

    assert_raise NoDataError, fn -> EMA.from_list!([], 1) end
  end
end
