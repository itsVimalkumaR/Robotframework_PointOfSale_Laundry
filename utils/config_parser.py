import os
import yaml


def parse_yaml(filename):
    """This function will parse the yaml file and return the object
       :param filename: the yaml file to be parsed
    """
    try:
        print("cwd is {}".format(os.getcwd()))
        a_yaml_file = open(filename)
        yaml_parsed = yaml.load(a_yaml_file, Loader=yaml.FullLoader)
        print(yaml_parsed)
        return (yaml_parsed)

    except Exception as err:
        print(str(err))
        return (str(err))
