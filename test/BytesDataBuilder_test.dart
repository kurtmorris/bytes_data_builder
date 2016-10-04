// Copyright (c) 2016, Kurt Morris. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:bytes_data_builder/bytes_data_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Proper byte logic (Big Endian, Little Endian, Signed, Unsigned)', () {
    Function eq;
    int int8data;
    int int16data;
    int int32data;
    int int64data;
    int Uint8data;
    int Uint16data;
    int Uint32data;
    int Uint64data;

    setUp(() {
      eq = const ListEquality().equals;
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
    });

    test('int8', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt8(int8data);
      ByteData bdata = new ByteData(1);
      bdata.setInt8(0, int8data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int16', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt16(int16data);
      ByteData bdata = new ByteData(2);
      bdata.setInt16(0, int16data);
      Uint8List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int32', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt32(int32data);
      ByteData bdata = new ByteData(4);
      bdata.setInt32(0, int32data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int64', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt64(int64data);
      ByteData bdata = new ByteData(8);
      bdata.setInt64(0, int64data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint8', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint8(Uint8data);
      ByteData bdata = new ByteData(1);
      bdata.setUint8(0, Uint8data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint16', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint16(Uint16data);
      ByteData bdata = new ByteData(2);
      bdata.setUint16(0, Uint16data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint32', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint32(Uint32data);
      ByteData bdata = new ByteData(4);
      bdata.setUint32(0, Uint32data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint64', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint64(Uint64data);
      ByteData bdata = new ByteData(8);
      bdata.setUint64(0, Uint64data);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int16LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt16(int16data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(2);
      bdata.setInt16(0, int16data, Endianness.LITTLE_ENDIAN);
      Uint8List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int32LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt32(int32data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(4);
      bdata.setInt32(0, int32data, Endianness.LITTLE_ENDIAN);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('int64LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt64(int64data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(8);
      bdata.setInt64(0, int64data, Endianness.LITTLE_ENDIAN);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint16LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint16(Uint16data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(2);
      bdata.setUint16(0, Uint16data, Endianness.LITTLE_ENDIAN);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint32LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint32(Uint32data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(4);
      bdata.setUint32(0, Uint32data, Endianness.LITTLE_ENDIAN);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
    test('Uint64LE', () {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addUint64(Uint64data, Endianness.LITTLE_ENDIAN);
      ByteData bdata = new ByteData(8);
      bdata.setUint64(0, Uint64data, Endianness.LITTLE_ENDIAN);
      List builderList = builder.takeBytes();
      List bdataList = bdata.buffer.asUint8List();
      expect(eq(builderList, bdataList), isTrue);
    });
  });
}
