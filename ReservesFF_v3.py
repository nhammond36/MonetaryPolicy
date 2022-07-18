# import libraries
from datetime import datetime
dateparse = lambda x: datetime.strptime(x, '%Y-%m-%d %H:%M:%S')
import matplotlib.pyplot as plt
# import matplotlib.ticker as ticker
# %matplotlib inline
#import matplotlib.animation as animation
import numpy as np
import pandas as pd
import plotly.express as px
# import matplotlib as mpl
# matplotlib.font_manager._rebuild()
# import matplotlib.font_manager as font_manager
# mpl.rcParams['font.family'] = 'sans-serif'
# mpl.rcParams['font.sans-serif'] = 'Lato'
# import dateparser
# from matplotlib.dates import DateFormatter
# import matplotlib.dates as mdate
#
#   MONTHLY data
# these are FRED data in country*year format that include
# volf, the percent change in the Fed Funds rate, for weighting circle size,
# month, for the animation element,
# year, for the color identification
# ff_=y
# res=x  TOTRESNS
#
# replace df with rates
rates = pd.read_csv(r'C:/Users/Owner/Documents/Research/Data/FRED/FRED_TOMO/Reserves_FF.csv',\
                    usecols=[0, 1, 2, 3],  parse_dates=['DATE'])
# TOTRESNS	BORROW	FEDFUNDS
# TOTRESNS This series is a sum of total reserve balances maintained plus vault cash used to satisfy required reserves
# NONBORRES Equals total reserves (TOTRESNS), less total borrowings from the Federal Reserve (BORROW).
# date = stirs.loc[0:, "DATE"]
# df = pd.read_csv('gapminder_full.csv')
rates
rates.describe()
rates.info()
rates_final=rates
rates_final=rates.dropna(how='any')
# rates_final=rates_final.sort_values(by=['year'])
rates_final
res  = rates_final.loc[:, "TOTRESNS"]
resb = rates_final.loc[:, "BORROW"]
ff = rates_final.loc[:, "FEDFUNDS"]
print(ff)
# volf = ((rates['FF']-rates['FF'].shift(1)) / rates['FF'].shift(1))
volf = (ff-ff.shift(1))/ff.shift(1)
rates_final["volf"] = volf
print(volf)
# irb2 = float(iorb)
# irb = rates['IORB'].apply(lambda x: float(x))
print(rates_final.columns)
varnames=rates_final.columns
list(varnames)
# Extract year and Month
rates_final['Year'] = pd.to_datetime(rates_final['DATE']).dt.year
rates_final['Month'] = pd.to_datetime(rates_final['DATE']).dt.month
year  = rates_final.loc[:, "Year"]
month  = rates_final.loc[:, "Month"]
print(year)
print(month)
#
#
#
# Reserves, FF, soma7.py code
N = len(ff)
# x = parse_dates
z = res
y = volf
#
# OLD PLOTS
# Scattplot  Reserves versus  FF volatility
# output to static HTML file
# output_file(\"C:/Users/Owner/Documents/Research/SOMA/scatter_ff.html\",title=\"Fed funds rates and reserves\")
# create a new plot with a title and axis labels,)
# N = len(ff)
# x = parse_dates
# z = res
# y = volf
# colors = np.random.rand(N)
# area = (30 * np.random.rand(N))**2  # 0 to 15 point radii
# area = [20*2**n for n in range(len(res))]
# area = res*.01
# plt.figure(figsize =(6, 4))
# plt.title('Fed Funds rate volatility vs total reserves',fontsize=12)
# plt.scatter(z, y, s=area,c='g', alpha=0.5)
# fontweight ='bold')
# volres=plt.scatter(z, y, marker='o',s=area, c='c', alpha=0.5)
# plt.xlabel('Reserves')
# plt.ylabel('FF rate volatility')
# plt.legend()
# plt.savefig('C:/Users/Owner/Documents/Research/SOMA/FF_reverserepos.png',dpi = 'figure',bbox_inches = 'tight',pad_inches = 0.15)
#
# plt.savefig('C:/Users/Owner/Documents/Research/SOMA/ffvol_reserves.eps')
# plt.show()
#
# Animate FF volatility versus reserves scatter plot
# fig = plt.figure(figsize =(6, 4))
# ax = py.axes(xlim=(0, 1), ylim=(0, 1))
# volres = plt.scatter([], [], s=10)
# volres=plt.scatter([], [])
# nrates = rates.to_numpy()
# print(rates)
# print(nrates.shape)
# print("shape nrates= ",np.shape(nrates))
# print("dimensions nrates= ",len(nrates.shape))
# vn = nrates[:,1]
# yn = nrates[:,4]
# print(nrates[ :,2])
# rates({"A": rates.res, "B": rates.volf}).to_numpy()
# def init():
#    volres.set_offsets([])
#    volres.set_facecolor([])
#    return volres,

