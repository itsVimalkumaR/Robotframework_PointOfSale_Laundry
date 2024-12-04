import os
from configparser import ConfigParser

dir_path = os.path.dirname(os.path.realpath(__file__))
config_file = os.path.join(dir_path, 'config.ini')
config = ConfigParser()
print(config.sections())
config.read(config_file)
print(config.sections())


class configtes():

    def environment(self):
        return (config['ENVIRONMENT']['environment'])

    def browser(self):
        return (config['ENVIRONMENT']['BROWSER'])

    def Loginurl(self):
        return (config['USERS']['Log_URL'])

    def userName(self):
        return (config['USERS']['username'])

    def password(self):
        return (config['USERS']['password'])

    def Signurl(self):
        return (config['USERS']['Sign_URL'])

    def Baseurl(self):
        return (config['RESTAPI']['base_url'])


ObjconfigReader = configtes()
