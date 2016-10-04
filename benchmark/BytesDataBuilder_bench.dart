import 'dart:math';
import 'dart:typed_data';
import 'package:bytes_data_builder/bytes_data_builder.dart';
import 'package:benchmark_harness/benchmark_harness.dart';

/// AUTHORS NOTE:
/// I'm a little surprised that this didn't bench better, but I think it may be
/// due to the fact that ByteData is written in Native code rather than pure dart.
/// I still think this is the best option for a growing BytesBuilder with other
/// integer options.
///
/// OUTPUT: (your times will vary)
/// DynData(RunTime): 20.101108576137975 us.
/// DynData(RunTime): 17.562346329469616 us.
/// DynData(RunTime): 17.279364119400405 us.
/// DynData(RunTime): 19.97642781517809 us.
/// DynData(RunTime): 15.116700931188777 us.
/// DynData(RunTime): 20.010405410813622 us.
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
class BuilderBenchmark extends BenchmarkBase {
  BuilderBenchmark() : super("Builder");

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
    new BuilderBenchmark().report();
  }

  // The benchmark code.
  void run() {
    BytesDataBuilder builder = new BytesDataBuilder();
    builder.addInt8(int8data);
    builder.addInt16(int16data);
    builder.addInt32(int32data);
    builder.addInt64(int64data);
    builder.addUint8(Uint8data);
    builder.addUint16(Uint16data);
    builder.addUint32(Uint32data);
    builder.addUint64(Uint64data);
    builder.addInt8(int8data);
    builder.addInt16(int16data, Endianness.LITTLE_ENDIAN);
    builder.addInt32(int32data, Endianness.LITTLE_ENDIAN);
    builder.addInt64(int64data, Endianness.LITTLE_ENDIAN);
    builder.addUint8(Uint8data);
    builder.addUint16(Uint16data, Endianness.LITTLE_ENDIAN);
    builder.addUint32(Uint32data, Endianness.LITTLE_ENDIAN);
    builder.addUint64(Uint64data, Endianness.LITTLE_ENDIAN);
    // takeBytes is cheaper then toBytes.
    done = builder.takeBytes();
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
  // Run BuilderBenchmark.
  BuilderBenchmark.main();
  BuilderBenchmark.main();
  BuilderBenchmark.main();
  BuilderBenchmark.main();
  BuilderBenchmark.main();
  BuilderBenchmark.main();
}