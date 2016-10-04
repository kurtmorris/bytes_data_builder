import 'dart:math';
import 'dart:typed_data';
import 'package:benchmark_harness/benchmark_harness.dart';

/// AUTHORS NOTE:
/// This runs the best, BUT you have to know the exact size of the data packet
/// you want to build before hand, by the time you calculate the size for this
/// ByteData instance, it may be more expensive in time to use a ByteData rather
/// then using the [BytesDataBuilder].
///
/// OUTPUT: (your times will vary)
/// Data(RunTime): 10.27395501035101 us.
/// Data(RunTime): 7.618147952051377 us.
/// Data(RunTime): 5.373859398342701 us.
/// Data(RunTime): 10.209811628975446 us.
/// Data(RunTime): 10.222544800302588 us.
/// Data(RunTime): 15.806278253722379 us.
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
class DataBenchmark extends BenchmarkBase {
  DataBenchmark() : super("Data");

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
    new DataBenchmark().report();
  }

  // The benchmark code.
  void run() {
    ByteData data = new ByteData(60);
    int pos = 0;
    data.setInt8(pos, int8data); pos += 1;
    data.setInt16(pos, int16data); pos += 2;
    data.setInt32(pos, int32data); pos += 4;
    data.setInt64(pos, int64data); pos += 8;
    data.setUint8(pos, Uint8data); pos +=  1;
    data.setUint16(pos, Uint16data); pos += 2;
    data.setUint32(pos, Uint32data); pos += 4;
    data.setUint64(pos, Uint64data); pos += 8;
    data.setInt8(pos, int8data); pos += 1;
    data.setInt16(pos, int16data, Endianness.LITTLE_ENDIAN); pos += 2;
    data.setInt32(pos, int32data, Endianness.LITTLE_ENDIAN); pos += 4;
    data.setInt64(pos, int64data, Endianness.LITTLE_ENDIAN); pos += 8;
    data.setUint8(pos, Uint8data); pos += 1;
    data.setUint16(pos, Uint16data, Endianness.LITTLE_ENDIAN); pos += 2;
    data.setUint32(pos, Uint32data, Endianness.LITTLE_ENDIAN); pos += 4;
    data.setUint64(pos, Uint64data, Endianness.LITTLE_ENDIAN); pos += 8;
    done = data.buffer.asInt8List();
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
  // Run DataBenchmark.
  DataBenchmark.main();
  DataBenchmark.main();
  DataBenchmark.main();
  DataBenchmark.main();
  DataBenchmark.main();
  DataBenchmark.main();
}