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
        html.Div(children='Hello World'),
        html.Div(children="Hello! I'm Karim El-Sharkawy and I'm a Math student at Purdue. I work on a mix of theoretical and applied topics"),
        html.Div(children="I can use python along with multiple packages, including sklearn. I've worked on a multitude of different projects in terms of theoretical and applied math, both of which relied on my knowledge of Python"),
        html.Div(children="On top of math and coding, I like to work on environmental projects and learn languages. Currently, I'm trying to become fluent in German and hoping to bring recycling to my local Mosque"),
        html.Div(children= "Thank you for your time and have a great day!")
    ])

    try:
        app.run(port=port, debug=False)
        #If we get here, the app ran so we can exit
        break
    except:
        continue # If we get here, the port was busy, let's try the next port