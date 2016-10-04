// Copyright (c) 2016, Kurt Morris. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:bytes_data_builder/bytes_data_builder.dart';
import 'dart:typed_data';

main() {
  Random rand = new Random();
  int int8data = rand.nextInt(255) - 127;
  int int16data = rand.nextInt(65535) - 32767;
  int int32data = rand.nextInt(4294967295) - 2147483647;
  int rand64 = rand.nextInt(4294967295) * rand.nextInt(4294967295);
  int int64data = rand64 - 9223372036854775807;
  int Uint8data = rand.nextInt(255);
  int Uint16data = rand.nextInt(65535);
  int Uint32data = rand.nextInt(4294967295);
  int Uint64data = rand.nextInt(4294967295) * rand.nextInt(4294967295);

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

  List<int> result = builder.takeBytes();
}
