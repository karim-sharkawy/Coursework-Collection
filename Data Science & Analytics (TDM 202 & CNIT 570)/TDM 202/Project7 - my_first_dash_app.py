import os
from dash import Dash, html, dcc

vscprefix = os.getenv("VSCODE_PROXY_URI")
vscprefix = vscprefix.replace("https://ondemand.anvil.rcac.purdue.edu", "")
vscprefix = vscprefix.replace("{{port}}/", "")

# Try many ports in this range until we find one that is free
for port in range(8050, 8500):
    print(f"Trying port {port}...")
    prefix=vscprefix+str(port)+'/'

    app = Dash("mytest", requests_pathname_prefix=prefix)

    app.layout = html.Div([
        html.Div(children='Hello World')
    ])

    try:
        app.run(port=port, debug=False)
        #If we get here, the app ran so we can exit
        break
    except:
        continue # If we get here, the port was busy, let's try the next port