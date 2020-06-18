defmodule Talib.RsiTest do
  use ExUnit.Case
  alias Talib.RSI

  doctest Talib.RSI

  defmodule Fixtures do
    def numbers_14 do
      [
        54.80,
        56.80,
        57.85,
        59.85,
        60.57,
        61.10,
        62.17,
        60.60,
        62.35,
        62.15,
        62.35,
        61.45,
        62.80,
        61.37,
        62.50,
        62.57,
        60.80,
        59.37,
        60.35,
        62.35,
        62.17,
        62.55,
        64.55,
        64.37,
        65.30,
        64.42,
        62.90,
        61.60,
        62.05,
        60.05,
        59.70,
        60.90,
        60.25,
        58.27,
        58.70,
        57.72,
        58.10,
        58.20
      ]
    end

    def numbers do
      # [
      #   89,
      #   77,
      #   53,
      #   64,
      #   78,
      #   67,
      #   30,
      #   6,
      #   24,
      #   53,
      #   46,
      #   30,
      #   100,
      #   48,
      #   34,
      #   69,
      #   40,
      #   44,
      #   66,
      #   89
      # ]
      [
        81,
        24,
        75,
        21,
        34,
        25,
        72,
        92,
        99,
        2,
        86,
        80,
        76,
        8,
        87,
        75,
        32,
        65,
        41,
        9,
        13,
        26,
        56,
        28,
        65,
        58,
        17,
        90,
        87,
        86,
        99,
        3,
        70,
        1,
        27,
        9,
        92,
        68,
        9
      ]
    end

    def numbers_rsi_2 do
      [
        0.0000000000000000,
        37.931034482758620,
        68.421052631578950,
        38.613861386138610,
        9.8236775818639900,
        4.9935979513444270,
        45.320560058953575,
        76.906318082788670,
        60.136286201022145,
        30.115783059110300,
        86.981496197071180,
        39.376933592344780,
        30.414003889969436,
        67.454191033138400,
        35.840108267425265,
        43.185617779672240,
        74.853807047725820,
        88.387636740431600
      ]
    end

    # def numbers_rsi_14 do
    #   [
    #     41.887905604719760,
    #     47.702675107208490,
    #     43.792631047660260,
    #     44.468749897255890,
    #     48.162132406610610,
    #     51.773428242757800
    #   ]
    # end

    def numbers_rsi_14 do
      [
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        72.38,
        74.53,
        74.75,
        65.71,
        59.26,
        61.68,
        66.67,
        65.74,
        66.99,
        70.91,
        69.9,
        71.57,
        67.33,
        60.0,
        54.72,
        55.88,
        48.62,
        47.57,
        51.92,
        49.5,
        42.99,
        44.66,
        41.75,
        43.43,
        44.09
      ]
    end

    def numbers_version_14 do
      [
        44.34,
        44.09,
        44.15,
        43.61,
        44.33,
        44.83,
        45.10,
        45.42,
        45.84,
        46.08,
        45.89,
        46.03,
        45.61,
        46.28,
        46.28,
        46.00,
        46.03,
        46.41,
        46.22,
        45.64,
        46.21,
        46.25,
        45.71,
        46.45,
        45.78,
        45.35,
        44.03,
        44.18,
        44.22,
        44.57,
        43.43,
        42.66,
        43.13
      ]
    end

    def numbers_rsi_version_14 do
      [
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        0.0,
        70.53,
        66.32,
        66.55,
        69.41,
        66.36,
        57.97,
        62.93,
        63.26,
        56.06,
        62.38,
        54.71,
        50.42,
        39.99,
        41.46,
        41.87,
        45.46,
        37.30,
        33.08,
        37.77
      ]
    end
  end

  # Relative Strength Index

  test "rsi returns the relative strength index with period 14" do
    assert RSI.from_list!(Fixtures.numbers_14(), 14).values == Fixtures.numbers_rsi_14()
  end

  test "version 2 rsi returns the relative strength index with period 14" do
    assert RSI.from_list!(Fixtures.numbers_version_14(), 14).values ==
             Fixtures.numbers_rsi_version_14()
  end

  # test "rsi returns the relative strength index with period 2" do
  #   assert Indicator.rsi(Fixtures.numbers(), 2) == Fixtures.numbers_rsi_2()
  # end

  # test "rsi returns nil when the list is empty" do
  #   assert Indicator.rsi([], 1) === nil
  # end

  # test "rsi returns nil when the period is 0" do
  #   assert Indicator.rsi(Fixtures.numbers(), 0) === nil
  # end

  # test "rsi returns nil when the list is smaller than the period" do
  #   assert Indicator.rsi(Fixtures.numbers(), 21) === nil
  # end
end
