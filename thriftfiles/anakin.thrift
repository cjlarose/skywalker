namespace py atmo_soa.anakin

enum ProviderType {
    OpenStack,
    AWS,
    Eucalyptus
}

typedef map<string, string> ProviderOptions

struct Provider {
    1: required ProviderType type;
    2: optional ProviderOptions options;
}

typedef map<string, string> Identity

struct Driver {
    1: required Provider provider;
    2: required Identity identity;
}

struct OpenStackDriver {
    1: required string key;
    2: optional string secret;
    3: option string host;
    4: optional i32 port; // Don't use i16; integers types are all signed
    5: optional string version;
}

struct Instance {
    1: required string id;
    2: required string image_id;
    3: optional string name;
    4: optional string address;
}

service Anakin {
    /*
     * Given a driver, list all instances.
     */
    list<Instance> list_all_instances(1: Driver driver);
}
