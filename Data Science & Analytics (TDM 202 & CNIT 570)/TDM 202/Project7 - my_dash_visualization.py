import os
from dash import Dash, html, dcc
import pandas as pd
import plotly.express as px

vscprefix = os.getenv("VSCODE_PROXY_URI")
vscprefix = vscprefix.replace("https://ondemand.anvil.rcac.purdue.edu", "")
vscprefix = vscprefix.replace("{{port}}/", "")

myDF = pd.read_csv("/anvil/projects/tdm/data/zillow/Metro_time_series.csv")
myfiveregions = myDF.groupby('RegionName')['AgeOfInventory'].mean().reset_index().nlargest(5, 'AgeOfInventory')
fig = px.bar(myfiveregions, x = 'RegionName', y='AgeOfInventory', title='Top 5 regions with the oldest inventory of homes')



# Try many ports in this range until we find one that is free
for port in range(8050, 8500):
    print(f"Trying port {port}...")
    prefix=vscprefix+str(port)+'/'

    app = Dash("mytest", requests_pathname_prefix=prefix)

    app.layout = html.Div([
        html.H1('Top 5 regions with the oldest inventory of homes'),
        dcc.Graph(figure=fig)
    ])

    try:
        app.run(port=port, debug=False)
        #If we get here, the app ran so we can exit
        break
    except:
        continue # If we get here, the port was busy, let's try the next port