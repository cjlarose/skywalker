Anakin
======

Uniform cloud interface as a service.

Building
--------

Anakin depends on Thirft-generated files in a module called `atmo_soa`. To create this module, download and install [Apache Thrift][1] with Python support.

From the root directory of this repository:

```bash
thrift --gen py thriftfiles/anakin.thrift
ln -s gen-py/atmo_soa ./atmo_soa
```

[1]: http://thrift.apache.org/