#
# def animate(i):
#    volres.set_offsets([vn[i], yn[i]])
# data = np.hstack((vn[:i,np.newaxis], yn[:i, np.newaxis]))
# volres.set_offsets(data)
# return volres,
#
# anim = animation.FuncAnimation(fig, animate, init_func=init, frames=len(x)+1,
#                               interval=200, blit=False, repeat=False)
# anim.save(' C:/Users/Owner/Documents/Research/SOMA/volres.mp4')
# ani = animation.FuncAnimation(fig, animate, np.arange(1, 200), init_func=init,
#       interval=25, blit=True)
# ,title=\"Soma data\")
#
# Scattplot  Reserves versus  FF
# output to static HTML file
# output_file(\'C:/Users/Owner/Documents/Research/SOMA/scatter_vol.html',title=\"Volatility and reserves")
# create a new plot with a title and axis labels,)
# y = ff
# colors = np.random.rand(N)
# area = (30 * np.random.rand(N))**2  # 0 to 15 point radii
# plt.figure(figsize =(5, 4))
# plt.title('Fed Funds rate vs total reserves',fontsize = 12, fontweight ='bold')
# plt.scatter(z, y, s=area,c='g', alpha=0.5)
# plt.xlabel('Reserves')
# plt.ylabel('Fed Funds rates')
# plt.legend()
# plt.show()
# plt.savefig('C:/Users/Owner/Documents/Research/SOMA/ff_reserves.png')
#
#
# NEW BL PLOTS
x = res
y = ff
maxx = max(res)
minx = min(res)
maxy = max(ff)
miny = min(ff)
fig = px.scatter(rates_final, x=res, y=ff)
fig.show()
fig = px.scatter(rates_final, x='TOTRESNS', y='FEDFUNDS',
      log_x= True, size_max=45, range_x=[minx,maxx], range_y=[miny,maxy])
fig.show()
fig = px.scatter(rates_final, x='TOTRESNS', y='FEDFUNDS', animation_frame=year,
      animation_group=month, log_x= True, size_max=45, range_x=[minx,maxx],range_y=[miny,maxy])
fig = px.scatter(rates_final, x=res, y=volf)
fig.show()
maxv = max(volf)
minv = min(volf)
fig = px.scatter(rates_final, x='TOTRESNS', y=volf, log_x= True,
      size_max=45, range_x=[minx,maxx], range_y=[minv,maxv])
fig.show()
fig = px.scatter(rates_final, x='TOTRESNS', y=volf, animation_frame=year,
      animation_group=month, log_x= True, size_max=45, range_x=[minx,maxx],
      range_y=[minv,maxv])
#
# FANCIER GRAPHS
fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 700
fig.show()
fig = px.scatter(rates_final, x='TOTRESNS', y='FEDFUNDS', animation_frame=year,
    animation_group=month, size=volf, color=month, hover_name=year,
    log_x= True, size_max=45, range_x=[minx,maxx], range_y=[miny,maxy])
#
fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 700
fig.show()
fig = px.scatter(rates_final,x='TOTRESNS', y='FEDFUNDS', animation_frame= year,
      animation_group=month, size=volf, color=year, hover_name=month, log_x=True,
      size_max=45,range_x=[minx,maxx], range_y=[miny,maxy])
# Tune marker appearance and layout
fig.update_traces(mode='markers', marker=dict(sizemode='area',
 ))
