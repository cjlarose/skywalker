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

struct Instance {
    1: required string id;
    2: required string image_id;
    3: optional string name;
    4: optional string address;
}

exception InvalidToken {
    1: optional string message;
}

service Anakin {
    /*
     * Given a driver, list all instances.
     */
    list<Instance> list_all_instances(1: Driver driver) throws (1: InvalidToken invalid_token);
}
