defmodule Talib.SMMATest do
  use ExUnit.Case
  alias Talib.SMMA

  doctest Talib.SMMA

  defmodule Fixtures do
    def numbers_14 do
      [
        2.00,
        1.05,
        2.00,
        0.72,
        0.53,
        1.07,
        0.00,
        1.75,
        0.00,
        0.20,
        0.00,
        1.35,
        0.00,
        1.13,
        0.07,
        0.00,
        0.00,
        0.98,
        2.00,
        0.00,
        0.38,
        2.00,
        0.00,
        0.93,
        0.00,
        0.00,
        0.00,
        0.45,
        0.00,
        0.00,
        1.20,
        0.00,
        0.00,
        0.43,
        0.00,
        0.38,
        0.10
      ]
    end

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

    def numbers_smma_2 do
      [
        0,
        83.0,
        68.0,
        66.0,
        72.0,
        69.50,
        49.75,
        27.88,
        25.94,
        39.47,
        42.73,
        36.36,
        68.18,
        58.09,
        46.05,
        57.52,
        48.76,
        46.38,
        56.19,
        72.59
      ]
    end

    def numbers_smma_14 do
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
        0.84,
        0.79,
        0.73,
        0.68,
        0.70,
        0.79,
        0.73,
        0.71,
        0.80,
        0.74,
        0.75,
        0.70,
        0.65,
        0.60,
        0.59,
        0.55,
        0.51,
        0.56,
        0.52,
        0.48,
        0.48,
        0.45,
        0.45,
        0.42
      ]
    end
  end

  test "from_list/2" do
    assert SMMA.from_list(Fixtures.numbers(), 2) ==
             {:ok,
              %Talib.SMMA{
                period: 2,
                values: Fixtures.numbers_smma_2()
              }}

    assert SMMA.from_list([3], 3) ==
             {:ok,
              %Talib.SMMA{
                period: 3,
                values: [0]
              }}

    assert SMMA.from_list([], 1) === {:error, :no_data}
    assert SMMA.from_list([3], 0) === {:error, :bad_period}
  end

  test "from_list!/2" do
    assert SMMA.from_list!(Fixtures.numbers(), 2) ==
             %Talib.SMMA{
               period: 2,
               values: Fixtures.numbers_smma_2()
             }

    assert SMMA.from_list!([3], 3) ==
             %Talib.SMMA{
               period: 3,
               values: [0]
             }

    assert_raise NoDataError, fn -> SMMA.from_list!([], 1) end
    assert_raise BadPeriodError, fn -> SMMA.from_list!([3], 0) end
  end

  test "from_list!/2 period 14" do
    assert SMMA.from_list!(Fixtures.numbers_14(), 14).values == Fixtures.numbers_smma_14()
  end
end
