namespace py atmo_soa.anakin

enum ProviderType {
    OpenStack,
    AWS,
    Eucalyptus
}

struct Provider {
    1: required ProviderType type;
    2: optional string url;
    3: optional string identifier;
}

typedef map<string, string> Identity
typedef map<string, string> ProviderCredentials

struct Driver {
    1: required Provider provider;
    2: required Identity identity;
    3: optional ProviderCredentials provider_credentials;
}

struct Instance {
    1: required string id;
    2: required string image_id;
    3: optional string name;
    4: optional list<string> public_addresses;
    5: optional list<string> private_addresses;
}

service Anakin {
    /*
     * Given a driver, list all instances.
     */
    list<Instance> list_all_instances(1: Driver driver);
}
