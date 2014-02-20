namespace py atmo_soa.auth

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
typedef string DriverToken

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
     * Given a provider and an identity, return a token to refer to the driver
     * to use in future requests.
     */
    DriverToken get_driver(1: Provider provider, 2: Identity identity);

    /*
     * Given a driver token, list all instances.
     */
    list<Instance> list_all_instances(1: DriverToken driver) throws (1: InvalidToken invalid_token);
}
