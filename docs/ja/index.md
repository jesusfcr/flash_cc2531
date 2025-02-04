---
lang: ja
lang-niv: auto
lang-ref: 001-ĉefa-afero
layout: page
slug: 必需品！
title: 重要なこと
---

# _flash\_cc2531_
 _flash\_cc2531_ を使用すると、 _Arduino_ または _CC Debugger_を必要とせずに、 _Raspberry_からCC2531USBスティックをプログラムできます。

## 前提条件
 _Raspberry_ または _Odroid-c2_のいずれかが必要です。  
キーのデバッグポートを _Raspberry_のポート _GPIO_ に接続するものが必要です。たとえば、ケーブル _CC_ と4本の線 _Dupont_ (を参照してください)。   
[WiringPi](http://wiringpi.com/) が事前にインストールされていない場合はインストールする必要があります (、通常は `sudo apt install wiringpi`でインストールできます。それ以外の場合はWebサイト [ を参照してください_ゴードン_](http://wiringpi.com/) または [この代替サイト](https://github.com/WiringPi/WiringPi))。  

 _flash\_cc2531_ を _raspbian_で _Raspberry Pi 3_ に投影しましたが、他のモデルでプログラミングの成功が報告されました：pi 4では
* （°のバージョン2.52が必要です10°）:  [取り付け _配線Pi_ 2.52 _ゴードンのウェブサイト_](http://wiringpi.com/wiringpi-updated-to-2-52-for-the-raspberry-pi-4b/)  
* pi1とpi2では、他のピン](#uzi_aliajn_pinglojn)を使用するために [が必要になります。  

* ただし、おそらくタイムベースオプション ( _"-m"_ )を設定する必要があります。



## 準備

 _flash\_cc2531_ をあなたの _raspberry_にダウンロードします：
```bash
git clone https://github.com/jmichault/flash_cc2531.git
```
次のピンをデバッグポートからGPIOポートに接続します。
1。ピン1 ( _GND_ ) -> ピン39 ( _GND_ )
2番目のピン7 ( _reset_ ) -> ピン35 ( _wPi 24, BCM19_ ）)
3。スピンドル3 ( _DC_ ) -> ピン36 ( _wPi 27, BCM16_ )
4。スピンドル4 ( _DD_ ) -> スピンドル38 ( _wPi 28, BCM20_ )

USBキーをポートに挿入します。

ダウンロードケーブル _CC_ と4本の線 _Dupont_ メスからメスはこの目的に最適です：
![キーと _ラズベリー_](https://github.com/jmichault/files/raw/master/Raspberry-CC2531.jpg)の写真°）
これは私のお気に入りの選択ですが、ケーブル _CC_ がない場合は、キーにケーブル _Dupont_ を直接はんだ付けすることもできます。たとえば、Webサイト [ を参照してください。 ）_mariva.com_](https://lemariva.com/blog/2019/08/zigbee-flashing-cc2531-using-raspberry-pi-without-cc-debugger) または [ _notenoughtech.com_](https://notenoughtech.com/home-automation/flashing-cc2531-without-cc-debugger/)


これを試してください：
```bash
cd flash_cc2531
./cc_chipid
```
戻らなければなりません：
```
  ID = b524.
```
0000またはffffが表示された場合は、何か問題があります。
* 最初に配線を確認してください。
* 次に、たとえば `./cc_chipid -m 100`、 `./cc_chipid -m 160` 、または `./cc_chipid -m 300`を使用して、より高い基準時間を試してください。
* これでうまくいかない場合は、 `make`で再コンパイルしてみてください。


## 使用する
フラッシュメモリの内容をsave.hexファイルに保存するには：
```bash
./cc_read save.hex
```
(は約1分)続きます。

フラッシュメモリを消去するには：
```bash
./cc_erase
```
**注：** あなた **は、あなたが何をしようとしているのか)を本当に理解していない限り、書く前に** 削除する必要があります (。

キーにファイルをプログラムするには _CC2531_:
```bash
./cc_write CC2531ZNP-Prod.hex
```
(は約3分)続きます。

<a id ="使用_aliajn_ピン"></ a>
## 他のピンを使用する
すべてのコマンドは次の引数を受け入れます：
* _-c_ ピン：デフォルトでピン _DC_ (を変更27)
* _-d_ ピン：変更ピン _DD_ )(デフォルト28)
* _-r_ ピン：変更ピン _reset_ (デフォルトで24)
* _-m_ ：遅延の乗数を変更し、デフォルトでベースタイム (を変更します：自動調整)

使用されるピン番号は _wiringPi_の番号です。 `gpio readall` を使用して、 _Raspberry_ (列 _wPi_)にレイアウトを配置します。

たとえば、ピン3、11、13を使用する場合：  
次のピンをデバッグポートからゲート _GPIO_に接続します。
1。ピン1 ( _GND_ ) -> ピン14 ( ）_GND_ )
2。ピン7 ( _reset_ ) -> ピン3 ( _wPi 8, BCM2_ )
3。ピン3 ( _DC_ ) -> ピン11 ( _wPi 0, BCM17_ )
4。ピン4 ( _DD_ ) -> ピン13 ( )_wPi 2 BCM27_ )

これで、次のコマンドを使用して、IDの読み取り、保存、削除、およびフラッシュメモリの書き込みを行うことができます。
```bash
./cc_chipid -r 8 -c 0 -d 2
./cc_read -r 8 -c 0 -d 2 save.hex
./cc_erase -r 8 -c 0 -d 2
./cc_write -r 8 -c 0 -d 2 CC2531ZNP-Prod.hex
```

 _CCDebugger.h_ でデフォルト値を変更し、 `make`でプログラムをコンパイルすることもできます。

## それが機能しない場合はどうなりますか？

1. 他のすべてのプログラムを停止します。

2. プログラミングする前にプロセッサ速度を設定します。例：  

```bash
sudo echo performance >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
```
3. -mオプションを使用して、使用する制限時間を増やします。例：  

```bash
./cc_write -m 300 CC2531ZNP-Prod.hex
```
4.  `make`でプログラムを再コンパイルします。



## ライセンス

このプロジェクトは、GPL v3 (でライセンスされています（2°を参照）。
