% Duffie Krishnamurti diversity index 
% Our objective is to show how the current setting of U.S.-dollar money markets limits
% the passthrough effectiveness of the Federal Reserve%s monetary policy. We focus on
% frictions associated with imperfect competition, regulation, infrastructure, and other
% forms of institutional segmentation within money markets.
% Empirically, dispersion across money market interest rates is a primary indicator
% of the level of passthrough inefficiency. We present a new index of rate dispersion
% in U.S. short-term money markets, the weighted mean absolute deviation of the crosssectional 
% distribution of overnight-equivalent rates, after adjusting for premia associated
% with credit risk and term structure. 
%
% Loyd BoE . An OIS contract is
% an over-the-counter trade derivative in which two counterparties exchange fixed and floating
% interest rate payments. The floating interest rate on OIS contracts is the overnight interbank
% rate, a measure of the de facto monetary policy stance.
% IDEA literature, motivated by Stock and Watson (2012) and Mertens and Ravn (2013), combined 
% high-frequency identification techniques with structural vector autoregression methods to 
% estimate the macroeconomic effects of monetary policy shocks

% OIS data Bloomberg
% FWCM <GO> will give you what you want (Forward Curve Matrix). You can select a curve and then 
% get the forwards by Tenor and Start Date. Or use the BCurveStrip and BCurveFwd in Excel.

% load NYFed short rate data.
% Old excel file that I converted to google sheet
%[x,txt,raw] = xlsread('C:/Users/Owner/Documents/Research/Data/FRED/FRED_TOMO/NYFedOvernightRates_v2.xlsx','A2:F6430');
%size(x) %6429           
% https://www.mathworks.com/matlabcentral/fileexchange/59359-matlab-to-google-sheets-matlab2sheets
% https://docs.google.com/spreadsheets/d/11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk/edit#gid=183946768
%
%}
NYFedOvernightRates data in columns
Effective Date
Rate Type
Rate (%)	
Volume (Billions of dollars)
Target Rate From (%)
Target Rate To (%)
1st Percentile (%)

25th Percentile (%)
75th Percentile (%)
99th Percentile (%)
Intra Day - Low (%)
Intra Day - High (%)
Standard Deviation (%)
30-Day Average SOFR
90-Day Average SOFR
180-Day Average SOFR
SOFR Index
Revision Indicator (Y/N)
Footnote ID
07/15/2022	EFFR	1.58	97
%} 


% =================== Code relavent to my question ==================
%{
https://www.mathworks.com/matlabcentral/answers/474980-extract-info-from-json-file-by-matlab
see https://support.google.com/a/users/answer/9310247?hl=en
https://support.google.com/a/users/answer/9308619?ref_topic=9326428
https://developer.apple.com/documentation/uikit/uidocumentpickerviewcontroller
https://www.mathworks.com/matlabcentral/answers/839935-reading-from-google-sheeets-using-matlab?s_tid=answers_rc1-3_p3_Topic
https://mathematica.stackexchange.com/questions/242191/how-to-import-a-google-sheets-file-that-requires-account-login
https://docs.google.com/spreadsheets/d/1eb5pOxHA7lSlGeTTA3BUEIJ3lFDUt18mo0y4LakBexw/edit?usp=sharing
https://support.google.com/drive/community/?hl=en&gpf=%23!searchin%2Fdrive%2Fcannot%2420view
%}
ID='11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk'
sheet_name = 'ONrates';
url_name = sprintf('https://drive.google.com/drive/my-drive/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
    ID, sheet_name);
%url_name = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
%    ID, sheet_name);
x = webread(url_name);

url_name = strcat('https://docs.google.com/spreadsheets/d/',ID,'/export?format=json');
websave('onrates2.json',url_name);
% result '<!doctype html><html lang="en-US" dir="ltr"><head><base href="https://accounts.google.com/v3/signin/'
%url_name = strcat('https://accounts.google.com/spreadsheets/d/',ID,'/export?format=json');
%websave('onrates2.json',url_name);

%url_name = strcat('https://accounts.google.com/spreadsheets/u/0/',ID,'/export?format=json');

fid = fopen('C:/Users/Owner/Documents/Research/MonetaryPolicy/Code/onrates2.json'); % Opening the file
raw = fread(fid,inf); % Reading the contents
%{
raw(1:10) ans =
    60
    33
   100
   111
    99
   116
   121
   112
   101
    32
%} 

