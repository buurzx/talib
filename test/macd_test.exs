defmodule Talib.MCDATest do
  use ExUnit.Case
  alias Talib.MACD

  doctest Talib.MACD

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

    def numbers_macd_2_3_4 do
      [
        {0.00000000000000000, 89.00000000000000000},
        {2.00000000000000000, 84.20000000000000000},
        {5.66666666666667100, 71.72000000000000000},
        {2.55555555555555700, 68.63200000000000000},
        {-1.14814814814815240, 72.37920000000000000},
        {0.45061728395062060, 70.22752000000000000},
        {6.73353909465020450, 54.13651199999999600},
        {9.53617969821673500, 34.88190719999999000},
        {3.82455989940557830, 30.52914431999999700},
        {-3.23556336686480250, 39.51748659200000000},
        {-2.16706278895493650, 42.11049195520000400},
        {1.40004157034834980, 37.26629517312000000},
        {-10.13878822655054500, 62.35977710387200000},
        {-0.01566378385018652, 56.61586626232320000},
        {4.01007821788327600, 47.56951975739392000},
        {-2.48899085445557940, 56.14171185443635000},
        {2.09082791830647350, 49.68502711266181000},
        {1.49052174099799120, 47.41101626759708400},
        {-2.77303653555275530, 54.84660976055825000},
        {-6.39261740312696250, 68.50796585633495000}
      ]
    end
  end

  defmodule Fixts do
    def verified_macd12v26v9diff,
      do: [
        0,
        -4.547008547008545,
        -3.9892858012516115,
        -7.814553897296733,
        -9.68546703354523,
        -11.758855194041395,
        -9.500012810452446,
        -6.02656065453003,
        -2.678111693000716,
        -7.762054965956388,
        -4.955890237178558,
        -3.179483224749447,
        -2.070566240940323,
        -6.6026618662643415,
        -3.776210725235984,
        -2.4759859198692027,
        -4.859274338230051,
        -4.038668120840633,
        -5.264248228346467,
        -8.717175683191812,
        -11.004031373646804,
        -11.633288323448895,
        -9.600560425733171,
        -10.13217748107575,
        -7.4816532084116645,
        -5.8781751804450835,
        -7.825556495508927,
        -3.4387406426898934,
        -0.20190496720273643,
        2.256606231167005,
        5.1941109452040735,
        -0.2217370531452758,
        0.8823334558761218,
        -3.766982623447589,
        -5.29260653034283,
        -7.863478747649999,
        -3.166999957817737,
        -1.365861305295958,
        -4.64570012391512
      ]

    def verified_macd12v26v9signal,
      do: [
        0,
        -0.9094017094017091,
        -1.5253785277716898,
        -2.7832136016766986,
        -4.163664288050406,
        -5.6827024692486034,
        -6.446164537489373,
        -6.362243760897504,
        -5.625417347318147,
        -6.052744871045796,
        -5.833373944272349,
        -5.30259580036777,
        -4.65618988848228,
        -5.045484284038693,
        -4.791629572278152,
        -4.328500841796362,
        -4.4346555410831,
        -4.355458057034607,
        -4.537216091296979,
        -5.373208009675945,
        -6.499372682470117,
        -7.526155810665873,
        -7.941036733679333,
        -8.379264883158616,
        -8.199742548209226,
        -7.735429074656398,
        -7.753454558826904,
        -6.890511775599502,
        -5.55279041392015,
        -3.990911084902719,
        -2.153906678881361,
        -1.767472753734144,
        -1.2375115118120907,
        -1.7434057341391904,
        -2.4532458933799184,
        -3.535292464233935,
        -3.4616339629506956,
        -3.0424794314197485,
        -3.363123569918823
      ]

    def verified_macd12v26v9result,
      do: [
        0,
        -3.6376068376068362,
        -2.4639072734799217,
        -5.031340295620034,
        -5.521802745494824,
        -6.076152724792792,
        -3.053848272963074,
        0.33568310636747434,
        2.9473056543174314,
        -1.7093100949105917,
        0.8774837070937913,
        2.1231125756183227,
        2.585623647541957,
        -1.5571775822256484,
        1.0154188470421683,
        1.8525149219271597,
        -0.42461879714695083,
        0.3167899361939739,
        -0.7270321370494885,
        -3.3439676735158663,
        -4.504658691176687,
        -4.107132512783021,
        -1.6595236920538383,
        -1.7529125979171347,
        0.7180893397975616,
        1.8572538942113148,
        -0.07210193668202258,
        3.4517711329096086,
        5.350885446717413,
        6.247517316069724,
        7.3480176240854345,
        1.5457357005888681,
        2.1198449676882127,
        -2.0235768893083987,
        -2.839360636962912,
        -4.3281862834160645,
        0.2946340051329588,
        1.6766181261237905,
        -1.2825765539962966
      ]

    def prices do
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
  end

  test "from_list/4" do
    assert MACD.from_list(Fixtures.numbers(), 2, 3, 4) ==
             {:ok,
              %Talib.MACD{
                long_period: 2,
                short_period: 3,
                signal_period: 4,
                values: Fixtures.numbers_macd_2_3_4()
              }}

    assert MACD.from_list([3], 3, 2, 1) ==
             {:ok,
              %Talib.MACD{
                long_period: 3,
                short_period: 2,
                signal_period: 1,
                values: [{0.0, 3.0}]
              }}

    assert MACD.from_list([1]) ==
             {:ok,
              %Talib.MACD{
                long_period: 26,
                short_period: 12,
                signal_period: 9,
                values: [{0.0, 1.0}]
              }}

    assert MACD.from_list([]) === {:error, :no_data}
  end

  test "from_list!/4" do
    assert MACD.from_list!(Fixtures.numbers(), 2, 3, 4) ==
             %Talib.MACD{
               long_period: 2,
               short_period: 3,
               signal_period: 4,
               values: Fixtures.numbers_macd_2_3_4()
             }

    assert MACD.from_list!([3], 3, 2, 1) ==
             %Talib.MACD{
               long_period: 3,
               short_period: 2,
               signal_period: 1,
               values: [{0.0, 3.0}]
             }

    assert MACD.from_list!([1]) ==
             %Talib.MACD{
               long_period: 26,
               short_period: 12,
               signal_period: 9,
               values: [{0.0, 1.0}]
             }

    assert_raise NoDataError, fn -> MACD.from_list!([]) end
  end
end
