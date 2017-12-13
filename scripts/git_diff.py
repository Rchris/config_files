#!/usr/bin/env python3

""" Git diff prompt from command line """


import os
import subprocess

from cmd import Cmd


def execute_cmd(cmd, verbose=True):
    """ Execute a command, with verbosity and return status and command stdout """

    ret = True
    try:

        if verbose:
            print("\n>> " + cmd + "\n")

        proc = subprocess.Popen(cmd.split(" "), stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        stdout, stderr = proc.communicate()
        lines = stdout.decode('UTF-8').split('\n')
        if proc.returncode != 0:
            if verbose:
                print("Command return code " + str(proc.returncode))
            ret = False

        if verbose:
            os.system(cmd)

        return ret, lines

    except OSError as exception:
        print(exception)
        ret = False

    return ret, []


class MyPrompt(Cmd):

    status = ''
    next_file = ''
    ignore_list = []

    def git_status(self, verbose=False):
        """ Git status """

        rets = execute_cmd("git st", verbose=verbose)
        if rets[0]:
            self.status = ''
            self.next_file = ''
            for line in rets[1]:
                if line.find(' M') == 0:
                    filename = line.replace(' M ', '')
                    if (self.next_file == '') and (filename not in self.ignore_list):
                        self.next_file = filename
                    self. status += line + '\n'

        return rets[0]

    def do_st(self, args):
        """ Print git status """

        self.git_status(verbose=(args == 'all'))
        if args != 'all':
            print(self.status)

    def do_n(self, args):
        """ Print the diff of the next file """

        self.git_status()
        if self.next_file == '':
            return

        execute_cmd("git diff " + self.next_file)

    def do_add(self, args):
        """ Add the next file """

        self.git_status()
        if self.next_file == '':
            return

        execute_cmd("git add " + self.next_file)

    def do_skip(self, args):
        """ Skip the next file """

        self.git_status()
        if self.next_file == '':
            return

        print("Skip", self.next_file)
        self.ignore_list.append(self.next_file)
        self.next_file = ''

    def do_q(self, args):
        """ Quit the program """

        print("Quitting")
        raise SystemExit


if __name__ == '__main__':
    prompt = MyPrompt()
    prompt.prompt = '> '
    prompt.cmdloop('')