str = char(raw'); % Transformation
%{ 
 '<!doctype html><html lang="en-US" dir="ltr"><head><base href="https://accounts.google.com/v3/signin/"><meta name="referrer" content="origin"><link rel="canonical" href="https://accounts.google.com/v3/signin/identifier"><meta name="viewport" content="width=device-width, initial-scale=1"><style data-href="https://www.gstatic.com/_/mss/boq-identity/_/ss/k=boq-identity.AccountsSignInUi.AS-LiHkF8H8.L.X.O/am=MAEUIAAQEAAAAAAAAAAAASARAQ/d=1/ed=1/rs=AOaEmlHasAgvE-Y01cPPOtJT0do9X5Z3lg/m=identifierview,_b,_tp,_r" nonce="XNj_ZSQR1sWu2L44u95eoQ">c-wiz{contain:style}c-wiz>c-data{display:none}c-wiz.rETSD{contain:none}c-wiz.Ubi8Z{contain:layout style}.BrpTO{margin:auto;max-width:380px;overflow:hidden;position:relative}.BrpTO .Q8ElWe{position:relative;text-align:center}.viAgtf{border-radius:50%;color:#5f6368;overflow:hidden}.eCirAf{line-height:1.4286}.cABCAe{width:100%}.cABCAe .viAgtf{flex:none;height:28px;margin-right:12px;width:28px}.cABCAe .Q8ElWe,.TPmpLe .Q8ElWe{display:flex;align-items:center}.cABCAe .Q8ElWe{justify-content:center}.BrpTO .viAgtf{height:64px;margin:0 auto 8px;width:64px}.rs3gSb{border-radius:50%;display:block}.cABCAe .rs3gSb,.cABCAe .hZUije,.cABCAe .kHluYc{max-height:100%;max-width:100%}.BrpTO .rs3gSb,.BrpTO .hZUije,.BrpTO .kHluYc{height:64px;width:64px}.TPmpLe{height:20px}.TPmpLe .viAgtf{margin-right:8px;height:20px;min-width:20px}.TPmpLe .rs3gSb,.TPmpLe .hZUije,.TPmpLe .kHluYc{color:#3c4043;height:20px;width:20px}.TPmpLe .kk39Eb{overflow:hidden}.TPmpLe .yavlK{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.cABCAe .kk39Eb{box-flex:1;flex-grow:1}.cABCAe .eCirAf{color:#3c4043;font-size:14px;font-weight:500}.BrpTO .eCirAf{color:#202124;font-size:16px}.yavlK{direction:ltr;font-size:12px;text-align:left;line-height:1.3333;word-break:break-all}.FzDwd{direction:ltr;font-size:12px;text-align:left;line-height:1.3333;word-break:break-all;color:#5f6368}.TPmpLe .yavlK{color:#3c4043}.cABCAe .yavlK{color:#5f6368}.BrpTO .yavlK{color:#5f6368;text-align:center}.BtUzhd{color:#5f6368;font-size:12px}.cABCAe .BtUzhd{align-self:flex-start;flex:none;line-height:1.3333}.JnOM6e{background-color:transparent;border:none;border-radius:4px;box-sizing:border-box;display:inline-block;font-size:14px;height:36px;letter-spacing:.15px;line-height:34px;padding:0 24px;position:relative;text-align:center}.JnOM6e:focus-visible{outline:none;position:relative}.JnOM6e:focus-visible::after{border:2px solid #185abc;border-radius:6px;bottom:-4px;box-shadow:0 0 0 2px #e8f0fe;content:"";left:-4px;position:absolute;right:-4px;top:-4px}.rDisVe:focus:not(:focus-visible),.GjFdVe:focus:not(:focus-visible){box-shadow:0 1px 1px 0 rgba(66,133,244,.3),0 1px 3px 1px rgba(66,133,244,.15)}.rDisVe:hover:not(:focus-visible),.GjFdVe:hover:not(:focus-visible){box-shadow:0 1px 1px 0 rgba(66,133,244,.45),0 1px 3px 1px rgba(66,133,244,.3)}.JnOM6e:hover{cursor:pointer}.JnOM6e.kTeh9{line-height:36px;text-decoration:none}.JnOM6e.eLNT1d{display:none}.rDisVe{background-color:#1a73e8;color:#fff}.rDisVe:focus,.rDisVe:hover{background-color:#185abc}.GjFdVe{border:1px solid #dadce0;color:#1a73e8}.GjFdVe:active{background-color:#aecbfa;color:#174ea6}.GjFdVe:focus{background-color:#e8f0fe;border-color:#185abc;color:#174ea6}.GjFdVe:hover{background-color:#e8f0fe;color:#174ea6}.KXbQ4b{color:#1a73e8;min-width:0;padding-left:8px;padding-right:8px}.KXbQ4b:active,.KXbQ4b:hover{color:#185abc}.KXbQ4b:active{background-color:rgba(26,115,232,0.122)}.KXbQ4b:focus,.KXbQ4b:hover{background-color:rgba(26,115,232,0.039)}.aN1Vld{margin:16px 0;outline:none}.aN1Vld+.aN1Vld{margin-top:24px}.aN1Vld:first-child{margin-top:0}.aN1Vld:last-child{margin-bottom:0}.fegW5d{border-radius:8px;padding:16px}.fegW5d>:first-child{margin-top:0}.fegW5d>:last-child{margin-bottom:0}.fegW5d .cySqRb{color:#202124}.fegW5d .yOnVIb{color:#202124}.fegW5d.YFdWic .yOnVIb{color:#5f6368;margin-top:4px;padding:0}.fegW5d.YFdWic .wSQNd,.fegW5d.YFdWic .yOnVIb{margin-left:64px;width:calc(100% - 64px)}.fegW5d.YFdWic:not(.S7S4N) .wSQNd{margin-left:0;width:0}.fegW5d:not(.S7S4N)>.yOnVIb{margin-top:0}.fegW5d.sj692e{background:#e8f0fe}.fegW5d.Xq8bDe{background:#fce8e6}.fegW5d.rNe0id{background:#fef7e0}.fegW5d.YFdWic{border:1px solid #dadce0;min-height:80px;position:relative}.fegW5d:not(.S7S4N){display:flex}.aN1Vld.eLNT1d{display:none}.wlrzMe{border:1px solid #dadce0;border-radius:8px;padding:16px}.wlrzMe .EEiyWe{display:flex;justify-content:flex-end;margin-top:16px}.wlrzMe .EEiyWe .GjFdVe{margin-bottom:0;margin-top:0}.wSQNd:empty{display:none}.wSQNd>:first-child{margin-top:0;padding-top:0}.wSQNd>:last-child{margin-bottom:0;padding-bottom:0}.cySqRb{align-items:center;color:#202124;display:flex;font-size:16px;font-weight:500;letter-spacing:0.1px;line-height:1.4286;margin-bottom:0;margin-top:0;padding:0}.zlrrr{color:#5f6368;flex-shrink:0;height:20px;margin-right:16px;width:20px}.zlrrr .GxLRef{height:100%;width:100%}.fegW5d .zlrrr{margin-top:0}.fegW5d.sj692e .zlrrr{color:#1967d2}.fegW5d.Xq8bDe .zlrrr{color:#c5221f}.fegW5d.rNe0id .zlrrr{color:#ea8600}.fegW5d.YFdWic .zlrrr{height:48px;left:16px;position:absolute;top:16px;width:48px}.yOnVIb{margin:auto -24px;padding-left:24px;padding-right:24px;margin-bottom:16px;margin-top:10px}.wlrzMe .yOnVIb{margin-bottom:0;margin-top:16px}.yOnVIb>:first-child:not(section){margin-top:0;padding-top:0}.yOnVIb>:last-child:not(section){margin-bottom:0;padding-bottom:0}.wSQNd:empty+.yOnVIb{margin-top:0}.yOnVIb:only-child{margin-bottom:0;margin-top:0}.hZUije{border:0}.hZUije.WS4XDd{max-height:1.3333em;padding:0 2px;vertical-align:middle;width:auto}.kHluYc{border:0;object-fit:contain}.kHluYc.WS4XDd{max-height:1.3333em;padding:0 2px;vertical-align:middle;width:auto}.vOZun{padding-bottom:3px;padding-top:9px;margin-bottom:0;margin-top:0}.gomQac{padding-bottom:3px;padding-top:9px;margin:0}.vOZun:empty{display:none}*,*:before,*:after{box-sizing:inherit}html{box-sizing:border-box}body,input,textarea,select,button{color:#202124;font-family:arial,sans-serif}body{background:#fff;direction:ltr;display:flex;flex-direction:column;font-size:14px;line-height:1.4286;margin:0;min-height:100vh;padding:0;position:relative}@media all and (min-width:601px){body{justify-content:center}}[data-style="heading"],.BDEI9 h2:not(.TrZEUc){color:#202124;font-size:16px;font-weight:500;letter-spacing:0.1px;line-height:1.4286}.BDEI9 a{text-decoration:none}.BDEI9 a:not(.TrZEUc){border-radius:4px;color:#1a73e8;display:inline-block;font-weight:500;letter-spacing:.25px;outline:0;position:relative;z-index:1}.BDEI9 button:not(.TrZEUc){border-radius:4px;color:#1a73e8;display:inline-block;font-weight:500;letter-spacing:.25px;outline:0;position:relative;z-index:1;background-color:transparent;cursor:pointer;padding:0;text-align:left;border:0}.BDEI9 button::-moz-focus-inner{border:0}.BDEI9 a:not(.TrZEUc):focus::after,.BDEI9 a:not(.TrZEUc):active::after,.BDEI9 button:not(.TrZEUc):focus::after,.BDEI9 button:not(.TrZEUc):active::after{background-color:rgba(26,115,232,0.149);border-radius:2px;bottom:-2px;content:"";left:-3px;position:absolute;right:-3px;top:-2px;z-index:-1}.BDEI9 img:not(.TrZEUc){border:0;max-height:1.3em;vertical-align:middle}@media all and (min-width:601px){.BDEI9{display:flex;flex-direction:column;min-height:100vh;position:relative}.BDEI9:before,.BDEI9:after{box-flex:1;flex-grow:1;content:"";height:24px}.BDEI9:before{min-height:30px}.BDEI9:after{min-height:24px}.BDEI9.LZgQXe:after{min-height:63.9996px}}.gEc4r{display:flex;height:24px;justify-content:center}.HUYFt{display:flex;flex-wrap:wrap;font-size:12px;justify-content:space-between;padding:0 24px 14px}.HUYFt .hXs2T,.HUYFt .M2nKge{line-height:48px}@media all and (min-width:601px){.HUYFt{padding-left:0;padding-right:0;position:absolute;width:100%}}.hXs2T .pUP0Nd{color:#5f6368}.hXs2T{margin-left:-16px;margin-right:16px}.N158t{appearance:none;background-color:transparent;background-image:url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGhlaWdodD0iMjRweCIgdmlld0JveD0iMCAwIDI0IDI0IiB3aWR0aD0iMjRweCIgZmlsbD0iIzQ1NUE2NCI+PHBhdGggZD0iTTAgMGgyNHYyNEgwVjB6IiBmaWxsPSJub25lIi8+PHBhdGggZD0iTTcgMTBsNSA1IDUtNUg3eiIvPjwvc3ZnPg==");background-position:right;background-repeat:no-repeat;border:none;border-radius:4px;color:#5f6368;cursor:pointer;font-size:12px;outline:none;padding:16.0002px 24px 16.0002px 16px;transition:background}.N158t:focus{background-color:#e8eaed}.M2nKge{list-style:none;margin:0 -16px;padding:0}.vomtoe{display:inline-block;margin:0}.pUP0Nd{border-radius:4px;color:#5f6368;display:inline-block;outline:none;z-index:1}.pUP0Nd .UskCyf{background-color:transparent;padding:6px 16px;transition:background}.pUP0Nd:focus .UskCyf{background-color:#e8eaed;border-radius:4px}.Ha17qf{background:#fff;display:flex;flex-direction:column;max-width:100%;min-height:100vh;position:relative}@media all and (min-width:601px){.Ha17qf{background:#fff;border:1px solid #dadce0;border-radius:8px;display:block;flex-shrink:0;margin:0 auto;min-height:0;width:450px}.Ha17qf.qmmlRd{width:450px}.Ha17qf.qmmlRd .Or16q{height:auto;min-height:500px}}.Or16q{box-flex:1;flex-grow:1;overflow:hidden;padding:24px 24px 36px}@media all and (min-width:601px){.Or16q{height:auto;min-height:500px;overflow-y:auto}}@media all and (min-width:450px){.Or16q{padding:48px 40px 36px}}.iEhbme{padding:24px 0 0}.iEhbme.RDPZE{opacity:.5;pointer-events:none}.HDuqac{background:transparent;border:none;color:#3c4043;cursor:pointer;display:inline-flex;font-size:14px;letter-spacing:0.25px;max-width:100%}.BOs5fd{align-items:center;background:#fff;border:1px solid #dadce0;display:inline-flex;max-width:100%;position:relative}.HDuqac:focus-visible{outline:none}.HDuqac:focus-visible .BOs5fd{outline:none;position:relative;background:rgba(60,64,67,0.122)}.HDuqac:focus-visible .BOs5fd::after{border:2px solid #185abc;border-radius:20px;bottom:-5px;box-shadow:0 0 0 2px #e8f0fe;content:"";left:-5px;position:absolute;right:-5px;top:-5px}.HDuqac:focus:not(:focus-visible) .BOs5fd{box-shadow:0 1px 1px 0 rgba(66,133,244,.3),0 1px 3px 1px rgba(66,133,244,.15);border-color:#dadce0;box-shadow:none}.HDuqac:hover:not(:focus-visible) .BOs5fd{background:rgba(60,64,67,0.039)}.HDuqac:focus .BOs5fd,.HDuqac:hover .BOs5fd{border-color:#dadce0}.HDuqac:active:focus .BOs5fd{background:rgba(60,64,67,0.122);border-color:#3c4043;color:#3c4043}.EI77qf{line-height:30px;margin:-8px 0;padding:8px 0}.EI77qf.DbQnIe{color:#1a73e8;font-size:12px;line-height:22px}.EI77qf .BOs5fd{border-radius:16px;padding:0 15px 0 15px}.EI77qf.DbQnIe .BOs5fd{border-radius:12px;padding:0 10px 0 10px}.EI77qf.iiFyne .BOs5fd{padding-right:7px}.EI77qf.cd29Sd .BOs5fd{padding-left:5px}.EI77qf.DbQnIe.cd29Sd .BOs5fd{padding-left:2px}.EI77qf.DbQnIe.iiFyne .BOs5fd{padding-right:7px}.hMeYtd{border-radius:10px;height:20px;margin-right:8px}.hMeYtd .rs3gSb,.hMeYtd .hZUije,.hMeYtd .kHluYc{border-radius:50%;color:#3c4043;display:block;height:20px;width:20px}.wJxLsd{direction:ltr;overflow:hidden;text-align:left;text-overflow:ellipsis;white-space:nowrap}.znpTjf{color:#3c4043;flex-shrink:0;height:18px;margin-left:4px;width:18px}.HDuqac.DbQnIe .znpTjf{height:16px;width:16px}.JC0zZc{display:block;height:100%;width:100%}.aMfydd{text-align:center}.aMfydd .Tn0LBd{padding-bottom:0;padding-top:16px;color:#202124;font-size:24px;font-weight:400;line-height:1.3333;margin-bottom:0;margin-top:0}.a2CQh{margin-bottom:0;margin-top:0;font-size:16px;font-weight:400;letter-spacing:0.1px;line-height:1.5;padding-bottom:0;padding-top:8px}.a2CQh:empty{display:none}.n868rf{display:inline-flex;letter-spacing:.25px;min-height:24px;padding-bottom:0;padding-top:8px}.C7uRJc{margin-top:8px}.NveWz{box-flex:1;flex-grow:1}.i2knIc{display:flex;box-flex:0;flex-grow:0;flex-wrap:wrap;margin-left:-8px;margin-top:32px;min-height:48px;padding-bottom:20px}.i2knIc.fXx9Lc{margin:0;min-height:0;padding:0}.sXlxWd{margin-bottom:32px;width:100%}.wg0fFb{display:flex;flex-direction:row-reverse;flex-wrap:wrap;width:100%}.RhTxBf,.tmMcIf{box-flex:1;flex-grow:1}.i2knIc.NNItQ:not(.F8PBrb) .RhTxBf,.i2knIc.NNItQ:not(.F8PBrb) .tmMcIf{text-align:center}.RhTxBf{text-align:right}.i2knIc.F8PBrb .wg0fFb{margin:0 -2px;margin-left:8px;width:calc(100% + 4px)}.i2knIc.F8PBrb .RhTxBf{display:flex;flex-wrap:wrap;width:100%}.i2knIc.F8PBrb .tmMcIf{margin:0 2px}.xOs3Jc{box-flex:1;flex-grow:1;margin:0 2px;min-width:calc(50% - 4px)}.Cokknd{margin-bottom:6px;margin-top:6px;white-space:nowrap;width:100%}.D4rY0b{color:#5f6368;font-size:14px;line-height:1.4286;margin-top:32px}.TRuRhd{margin-top:24px;position:relative}.Fu5aXd:first-child .TRuRhd{margin-top:8px}.xyezD{background-color:transparent;border:none;box-sizing:border-box;color:#202124;font-size:16px;height:56px;outline:none;padding:0 14px;width:100%}.TRuRhd.YKooDc .xyezD{direction:ltr;text-align:left}.Yr2OOb{line-height:1.4286;margin:14px;padding:0;resize:vertical}.LBj8vb{background-color:transparent;border:none;font-size:16px;height:56px;padding:0 14px;outline:none;width:100%}.dXXNOd{display:flex;width:100%}.xMpNCd:not(:empty){line-height:56px;padding-left:14px}.pkBWge:not(:empty){line-height:56px;padding-right:14px}.TRuRhd[data-has-domain-suffix] .pkBWge{display:flex;white-space:nowrap}.TRuRhd[data-has-domain-suffix][data-has-at-sign] .pkBWge{display:none}.fjpXlc{display:flex;height:100%}.nWPx2e{align-items:stretch;display:flex;flex-direction:row;height:100%;justify-content:flex-start;left:0;max-width:100%;pointer-events:none;position:absolute;top:0;width:100%}.YhhY8,.CCQ94b,.tNASEf{border:1px solid #dadce0}.YhhY8{border-bottom-left-radius:4px;border-right:none;border-top-left-radius:4px;width:8px}.CCQ94b{border-left:none;border-right:none;border-top:none;color:#5f6368;font-size:12px;margin:-6px 0 0;padding:0 6px}.tNASEf{border-bottom-right-radius:4px;border-left:none;border-top-right-radius:4px;box-flex:1;flex-grow:1}.Fu5aXd:not(.Jj6Lae) .xyezD:focus+.nWPx2e .CCQ94b,.Fu5aXd:not(.Jj6Lae) .LBj8vb:focus+.nWPx2e .CCQ94b{color:#1a73e8}.xyezD:focus+.nWPx2e .YhhY8,.xyezD:focus+.nWPx2e .CCQ94b,.xyezD:focus+.nWPx2e .tNASEf,.LBj8vb:focus+.nWPx2e .YhhY8,.LBj8vb:focus+.nWPx2e .CCQ94b,.LBj8vb:focus+.nWPx2e .tNASEf{border-color:#1a73e8;border-width:2px}.F3wxlc{align-items:flex-start;color:#5f6368;display:flex;font-size:12px;line-height:normal;margin-top:4px}.EllNBf{margin-right:8px;margin-top:-2px}.SnjiRb{height:16px;width:16px}.F3wxlc:empty,.NHVGlc:empty{display:none}.Fu5aXd.Jj6Lae .F3wxlc{color:#d93025}.Fu5aXd .azsAwf{margin-left:16px}.Fu5aXd.Jj6Lae .nWPx2e .YhhY8,.Fu5aXd.Jj6Lae .nWPx2e .CCQ94b,.Fu5aXd.Jj6Lae .nWPx2e .tNASEf{border-color:#d93025}.Fu5aXd.Jj6Lae .nWPx2e .CCQ94b{color:#d93025}.ZWssT{margin-top:26px}.vopC4e{background:transparent;border:none;box-sizing:border-box;color:#202124;cursor:pointer;margin-bottom:-15px;margin-top:-15px;outline:inherit;padding-bottom:15px;padding-top:15px;position:relative;z-index:1}.vopC4e:focus::after{background-color:rgba(26,115,232,0.149);border-radius:2px;bottom:0;content:"";left:0;position:absolute;right:0;top:0;z-index:-1}.JVMrYb{display:block}.hJIRO{display:none}.sQecwc{display:hidden}sentinel{}
     /*# sourceURL=/_/mss/boq-identity/_/ss/k=boq-identity.AccountsSignInUi.AS-LiHkF8H8.L.X.O/am=MAEUIAAQEAAAAAAAAAAAASARAQ/d=1/ed=1/rs=AOaEmlHasAgvE-Y01cPPOtJT0do9X5Z3lg/m=identifierview,_b,_tp,_r */</style><style nonce="XNj_ZSQR1sWu2L44u95eoQ">@font-face{font-family:'Product Sans';font-style:normal;font-weight:400;src:url(//fonts.gstatic.com/s/productsans/v9/pxiDypQkot1TnFhsFMOfGShVF9eL.ttf)format('truetype');}</style><noscript><meta http-equiv="refresh" content="0; url=/ServiceLogin?continue=https://docs.google.com/spreadsheets/d/11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk/export?format%3Djson&amp;dsh=S-1844912635:1663124844259132&amp;flowEntry=ServiceLogin&amp;followup=https://docs.google.com/spreadsheets/d/11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk/export?format%3Djson&amp;ifkv=AQDHYWpDOzN6dkhC2V-SxseTIDLBKCpiIKy7SiSJ3MBn8UZVan0n0AObPQHiPVkZmRcTbz1xHFLb&amp;ltmpl=sheets&amp;nojavascript=1&amp;osid=1&amp;service=wise"><style nonce="XNj_ZSQR1sWu2L44u95eoQ">body{opacity:0;}</style></noscript><title>Google Sheets: Sign-in</title></head><body><div class="BDEI9 LZgQXe"><div class="Ha17qf" data-auto-init="Card"><div class="Or16q"><div data-view-id="hm18Ec" data-locale="en_US" data-allow-sign-up-types="true"><c-wiz jsrenderer="OTcFib" jsshadow jsdata="deferred-i2" data-p="%.@.]" data-node-index="2;0" jsmodel="hc6Ubd" c-wiz><div class="gEc4r"><img src="//ssl.gstatic.com/images/branding/googlelogo/2x/googlelogo_color_74x24dp.png" class="TrZEUc" alt="Google" width="74" height="24"></div><c-data id="i2" jsdata=" eCjdDd;_;2"></c-data></c-wiz><div class="EQIoSc" jsname="bN97Pc"><div jsname="paFcre"><div class="aMfydd" jsname="tJHJj"><h1 class="Tn0LBd" jsname="r4nke">Sign in</h1><p class="a2CQh" jsname="VdSJob">to continue to Sheets</p></div></div><form action="/v3/signin/identifier?continue=https://docs.google.com/spreadsheets/d/11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk/export?format%3Djson&amp;dsh=S-1844912635:1663124844259132&amp;flowEntry=ServiceLogin&amp;flowName=WebLiteSignIn&amp;followup=https://docs.google.com/spreadsheets/d/11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk/export?format%3Djson&amp;ifkv=AQDHYWpDOzN6dkhC2V-SxseTIDLBKCpiIKy7SiSJ3MBn8UZVan0n0AObPQHiPVkZmRcTbz1xHFLb&amp;ltmpl=sheets&amp;osid=1&amp;service=wise" method="POST" novalidate><div class="iEhbme" jsname="rEuO1b"><section class="aN1Vld "><div class="yOnVIb" jsname="MZArnb"><div class="Fu5aXd" jsname="dWPKW"><div class="Flfooc"><div class="TRuRhd  YKooDc"><div class="fjpXlc"><label class="dXXNOd"><input class="xyezD" jsname="Ufn6O" type="email" name="identifier" id="identifierId" autofocus autocapitalize="none" autocomplete="username" dir="ltr"/><div class="nWPx2e"><div class="YhhY8"></div><div class="CCQ94b">Email or phone</div><div class="tNASEf"></div></div></label></div></div></div><div class="F3wxlc" jsname="h9d3hd" aria-live="assertive"></div><div class="NHVGlc" jsname="JIbuQc"></div></div><p class="vOZun" jsname="OZNMeb" aria-live="assertive"></p><p class="vOZun">Forgot email?</p><input type="password" name="hiddenPassword" class="hJIRO" tabindex="-1" aria-hidden="true" spellcheck="false" jsname="RHeR4d"><input type="hidden" name="usi" value="S-1844912635:1663124844259132"><input type="hidden" name="domain" value=""><input type="hidden" name="region" value="US"><span jsname="xdJtEf"><script nonce="lMRYFgvHjeyQ8E0YVif5nw">//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjogMywic291cmNlcyI6WyIiXSwic291cmNlc0NvbnRlbnQiOlsiICJdLCJuYW1lcyI6WyJjbG9zdXJlRHluYW1pY0J1dHRvbiJdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUEifQ==
     (function(){var B=function(Z,Y,L,k,p,v,d,u,x){return 5>(L+(1==(L|6)>>3&&(x=(u=r(Y,k,v))&&1===d.eval(u.createScript(p))?function(h){return u.createScript(h)}:function(h){return""+h}),1)&8)&&0<=(L|3)>>Z&&(k(function(h){h(Y)}),x=[function(){return Y}]),x},z=function(Z,Y,L,k,p,v,d,u,x,h,U,D,g,A,b,a,H,e,S,I,G){return 2==(Y<<(Y-9<<1>=((Y&59)==Y&&k.addEventListener(p,L,Z),Y)&&(Y+4^28)<Y&&(G=Z),1)&7)&&(S=function(){},I=function(){try{return u.contentWindow.location.href.match(/^h/)?null:!1}catch(R){return""+R}},e=function(){S=(((A.push(k,+new Date-b),clearInterval(x),d).f=void 0,S)(),void 0)},a=function(R,l){(A.push(Z,(l=+new Date,l-b),R),5<R)?(A.push(35,l-b),e()):(g=l,h=R,u=document.createElement("iframe"),z(!1,8,function(T){R===h&&(T=I(),null===T?(A.push(15,+new Date-b),D=u.contentWindow,u=null,h=0,clearInterval(x),S(),S=void 0):(A.push(29,l-b,T),H(),a(R+1)))},u,"load"),z(!1,3,function(){R===h&&(A.push(64,l-b),H(),a(R+1))},u,"error"),u.style.display="none",u.src=v,U.appendChild(u))},H=function(){u=(U.removeChild(u),null),h=0},u=null,A=[],h=0,d.f=function(R,l){S?(l=S,S=function(){(l(),setTimeout)(function(){R(D,A)},0)}):R(D,A)},b=+new Date,U=document.body||document.documentElement.lastChild,x=setInterval(function(R,l,T){u&&(l=h,R=+new Date,2E4<R-b?(A.push(p,R-b),H(),e()):(T=I())?(A.push(93,R-b,T),H(),a(l+1)):R-g>L&&(A.push(87,R-b),H(),a(l+1)))},512),a(1)),G},c=function(Z,Y,L,k,p,v,d,u,x,h,U){return(Y-9<<2>=Y&&(Y-6|22)<Y&&(x=y,x.f||z(v,5,p,L,k,u,x),x.f(d)),(Y|48)==Y)&&(h=function(){},k=void 0,v=J(p,function(D){h&&(L&&P(L),k=D,h(),h=void 0)},!!L)[0],U={invoke:function(D,g,A,b,a){function H(){k(function(e){P(function(){D(e)})},A)}if(!g)return a=v(A),D&&D(a),a;k?H():(b=h,h=function(){P((b(),H))})}}),1==(Y>>2&7)&&(U=(k=y[p.substring(0,3)+"_"])?k(p.substring(3),L,v):B(Z,p,3,L)),U},y,r=function(Z,Y,L,k,p){if(p=(k=Y,W.trustedTypes),!p||!p.createPolicy)return k;try{k=p.createPolicy(Z,{createHTML:V,createScript:V,createScriptURL:V})}catch(v){if(W.console)W.console[L](v.message)}return k},V=function(Z){return z.call(this,Z,20)},n=function(Z,Y,L,k){return c.call(this,4,48,Y,k,Z,L)},W=this||self,P=W.requestIdleCallback?function(Z){requestIdleCallback(function(){Z()},{timeout:4})}:W.setImmediate?function(Z){setImmediate(Z)}:function(Z){setTimeout(Z,0)},J=function(Z,Y,L,k){return c.call(this,4,5,Y,k,Z,L)};((y=W.botguard||(W.botguard={}),40)<y.m||(y.m=41,y.bg=n,y.a=J),y).qBK_=function(Z,Y,L,k,p,v){return c(4,24,60,66,(k=Z.lastIndexOf("//"),v=atob(Z.substr(k+2)),6E3),82,function(d,u,x){if(x="FNL"+u,d)try{p=d.eval(B(4,"bg",8,null,"1","error",d)(Array(7824*Math.random()|0).join("\n")+['//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjogMywic291cmNlcyI6WyIiXSwic291cmNlc0NvbnRlbnQiOlsiICJdLCJuYW1lcyI6WyJjbG9zdXJlRHluYW1pY0J1dHRvbiJdLCJtYXBwaW5ncyI6IkFBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUEifQ==',
     '(function(){var d=function(Z,Y,u,L,h,p,k,x,R,A,b,v,l){if(2==(Z>>2&14)&&L.W.splice(Y,Y,u),(Z&59)==Z)if(Array.isArray(h))for(R=Y;R<h.length;R++)d(32,0,"object",L,h[R],p,k,x);else x=D(27,x),k&&k[Ys]?k.Z.add(String(h),x,true,H(114,p,8,u)?!!p.capture:!!p,L):S(7,"object",false,p,k,true,L,x,h);if((Z|40)==Z)if(b=h.Z.J[String(L)]){for(R=(x=(b=b.concat(),0),Y);x<b.length;++x)(v=b[x])&&!v.X&&v.capture==p&&(k=v.hx||v.src,A=v.listener,v.v&&B(4,14,1,h.Z,v),R=false!==A.call(k,u)&&R);l=R&&!u.defaultPrevented}else l=Y;return(3==(Z>>1&15)&&T.call(this,Y,u||g.nv(),L),Z&91)==Z&&(l=Y&&Y.parentNode?Y.parentNode.removeChild(Y):null),l},B=function(Z,Y,u,L,h,p,k,x){if(!((Y|5)>>3))a:{for(k in h)if(p.call(void 0,h[k],k,h)){x=L;break a}x=u}return((2==((Y|88)==Y&&(this.type=u,this.currentTarget=this.target=L,this.defaultPrevented=this.u=false),Y+Z)>>3&&(p=h.type,p in L.J&&ks(4,28,u,h,L.J[p])&&(z(true,11,h),0==L.J[p].length&&(delete L.J[p],L.A--))),Y)-2|30)>=Y&&(Y-1|70)<Y&&(h=new y(u,L),x=[function(R){return ks(4,15,false,R,h)}]),x},xs=function(Z,Y,u,L,h,p,k,x,R,A,b,v){if(1==(u|6)>>3)if(Z="array"===ZA("null",h,"number")?h:[h],this.B)Y(this.B);else try{L=!this.W.length,p=[],d(78,0,[hu,p,Z],this),d(15,0,[L0,Y,p],this),k&&!L||p0(null,this,k,254,true)}catch(l){J(51,0,l,this),Y(this.B)}return 5>(u+1&8)&&0<=(u|3)>>4&&(x=p&7,Z=[55,43,-28,32,5,63,Z,38,-99,-33],A=sG,R=Rm[L.G](L.F7),R[L.G]=function(l){b=l,x+=Y+7*p,x&=7},R.concat=function(l,a,r){return((b=(a=(r=+((l=h%16+1,A)()|0)*l-2580*h*b+5*h*h*l-l*b-300*h*h*b+k*b*b+Z[x+67&7]*h*l+x- -300*b,Z)[r],void 0),Z)[(x+37&7)+(p&2)]=a,Z)[x+((p|2)-(p&-3)-(~p&2))]=43,a},v=R),v},Au=function(Z,Y,u,L,h,p,k,x,R){if(((L+Z^12)<L&&(L-2^20)>=L&&(k=u,k=(p=k<<13,(p|0)+~p-(~k^p)),k^=k>>17,k^=k<<5,(k=(h|0)+(k&~h)-(k^h))||(k=1),R=Y^k),L&75)==L)if(h=u.length,h>Y){for(k=(p=Array(h),Y);k<h;k++)p[k]=u[k];R=p}else R=[];return 16>(L<<1&16)&&5<=(L<<1&7)&&(Y.X?k=true:(x=new P(u,this),h=Y.listener,p=Y.hx||Y.src,Y.v&&c(15,0,null,Y),k=h.call(p,x)),R=k),R},E=function(Z,Y,u,L,h,p,k,x,R,A){if((u-2^1)<u&&u+7>>1>=u)a:{for(x=Y;x<h.length;++x)if(k=h[x],!k.X&&k.listener==Z&&k.capture==!!L&&k.hx==p){A=x;break a}A=-1}return(u-(3==((2==(u>>2&15)&&(A=Z.classList?Z.classList:m(2,40,"",Y,Z).match(/\\S+/g)||[]),u)^69)>>3&&(A=Rm[Y](Rm.prototype,{stack:Z,document:Z,splice:Z,parent:Z,replace:Z,prototype:Z,pop:Z,call:Z,propertyIsEnumerable:Z,length:Z,floor:Z,console:Z})),3==u-7>>3&&(this.listener=h,this.proxy=null,this.src=L,this.type=p,this.capture=!!Z,this.hx=Y,this.key=++bm,this.v=this.X=false),6)|44)<u&&u-9<<2>=u&&(R=function(){},R.prototype=L.prototype,Z.L=L.prototype,Z.prototype=new R,Z.prototype.constructor=Z,Z.Na=function(b,v,l){for(var a=Array(arguments.length-Y),r=Y;r<arguments.length;r++)a[r-Y]=arguments[r];return L.prototype[v].apply(b,a)}),A},v_=function(Z,Y,u,L,h,p,k,x,R,A,b){if(11<=Z>>1&&23>(Z^25)){for(R=(k=(L=0,[]),0);L<Y.length;L++)for(R+=u,h=(x=h<<u,p=Y[L],~(x&p)-1-~x-~p);7<R;)R-=8,k.push((A=h>>R,-256-2*~(A|255)-(A^255)+(~A|255)));b=k}return b},DA=function(Z,Y,u,L,h,p,k,x,R,A,b){return(u|8)==((u^16)>>((u+4&54)<u&&(u+6^19)>=u&&(x.classList?x.classList.remove(k):(x.classList?x.classList.contains(k):S(17,L,k,E(x,p,11)))&&J(31,h,Array.prototype.filter.call(E(x,p,72),function(v){return v!=k}).join(Y),x)),4)||(Array.isArray(h)&&(h=h.join(" ")),A="aria-"+k,""===h||void 0==h?(lm||(R={},lm=(R.atomic=Z,R.autocomplete="none",R.dropeffect="none",R.haspopup=Z,R.live=L,R.multiline=Z,R.multiselectable=Z,R.orientation="vertical",R.readonly=Z,R.relevant="additions text",R.required=Z,R.sort="none",R[Y]=Z,R.disabled=Z,R.hidden=Z,R.invalid="false",R)),x=lm,k in x?p.setAttribute(A,x[k]):p.removeAttribute(A)):p.setAttribute(A,h)),u)&&(b=Object.prototype.hasOwnProperty.call(Y,dn)&&Y[dn]||(Y[dn]=++am)),b},m=function(Z,Y,u,L,h,p,k,x){return(14>Y-9&&7<=Y>>1&&(x=!!(p=h.Vj,(L|u)+(p&~L)-(p^L))),(Y+5&7)==Z&&(k=function(R){return u.call(k.src,k.listener,R)},u=So,x=k),Y|40)==Y&&(x=typeof h.className==L?h.className:h.getAttribute&&h.getAttribute("class")||u),x},B_=function(Z,Y,u,L,h,p,k,x,R,A,b){if(Z-6<<((Z+5&24)<Z&&(Z+2&60)>=Z&&(rn.call(this),this.Z=new UG(this),this.s0=this,this.Gt=null),1)>=Z&&(Z-2^14)<Z)if(Y.classList)Array.prototype.forEach.call(u,function(v,l){Y.classList?Y.classList.add(v):(Y.classList?Y.classList.contains(v):S(21,1,v,E(Y,"string",9)))||(l=m(2,41,"","string",Y),J(3,"class",l+(0<l.length?" "+v:v),Y))});else{for(h in p=((Array.prototype.forEach.call(E(Y,"string",(L={},10)),function(v){L[v]=true}),Array.prototype).forEach.call(u,function(v){L[v]=true}),""),L)p+=0<p.length?" "+h:h;J(30,"class",p,Y)}if(1==((Z|8)&(Z>>1&12||u.Wg&&u.Wg.forEach(Y,void 0),7))){for(R=k=0;k<Y.length;k++)R+=Y.charCodeAt(k),R+=R<<10,R^=R>>6;b=(p=new Number((x=(A=1<<u,2*~(A&1)- -1-2*~A+(~A^1)),(R+=R<<3,R^=R>>11,h=R+(R<<15)>>>0,(h|0)-~(h&x))+~h)),p[0]=(h>>>u)%L,p)}return b},ks=function(Z,Y,u,L,h,p,k,x,R){return((((Y&93)==Y&&(k=c(90,u,0,h,L),(p=0<=k)&&Array.prototype.splice.call(h,k,u),R=p),(Y|40)==Y)&&(k=typeof p,x=k!=h?k:p?Array.isArray(p)?"array":k:"null",R=x==u||x==h&&typeof p.length==L),Y+6)&27)>=Y&&(Y+1^25)<Y&&(h.gG(function(A){p=A},u,L),R=p),R},z=function(Z,Y,u,L,h,p,k,x,R,A){if(22<=(Y-2>>3||(Ty.call(this),Z||eo||(eo=new gn),this.Wg=this.Jx=this.ow=null,this.Hg=void 0,this.tx=false,this.YH=this.Qs=null),Y-9)&&37>Y-9){if(!(R=(zy.call(this,L),u))){for(x=this.constructor;x;){if(h=(k=DA(false,x,11),yp[k]))break;x=(p=Object.getPrototypeOf(x.prototype))&&p.constructor}R=h?"function"===typeof h.nv?h.nv():new h:null}this.P=R}if(9<=(Y<<2&15)&&1>(Y^35)>>5){if(!Z)throw Error("Invalid class name "+Z);if("function"!==typeof u)throw Error("Invalid decorator function "+u);}if(!(Y<<1&14)){if(u=window.btoa){for(h=(p=0,"");p<Z.length;p+=8192)h+=String.fromCharCode.apply(null,Z.slice(p,p+8192));L=u(h).replace(/\\+/g,"-").replace(/\\//g,"_").replace(/=/g,"")}else L=void 0;A=L}return(Y+3&29)>=Y&&(Y+6&78)<Y&&(u.X=Z,u.listener=null,u.proxy=null,u.src=null,u.hx=null),A},N=function(Z,Y,u,L,h,p,k,x,R){if((Z&106)==Z)for(k=L.length,x="string"===typeof L?L.split(u):L,p=Y;p<k;p++)p in x&&h.call(void 0,x[p],p,L);return 3==((Z|((Z+3&53)>=(Z-6&12||(R=m(2,14,0,u,h)&&!!(h.U&u)!=L&&(!(h.hj&u)||h.dispatchEvent(Im(64,45,Y,32,2,16,u,L)))&&!h.lo),Z)&&Z+9>>2<Z&&(u=Y[Ju],R=u instanceof UG?u:null),56))==Z&&(this.lo=this.lo),Z+2&27)&&(R=Math.floor(this.m())),R},w=function(Z,Y,u,L,h,p,k){if((((Z&59)==Z&&(Y.o?k=P_(Y.H,Y):(L=c_(425,true,8,Y),-~L-(~L^128)-(~L&128)+2*(~L|128)&&(L=-(L|0)+(L|128)+~(L&128)-~L,u=c_(425,true,2,Y),L=(L<<2)+(u|0)),k=L)),Z-9)<<1>=Z&&(Z+4^28)<Z&&(L=Rm[u.G](u.vg),L[u.G]=function(){return Y},L.concat=function(x){Y=x},k=L),2)==(Z<<1&7)){for(p=(h=w(43,L),Y);u>Y;u--)p=p<<8|F(8,true,L);C(L,h,p)}return k},c=function(Z,Y,u,L,h,p,k,x,R){if(8<=(Z-9&(((Z+2^7)<Z&&(Z-5|69)>=Z&&(Y.Lv=void 0,Y.nv=function(){return Y.Lv?Y.Lv:Y.Lv=new Y}),(Z+9^29)<Z&&Z-1<<1>=Z&&"number"!==typeof L)&&L&&!L.X&&((k=L.src)&&k[Ys]?B(4,13,1,k.Z,L):(h=L.proxy,x=L.type,k.removeEventListener?k.removeEventListener(x,h,L.capture):k.detachEvent?k.detachEvent(Im(64,32,"on",x),h):k.addListener&&k.removeListener&&k.removeListener(h),Gy--,(p=N(13,k))?(B(4,12,1,p,L),p.A==Y&&(p.src=u,k[Ju]=u)):z(true,13,L))),31))&&25>(Z^92))a:if("string"===typeof L)R="string"!==typeof h||h.length!=Y?-1:L.indexOf(h,u);else{for(p=u;p<L.length;p++)if(p in L&&L[p]===h){R=p;break a}R=-1}return((Z|32)==Z&&(this.h=Y),Z<<2)&27||(R=Y),R},D=function(Z,Y,u,L,h,p,k,x,R,A,b,v,l,a,r,U){if(4==(Z-3&15)){if((u.h=((l=(k=(a=(h||u.Bg++,0<(A=L?255:h?5:2,u).Pg&&u.wG&&u.zt&&1>=u.Vs&&!u.o&&!u.R&&(!h||1<u.fv-p)&&0==document.hidden),4==u.Bg))||a?u.m():u.s,x=l-u.s,R=x>>Y,u.T)&&(u.T=(b=u.T,r=R*(x<<2),-2-(b|~r)-(~b|r))),R||u.h),u.ZC+=R,k)||a)u.Bg=0,u.s=l;!a||l-u.O<u.Pg-A?U=false:(u.fv=p,v=t(h?79:193,u),C(u,193,u.j),u.W.push([W_,v,h?p+1:p]),u.R=Vp,U=true)}if(Z+4>>1<Z&&(Z+8&69)>=Z)if(k&&k.once)d(33,Y,"object",x,h,k,p,L);else if(Array.isArray(h))for(R=Y;R<h.length;R++)D(64,0,false,L,h[R],p,k,x);else L=D(26,L),p&&p[Ys]?p.Z.add(String(h),L,u,H(114,k,9,"object")?!!k.capture:!!k,x):S(6,"object",false,k,p,u,x,L,h);if((((Z|24)==Z&&("function"===typeof Y?U=Y:(Y[n0]||(Y[n0]=function(e){return Y.handleEvent(e)}),U=Y[n0])),Z)+1^25)<Z&&(Z-6^22)>=Z)if(Array.isArray(p))for(R=u;R<p.length;R++)D(18,"object",0,L,h,p[R],k,x);else v=H(114,L,10,Y)?!!L.capture:!!L,h=D(28,h),x&&x[Ys]?x.Z.remove(String(p),h,v,k):x&&(b=N(14,x))&&(A=b.Mz(v,h,k,p))&&c(14,0,null,A);return(Z&57)==Z&&(M1.call(this,Y?Y.type:""),this.relatedTarget=this.currentTarget=this.target=null,this.button=this.screenY=this.screenX=this.clientY=this.clientX=this.offsetY=this.offsetX=0,this.key="",this.charCode=this.keyCode=0,this.metaKey=this.shiftKey=this.altKey=this.ctrlKey=false,this.state=null,this.pointerId=0,this.pointerType="",this.Y=null,Y&&(p=this.type=Y.type,h=Y.changedTouches&&Y.changedTouches.length?Y.changedTouches[0]:null,this.target=Y.target||Y.srcElement,this.currentTarget=u,L=Y.relatedTarget,L||("mouseover"==p?L=Y.fromElement:"mouseout"==p&&(L=Y.toElement)),this.relatedTarget=L,h?(this.clientX=void 0!==h.clientX?h.clientX:h.pageX,this.clientY=void 0!==h.clientY?h.clientY:h.pageY,this.screenX=h.screenX||0,this.screenY=h.screenY||0):(this.offsetX=Y.offsetX,this.offsetY=Y.offsetY,this.clientX=void 0!==Y.clientX?Y.clientX:Y.pageX,this.clientY=void 0!==Y.clientY?Y.clientY:Y.pageY,this.screenX=Y.screenX||0,this.screenY=Y.screenY||0),this.button=Y.button,this.keyCode=Y.keyCode||0,this.key=Y.key||"",this.charCode=Y.charCode||("keypress"==p?Y.keyCode:0),this.ctrlKey=Y.ctrlKey,this.altKey=Y.altKey,this.shiftKey=Y.shiftKey,this.metaKey=Y.metaKey,this.pointerId=Y.pointerId||0,this.pointerType="string"===typeof Y.pointerType?Y.pointerType:om[Y.pointerType]||"",this.state=Y.state,this.Y=Y,Y.defaultPrevented&&P.L.preventDefault.call(this))),U},H=function(Z,Y,u,L,h,p){return((u&Z)==u&&(L.classList?Array.prototype.forEach.call(Y,function(k){DA(false," ",5,1,"class","string",k,L)}):J(29,"class",Array.prototype.filter.call(E(L,"string",8),function(k){return!S(29,1,k,Y)}).join(" "),L)),u)-8>>3||(h=typeof Y,p=h==L&&null!=Y||"function"==h),p},J=function(Z,Y,u,L,h,p,k,x,R){if((3==(Z+((Z+5^((Z|48)==(2==Z+4>>3&&(this.C=f.document||document),Z)&&(L.B=((L.B?L.B+"~":"E:")+u.message+":"+u.stack).slice(Y,2048)),21))>=Z&&(Z-5|11)<Z&&("string"==typeof L.className?L.className=u:L.setAttribute&&L.setAttribute(Y,u)),8)&15)&&(R=Math.floor(this.mG+(this.m()-this.O))),2)==((Z^59)&15))for(x in k=Y,L.J){for(h=L.J[p=Y,x];p<h.length;p++)++k,z(u,10,h[p]);delete L.J[x],L.A--}return R},Im=function(Z,Y,u,L,h,p,k,x,R){if((8<=(Y|9)&&3>(Y>>2&8)&&(this.src=u,this.A=0,this.J={}),-42)<=Y-8&&5>((Y^14)&8))a:{switch(k){case 1:R=x?"disable":"enable";break a;case h:R=x?"highlight":"unhighlight";break a;case u:R=x?"activate":"deactivate";break a;case 8:R=x?"select":"unselect";break a;case p:R=x?"check":"uncheck";break a;case L:R=x?"focus":"blur";break a;case Z:R=x?"open":"close";break a}throw Error("Invalid component state");}return Y+9>>1<Y&&(Y+3&45)>=Y&&(R=L in mj?mj[L]:mj[L]=u+L),R},S=function(Z,Y,u,L,h,p,k,x,R,A,b,v,l,a){if(0<=Z-4>>3&&6>Z-9){if(!R)throw Error("Invalid event type");if(!(b=((v=N((l=H(114,L,11,Y)?!!L.capture:!!L,15),h))||(h[Ju]=v=new UG(h)),v.add(R,x,p,l,k)),b).proxy){if((((A=m(2,5),b).proxy=A,A).src=h,A).listener=b,h.addEventListener)EG||(L=l),void 0===L&&(L=u),h.addEventListener(R.toString(),A,L);else if(h.attachEvent)h.attachEvent(Im(64,33,"on",R.toString()),A);else if(h.addListener&&h.removeListener)h.addListener(A);else throw Error("addEventListener and attachEvent are unavailable.");Gy++}}return 1==((Z|4)&3)&&(a=0<=c(87,Y,0,L,u)),a},X4=function(Z,Y,u,L,h,p,k,x,R,A,b,v){return 1==(((Y|Z)==((Y-6|22)<Y&&Y-9<<2>=Y&&(v=(k=p[h]<<L,x=p[4+3*(h&-2)-(~h&1)+u*(~h|1)]<<16,-~(k&x)+u*(k^x)+(~k^x))|p[3*(h&u)- -1+~(h|u)+u*(h^u)]<<8|p[u*(h&3)+~h-~(h|3)+(h&-4)]),Y)&&(v=b=function(){if(h.h==h){if(h.V){var l=[N1,k,p,void 0,R,A,arguments];if(x==u)var a=p0(null,(d(13,0,l,h),h),false,254,false);else if(x==L){var r=!h.W.length;(d(76,0,l,h),r)&&p0(null,h,false,254,false)}else a=wn(l,null,h,6);return a}R&&A&&R.removeEventListener(A,b,OG)}}),Y>>2)&7)&&(k=F(8,u,L),k&128&&(k=(p=2*(k|127)- -2+~(k|127)+(~k^127),h=F(8,u,L)<<7,~p-2*~h+3*(p&~h)+(~p^h))),v=k),v},ZA=function(Z,Y,u,L,h){if("object"==(h=typeof Y,h))if(Y){if(Y instanceof Array)return"array";if(Y instanceof Object)return h;if("[object Window]"==(L=Object.prototype.toString.call(Y),L))return"object";if("[object Array]"==L||typeof Y.length==u&&"undefined"!=typeof Y.splice&&"undefined"!=typeof Y.propertyIsEnumerable&&!Y.propertyIsEnumerable("splice"))return"array";if("[object Function]"==L||"undefined"!=typeof Y.call&&"undefined"!=typeof Y.propertyIsEnumerable&&!Y.propertyIsEnumerable("call"))return"function"}else return Z;else if("function"==h&&"undefined"==typeof Y.call)return"object";return h},Ty=function(){return B_.call(this,10)},C0=function(Z,Y,u,L,h,p,k,x,R,A){for(h=w(32,(A=w((R=Y[F4]||{},Z),Y),R.kH=w(35,Y),R.I=[],p=Y.h==Y?(x=F(8,u,Y),-2-~(x|L)+(~x^L)-(~x|L)):1,Y)),k=0;k<p;k++)R.I.push(w(10,Y));for(;p--;)R.I[p]=t(R.I[p],Y);return R.DC=t(h,Y),R.qz=t(A,Y),R},So=function(Z,Y,u,L,h,p){return Au.call(this,9,Z,Y,7,u,L,h,p)},tu=function(Z,Y){return H.call(this,114,Y,16,Z)},c_=function(Z,Y,u,L,h,p,k,x,R,A,b,v,l,a,r,U,e){if((p=t(193,L),p)>=L.j)throw[f0,31];for(l=(R=0,(A=u,L).Jj).length,r=p;0<A;)v=r%8,a=r>>3,b=8-(v|0),x=b<A?b:A,e=L.D[a],Y&&(h=L,h.N!=r>>6&&(h.N=r>>6,k=t(Z,h),h.eB=im(306,255,24,[0,0,k[1],k[2]],8,h.T,h.N)),e^=L.eB[a&l]),R|=(e>>8-(v|0)-(x|0)&(1<<x)-1)<<(A|0)-(x|0),A-=x,r+=x;return C((U=R,L),193,(p|0)+(u|0)),U},q1=function(Z,Y,u,L,h){if(3==Z.length){for(h=0;3>h;h++)Y[h]+=Z[h];for(L=(u=0,[13,8,13,12,16,5,3,10,15]);9>u;u++)Y[3](Y,u%3,L[u])}},Qp=function(Z,Y,u,L,h,p){try{h=Z[((Y|0)+2)%3],Z[Y]=(L=(Z[Y]|0)-(Z[((Y|1)- -2+(Y|-2))%3]|0)-(h|0),p=1==Y?h<<u:h>>>u,(L&p)+~p-2*(~L^p)+(~L|p))}catch(k){throw k;}},YU=function(Z,Y,u,L,h,p){return C(Y,Z,($s(Z,Y,u,((p=t(Z,Y),Y.D)&&p<Y.j?(C(Y,Z,Y.j),K0(Z,Y,h)):C(Y,Z,h),L)),p)),t(332,Y)},gn=function(){return J.call(this,12)},kU=function(Z,Y){for(Y=[];Z--;)Y.push(255*Math.random()|0);return Y},p0=function(Z,Y,u,L,h,p,k,x){if(Y.W.length){Y.wG=(Y.wG&&0(),true),Y.zt=u;try{x=Y.m(),Y.O=x,Y.Bg=0,Y.s=x,p=Zg(null,6,true,0,Z,u,Y),k=Y.m()-Y.O,Y.mG+=k,k<(h?0:10)||0>=Y.Rw--||(k=Math.floor(k),Y.Tt.push(k<=L?k:254))}finally{Y.wG=false}return p}},h2=function(Z,Y,u,L,h){if(!(h=(L=u,f.trustedTypes),h)||!h.createPolicy)return L;try{L=h.createPolicy(Y,{createHTML:ub,createScript:ub,createScriptURL:ub})}catch(p){if(f.console)f.console[Z](p.message)}return L},M1=function(Z,Y){return B.call(this,4,89,Z,Y)},g=function(){return ks.call(this,4,3)},Lm=function(Z,Y,u,L,h,p,k,x,R,A){function b(v){v&&Y.appendChild("string"===typeof v?L.createTextNode(v):v)}for(A=1;A<p.length;A++)if(x=p[A],!ks(4,40,"array",Z,"object",x)||H(114,x,12,"object")&&0<x.nodeType)b(x);else{a:{if(x&&typeof x.length==Z){if(H(114,x,13,"object")){R="function"==typeof x.item||typeof x.item==h;break a}if("function"===typeof x){R="function"==typeof x.item;break a}}R=u}N(10,0,k,R?Au(9,0,x,8):x,b)}},P=function(Z,Y,u,L,h){return D.call(this,8,Z,Y,u,L,h)},pm=function(Z,Y,u){return B.call(this,4,71,Z,Y,u)},RQ=function(Z,Y,u,L,h,p,k){q(((k=(p=w(3,(h=(u=(L=(Z|0)+3- -1+~(Z|3),Z&4),w(42,Y)),Y)),t(h,Y)),u)&&(k=sj(""+k,64)),L&&q(Q(k.length,2),p,Y),k),p,Y)},ub=function(Z){return c.call(this,8,Z)},jb=function(Z,Y,u,L,h,p,k,x,R,A,b,v){((Y.push((v=(h=Z[0]<<24|Z[1]<<16,k=Z[2]<<8,-~(h&k)-1+(h^k)),x=Z[3],~v-2*~x+2*(v&~x)+(v|~x))),Y).push((A=(R=Z[4]<<24,u=Z[5]<<16,~u-2*~(R|u)+(~R|u)),b=Z[6]<<8,-(A|0)-2*~(A|b)+(~A&b)+2*(A|~b))|Z[7]),Y).push((L=Z[8]<<24,p=Z[9]<<16,-~p+2*(L&~p)+(~L|p))|Z[10]<<8|Z[11])},f=this||self,xU=function(){return B.call(this,4,48)},Q=function(Z,Y,u,L){for(L=(u=[],(Y|0)-1);0<=L;L--)u[3*(Y&-2)-2*(Y^1)+(~Y&1)-(L|0)]=Z>>8*L&255;return u},A2=function(Z,Y,u,L,h){return E.call(this,u,Z,31,Y,L,h)},rp=function(Z,Y,u,L,h,p){for(L=(Y.vg=(Y.F7=E({get:function(){return this.concat()}},(Y.Jj=(Y.SE=vf,(Y.oE=bb,Y)[L0]),Y.G),89),Rm)[Y.G](Y.F7,{value:{value:{}}}),p=0,[]);128>p;p++)L[p]=String.fromCharCode(p);p0(null,Y,(d(14,(d(77,0,(C(Y,48,(C(Y,145,(C(Y,371,(C(Y,(C(Y,(C(Y,(C(Y,(C(Y,(C(Y,498,(C(Y,231,[0,(C(Y,309,(C(Y,(C(Y,195,(C(Y,182,(C(Y,417,(C(Y,(C(Y,(C(Y,(C(Y,42,(C(Y,(C(Y,(C(Y,393,(C(Y,509,[165,(C(Y,((C(Y,100,(Y.jE=(C(Y,299,(C(Y,(C(Y,(C(Y,367,(C(Y,322,(C(Y,(C(Y,(C((Y.Gp=(C((C(Y,(C(Y,(C(Y,193,(Y.io=(Y.Bg=((Y.Ma=0,Y).wG=false,Y.cg=[],void 0),(Y.h=Y,(Y.W=[],(Y.B=(Y.o=(Y.T=void 0,Y.s=0,void 0),void 0),Y).xH=(Y.uo=[],Y.Pg=0,Y.eB=void 0,Y.N=void 0,Y.R=(Y.fv=8001,Y.Rw=25,null),Y.O=0,(h=window.performance||{},Y).j=(Y.H=void 0,Y.mG=0,0),Y.ZC=1,Y.Vs=0,Y.Tt=[],(Y.rG=function(k){return c.call(this,34,k)},Y).D=[],false),Y.zt=false,Y.V=[],h).timeOrigin||(h.timing||{}).navigationStart)||0),0)),C(Y,79,0),488),function(k,x,R,A){if(A=k.uo.pop()){for(R=F(8,true,k);0<R;R--)x=w(3,k),A[x]=k.V[x];k.V=(A[322]=k.V[A[480]=k.V[480],322],A)}else C(k,193,k.j)}),new dp("Submit"),152),function(k,x,R,A){C(k,(x=(A=(R=w(43,k),w(16,k)),w(8,k)),x),t(R,k)||t(A,k))}),Y),503,kU(4)),C(Y,318,function(k,x,R,A,b,v,l,a){C((A=t((l=(R=t((v=w((x=w(35,(b=w((a=w(10,k),16),k),k)),32),k),b),k),t(v,k)),x),k),k),a,X4(48,48,2,1,k,A,R,l))}),0),Y),64,function(k,x,R,A,b,v){C(k,(b=t((R=(A=w(11,(v=w(40,(x=w(8,k),k)),k)),t(x,k)),v),k),A),+(R==b))}),28),function(){}),452),Y),2048)),0)),480),[]),132),function(k,x,R,A,b){C(k,(A=t((b=(R=w((x=w(3,k),11),k),t(R,k)),x),k),R),b+A)}),function(k,x,R){C(k,(x=w((R=w(8,k),11),k),x),""+t(R,k))})),0),function(k){aQ(1,k)})),C)(Y,19,function(k){aQ(4,k)}),C(Y,432,function(k,x,R,A,b,v,l,a,r,U,e,G,W,V){if(!D(39,14,k,true,true,x)){if("object"==ZA((r=t((U=t((a=(b=(A=(v=w(3,(W=w(11,k),k)),w)(35,k),w(8,k)),t)(A,k),W),k),G=t(v,k),b),k),"null"),U,"number")){for(l in e=[],U)e.push(l);U=e}for(R=(a=(V=U.length,0)<a?a:1,0);R<V;R+=a)G(U.slice(R,(R|0)+(a|0)),r)}}),210),0),0),0]),function(k,x,R,A){D(71,14,k,false,true,x)||(A=w(42,k),R=w(3,k),C(k,R,function(b){return eval(b)}(lb(t(A,k.h)))))})),215),function(k,x,R,A,b,v,l,a,r,U,e,G,W,V,jo,um){function O(I,M){for(;R<I;)v|=F(8,true,k)<<R,R+=8;return v>>=(M=v&(R-=I,(1<<I)-1),I),M}for(r=(U=(b=(V=(R=(e=w(40,k),v=0),um=(O(3)|0)+1,O)(5),0),[]),0);r<V;r++)x=O(1),U.push(x),b+=x?0:1;for(A=(G=(jo=((b|0)-1).toString(2).length,[]),0);A<V;A++)U[A]||(G[A]=O(jo));for(l=0;l<V;l++)U[l]&&(G[l]=w(8,k));for(a=um,W=[];a--;)W.push(t(w(16,k),k));C(k,e,function(I,M,X,n,H_){for(M=(H_=[],X=0,[]);X<V;X++){if(!U[n=G[X],X]){for(;n>=M.length;)M.push(w(40,I));n=M[n]}H_.push(n)}I.H=w((I.o=w(23,W.slice(),I),22),H_,I)})}),332),{}),f)),351),function(k){w(5,0,4,k)}),111),function(k,x,R,A){(x=t((A=w(10,(R=w(11,k),k)),A),k),0)!=t(R,k)&&C(k,193,x)}),294),function(k,x){K0((x=t(w(42,k),k),193),k.h,x)}),function(k,x,R){x=(R=w(32,k),t(R,k.h)),x[0].removeEventListener(x[1],x[2],OG)})),[])),function(k,x,R,A,b,v){C(k,(x=(A=(b=w(34,(R=w(11,k),v=w(40,k),k)),t(R,k)),t(v,k)),b),A in x|0)})),489),function(k,x,R,A,b,v,l,a,r,U){(R=(x=t((r=t((l=(A=w((b=w(43,(v=w(10,(a=w(16,k),k)),k)),16),k),t(A,k)),b),k),a),k.h),t(v,k)),0!==x)&&(U=X4(48,49,2,1,k,l,r,1,x,R),x.addEventListener(R,U,OG),C(k,367,[x,R,U]))}),function(k,x,R,A,b){C(k,(R=ZA((b=(x=w(34,k),w(32,k)),A=t(x,k),"null"),A,"number"),b),R)})),0),0]),691)),C(Y,296,function(k,x,R,A,b){!D(23,14,k,false,true,x)&&(R=C0(34,k,true,1),A=R.DC,b=R.qz,k.h==k||b==k.rG&&A==k)&&(C(k,R.kH,b.apply(A,R.I)),k.s=k.m())}),265),function(k,x,R,A){C((R=(x=F(8,true,(A=w(42,k),k)),w(34,k)),k),R,t(A,k)>>>x)}),264),function(k,x,R,A,b){for(A=(x=(R=X4(48,6,(b=w(32,k),true),k),0),[]);x<R;x++)A.push(F(8,true,k));C(k,b,A)}),23),function(k,x,R,A,b,v){C(k,(x=t((v=(A=(b=w(16,(R=w(43,k),k)),w)(10,k),t(R,k)),b),k),A),v[x])}),404),function(k,x,R,A,b,v,l){l=w(35,(x=w(42,(b=w(35,k),k)),k)),k.h==k&&(A=t(b,k),R=t(l,k),v=t(x,k),A[v]=R,425==b&&(k.N=void 0,2==v&&(k.T=c_(425,false,32,k),k.N=void 0)))}),378),function(k){RQ(4,k)}),function(k,x,R,A,b,v,l,a,r){D(55,14,k,false,true,x)||(b=C0(34,k.h,true,1),v=b.qz,A=b.DC,a=b.kH,r=b.I,l=r.length,R=0==l?new A[v]:1==l?new A[v](r[0]):2==l?new A[v](r[0],r[1]):3==l?new A[v](r[0],r[1],r[2]):4==l?new A[v](r[0],r[1],r[2],r[3]):2(),C(k,a,R))})),function(k,x,R,A,b,v,l,a){for(b=(x=(A=t(380,(l=(v=X4(48,5,true,(a=w(34,k),k)),""),k)),A.length),0);v--;)b=(R=X4(48,7,true,k),2*(b|R)-~(b&R)+~(b|R))%x,l+=L[A[b]];C(k,a,l)})),Y.lx=0,function(k){RQ(3,k)})),d(79,0,[Dg],Y),[Hf,u]),Y),0),[Sb,Z],Y),true),254,true)},K0=function(Z,Y,u){C(Y,Z,((Y.uo.push(Y.V.slice()),Y).V[Z]=void 0,u))},Uj=function(){return S.call(this,18)},Bf=function(Z){return d.call(this,64,Z)},wn=function(Z,Y,u,L,h,p,k,x,R,A,b){if((b=Z[0],b)==hu)u.Rw=25,u.F(Z);else if(b==L0){x=Z[1];try{k=u.B||u.F(Z)}catch(v){J(49,0,v,u),k=u.B}x(k)}else if(b==W_)u.F(Z);else if(b==Hf)u.F(Z);else if(b==Sb){try{for(R=0;R<u.cg.length;R++)try{h=u.cg[R],h[0][h[1]](h[2])}catch(v){}}catch(v){}(0,Z[1])(function(v,l){u.gG(v,true,l)},(u.cg=[],function(v){d(12,0,(v=!u.W.length,[T0]),u),v&&p0(null,u,true,254,false)}))}else{if(b==N1)return p=Z[2],C(u,90,Z[L]),C(u,332,p),u.F(Z);b==T0?(u.D=[],u.V=Y,u.Tt=[]):b==Dg&&(A=f.parent,"loading"===A.document.readyState&&(u.R=function(v,l){function a(){l||(l=true,v())}((l=false,A).document.addEventListener("DOMContentLoaded",a,OG),A).addEventListener("load",a,OG)}))}},P_=function(Z,Y,u){return(u=Z.create().shift(),Y).o.create().length||Y.H.create().length||(Y.o=void 0,Y.H=void 0),u},im=function(Z,Y,u,L,h,p,k,x,R,A){for(A=L[x=(R=0,L[3]|0),2]|0;14>R;R++)k=k>>>h|k<<u,x=x>>>h|x<<u,k+=p|0,x+=A|0,p=p<<3|p>>>29,k^=A+Z,x^=R+Z,p^=k,A=A<<3|A>>>29,A^=x;return[p>>>u&Y,p>>>16&Y,p>>>h&Y,p>>>0&Y,k>>>u&Y,k>>>16&Y,k>>>h&Y,k>>>0&Y]},UG=function(Z){return Im.call(this,64,3,Z)},eb=function(){return v_.call(this,5)},sj=function(Z,Y,u,L,h,p,k,x,R,A,b,v,l,a){for(a=(h=(v=Z.replace(/\\r\\n/g,"\\n"),L=0),[]);L<v.length;L++)k=v.charCodeAt(L),128>k?a[h++]=k:(2048>k?a[h++]=(u=k>>6,(u|0)+~(u&192)- -193):(55296==(k&64512)&&L+1<v.length&&56320==(l=v.charCodeAt(L+1),64512-(~l&64512))?(k=(R=(k|1023)-2*(k&-1024)+(k|-1024)-(~k|1023)<<10,4*(65536&R)+2*~(65536&R)-(65536|~R)-(-65537|R))+(v.charCodeAt(++L)&1023),a[h++]=k>>18|240,a[h++]=k>>12&63|128):a[h++]=(p=k>>12,224-(~p^224)+(p|-225)),a[h++]=(b=(x=k>>6,-~(x&63)+(~x&63)+(x|-64)),-~b+(b&-129)-(~b^128)+2*(~b|128))),a[h++]=(A=Y+(k^63)-2*(~k&63)+(~k|63),-~A+(A^128)+(~A|128)));return a},t=function(Z,Y,u){if((u=Y.V[Z],void 0)===u)throw[f0,30,Z];if(u.value)return u.create();return u.create(5*Z*Z+43*Z+-5),u.prototype},Zg=function(Z,Y,u,L,h,p,k,x,R,A){for(;k.W.length;){x=(k.R=h,k.W.pop());try{R=wn(x,h,k,Y)}catch(b){J(52,L,b,k)}if(p&&k.R){(A=k.R,A)(function(){p0(Z,k,u,254,u)});break}}return R},C=function(Z,Y,u){if(193==Y||79==Y)Z.V[Y]?Z.V[Y].concat(u):Z.V[Y]=w(20,u,Z);else{if(Z.xH&&425!=Y)return;509==Y||503==Y||182==Y||480==Y||231==Y?Z.V[Y]||(Z.V[Y]=xs(u,6,3,Z,Y,134,60)):Z.V[Y]=xs(u,6,5,Z,Y,153,60)}425==Y&&(Z.T=c_(425,false,32,Z),Z.N=void 0)},rn=function(){return N.call(this,58)},$s=function(Z,Y,u,L,h,p,k,x){if(!Y.B){Y.Vs++;try{for(x=(p=(k=void 0,L),Y).j;--u;)try{if((h=void 0,Y).o)k=P_(Y.o,Y);else{if(p=t(Z,Y),p>=x)break;k=t((h=w((C(Y,79,p),8),Y),h),Y)}D(7,14,Y,(k&&k.call?k(Y,u):gp(L,Y,[f0,21,h],L),false),false,u)}catch(R){t(498,Y)?gp(L,Y,R,22):C(Y,498,R)}if(!u){if(Y.bo){$s(193,(Y.Vs--,Y),122147706555,0);return}gp(L,Y,[f0,33],L)}}catch(R){try{gp(L,Y,R,22)}catch(A){J(48,L,A,Y)}}Y.Vs--}},K,q=function(Z,Y,u,L,h,p,k,x,R){if(u.h==u)for(R=t(Y,u),503==Y?(k=function(A,b,v,l,a,r){if(R.O0!=(b=R.length,l=(b|0)-4>>3,l)){v=((R.O0=l,l)<<3)-4,r=[0,0,h[1],h[2]];try{R.Ax=im(306,255,24,r,8,X4(48,25,2,24,v,R),X4(48,24,2,24,(v|0)+4,R))}catch(U){throw U;}}R.push((a=R.Ax[(b|0)- -8+~(b|7)],(a|0)+~a+(a&~A)-(a|~A)))},h=t(231,u)):k=function(A){R.push(A)},L&&k((L|0)+~L- -256-(~L&255)),p=0,x=Z.length;p<x;p++)k(Z[p])},gp=function(Z,Y,u,L,h,p,k,x,R,A,b){if(!Y.xH){if(3<(p=(h=t(480,((A=void 0,u)&&u[Z]===f0&&(L=u[1],A=u[2],u=void 0),Y)),h.length==Z&&(x=t(79,Y)>>3,h.push(L,(b=x>>8,(b|255)-(b&-256)-(~b&255)),x&255),void 0!=A&&h.push((A|Z)- -256+~(A|255))),k="",u&&(u.message&&(k+=u.message),u.stack&&(k+=":"+u.stack)),t(322,Y)),p)){k=(k=k.slice(Z,(p|Z)-3),p-=(k.length|Z)+3,sj)(k,64),R=Y.h,Y.h=Y;try{q(Q(k.length,2).concat(k),503,Y,12)}finally{Y.h=R}}C(Y,322,p)}},yj=function(Z,Y){for(var u=1,L,h;u<arguments.length;u++){for(L in h=arguments[u],h)Z[L]=h[L];for(var p=0;p<z0.length;p++)L=z0[p],Object.prototype.hasOwnProperty.call(h,L)&&(Z[L]=h[L])}},IQ=function(Z,Y,u,L,h){return B_.call(this,12,Z,Y,u,L,h)},zy=function(Z){return z.call(this,Z,3)},aQ=function(Z,Y,u,L){q((L=w(43,(u=w(40,Y),Y)),Q(t(u,Y),Z)),L,Y)},dp=function(Z,Y,u){return d.call(this,6,Z,Y,u)},y=function(Z,Y,u){u=this;try{rp(Y,this,Z)}catch(L){J(50,0,L,this),Y(function(h){h(u.B)})}},F=function(Z,Y,u){return u.o?P_(u.H,u):c_(425,Y,Z,u)},T=function(Z,Y,u,L,h,p,k,x){return z.call(this,Z,31,Y,u,L,h,p,k,x)},dn="closure_uid_"+(1E9*Math.random()>>>0),am=0,eo,EG=function(Z,Y){if(!f.addEventListener||!Object.defineProperty)return false;Y=Object.defineProperty({},(Z=false,"passive"),{get:function(){Z=true}});try{f.addEventListener("test",function(){},Y),f.removeEventListener("test",function(){},Y)}catch(u){}return Z}(),om={2:(((M1.prototype.preventDefault=function(){this.defaultPrevented=true},M1.prototype).stopPropagation=(rn.prototype.lo=false,function(){this.u=true}),E)(P,2,47,M1),"touch"),3:"pen",4:"mouse"},Ys=((P.prototype.stopPropagation=function(){(P.L.stopPropagation.call(this),this.Y.stopPropagation)?this.Y.stopPropagation():this.Y.cancelBubble=true},P).prototype.preventDefault=function(Z){(P.L.preventDefault.call(this),Z=this.Y,Z.preventDefault)?Z.preventDefault():Z.returnValue=false},"closure_listenable_")+(1E6*Math.random()|0),bm=0,z0="constructor hasOwnProperty isPrototypeOf propertyIsEnumerable toLocaleString toString valueOf".split(" "),Ju="closure_lm_"+((UG.prototype.hasListener=(UG.prototype.Mz=function(Z,Y,u,L,h,p){return-1<((h=(p=-1,this.J)[L.toString()],h)&&(p=E(Y,0,6,Z,h,u)),p)?h[p]:null},(UG.prototype.remove=function(Z,Y,u,L,h,p,k){if(h=Z.toString(),!(h in this.J))return false;return(k=E(Y,0,3,(p=this.J[h],u),p,L),-1<k)?(z(true,12,p[k]),Array.prototype.splice.call(p,k,1),0==p.length&&(delete this.J[h],this.A--),true):false},UG).prototype.add=function(Z,Y,u,L,h,p,k,x,R){return-(p=(x=this.J[k=Z.toString(),k],x||(x=this.J[k]=[],this.A++),E)(Y,0,5,L,x,h),1)<p?(R=x[p],u||(R.v=false)):(R=new A2(h,this.src,!!L,Y,k),R.v=u,x.push(R)),R},function(Z,Y,u,L,h){return B(4,3,false,(L=(u=void 0!==Z)?Z.toString():"",h=void 0!==Y,true),this.J,function(p,k){for(k=0;k<p.length;++k)if(!(u&&p[k].type!=L||h&&p[k].capture!=Y))return true;return false})}),1E6*Math.random())|0),mj={},Gy=0,n0="__closure_events_fn_"+(1E9*Math.random()>>>0);((E(Ty,2,51,rn),Ty.prototype)[Ys]=true,K=Ty.prototype,K.pv=function(Z){this.Gt=Z},K.addEventListener=function(Z,Y,u,L){D(5,0,false,Y,Z,this,u,L)},K.removeEventListener=function(Z,Y,u,L){D(15,"object",0,u,Y,Z,L,this)},K).dispatchEvent=function(Z,Y,u,L,h,p,k,x,R,A,b){if(u=this.Gt)for(k=[];u;u=u.Gt)k.push(u);if(h=!((Y=(L=(p=(R=this.s0,Z),p.type||p),k),"string")===typeof p?p=new M1(p,R):p instanceof M1?p.target=p.target||R:(b=p,p=new M1(L,R),yj(p,b)),0),Y)for(x=Y.length-1;!p.u&&0<=x;x--)A=p.currentTarget=Y[x],h=d(45,true,p,L,A,true)&&h;if(p.u||(A=p.currentTarget=R,h=d(44,true,p,L,A,true)&&h,p.u||(h=d(47,true,p,L,A,false)&&h)),Y)for(x=0;!p.u&&x<Y.length;x++)A=p.currentTarget=Y[x],h=d(46,true,p,L,A,false)&&h;r... Output truncated. Text exceeds maximum line length for Command Window display.
%} 

fclose(fid); % Closing the file
rdata = jsondecode(str); % Using the jsondecode function to parse JSON from string
%Error using jsondecode
%JSON syntax error at line 1, column 1 (character 1): expected value but found '<'.
% =================== Code relavent to my question ==================


%{
Other things I tried
opts = detectImportOptions('C:/Users/Owner/Documents/Research/MonetaryPolicy/Code/onrates2.json')

str = fileread('C:/Users/Owner/Documents/Research/MonetaryPolicy/Code/onrates.json'); % dedicated for reading files as text 
data = jsondecode(str);

https://drive.google.com/drive/my-drive/ID
https://drive.google.com/drive/my-drive/'11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk'
https://accounts.google.com/spreadsheets/u/0/'11n3ptMticqVXVcMqMow2v6sZWbWlNbWtok8fEAIJUWk'/export?format=json');

s = struct(str);
rdata.Data.x1
% jsonData.Data.x1
%}

%opts = detectImportOptions('C:/Users/Owner/Documents/Research/MonetaryPolicy/Code/onrates.json'); 
%opts.DataLines = [3 8];
%opts.VariableNames = {'Timestamp','Temp',...
%                      'Humidity','Wind','Weather'};
%T_first = readtable('bigfile.txt',opts) 

%{
Ignore these prior attempts
[x,txt,raw] = xlsread('C:/Users/Owner/Documents/Research/Data/FRED/FRED_TOMO/onrates.xlsx','A2:F6430');
x = webread(url)
x=websave('onrates.xlsx',url_name);
[x,txt,raw] = xlsread('C:/Users/Owner/Documents/Research/MonetaryPolicy/Code/onrates.xlsx','A2:F6430');
 Did you mean:
x(1,:) 'C:\Users\Owner\Documents\Research\MonetaryPolicy\Code\onrates.xlsx'

url_name = strcat('https://docs.google.com/spreadsheets/d/',docid,'/export?format=xlsx');
websave('output.xlsx',url_name);

% read data from google sheets 
% https://www.mathworks.com/matlabcentral/answers/496246-import-data-from-google-sheets-to-matlab
% ID = 'bladjaljd77442n2j3ljk2j3j2jdkdjad'
% sheet_name = 'My Sheet';
% url_name = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
%    ID, sheet_name);
% sheet_data = webread(url_name);

% write matlab2sheets mat2sheets
% https://www.mathworks.com/matlabcentral/fileexchange/59359-matlab-to-google-sheets-matlab2sheets
%}

% ==================== end of relevant code for my question ===============

% TEST
% txt(1:5,:) 5×2 cell array
%    {'07/15/2022'}    {'EFFR'}
%    {'07/15/2022'}    {'OBFR'}
%    {'07/15/2022'}    {'TGCR'}
%    {'07/15/2022'}    {'BGCR'}
%    {'07/15/2022'}    {'SOFR'}

% raw(1:5,:) 5×6 cell array
%    {'07/15/2022'}    {'EFFR'}    {[1.5800]}    {[ 97]}    {[1.5000]}    {[1.7500]}
%    {'07/15/2022'}    {'OBFR'}    {[1.5700]}    {[276]}    {0×0 char}    {0×0 char}
%    {'07/15/2022'}    {'TGCR'}    {[1.5100]}    {[359]}    {0×0 char}    {0×0 char}
%    {'07/15/2022'}    {'BGCR'}    {[1.5100]}    {[368]}    {0×0 char}    {0×0 char}
%    {'07/15/2022'}    {'SOFR'}    {[1.5400]}    {[950]}    {0×0 char}    {0×0 char}


x(1:5,:)
%    1.5800   97.0000    1.5000    1.7500
%    1.5700  276.0000       NaN       NaN
%    1.5100  359.0000       NaN       NaN
%    1.5100  368.0000       NaN       NaN
%    1.5400  950.0000       NaN       NaN

% Last input rows to check
% 03/04/2016	EFFR	0.36	75	0.25	0.5	  0.34	0.36	0.37	0.52
% 03/04/2016	OBFR	0.37	325			      0.25	0.36	0.37	0.43
% 03/03/2016	EFFR	0.37	75	0.25	0.5	  0.34	0.36	0.37	0.5
% 03/03/2016	OBFR	0.37	326			      0.15	0.36	0.37	0.42
% 03/02/2016	EFFR	0.37	75	0.25	0.5	  0.33	0.36	0.37	0.45
% 03/02/2016	OBFR	0.37	333			      0.29	0.36	0.37	0.42
% 03/01/2016	EFFR	0.36	76	0.25	0.5	  0.34	0.36	0.37	0.5
% 03/01/2016	OBFR	0.37	324			0.29  0.36	0.37	0.42

% From code:
% rates(1281:1286,:) Columns 1 through 10
%    0.1000   77.0000         0    0.2500    0.0800  247.0000       NaN       NaN    0.0500  325.0000
%    0.0800  247.0000       NaN       NaN    0.0500  325.0000       NaN       NaN    0.0500  360.0000
%    0.0500  325.0000       NaN       NaN    0.0500  360.0000       NaN       NaN    0.0500  905.0000
%    0.0500  360.0000       NaN       NaN    0.0500  905.0000       NaN       NaN    0.1000   76.0000
%    0.0500  905.0000       NaN       NaN    0.1000   76.0000         0    0.2500    0.0800  262.0000
%    0.1000   76.0000         0    0.2500    0.0800  262.0000       NaN       NaN    0.0500  324.0000

% new sample size all rates for one date one row
K1 = round(5378/5) %1076  % 5ow 5380 - 2 -5378 observari
K2 = round(size(x(5361:end,1))/4) % (6430-5360)/4 = 267.5
K = K1+K2;
% error
% five rates row 2 through 
% last SOFR reading row 5380 04/02/2018	SOFR	1.8	849			1.25	1.77	1.89	2.25	
% four rates 5381 to 6430

% old sample size each rates for one date on separate rows
J1 = 5379;
J2 = 6429-5380;
J = J1 + J2;
rates=zeros(J,20);
vol=zeros(J,1);
kk=1
k=1


% from  3/01/2016 until on 3/30/2018 + EFFR, OBFR MPResultsJ2 first row
% 3/30/2018
% after 4/02/2018 until 7/15/2022 EFFR, OBFR, TGCR, BGCT, SOFR

% data with 5 rates EFFR, OBFR, TGCR, BGCT, SOFR
for j=1:J1 
    date(k,1) = txt(kk,1);
    for i=0:4
        ii=i*4 + 2; % 2     6      10     14     18
        %             0*4+2 1*4+2  2*4+2  3*4+2  4*4+2
    vol(k,i+1)= x(kk+i,ii)
    %vol(k)= vol(k) + x(kk+i,ii) get sum tot later
    end
    rates(k,1:4)= x(kk,1:4)
    rates(k,5:8)= x(kk+1,1:4)
    rates(k,9:12)= x(kk+2,1:4)
    rates(k,13:16)= x(kk+3,1:4)
    rates(k,17:20)= x(kk+4,1:4)
    for i=1:20
 end

kk = k+5
k = k+1
end


% x(5376:5380,1:4)
%OBFR    1.6800  160.0000       NaN       NaN
%TGCR    1.7700  329.0000       NaN       NaN
%BGCR    1.7700  361.0000       NaN       NaN
%SOFR	  1.8000  849.0000       NaN       NaN
%EFFR   1.6700   88.0000    1.5000    1.7500


% 04/02/2018	EFFR	1.68	89	1.5	1.75	1.65	1.68	1.69	1.81												
% 04/02/2018	OBFR	1.68	160			1.4	1.68	1.69	1.8												
% 04/02/2018	TGCR	1.77	329			1.15	1.75	1.77	1.85												
% 04/02/2018	BGCR	1.77	361			1.15	1.76	1.77	2.1												
% 04/02/2018	SOFR	1.8	849			1.25	1.77	1.89	2.25												

%txt(5376:5380,2) 5×1 cell array


%  5376/5 = 1.0752e+03
%  5380/5 = 1076
% rates(1074:1076,1:10)

% J1 data rows 1-1072
%04/02/2018	EFFR	1.68	89	1.5	1.75	1    .65	1.68	1.69	1.81
%04/02/2018	OBFR	1.68	160			1.4	    1.68	1.69	1.8
%04/02/2018	TGCR	1.77	329			1.15	1.75	1.77	1.85
%04/02/2018	BGCR	1.77	361			1.15	1.76	1.77	2.1
%04/02/2018	SOFR	1.8	    849			1.25	1.77	1.89	2.25


%rates(1067:1072,1:10)
%'OBFR'    0.0700  271.0000       NaN       NaN    0.0500  361.0000       NaN       NaN    0.0500  396.0000
%'TGCR'    0.0500  361.0000       NaN       NaN    0.0500  396.0000       NaN       NaN    0.0500  945.0000
%'BGCR'    0.0500  396.0000       NaN       NaN    0.0500  945.0000       NaN       NaN    0.0800   68.0000
%'SOFR'    0.0500  945.0000       NaN       NaN    0.0800   68.0000         0    0.2500    0.0700  267.0000
%'EFFR'    0.0800   68.0000         0    0.2500    0.0700  267.0000       NaN       NaN    0.0500  352.0000
%'OBFR'    0.0700  267.0000       NaN       NaN    0.0500  352.0000       NaN       NaN    0.0500  386.0000
% 1072-1078 0 zeros

%txt(1067:1072,2) 6×1 cell array


% ===========================================================================
%So missing a lot of the 5 rate data

%1067 09/08/2021	OBFR	0.07	276			0.04	0.06	0.08	0.12
%1068 09/08/2021	TGCR	0.05	352			0.02	0.05	0.05	0.15
%1069 09/08/2021	BGCR	0.05	377			0.02	0.05	0.05	0.15
%1070 09/08/2021	SOFR	0.05	896			0.01	0.05	0.05	0.15
%1071 09/07/2021	EFFR	0.08	71	0	0.25	0.05	0.07	0.08	0.1
%1072 09/07/2021	OBFR	0.07	271			0.04	0.06	0.08	0.12
%1073 09/07/2021	TGCR	0.05	361			0.02	0.05	0.05	0.15
%1074 09/07/2021	BGCR	0.05	396			0.02	0.05	0.05	0.15
%1075 09/07/2021	SOFR	0.05	945			0.01	0.05	0.06	0.15
%1076 09/03/2021	EFFR	0.08	68	0	0.25	0.06	0.07	0.08	0.1
%1077 09/03/2021	OBFR	0.07	267			0.05	0.06	0.08	0.12

%1078 09/03/2021	TGCR	0.05	352			0.01	0.05	0.05	0.15

%1071 09/07/2021	EFFR	0.08	71	0	0.25	0.05	0.07	0.08	0.1												
%1072 09/07/2021	OBFR	0.07	271			0.04	0.06	0.08	0.12												
%1073 09/07/2021	TGCR	0.05	361			0.02	0.05	0.05	0.15												
%1074 09/07/2021	BGCR	0.05	396			0.02	0.05	0.05	0.15												
%1075 09/07/2021	SOFR	0.05	945			0.01	0.05	0.06	0.15												
%1075 09/03/2021	EFFR	0.08	68	0	0.25	0.06	0.07	0.08	0.1												



%But these are the last rows with 5 rates in data
%5375 04/02/2018	EFFR	1.68	89	1.5	1.75	1.65	1.68	1.69	1.81												
%5376 04/02/2018	OBFR	1.68	160			1.4	1.68	1.69	1.8												
%5378 04/02/2018	TGCR	1.77	329			1.15	1.75	1.77	1.85												
%5379 04/02/2018	BGCR	1.77	361			1.15	1.76	1.77	2.1												
%5380 04/02/2018	SOFR	1.8	    849			1.25	1.77	1.89	2.25												


% Duffie Krishnamurti diverstion index D
d=zeros(J,2);
for j=1:J1
    for i=0:4
        ii=i*4 + 2
        ij=i*4 + 1 
    dn(j,i+1)=  vol(j,ii)*rates(j,ij);  % 1  5  9  13  17
    %                                   0  1  2   3   4
    d(j,1)=  d(j,1) +  dn(j,1);
    end
    for i=1:5
    d(j,i) =dn(j,i)/d(j,1);
    end
end


% running 5 day standard deviation
[y2,txt,raw] = xlsread('C:/Users/Owner/Documents/Research/MonetaryPolicy/MPRsultsJ2.xlsx','A1:F525');
y2r =flip(y2)

% weekly mean and standard deviations
jj=1;
for k=1:size(y2r,1)/5
    %for j=1:5:size(y2r,1)/5
        y2wm(k,:) = mean(y2r(y2r(jj:jj+4,:)
        y2ws(k,:) = std(y2r(y2r(jj:jj+4,:)
        jj=jj+5
end
% k = 1 jj=1: 1,2,3,4,5
% k = 2 jj=6: 6,7,8,9.10
% k = 4 jj=11: 11,12,13,14,15
%
% monthly mean and standard deviations
jj=1;
for k=1:size(y2r,1)/20
    %for j=1:20:size(y2r,1)/20
        y2mm(k,:) = mean(y2r(y2r(jj:jj+4,:)
        y2ms(k,:) = std(y2r(y2r(jj:jj+4,:)
        jj=jj+5
end
% k = 1 jj=1: 1,2,3,4,5
% k = 2 jj=6: 6,7,8,9.10
% k = 4 jj=11: 11,12,13,14,15



% =========================== OLD CODE ===============================
x = x(x(:,1)>=1929,:);
yr_r = x(:,1);
mo_r = x(:,2);
ret = x(:,3);



%x = load('data/US_Treasury_Debt_1776-2018_edited.csv');
%x = x(((x(:,1)==1928)&(x(:,2)==12))|(x(:,1)>=1929),:); % start with 1928:12 for baseline
%yr = x((x(:,1)>=1929),1);
%mo = x((x(:,1)>=1929),2);
rates = x(:,2:6); %Market Value held by public,
omv = x(:,3); % to allow rest of program to work. The distinction is not maintained with new data
clear x

% create surplus, make all series the same length

gps = -gmv(2:end)+gmv(1:end-1).*(1+ret); % nominal surplus, gross debt
ops = -omv(2:end)+omv(1:end-1).*(1+ret); % nominal surplus, outstanding debt


% plots to diagnose 2011  surpluses
if 0
    figure
    plot(datenum(yr,mo,28),[(gmv(2:end)-gmv(1:end-1))./gmv(1:end-1) ret ])
    datetick('x')
    %
    figure
    plot(datenum(yr,mo,28),filter(ones(12,1)/12,1,gps))
    hold on
    plot(datenum(yr,mo,28),filter(ones(12,1)/12,1,dgps))
    datetick('x')
    dgps = -gmv(2:end)+gmv(1:end-1);
    figure
    plot(datenum(yr,mo,28),filter(ones(12,1)/12,1,gps))
    hold on
    plot(datenum(yr,mo,28),filter(ones(12,1)/12,1,dgps))
end


gmv28 = gmv(1);
omv28 = omv(1); % save initial values for later
gmv = gmv(2:end); % eilminate 1928:12
omv = omv(2:end);

% create annual, quarterly data

Tm = size(gps,1);
ta = 1;
for t = (12:12:Tm);
    yr_a(ta) = yr(t); % year is 12/31 of that year
    mo_a(ta) = 12;
    gmv_a(ta) = gmv(t); % use end of year value
    omv_a(ta) = omv(t);
    gps_a_sum(ta) = sum(gps(t-11:t)); % sum for comparison
    ops_a_sum(ta) = sum(ops(t-11:t));
    gps_a(ta) = gps(t-11);
    ops_a(ta) = ops(t-11);
    for indx = -10:1:0; % reinvest surpluses so the identity works annual data
        gps_a(ta) = gps_a(ta)*(1+ret(t+indx)) + gps(t+indx);
        ops_a(ta) = ops_a(ta)*(1+ret(t+indx)) + ops(t+indx);
    end;
    % to check that identity works.
    if t == 12;
        gret_a(ta) = (gmv_a(ta)+gps_a(ta))/gmv28-1; %net return that makes identity hold
        oret_a(ta) = (omv_a(ta)+ops_a(ta))/omv28-1;
    else;
        gret_a(ta) = (gmv_a(ta)+gps_a(ta))/gmv_a(ta-1)-1; %net return that makes identity hold
        oret_a(ta) = (omv_a(ta)+ops_a(ta))/omv_a(ta-1)-1;
    end;
    cumret_a(ta) = prod(1+ret(t-11:t))-1; % direct cumulative return for comparison
    ta = ta+1;
end
yr_a = yr_a';
mo_a = mo_a';
gps_a_sum = gps_a_sum';
ops_a_sum = ops_a_sum';
gps_a = gps_a';
ops_a = ops_a';
gmv_a = gmv_a';
omv_a = omv_a';
gret_a = gret_a';
oret_a = oret_a';
cumret_a = cumret_a';

% diagnose 2011 -- not a problem of annualizing
if 0
    figure
    plot(datenum(yr,mo,28),filter(ones(12,1),1,gps))
    hold on
    plot(datenum(yr_a,mo_a,28),gps_a);
    plot(datenum(yr_a,mo_a,28),gps_a_sum);
end

% quarterly data. Not currently used. 
tq = 1;
for t = (3:3:Tm);
    yr_q(tq) = yr(t); % date is last mo of quarter
    mo_q(tq) = mo(t);
    omv_q(tq) = omv(t);
    ops_q_sum(tq) = sum(ops(t-2:t)); % sum for comparison
    ops_q(tq) = ops(t-2);
    for indx = -1:1:0; % reinvest surpluses
        ops_q(tq) = ops_q(tq)*(1+ret(t+indx)) + ops(t+indx);
    end;
    % to check that identity works.
    if t == 3;
        oret_q(tq) = (omv_q(tq)+ops_q(tq))/omv28-1;  %net return that makes identity hold
    else;
        oret_q(tq) = (omv_q(tq)+ops_q(tq))/omv_q(tq-1)-1; %net return that makes identity hold
    end;
    cumret_q(tq) = prod(1+ret(t-2:t))-1; % direct cumulative return for comparison
    tq = tq+1;
end

ops_q_sum = ops_q_sum(yr_q>=1947)';
ops_q = ops_q(yr_q>=1947)';
omv_q = omv_q(yr_q>=1947)';
oret_q = oret_q(yr_q>=1947)';
cumret_q = cumret_q(yr_q>=1947)';
mo_q = mo_q(yr_q>=1947)';
yr_q = yr_q(yr_q>=1947)';

%Load GDP other data, create ratios

x = load('data/GDPA.csv');
x = x(x(:,1)<=2018,:);
yr_GDP = x(:,1);
GDP = x(:,4);

x = load('data/A191RD3A086NBEA.csv');
x = x(x(:,1)<=2018,:);
GDPDEF = x(:,4)/100;
clear x

RGDP = GDP./GDPDEF; % to keep identities consistent;

x = load('data/pcecca.csv');
x = x(x(:,1)<=2018,:);
rcons = x(:,4); % real and nominal consumption. Use instead of GDP to detrend

x = load('data/pceca.csv');% 1929 on
x = x(x(:,1)<=2018,:);
ncons = x(:,4);

% take ratios

if use_consumption
    
    py_a = ncons*1e9*mean(GDP./ncons); % adjust up so units are x to GDP ratios
    Y_a = py_a./GDPDEF; % inflaiton is GDP, so keep consistent.
    
else
    disp('get_data_and_run_var: using GDP. This is nonstandard.')
    py_a = GDP*1e9;
    Y_a = py_a./GDPDEF;
end

ovy_a = omv_a./py_a;
gvy_a = gmv_a./py_a;
osy_a = ops_a./py_a;
gsy_a = gps_a./py_a;


% nipa data for comparison -- from simple_debt_graph

x = load('data/FYGFDPUB.csv');%1939-2016
% gross federal debt held by public
x = x((x(:,1)>=1929)&(x(:,1)<=2018),:);
B_yr = x(:,1);
B = x(:,4);

x = load('data/usrec.csv');
% NBER recressions
rec_yr = x(:,1);
rec_mo = x(:,2);
rec_dy = x(:,3);
rec = x(:,4);

%unemployment
x = load('data/unrate.csv'); % monthly from 194801
unm_yr = x(:,1);
unm_mo = x(:,2);
unm_dy = x(:,3);
unm = x(:,4);

x = load('data/M0892AUSM156SNBR.csv'); % early monthly data 29:04 to 42:06
unem_yr = x(:,1);
unem_mo = x(:,2);
unem_dy = x(:,3);
unem = x(:,4);

x = load('data/Q0892BUSQ156SNBR.csv'); % early quarterly data 40:04 to 46:10
uneq_yr = x(:,1);
uneq_mo = x(:,2);
une1_dy = x(:,3);
uneq = x(:,4);

% splice together to form annual unemployment conformable to yr_a

un = 0*yr_a;
un(1) = mean(unem(1:9)); %1929
for ta = 2:13; %1930:1941
    un(ta) = mean(unem((ta-2)*12+10:(ta-2)*12+21));
end;
for ta = 14:18; %1942:1946
    un(ta) = mean(uneq((ta-14)*4+8:(ta-14)*4+11));
end;
un(19) = NaN; % 1947
for ta=20:size(yr_a,1); % 1948-2018
    un(ta) = mean(unm((ta-20)*12+1:(ta-20)*12+12));
end;


x = load('data/fyfsd.csv');%1901-2017
% ferderal surplus or deficit, US OMB
x = x((x(:,1)>=1929)&(x(:,1)<=2018),:);
sg_yr = x(:,1);
sg = x(:,4);

x = load('data/A091RC1Q027SBEA.csv');%1947-2018
% federal government current expenditures, interest payments, BEA
x = x((x(:,1)>=1929)&(x(:,1)<=2018),:);
int_cost_yr = x(:,1);
int_cost = x(:,4);
% convert to annual
int_cost_yr_a = zeros(2018-1947+1,1);
int_cost_a = zeros(2018-1947+1,1);
for ta = 1947:2018;
    int_cost_yr_a(ta-1947+1) = ta;
    int_cost_a(ta-1947+1) = mean(int_cost(4*(ta-1947)+(1:4)));
end;

% form ratios in nipa data. Divide by consumpiton
% like our data

if use_consumption;
    disp('using ratios to consumption')
    sg_y = (sg/1000)./ncons/mean(GDP./ncons);
    s_y = (sg(find(sg_yr==1947):end)/1000 + int_cost_a)./...
        ncons(find(yr_a==1947):end)/mean(GDP./ncons);
    B_y = B./ncons(find(yr_a>=1939):end)/mean(GDP./ncons);
else; %  GDP for comparison
    disp('using ratios to GDP')
    sg_y = (sg/1000)./GDP;
    s_y = (sg(find(sg_yr==1947):end)/1000 + int_cost_a)./...
        GDP(find(yr_GDP==1947):end);
    B_y = B./GDP(find(yr_GDP==1939):end);
end


% quarterly data

x = load('data/gdp.csv');
gdp_q = x(:,4);
gdp_q = gdp_q(x(:,1)<=2018);

x = load('data/ngdppot.csv'); % only 1949 on
gdppot_q = x(:,4);
gdppot_q = gdppot_q(x(:,1)<=2018);

x = load('data/gdpdef.csv');
gdpdef_q = x(:,4);
gdpdef_q = gdpdef_q(x(:,1)<=2018);

rgdp_q = gdp_q./gdpdef_q;

ovy_q = omv_q./(gdp_q*1e9);
osy_q = ops_q./(gdp_q*1e9);


% interest rate data

x=load('data/crsp_riskfree_1_mo.txt');
caldt = x(:,2:4);
y1m = x(:,5);

x=load('data/crsp_riskfree_3_mo.txt');
caldt = x(:,2:4);
y = x(:,5);

y1m_a = log(1+y1m(((caldt(:,1)==12)&(caldt(:,3)<=2018)&(caldt(:,3)>=1929)),:)/100);
y_a = log(1+y(((caldt(:,1)==12)&(caldt(:,3)<=2018)&(caldt(:,3)>=1929)),:)/100);

% use last day of year for annual data

indx1 = find((caldt(:,1)==3)&(caldt(:,3)==1947));
indx2 = find((caldt(:,1)==12)&(caldt(:,3)==2018));

y1m_q = log(1+y1m(indx1:3:indx2,:)/100);
y_q = log(1+y(indx1:3:indx2,:)/100);

% long term bond data

x = load('data/GS10.csv');

y10_yr = x(:,1);
y10_mo = x(:,2);
y10_dy = x(:,3);
y10 = x(:,4);

x = load('data/ltgov.csv'); % used to extend back before 1950s
lg_yr = x(:,1);
lg_mo = x(:,2);
lg_dy = x(:,3);
lg = x(:,4);

indx_last = find((y10_yr(1)==lg_yr)&(lg_mo==y10_mo(1))&(lg_dy==y10_dy(1)));

y10_yr = [lg_yr(1:indx_last-1); y10_yr];
y10_mo = [lg_mo(1:indx_last-1); y10_mo];
y10_dy = [lg_dy(1:indx_last-1); y10_dy];
y10 = [lg(1:indx_last-1); y10];

indx1 = find( (y10_yr == 1941) & (y10_mo == 12)); % first useable date is 1942 jan 1 = 1941 year data
indx2 = find( (y10_yr == 2018) & (y10_mo == 12));

% y10_a = log(1+y10(indx1+1:12:indx2+1)/100);
% use Jan 1 year 1953 for 1952 observation since they are first of the month
y10_a = log(1+y10(indx1:12:indx2)/100);
y10_yr_a = y10_yr(indx1:12:indx2);

% this is now 1942 to 2018

% use historic Fed  data to fill in 1929 to  1940

x = load('data/FRB_H15.csv');
y10p_yr_m  = x(:,1);
y10p_mo_m = x(:,2);
y10p_m = x(:,3);
%use dec observation for the year

y10p_yr = y10p_yr_m(60:12:end);
y10p_mo = y10p_mo_m(60:12:end);
y10p = y10p_m(60:12:end);

y10p_yr = y10p_yr(1:12); % stop in 1940
y10p = y10p(1:12);


y10_a = [log(1+y10p/100) ; y10_a];
y10_yr_a = [y10p_yr; y10_yr_a];


if 0;
    figure;
    plot(datenum(caldt(:,[3 1 2])),[y1m y]);
    legend('1m','3m');
    % shows it's better to use 3 m
end;

% ---------
% linearized analysis
% form logs for analysis of linearized variables.
% ----------------

vt = log(ovy_a); % choose o or g
rnt = log(1+cumret_a);
inflt = [NaN; log(GDPDEF(2:end)./GDPDEF(1:end-1))];
grt = [NaN; log(Y_a(2:end)./Y_a(1:end-1))];
syt = osy_a;
svt = [NaN; osy_a(2:end)./ovy_a(1:end-1)];
svt_x = [ NaN; -vt(2:end)+vt(1:end-1)+rnt(2:end)-inflt(2:end)-grt(2:end)]; % use to check identities.

vt_q = log(ovy_q);
rnt_q = log(1+cumret_q);
inflt_q = [NaN; log(gdpdef_q(2:end)./gdpdef_q(1:end-1))];
grt_q = [NaN; log(rgdp_q(2:end)./rgdp_q(1:end-1))];
syt_q = osy_q;
svt_q = [NaN; osy_q(2:end)./ovy_q(1:end-1)];
svt_qx = [ NaN; -vt_q(2:end)+vt_q(1:end-1)+rnt_q(2:end)-inflt_q(2:end)-grt_q(2:end)]; % use to check identities.


%Plot data

% comparison with BEA
% moved to make_surplus_plot

if 0 % Important: if you get in mind to use quarterly data, deal with the huge seasonal shown here
    figure
    plot(eomdate(yr_q,mo_q),[ svt_q svt_qx]);
    title('Quarterly: actual sv and sv calcualted to nail identity')
    datetick('x');
end


% ------------------
% Run VAR
% -----------------

stind = find(yr_a == stdate);
stind_y10 = find(y10_yr_a == stdate);
endind = find(yr_a == enddate);
endind_y_10 = find(y10_yr_a == enddate);
disp('Using sample' )
disp([stdate enddate])

% set up data
x = [rnt(stind:endind) grt(stind:endind) inflt(stind:endind) svt_x(stind:endind) vt(stind:endind) y_a(stind:endind) y10_a(stind_y10:endind)];

lbls = {'r^n','g', '\pi','s','v','i','y'};
rni = 1; % index numbers, used later to select elments
gi = 2;
pii = 3;
svi = 4;
vi = 5;
yi = 6;
y10i = 7;
rgi = 8;
rngi = 9;

arn  = [ 1 0 0 0 0 0 0 ]'; % a'x gives elements
ag   = [ 0 1 0 0 0 0 0 ]';
api  = [ 0 0 1 0 0 0 0 ]';
asv  = [ 0 0 0 1 0 0 0 ]';
av   = [ 0 0 0 0 1 0 0 ]';
ay3  = [ 0 0 0 0 0 1 0 ]';
ay10 = [ 0 0 0 0 0 0 1 ]';

% estimate VAR
% IF you change following, mirror in bootstrap or place in function

xl  = x; %  save full sample for later use

x1 = x(2:end,:);
x = [ones(size(x,1)-1,1) x(1:end-1,:)];

b = x\x1; % Estimate by OLS
err = x1-x*b;
sigma = cov(err);
R2 = 1-var(err)./var(x1);

A = b(2:end,:)';

[Q,V] = eig(A);
if any(any(abs(V)>=1))
    % this occurs in the pre 1980 sample. This is a hack to let the
    % program run -- produces an A matrix close to the estimated one If
    % you do pre 1980. pre 1980 data dropped. If you revive a pre-1980 
    % estimation, either defend this as bayesian, or report sums
    % of first 20 or so responses rather than I-A calculations.
    disp('Removing eigenvalues greater than one')
    Aold = A;
    V2 = (abs(V) < 1).*V + (abs(V)>=1)*0.99;
    A = real(Q*V2*inv(Q));
    disp('Old and new A matrix')
    disp(Aold)
    disp(A)
end;

ImA = inv(eye(size(A,1))-A);

% end estimation
