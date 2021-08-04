import os
from IPython.lib import passwd

c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.NotebookApp.open_browser = False
c.MultiKernelManager.default_kernel_name = 'python3'

# sets a password if PASSWORD is set in the environment
if 'NOTEBOOK_PASS' in os.environ:
    c.NotebookApp.password = passwd(os.environ['NOTEBOOK_PASS'])
    del os.environ['NOTEBOOK_PASS']
else:
    c.NotebookApp.token = ''

if 'NOTEBOOK_USER' in os.environ:
    c.NotebookApp.notebook_dir = '/root/' + os.environ['NOTEBOOK_USER'] + '/jupyter'
    del os.environ['NOTEBOOK_USER']
