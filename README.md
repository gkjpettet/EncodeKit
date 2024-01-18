# EncodeKit
A module for encoding and decoding Xojo objects for storage and transmission.

## About
EncodeKit exposes two classes: `JSONEncoder` and `JSONDecoder` which are capable of serialising and deserialising almost any Xojo class with little or no input from you.

## Usage
Firstly, drop the `EncodeKit` module into your project.

Before you can encode a custom class, you must first register it with EncodeKit.
There is no need to register Xojo primitives or other common built-in classes such as
Dictionary, FolderItem and DateTime as they are handled internally.

To register a class called `MyClass`:

```xojo
EncodeKit.RegisterClass GetTypeInfo(MyClass)
```

To encode an instance of `MyClass`:

```xojo
Var encoder As New EncodeKit.JSONEncoder
Var c1 As New MyClass
Var json As String = encoder.Encode(c1)
```

To decode an instance of `MyClass`:

```xojo
Var decoder As New EncodeKit.JSONDecoder
Var c1 As MyClass = decoder.Decode(json)
```

## Credit
This is essentially a modern port of Kem Tekinay's proof-of-concept Serializer_MTC class:

[https://github.com/ktekinay/Data-Serialization/][serialiser]

`EncodeKit` differs in the following ways:

- Separate encoder and decoder classes.
- API 2.0.
- Removed all references to Xojo.Data and Xojo.Core namespaces.
- Removed the need for Text and Auto datatypes.
- Removed support for Date
- Added support for DateTime, TimeZone and FolderItem encoding

[serialiser]: https://github.com/ktekinay/Data-Serialization/