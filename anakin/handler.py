from atmo_soa.anakin.ttypes import Instance

class Handler(object):

    def __init__(self):
        pass

    def list_all_instances(self, driver):
        return [
            Instance(id='1234')
        ]
