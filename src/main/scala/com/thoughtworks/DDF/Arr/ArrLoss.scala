package com.thoughtworks.DDF.Arr

import com.thoughtworks.DDF.Eval.Eval

case class ArrLoss[A, BL](seq: Seq[(Eval[A], BL)])
