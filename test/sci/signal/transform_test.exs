defmodule Sci.Signal.TransformTest do
  use Sci.TestCase, async: true
  doctest Sci.Signal.Transform

  describe "bilinear/4" do
    import Sci.Signal.Transform, only: [bilinear: 4]

    test "raises with more zeros than poles" do
      assert_raise RuntimeError, "length of zeros cannot exceed length of poles", fn ->
         bilinear([1, 2], [1], 0.1, 2.0)
      end
    end

    test "populates -1 as zeros when empty" do
      assert {[-1, -1, -1, -1], _, _} = bilinear([], [2, 3, 4, 5], 1.3, 2.0)
    end

    test "shifts zeros when not empty" do
      assert {[-3.0, -2.0, -1.6666666666666667, -1], _, _} = bilinear([2, 3, 4], [2, 3, 4, 5], 1.3, 2.0)
    end

    test "shifts poles" do
      expected_poles = [~i{-0.045436579714941916+0.6672218723563778i}, ~i{-0.03266828910227484+0.1987100804126568i}, ~i{-0.03266828910227484-0.1987100804126568i}, ~i{-0.045436579714941916-0.6672218723563778i}]
      provided_poles = [~i{-0.40752+0.98383i}, ~i{-0.98383+0.40752i}, ~i{-0.98383-0.40752i}, ~i{-0.40752-0.98383i}]
      {_, poles, _} = bilinear([], provided_poles, 1.2859, 2.0)
      assert expected_poles == poles

      assert {_, [-3.0, -2.0, -1.6666666666666667, -1.5], _} = bilinear([], [2, 3, 4, 5], 1.3, 2.0)
      assert {_, [-3.0, -2.0, -1.6666666666666667, -1.5], _} = bilinear([2, 3, 4], [2, 3, 4, 5], 1.3, 2.0)
    end

    test "transforms gain to compensate for shifted zeros, poles" do
      assert {_, _, 0.05416666666666667} = bilinear([], [2, 3, 4, 5], 1.3, 2.0)
      assert {_, _, 0.10630859774129929} = bilinear([], [~i{-0.40752+0.98383i}, ~i{-0.98383+0.40752i}, ~i{-0.98383-0.40752i}, ~i{-0.40752-0.98383i}], 1.2859, 2.0)
      assert {_, _, -0.325} = bilinear([2, 3, 4], [2, 3, 4, 5], 1.3, 2.0)
    end
  end

end
