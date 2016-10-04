// Copyright (c) 2016, Kurt Morris. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library bytes_data_builder;

import 'dart:typed_data';
import 'dart:io';

/// Builds a list of bytes, allowing bytes, integers, floats and
/// lists of bytes to be added at the end.
///
/// Used to efficiently collect bytes and lists of bytes.
class BytesDataBuilder implements BytesBuilder {
  final BytesBuilder _delegate;

  /// Construct a new empty [BytesDataBuilder].
  ///
  /// If [copy] is true, the data is always copied when added to the list. If
  /// it [copy] is false, the data is only copied if needed. That means that if
  /// the lists are changed after added to the [BytesDataBuilder], it may effect the
  /// output. Default is `true`.
  BytesDataBuilder({bool copy: true})
      : _delegate = new BytesBuilder(copy: copy);

  /// Appends [bytes] to the current contents of the builder.
  ///
  /// Each value of [bytes] will be bit-representation truncated to the range
  /// 0 .. 255.
  void add(List<int> bytes) => _delegate.add(bytes);

  /// Append [byte] to the current contents of the builder.
  ///
  /// The [byte] will be bit-representation truncated to the range 0 .. 255.
  void addByte(int byte) => _delegate.addByte(byte);

  /// Returns the contents of `this` and clears `this`.
  ///
  /// The list returned is a view of the internal buffer, limited to the
  /// [length].
  List<int> takeBytes() => _delegate.takeBytes();

  /// Returns a copy of the current contents of the builder.
  ///
  /// Leaves the contents of the builder intact.
  List<int> toBytes() => _delegate.toBytes();

  /// The number of bytes in the builder.
  int get length => _delegate.length;

  /// Returns `true` if the buffer is empty.
  bool get isEmpty => _delegate.isEmpty;

  /// Returns `true` if the buffer is not empty.
  bool get isNotEmpty => _delegate.isNotEmpty;

  /// Clear the contents of the builder.
  void clear() => _delegate.clear();

  /// Quick and slick way of converting multiple integer types to bytes.
  ///
  /// The [data] will be converted to bytes according to the amount
  /// of [bits], whether the bytes are [signed] bytes or not and of course
  /// the appropriate [Endianness] for the bytes.
  void _add(int data, int bits, bool signed, Endianness endian) {
    if (endian == Endianness.BIG_ENDIAN) {
      if (bits > 32) {
        addByte(signed ? data >> 56 : (data >> 56) & 0xff);
        addByte(signed ? data >> 48 : (data >> 48) & 0xff);
        addByte(signed ? data >> 40 : (data >> 40) & 0xff);
        addByte(signed ? data >> 32 : (data >> 32) & 0xff);
      }
      if (bits > 16) {
        addByte(signed ? data >> 24 : (data >> 24) & 0xff);
        addByte(signed ? data >> 16 : (data >> 16) & 0xff);
      }
      if (bits > 8) {
        addByte(signed ? data >> 8 : (data >> 8) & 0xff);
      }
      addByte(signed ? data : data & 0xff);
    } else if (endian == Endianness.LITTLE_ENDIAN) {
      addByte(signed ? data : data & 0xff);
      if (bits > 8) {
        addByte(signed ? data >> 8 : (data >> 8) & 0xff);
      }
      if (bits > 16) {
        addByte(signed ? data >> 16 : (data >> 16) & 0xff);
        addByte(signed ? data >> 24 : (data >> 24) & 0xff);
      }
      if (bits > 32) {
        addByte(signed ? data >> 32 : (data >> 32) & 0xff);
        addByte(signed ? data >> 40 : (data >> 40) & 0xff);
        addByte(signed ? data >> 48 : (data >> 48) & 0xff);
        addByte(signed ? data >> 56 : (data >> 56) & 0xff);
      }
    }
  }

  /// Appends four bytes to the current contents of the builder with
  /// the IEEE 754 single-precision binary floating-point (binary32)
  /// representation of the specified value.
  BytesDataBuilder addFloat32(double data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    ByteData bd = new ByteData(4);
    bd.setFloat32(0, data, endian);
    add(bd.buffer.asInt8List());
    return this;
  }

  /// Appends eight bytes to the current contents of the builder with
  /// the IEEE 754 single-precision binary floating-point (binary64)
  /// representation of the specified value.
  BytesDataBuilder addFloat64(double data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    ByteData bd = new ByteData(8);
    bd.setFloat64(0, data, endian);
    add(bd.buffer.asInt8List());
    return this;
  }

  /// Appends a byte to the current contents of the builder with
  /// the binary representation of the specified value,
  /// which must fit in a byte.
  BytesDataBuilder addInt8(int data) {
    addByte(data);
    return this;
  }

  /// Appends two bytes to the current contents of the builder with
  /// the two's complement binary representation of the specified value,
  /// which must fit in two bytes.
  BytesDataBuilder addInt16(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 16, true, endian);
    return this;
  }

  /// Appends four bytes to the current contents of the builder with
  /// the four's complement binary representation of the specified value,
  /// which must fit in four bytes.
  BytesDataBuilder addInt32(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 32, true, endian);
    return this;
  }

  /// Appends eight bytes to the current contents of the builder with
  /// the eight's complement binary representation of the specified value,
  /// which must fit in eights bytes.
  BytesDataBuilder addInt64(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 64, true, endian);
    return this;
  }

  /// Appends a byte to the current contents of the builder with
  /// the binary representation of the specified value,
  /// which must fit in a byte.
  BytesDataBuilder addUint8(int data) {
    addByte(data & 0xff);
    return this;
  }

  /// Appends two bytes to the current contents of the builder with
  /// the two's complement binary representation of the specified value,
  /// which must fit in two bytes.
  BytesDataBuilder addUint16(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 16, false, endian);
    return this;
  }

  /// Appends four bytes to the current contents of the builder with
  /// the four's complement binary representation of the specified value,
  /// which must fit in four bytes.
  BytesDataBuilder addUint32(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 32, false, endian);
    return this;
  }

  /// Appends eight bytes to the current contents of the builder with
  /// the eight's complement binary representation of the specified value,
  /// which must fit in eights bytes.
  BytesDataBuilder addUint64(int data,
      [Endianness endian = Endianness.BIG_ENDIAN]) {
    _add(data, 64, false, endian);
    return this;
  }
}