fig.update_layout(
 title='Fed funds rates v reserves, 1959~2022',
 xaxis=dict(
 title='Reserves',
 gridcolor='white',
 type='log',
 gridwidth=2,
 ),
 yaxis=dict(
 title='Fed funds rate (x.xx pct)',
 gridcolor='white',
 gridwidth=2,
 ),
 paper_bgcolor='rgb(243, 243, 243)',
 plot_bgcolor='rgb(243, 243, 243)',
)
fig.layout.updatemenus[0].buttons[0].args[1]["frame"]["duration"] = 600
fig.write_html("'C:/Users/Owner/Documents/Research/SOMA/FF_reposcatterplot.html")
fig.show()
#
#
# CHANGE!!! DID BROOKE CHANGE DATA SET??
# df = px.data.gapminder()
fig = px.scatter(rates_final, x="TOTRESNS", y="FEDFUNDS", animation_frame="Month", animation_group="country",
           size="pop", color="Year", hover_name="country", facet_col="continent",
           log_x=True, size_max=45, range_x=[0,max("TOTRESNS")], range_y=[0,max("FEDFUNDS")])

# Tune marker appearance and layout
fig.update_traces(mode='markers', marker=dict(sizemode='area',
 ))
fig.update_layout(
 title='Fed funds rates v reserves, 1959~2022 by Continent?, 1959~2022',
 xaxis=dict(
 #title='Reserves',
 gridcolor='white',
 type='log',
 gridwidth=2,
 ),
 yaxis=dict(
 title='Fed Funds rate (xx.x pct)',
 gridcolor='white',
 gridwidth=2,
 ),
 paper_bgcolor='rgb(243, 243, 243)',
 plot_bgcolor='rgb(243, 243, 243)',
)
fig.layout.updatemenus[0].buttons[0].args[1]["frame"]["duration"] = 600
fig.write_html("scatterplot_continent_facet.html")
fig.show()
# df = px.data.gapminder()
fig = px.line(rates_final, x="year", y="lifeExp", color="continent", line_group="country", hover_name="country",
        line_shape="spline", render_mode="svg")
fig.show()
# df = px.data.gapminder()
# rates_final=df
fig = px.area(rates_final, x="year", y="pop", color="continent", line_group="country")
fig.show()
df = px.data.gapminder().query("year == 2007").query("continent == 'Europe'")
df.loc[df['pop'] < 2.e6, 'country'] = 'Other countries' # Represent only large countries
fig = px.pie(df, values='pop', names='country', title='Population of European continent')
fig.show()
#
#
# df = px.data.gapminder().query("year == 2007")
fig = px.sunburst('Fed funds rates v reserves, 1959~2022', path=['continent', 'country'], values='pop',
                  color='lifeExp', hover_data=['iso_alpha'])
fig.show()
df = px.data.gapminder()
fig = px.scatter_geo('Fed funds rates v reserves, 1959~2022', locations="iso_alpha", color="continent", hover_name="country", size="pop",
               animation_frame="year", projection="natural earth")
fig.show()
df = px.data.gapminder()
fig = px.choropleth('Fed funds rates v reserves, 1959~2022', locations="iso_alpha", color="lifeExp", hover_name="country", animation_frame="year", range_color=[20,80])
fig.show()
#
# IMPORT DAILY Data
stirs = pd.read_csv(r'C:/Users/Owner/Documents/Research/Data/FRED/FRED_TOMO/SOMArates4.csv', na_values=".",  usecols=[0,1,2,3,4,5,6,7], parse_dates=['DATE'])
# DATE	RPONTSYD	RRPONTSYD	RPTSYD	RRPTSYD	EFFR	RPONTTLD	RRPONTTLD
stirs_final = stirs
stirs_final.replace('.', np.nan, None, regex=True)
stirs_final=stirs.dropna(how='any')
stirs_final.info()
stirs_final.dtypes
# Overnight Reverse Repurchase Agreements: Total Securities Sold by the Federal Reserve in the Temporary Open Market Operations
# stirs_final.astype('float').dtypes
stirs_final.columns = stirs.columns.str.strip()
# stirs['DATE'] = pd.to_datetime(stirs['DATE'])
stirs_final['DATE'] = pd.to_datetime(stirs_final['DATE'], format="%m/%d/%Y")
date = stirs_final.loc[0:, "DATE"]
print(date)
effrate = stirs_final.loc[:,"EFFR"]
type(effrate)
repo = stirs_final.loc[:, "RPONTSYD"]
rrepo = stirs_final.loc[:, "RRPONTSYD"]
trepo = stirs_final.loc[:, "RPONTTLD"]
trrepo = stirs_final.loc[:, "RRPONTTLD"]
print(effrate)
print(repo)
print(rrepo)
print(trepo)
print(trrepo)
x = stirs_final['DATE']
print(date)
print(x)
