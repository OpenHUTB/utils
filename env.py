
def ldconfig():
    import os
    sudoPassword = 'jjj'
    command = 'ldconfig /usr/local/cuda-10.0/lib64/'
    str = os.system('echo %s|sudo -S %s' % (sudoPassword, command))
    print str