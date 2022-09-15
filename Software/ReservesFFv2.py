# import libraries
from datetime import datetime
dateparse = lambda x: datetime.strptime(x, '%Y-%m-%d %H:%M:%S')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import plotly.express as px
df = pd.read_csv(r'C:/Users/Owner/Documents/Research/Data/FRED/FRED_TOMO/RESERVES_FF.csv', na_values=".",\
                    usecols=[0, 1, 2, 3,4,5,6],  parse_dates=['DATE'])
# DATE	TOTRESNS	BORROW	FEDFUNDS	PCETRIM1M158SFRBDAL	UNRATE	UNRATENSA	BBKMGDP
# TOTRESNS This series is a sum of total reserve balances maintained plus vault cash used to satisfy required reserves
# NONBORRES Equals total reserves (TOTRESNS), less total borrowings from the Federal Reserve (BORROW).
# ,7,8
df_final=df
df_final.replace('.', np.nan, None, regex=True)
df_final=df.dropna(how='any')
res  = df_final.loc[:, "TOTRESNS"]
resb = df_final.loc[:, "BORROW"]
ff = df_final.loc[:, "FEDFUNDS"]
volf = df_final.loc[:, "VOLF"]
print(ff)
#
pd.to_datetime(df_final['DATE'],format='%m/%d/%Y')
date = df_final.loc[:, "DATE"]
print('DATE')
x = df_final['DATE']
print(x)
# Extract year and Month
df_final['Year'] = pd.to_datetime(df_final['DATE']).dt.year
df_final['Month'] = pd.to_datetime(df_final['DATE']).dt.month
df_final['mon_yr'] = pd.to_datetime(df_final['DATE']).dt.to_period('M')
year  = df_final.loc[:, "Year"]
month  = df_final.loc[:, "Month"]
mon_yr  = df_final.loc[:, "mon_yr"]
print(year)
print(month)
varnames=df_final.columns
list(varnames)
# varnames = rates.head()
df_final.info()
df_final.columns = df_final.columns.str.strip()
#
fig = px.scatter(df_final, x='DATE', y='FEDFUNDS', size_max=45)
#df_final.plot(x="DATE", y="FEDFUNDS")
print(df_final.columns)
fig = px.scatter(df_final, x='DATE', y='TOTRESNS', size_max=45)
# df_final.plot(x="DATE", y="TOTRESNS")
print(df_final.columns)
#
# Reserves, FF, soma7.py code
N = len(ff)
z = res
y = volf
# NEW BL PLOTS
# PCETRIM1M158SFRBDAL	UNRATE	UNRATENSA	BBKMGDP
# pce= df_final["PCETRIM1M158SFRBDAL"]
# # Fed fund vs reserves
x = res
y = ff
maxx = max(res)
minx = min(res)
maxy = max(ff)
miny = min(ff)
fig = px.scatter(df_final, x="TOTRESNS", y="FEDFUNDS", log_x= True,)
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReservesscatterplot1.html")
#fig.show()
#
fig.update_xaxes(
    rangeslider_visible=True,
    rangeselector=dict(
        buttons=list([
            dict(count=120, label="10y", step="month", stepmode="backward"),
            dict(count=240, label="20y", step="month", stepmode="backward"),
            dict(count=360, label="30y", step="month", stepmode="backward"),
            dict(count=480, label="40y", step="month", stepmode="backward"),
            dict(count=600, label="50y", step="month", stepmode="backward"),
            dict(step="all")
        ])
    )
)
labels={
                     "TOTRESNS": "Reserves",
                     "FEDFUNDS": "Fed funds rates",
                 },
title=("Fed funds rate versus reserves")
fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReservesscatterplot10.html")
fig.show()
# fig = px.scatter(df_final, x=df_final['TOTRESNS'], y=df_final['FEDFUNDS'], log_x= True, size_max=45)
# range_x=[minx,maxx], range_y=[miny,maxy])

# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFVOLvReservesscatterplot11.html")
# fig.show()
# log_x= True,
#
print(len(df_final['TOTRESNS']))
print(len(df_final['FEDFUNDS']))
print(len(df_final['TOTRESNS']))
print(len(df_final['Month']))
print(len(df_final['mon_yr']))
# 539 539 539 530 530
# px.scatter(df_final, x=df_final['TOTRESNS'], y=df_final['FEDFUNDS'],
#       animation_group= df_final['Month'], size=df_final['FEDFUNDS'], color=df_final['Month'], hover_name=df_final['Month'])
# range_x=[minx,maxx], range_y=[miny,maxy])
# fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 300
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReservesscatterplot3.html")
# fig.show()
# File "C:\Users\Owner\Documents\Research\MonetaryPolicy\ReservesFFv2.py", line 99, in
# <module>
#    fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 300
# IndexError: tuple index out of range
# log_x= True,
#
# fig = px.scatter(df_final, x='TOTRESNS', y='FEDFUNDS', animation_frame=year,
#    animation_group=mon_yr, size=pce, color=mon_yr, hover_name=mon_yr,
#    log_x= True, range_x=[minx,maxx], range_y=[miny,maxy])
# fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 300
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReservesscatterplot4.html")
# fig.show()
#
# Fed funds volatility vs reserves
maxv = max(volf)
minv = min(volf)
fig = px.scatter(df_final, x=res, y=volf)
fig.show()
#
fig = px.scatter(df_final, x=df_final['TOTRESNS'], y=df_final['VOLF'], log_x= True, size_max=45)
# range_x=[minx,maxx], range_y=[miny,maxy])
fig.update_xaxes(
    rangeslider_visible=True,
    rangeselector=dict(
        buttons=list([
            dict(count=120, label="10y", step="month", stepmode="backward"),
            dict(count=240, label="20y", step="month", stepmode="backward"),
            dict(count=360, label="30y", step="month", stepmode="backward"),
            dict(count=480, label="40y", step="month", stepmode="backward"),
            dict(count=600, label="50y", step="month", stepmode="backward"),
            dict(step="all")
        ])
    )
)
labels={
                     "TOTRESNS": "Reserves",
                     "VOLF": "Fed funds % change",
                 },
title=("Fed funds volatility versus reserves")
fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFVOLvReservesscatterplot11.html")
fig.show()
#
# fig = px.scatter(df_final, x=df_final['TOTRESNS'], y=df_final['VOLF'], animation_frame=mon_yr,
#      animation_group=df_final['mon_yr'], log_x= True, size_max=45)
# range_x=[minx,maxx],range_y=[minv,maxv])
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReserves2scatterplot5.html")
# fig.show()
#
# fig = px.scatter(df_final, x=df_final['TOTRESNS'}, y=df_final['VOLF'], log_x= True,
#      size_max=df_final['VOLF'])
# range_x=[minx,maxx], range_y=[minv,maxv])
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReserves2scatterplot6.html")
# fig.show()
# fig = px.scatter(df_final, x=df_final['TOTRESNS'], y=df_final['VOLF'], animation_frame=year,
#      animation_group=df_final['Month'], log_x= True, size=df_final['pce'])
# , range_x=[minx,maxx],
#      range_y=[minv,maxv])
# fig.write_html("C:/Users/Owner/Documents/Research/MonetaryPolicy/FFvReserves2scatterplot7.html")
# fig.show()
#
# FANCIER GRAPHS
# fig = px.scatter(rates_final, x=df_final['TOTRESNS'], y=df_final['VOLF'FEDFUNDS', animation_frame=year,
#     animation_group=month, size=ff, color=month, hover_name=year,
#     log_x= True, size_max=45)
# range_x=[minx,maxx], range_y=[miny,maxy])
# fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 700
# fig.show()
# -------------------------------------------------------
# fig.layout.updatemenus[0].buttons[0].args[1]['frame']['duration'] = 100
# IndexError: tuple index out of range
#
# fig = px.scatter(df_final,x='TOTRESNS', y='FEDFUNDS', animation_frame= year,
#      animation_group=month, size=ff, color=year, hover_name=month)
# log_x=True, range_x=[minx,maxx], range_y=[miny,maxy])
# Tune marker appearance and layout
# fig.update_traces(mode='markers', marker=dict(sizemode='area',
# ))
# fig.update_layout(
# title='Fed funds rates v reserves, 1959~2022',
# xaxis=dict(
# title='Reserves',
# gridcolor='white',
# type='log',
# gridwidth=2,
# ),
# yaxis=dict(
# title='Fed funds rate (x.xx pct)',
# gridcolor='white',
# gridwidth=2,
# ),
# paper_bgcolor='rgb(243, 243, 243)',
# plot_bgcolor='rgb(243, 243, 243)',
#)
# fig.layout.updatemenus[0].buttons[0].args[1]["frame"]["duration"] = 600
# fig.write_html("'C:/Users/Owner/Documents/Research/SOMA/FF_reposcatterplot.html")
# fig.show()
# -------------------------------------------------------
