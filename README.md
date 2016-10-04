# bytes_data_builder

Builds a list of bytes, allowing bytes, fixed-width integers, floats and lists of bytes to be added at the end.

## Usage

A simple usage example:

    import 'package:bytes_data_builder/bytes_data_builder.dart';

    main() {
      BytesDataBuilder builder = new BytesDataBuilder();
      builder.addInt8(0);
      List<int> result = builder.takeBytes();
    }
