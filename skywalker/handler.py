import traceback

from rtwo.provider import EucaProvider, OSProvider
from rtwo.identity import EucaIdentity, OSIdentity
from rtwo.driver import AWSDriver, EucaDriver, OSDriver

from atmo_soa.skywalker.ttypes import Instance, ProviderType

class Handler(object):

    rtwo_map = {
        ProviderType.OpenStack: (OSProvider, OSIdentity,OSDriver),
        ProviderType.Eucalyptus: (EucaProvider, EucaIdentity, EucaDriver),
    }

    def __init__(self):
        # TODO: Figure out why this is needed
        OSProvider.set_meta()
        EucaProvider.set_meta()

    @staticmethod
    def _get_driver(tdriver):
        """
        Given an atmo_soa.skywalker.ttypes.driver, convert to an instance 
        rtwo.driver.BaseDriver
        """
        if not tdriver.provider_credentials:
            tdriver.provider_credentials = {}

        provider_type = tdriver.provider.type
        provider_cls, identity_cls, driver_cls = Handler.rtwo_map[provider_type]

        provider = provider_cls(identifier=tdriver.provider.identifier)
        identity = identity_cls(provider, **tdriver.identity)

        driver = driver_cls(provider, identity, **tdriver.provider_credentials)
        return driver

    @staticmethod
    def _convert_instance(instance):
        """
        Given an instance of rtwo.instance.Instance, return
        an instance of atmo_soa.skywalker.ttypes.Instance
        """
        public_addresses = []
        if instance.ip:
            public_addresses.append(str(instance.ip))

        return Instance(
            id=instance.id,
            image_id=instance.image_id,
            name=instance.name,
            public_addresses=public_addresses
        )

    def list_all_instances(self, driver):
        try:
            rtwo_driver = Handler._get_driver(driver)
            instances = rtwo_driver.list_all_instances()
            return [Handler._convert_instance(i) for i in instances]
        except Exception as e:
            traceback.print_exc()
            print e.message
