import 'dart:math';
import 'dart:typed_data';
import 'package:benchmark_harness/benchmark_harness.dart';

/// AUTHORS NOTE:
/// Honestly quite surprised at how efficient the dart optimizer is.
/// This is the absolute worst way to build byte data, please don't ever do this.
///
/// OUTPUT: (your times will vary)
/// DynData(RunTime): 17.500721904778572 us.
/// DynData(RunTime): 26.935664166139176 us.
/// DynData(RunTime): 21.584985484097263 us.
/// DynData(RunTime): 18.657934753202166 us.
/// DynData(RunTime): 21.59570677349343 us.
/// DynData(RunTime): 21.90604497311033 us.
///
/// NOTE:
/// The Dart VM can run in two modes: checked and production mode.
/// Checked mode is slower because the VM is checking types at runtime.
/// Before benchmarking make sure that your code runs without issue in checked mode.
/// If checked mode finds an issue, it will likely cause a performance problem
/// in production mode. After making sure your program is correct,
/// you should run your benchmark in production mode to get an accurate
/// measurement of real world performance.
///
/// Source: https://www.dartlang.org/articles/dart-vm/benchmarking

// Create a new benchmark by extending BenchmarkBase.
class DynDataBenchmark extends BenchmarkBase {
  DynDataBenchmark() : super("DynData");

  int int8data;
  int int16data;
  int int32data;
  int int64data;
  int Uint8data;
  int Uint16data;
  int Uint32data;
  int Uint64data;
  List done;

  static void main() {
    new DynDataBenchmark().report();
  }

  // The benchmark code.
  void run() {
    List dat = [];
    ByteData data;
    /// overkill but you get my point
    data = new ByteData(1); data.setInt8(0, int8data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(2); data.setInt16(0, int16data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(4); data.setInt32(0, int32data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(8); data.setInt64(0, int64data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(1); data.setUint8(0, Uint8data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(2); data.setUint16(0, Uint16data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(4); data.setUint32(0, Uint32data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(8); data.setUint64(0, Uint64data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(1); data.setInt8(0, int8data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(2); data.setInt16(0, int16data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(4); data.setInt32(0, int32data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(8); data.setInt64(0, int64data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(1); data.setUint8(0, Uint8data); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(2); data.setUint16(0, Uint16data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(4); data.setUint32(0, Uint32data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    data = new ByteData(8); data.setUint64(0, Uint64data, Endianness.LITTLE_ENDIAN); dat.addAll(data.buffer.asInt8List());
    done = dat;
  }

  // Not measured: setup code executed before the benchmark runs.
  void setup() {
    Random rand = new Random();
    int8data = rand.nextInt(255) - 127;
    int16data = rand.nextInt(65535) - 32767;
    int32data = rand.nextInt(4294967295) - 2147483647;
    int rand64 = rand.nextInt(4294967295) * rand.nextInt(4294967295);
    int64data = rand64 - 9223372036854775807;
    Uint8data = rand.nextInt(255);
    Uint16data = rand.nextInt(65535);
    Uint32data = rand.nextInt(4294967295);
    Uint64data = rand.nextInt(4294967295) * rand.nextInt(4294967295);
  }

  // Not measured: teardown code executed after the benchmark runs.
  void teardown() {
  }
}

// Main function runs the benchmark.
main() {
  // Run DynDataBenchmark.
  DynDataBenchmark.main();
  DynDataBenchmark.main();
  DynDataBenchmark.main();
  DynDataBenchmark.main();
  DynDataBenchmark.main();
  DynDataBenchmark.main();
}