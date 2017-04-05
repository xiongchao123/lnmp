<?php
echo "使用方法：php MonkeyKing.php [猴子数目] [踢出第几只]\r\n";
/**
 * 一群猴子按编号围成一圈，然后从第一只开始数，数到第m只，把他踢出圈，然后再从他后面开始数，数到第m只，再把他踢出圈，如此下去，直到剩下最后一个猴子为止。
 * @param $n
 * @param $m
 */
function monkeyKing($n, $m)
{
    //生成1-n的数组
    $monkey = range(1, $n);
    $i = 0;
    while(count($monkey) > 1){
        $i ++;
        //获得第一个数
        $head = array_shift($monkey);
        if ($i % $m != 0){
            //如果不是m的倍数，则将i放到数组末尾，否则去掉m。
            array_push($monkey, $head);
        }
    }
    return $monkey[0];
}
$monkeyNum = isset($argv[1]) && $argv[1] ? (int)$argv[1] : 100;
$monkeyStep = isset($argv[2]) && $argv[2] ? (int)$argv[2] : 5;
$monkeyKing = monkeyKing($monkeyNum,  $monkeyStep);
echo $monkeyNum.'只猴子围成一圈，数到'.$monkeyStep.'只踢出圈，如此下去，选出的大王编号是：'.$monkeyKing."\r\n";