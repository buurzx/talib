defmodule Talib.UtilityTest do
  use ExUnit.Case
  alias Talib.Utility

  doctest Talib.Utility

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

    def numbers_change do
      [
        0,
        -12,
        -24,
        11,
        14,
        -11,
        -37,
        -24,
        18,
        29,
        -7,
        -16,
        70,
        -52,
        -14,
        35,
        -29,
        4,
        22,
        23
      ]
    end

    def numbers_gain do
      [
        0,
        0,
        0,
        11,
        14,
        0,
        0,
        0,
        18,
        29,
        0,
        0,
        70,
        0,
        0,
        35,
        0,
        4,
        22,
        23
      ]
    end

    def numbers_loss do
      [
        0,
        12,
        24,
        0,
        0,
        11,
        37,
        24,
        0,
        0,
        7,
        16,
        0,
        52,
        14,
        0,
        29,
        0,
        0,
        0
      ]
    end

    def numbers_high, do: 100
    def numbers_low, do: 6

    def numbers_occur do
      %{
        89 => 2,
        77 => 1,
        53 => 2,
        64 => 1,
        78 => 1,
        67 => 1,
        30 => 2,
        6 => 1,
        24 => 1,
        46 => 1,
        100 => 1,
        48 => 1,
        34 => 1,
        69 => 1,
        40 => 1,
        44 => 1,
        66 => 1
      }
    end
  end

  test "change/2" do
    assert Utility.change(Fixtures.numbers()) === {:ok, Fixtures.numbers_change()}
    assert Utility.change([nil, 3, nil]) === {:ok, [0, 0, 0]}
    assert Utility.change([nil, 3]) === {:ok, [0, 0]}
    assert Utility.change([nil]) === {:ok, [0]}
    assert Utility.change([3]) === {:ok, [0]}
    assert Utility.change([]) === {:error, :no_data}
  end

  test "gain/1" do
    assert Utility.gain(Fixtures.numbers()) === {:ok, Fixtures.numbers_gain()}
    assert Utility.gain([nil, 3, nil]) === {:ok, [0, 0, 0]}
    assert Utility.gain([nil, 3]) === {:ok, [0, 0]}
    assert Utility.gain([nil]) === {:ok, [0]}
    assert Utility.gain([3]) === {:ok, [0]}
    assert Utility.gain([]) === {:error, :no_data}
  end

  test "high/1" do
    assert Utility.high(Fixtures.numbers()) === {:ok, Fixtures.numbers_high()}
    assert Utility.high([nil, 3, nil]) === {:ok, 3}
    assert Utility.high([nil, 3]) === {:ok, 3}
    assert Utility.high([nil]) === {:ok, nil}
    assert Utility.high([3]) === {:ok, 3}
    assert Utility.high([]) === {:error, :no_data}
  end

  test "loss/1" do
    assert Utility.loss(Fixtures.numbers()) === {:ok, Fixtures.numbers_loss()}
    assert Utility.loss([nil, 3, nil]) === {:ok, [0, 0, 0]}
    assert Utility.loss([nil, 3]) === {:ok, [0, 0]}
    assert Utility.loss([nil]) === {:ok, [0]}
    assert Utility.loss([3]) === {:ok, [0]}
    assert Utility.loss([]) === {:error, :no_data}
  end

  test "low/1" do
    assert Utility.low(Fixtures.numbers()) === {:ok, Fixtures.numbers_low()}
    assert Utility.low([nil, 3, nil]) === {:ok, 3}
    assert Utility.low([nil, 3]) === {:ok, 3}
    assert Utility.low([nil]) === {:ok, nil}
    assert Utility.low([3]) === {:ok, 3}
    assert Utility.low([]) === {:error, :no_data}
  end

  test "occur/1" do
    assert Utility.occur(Fixtures.numbers()) === {:ok, Fixtures.numbers_occur()}
    assert Utility.occur([nil, 3, nil]) === {:ok, %{3 => 1, nil => 2}}
    assert Utility.occur([3]) === {:ok, %{3 => 1}}
    assert Utility.occur([]) === {:error, :no_data}
  end

  test "change!/2" do
    assert Utility.change!(Fixtures.numbers()) === Fixtures.numbers_change()
    assert Utility.change!([nil, 3, nil]) === [0, 0, 0]
    assert Utility.change!([nil, 3]) === [0, 0]
    assert Utility.change!([nil]) === [0]
    assert Utility.change!([3]) === [0]
    assert_raise NoDataError, fn -> Utility.change!([]) end
  end

  test "gain!/1" do
    assert Utility.gain!(Fixtures.numbers()) === Fixtures.numbers_gain()
    assert Utility.gain!([nil, 3, nil]) === [0, 0, 0]
    assert Utility.gain!([nil, 3]) === [0, 0]
    assert Utility.gain!([nil]) === [0]
    assert Utility.gain!([3]) === [0]
    assert_raise NoDataError, fn -> Utility.gain!([]) end
  end

  test "high!/1" do
    assert Utility.high!(Fixtures.numbers()) === Fixtures.numbers_high()
    assert Utility.high!([nil, 3, nil]) === 3
    assert Utility.high!([nil, 3]) === 3
    assert Utility.high!([nil]) === nil
    assert Utility.high!([3]) === 3
    assert_raise NoDataError, fn -> Utility.high!([]) end
  end

  test "loss!/1" do
    assert Utility.loss!(Fixtures.numbers()) === Fixtures.numbers_loss()
    assert Utility.loss!([nil, 3, nil]) === [0, 0, 0]
    assert Utility.loss!([nil, 3]) === [0, 0]
    assert Utility.loss!([nil]) === [0]
    assert Utility.loss!([3]) === [0]
    assert_raise NoDataError, fn -> Utility.loss!([]) end
  end

  test "low!/1" do
    assert Utility.low!(Fixtures.numbers()) === Fixtures.numbers_low()
    assert Utility.low!([nil, 3, nil]) === 3
    assert Utility.low!([nil, 3]) === 3
    assert Utility.low!([nil]) === nil
    assert Utility.low!([3]) === 3
    assert_raise NoDataError, fn -> Utility.low!([]) end
  end

  test "occur!/1" do
    assert Utility.occur!(Fixtures.numbers()) === Fixtures.numbers_occur()
    assert Utility.occur!([nil, 3, nil]) === %{3 => 1, nil => 2}
    assert Utility.occur!([3]) === %{3 => 1}
    assert_raise NoDataError, fn -> Utility.occur!([]) end
  end

  test "filter_nil/1" do
    assert Utility.filter_nil(Fixtures.numbers()) === Fixtures.numbers()
    assert Utility.filter_nil([nil, 3, nil]) === [3]
    assert Utility.filter_nil([nil, 3]) === [3]
    assert Utility.filter_nil([nil]) === []
    assert Utility.filter_nil([3]) === [3]
  end

  test "to_bang_function/1" do
    assert Talib.Utility.to_bang_function({:ok, [1, nil, 5]}) === [1, nil, 5]

    assert_raise BadPeriodError, fn ->
      Talib.Utility.to_bang_function({:error, :bad_period})
    end

    assert_raise NoDataError, fn ->
      Talib.Utility.to_bang_function({:error, :no_data})
    end
  end
end
