function out = model
%
% inductor_in_circuit.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Electromagnetics_and_Circuits');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 30);
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', [15 30]);
model.geom('geom1').feature('r1').set('pos', [0 -15]);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', [3 20]);
model.geom('geom1').feature('r2').set('pos', [7.5 -10]);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', [6 22]);
model.geom('geom1').feature('r3').set('pos', [6 -11]);
model.geom('geom1').run('r3');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [2 3]);
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [1 2 3 4]);
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r3', [1 2 3 4]);
model.geom('geom1').feature('fil1').set('radius', 0.5);
model.geom('geom1').runPre('fin');

model.param.set('t', '0[s]');
model.param.descr('t', 'Time for stationary solution');
model.param.set('N', '1e3');
model.param.descr('N', 'Coil turns');
model.param.set('d_coil', '0.1[mm]');
model.param.descr('d_coil', 'Coil wire diameter');
model.param.set('sigma_coil', '5e7[S/m]');
model.param.descr('sigma_coil', 'Wire conductivity');
model.param.set('Vappl', '15[V]');
model.param.descr('Vappl', 'Supply voltage');

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.material('mat1').label('Copper');
model.material('mat1').set('family', 'copper');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'17e-6[1/K]' '0' '0' '0' '17e-6[1/K]' '0' '0' '0' '17e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8960[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '110[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.35');
model.material('mat1').propertyGroup('linzRes').set('rho0', '1.72e-8[ohm*m]');
model.material('mat1').propertyGroup('linzRes').set('alpha', '0.0039[1/K]');
model.material('mat1').propertyGroup('linzRes').set('Tref', '298[K]');
model.material('mat1').propertyGroup('linzRes').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat2').label('Low Carbon Steel 1006');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'8.41[MS/m]' '0' '0' '0' '8.41[MS/m]' '0' '0' '0' '8.41[MS/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1[1]' '0' '0' '0' '1[1]' '0' '0' '0' '1[1]'});
model.material('mat2').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'19.7407997395833' '0.0963091145833333';  ...
'38.5601479166667' '0.188022916666667';  ...
'55.53659296875' '0.27054609375';  ...
'69.7486833333333' '0.339283333333333';  ...
'80.5960114583333' '0.39121953125';  ...
'88.7623458333333' '0.429660416666667';  ...
'95.2524989583333' '0.459491927083333';  ...
'101.071283333333' '0.4856';  ...
'107.05963984375' '0.512055989583333';  ...
'113.403022916667' '0.539672916666667';  ...
'120.123015364583' '0.56844921875';  ...
'127.2412' '0.598383333333333';  ...
'134.780091666667' '0.62946640625';  ...
'142.765933333333' '0.661660416666667';  ...
'151.2259' '0.694920052083333';  ...
'160.187166666667' '0.7292';  ...
'169.678080208333' '0.764441927083333';  ...
'179.731675' '0.800535416666667';  ...
'190.382157291667' '0.83735703125';  ...
'201.663733333333' '0.874783333333333';  ...
'213.6120859375' '0.912679427083333';  ...
'226.268804166667' '0.950864583333333';  ...
'239.676953645833' '0.989146614583333';  ...
'253.8796' '1.02733333333333';  ...
'268.921667708333' '1.06522604166667';  ...
'284.855516666667' '1.1026';  ...
'301.735365625' '1.13922395833333';  ...
'319.615433333333' '1.17486666666667';  ...
'338.552277864583' '1.20930625';  ...
'358.611814583333' '1.24235833333333';  ...
'379.862298177083' '1.27384791666667';  ...
'402.371983333333' '1.3036';  ...
'426.212070052083' '1.33146223958333';  ...
'451.465539583333' '1.35737291666667';  ...
'478.218318489583' '1.38129296875';  ...
'506.556333333333' '1.40318333333333';  ...
'536.569219270833' '1.42303125';  ...
'568.361445833333' '1.44092916666667';  ...
'602.041191145833' '1.45699583333333';  ...
'637.716633333333' '1.47135';  ...
'675.500618489583' '1.4841203125';  ...
'715.524664583333' '1.495475';  ...
'757.924957552083' '1.5055921875';  ...
'802.837683333333' '1.51465';  ...
'850.404904947917' '1.52282291666667';  ...
'900.79219375' '1.53027083333333';  ...
'954.170998177083' '1.53715';  ...
'1010.71276666667' '1.54361666666667';  ...
'1070.59634661458' '1.54981510416667';  ...
'1134.03018125' '1.55584166666667';  ...
'1201.23011276042' '1.56178072916667';  ...
'1272.41198333333' '1.56771666666667';  ...
'1347.80094921875' '1.57372395833333';  ...
'1427.65942291667' '1.5798375';  ...
'1512.25913098958' '1.58608229166667';  ...
'1601.8718' '1.59248333333333';  ...
'1696.78088307292' '1.59905989583333';  ...
'1797.31673958333' '1.60580833333333';  ...
'1903.82145546875' '1.61271927083333';  ...
'2016.63711666667' '1.61978333333333';  ...
'2136.12057135417' '1.62698984375';  ...
'2262.68771666667' '1.63432291666667';  ...
'2396.76921197917' '1.64176536458333';  ...
'2538.79571666667' '1.6493';  ...
'2689.216475' '1.65690833333333';  ...
'2848.55507083333' '1.66456666666667';  ...
'3017.35367291667' '1.67225';  ...
'3196.15445' '1.67993333333333';  ...
'3385.52296744792' '1.68759453125';  ...
'3586.11837708333' '1.69522291666667';  ...
'3798.62322734375' '1.70281067708333';  ...
'4023.72006666667' '1.71035';  ...
'4262.12089895833' '1.7178359375';  ...
'4514.65555' '1.725275';  ...
'4782.18330104167' '1.7326765625';  ...
'5065.56343333333' '1.74005';  ...
'5365.69230885417' '1.74740885416667';  ...
'5683.6146125' '1.75478333333333';  ...
'6020.41210989583' '1.7622078125';  ...
'6377.16656666667' '1.76971666666667';  ...
'6755.00643177083' '1.77734348958333';  ...
'7155.2468875' '1.78511875';  ...
'7579.24979947917' '1.79307213541667';  ...
'8028.37703333333' '1.80123333333333';  ...
'8504.04922526041' '1.80963151041667';  ...
'9007.92209375' '1.81829375';  ...
'9541.71012786458' '1.82724661458333';  ...
'10107.1278166667' '1.83651666666667';  ...
'10705.9636359375' '1.84612630208333';  ...
'11340.3020083333' '1.85608125';  ...
'12012.3013432292' '1.86638307291667';  ...
'12724.12005' '1.87703333333333';  ...
'13478.0096830729' '1.88802942708333';  ...
'14276.5943770833' '1.89935208333333';  ...
'15122.5914117187' '1.91097786458333';  ...
'16018.7180666667' '1.92288333333333';  ...
'16967.8088835938' '1.93504114583333';  ...
'17973.1674520833' '1.94740833333333';  ...
'19038.2146236979' '1.95993802083333';  ...
'20166.37125' '1.97258333333333';  ...
'21361.20580625' '1.98529453125';  ...
'22626.8772625' '1.99801041666667';  ...
'23967.6922125' '2.01066692708333';  ...
'25387.95725' '2.0232';  ...
'26892.1648177083' '2.03554635416667';  ...
'28485.5507541667' '2.04764583333333';  ...
'30173.536746875' '2.0594390625';  ...
'31961.5444833333' '2.07086666666667';  ...
'33855.22961875' '2.08187630208333';  ...
'35861.1836791667' '2.09244375';  ...
'37986.2321583333' '2.10255182291667';  ...
'40237.20055' '2.11218333333333';  ...
'42621.2088973958' '2.121328125';  ...
'45146.5554416667' '2.13000416666667';  ...
'47821.8329734375' '2.13823645833333';  ...
'50655.6342833333' '2.14605';  ...
'53656.9229768229' '2.1534765625';  ...
'56836.14591875' '2.160575';  ...
'60204.1207888021' '2.1674109375';  ...
'63771.6652666667' '2.17405';  ...
'67550.0638614583' '2.1805578125';  ...
'71552.4684' '2.187';  ...
'75792.4975385417' '2.1934421875';  ...
'80283.7699333333' '2.19995';  ...
'85040.4919427083' '2.2065875';  ...
'90079.2207333333' '2.2134125';  ...
'95417.1011739583' '2.22048125';  ...
'101071.278133333' '2.22785';  ...
'107059.636354167' '2.23557161458333';  ...
'113403.020075' '2.24368541666667';  ...
'120123.013408333' '2.25222734375';  ...
'127241.200466667' '2.26123333333333';  ...
'134780.096808073' '2.27074036458333';  ...
'142765.943772917' '2.28078958333333';  ...
'151225.914147135' '2.29142317708333';  ...
'160187.180716667' '2.30268333333333';  ...
'169678.088888802' '2.31461197916667';  ...
'179731.67455625' '2.32725';  ...
'190382.146233073' '2.34063802083333';  ...
'201663.712433333' '2.35481666666667';  ...
'213612.057913021' '2.36982916666667';  ...
'226268.772395833' '2.38572916666667';  ...
'239676.921847396' '2.40257291666667';  ...
'253879.572233333' '2.42041666666667';  ...
'268790.53303474' '2.43915367374234';  ...
'283806.587794583' '2.45802522327207';  ...
'298195.263571302' '2.4761096077099';  ...
'311224.087423333' '2.49248511950988';  ...
'323854.862406094' '2.50835940392021';  ...
'343826.495562917' '2.53345751736562';  ...
'380572.169934115' '2.579633869065';  ...
'443525.06856' '2.6587428682372';  ...
'539061.160336875' '2.77879706186916';  ...
'661327.557585' '2.9324415480199';  ...
'801414.158480625' '3.10847956251649';  ...
'950410.8612' '3.29571434118602'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat2').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat2').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat2').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat2').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat2').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material('mat1').selection.set([1 2 3 4]);
model.material('mat2').selection.set([2]);

model.physics('mf').feature('init1').set('A', {'0' '1[uWb/m^2]*r' '0'});
model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').selection.set([2]);
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf').feature('als1').set('sigma', [1000 0 0 0 1000 0 0 0 1000]);
model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([4]);
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('sigmaCoil', 'sigma_coil');
model.physics('mf').feature('coil1').set('ICoil', 0.1);
model.physics('mf').feature('coil1').set('N', 'N');
model.physics('mf').feature('coil1').set('AreaFrom', 'Diameter');
model.physics('mf').feature('coil1').set('coilWindDiameter', 'd_coil');

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('size').set('hnarrow', 4);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg1').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg1').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg1').feature('str1').feature.create('filt1', 'Filter');
model.result('pg1').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg1').feature.create('con1', 'Contour');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('solutionparams', 'parent');
model.result('pg1').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg1').feature('con1').set('titletype', 'none');
model.result('pg1').feature('con1').set('number', 10);
model.result('pg1').feature('con1').set('levelrounding', false);
model.result('pg1').feature('con1').set('coloring', 'uniform');
model.result('pg1').feature('con1').set('colorlegend', false);
model.result('pg1').feature('con1').set('color', 'custom');
model.result('pg1').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg1').feature('con1').set('resolution', 'fine');
model.result('pg1').feature('con1').set('inheritcolor', false);
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('data', 'parent');
model.result('pg1').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').feature('con1').feature.create('filt1', 'Filter');
model.result('pg1').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'none');
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('data', 'dset1');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Magnetic Flux Density Norm, Revolved Geometry (mf)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').set('data', 'rev1');
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('vol1').set('colorcalibration', -0.8);
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('solutionparams', 'parent');
model.result('pg2').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg2').feature('con1').set('titletype', 'none');
model.result('pg2').feature('con1').set('number', 10);
model.result('pg2').feature('con1').set('levelrounding', false);
model.result('pg2').feature('con1').set('coloring', 'uniform');
model.result('pg2').feature('con1').set('colorlegend', false);
model.result('pg2').feature('con1').set('color', 'custom');
model.result('pg2').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg2').feature('con1').set('resolution', 'fine');
model.result('pg2').feature('con1').set('inheritcolor', false);
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature('con1').set('inheritplot', 'vol1');
model.result('pg2').feature('con1').feature.create('filt1', 'Filter');
model.result('pg2').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg2').feature('con1').feature('filt1').set('shownodespec', 'on');
model.result('pg1').run;

model.physics('mf').feature.duplicate('coil2', 'coil1');
model.physics('mf').feature('coil2').set('CoilExcitation', 'CircuitCurrent');
model.physics('mf').feature('coil2').set('CoilName', '1');
model.physics.create('cir', 'Circuit', 'geom1');
model.physics('cir').model('comp1');

model.study('std1').feature('stat').setSolveFor('/physics/cir', false);
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/mf', true);
model.study('std2').feature('stat').setSolveFor('/physics/cir', true);

model.physics('cir').feature.create('VIN', 'VoltageSource');
model.physics('cir').feature('VIN').set('Connections', {'1' '0'});
model.physics('cir').feature('VIN').label('Voltage Source VIN');
model.physics('cir').feature('VIN').set('sourceType', 'SineSource');
model.physics('cir').feature('VIN').set('offset', '0.0');
model.physics('cir').feature('VIN').set('value', '1.0');
model.physics('cir').feature('VIN').set('freq', '10000.0');
model.physics('cir').feature.create('VCC', 'VoltageSource');
model.physics('cir').feature('VCC').set('Connections', {'4' '0'});
model.physics('cir').feature('VCC').label('Voltage Source VCC');
model.physics('cir').feature('VCC').set('sourceType', 'DC');
model.physics('cir').feature('VCC').set('value', '15.0');
model.physics('cir').feature.create('RG', 'Resistor');
model.physics('cir').feature('RG').set('Connections', {'1' '2'});
model.physics('cir').feature('RG').label('Resistor RG');
model.physics('cir').feature('RG').set('R', '100.0');
model.physics('cir').feature.create('CIN', 'Capacitor');
model.physics('cir').feature('CIN').set('Connections', {'2' '3'});
model.physics('cir').feature('CIN').label('Capacitor CIN');
model.physics('cir').feature('CIN').set('C', '9.999999999999999E-6');
model.physics('cir').feature.create('R1', 'Resistor');
model.physics('cir').feature('R1').set('Connections', {'4' '3'});
model.physics('cir').feature('R1').label('Resistor R1');
model.physics('cir').feature('R1').set('R', '47000.0');
model.physics('cir').feature.create('R2', 'Resistor');
model.physics('cir').feature('R2').set('Connections', {'3' '0'});
model.physics('cir').feature('R2').label('Resistor R2');
model.physics('cir').feature('R2').set('R', '10000.0');
model.physics('cir').feature.create('RE', 'Resistor');
model.physics('cir').feature('RE').set('Connections', {'7' '0'});
model.physics('cir').feature('RE').label('Resistor RE');
model.physics('cir').feature('RE').set('R', '1000.0');
model.physics('cir').feature.create('COUT', 'Capacitor');
model.physics('cir').feature('COUT').set('Connections', {'5' '6'});
model.physics('cir').feature('COUT').label('Capacitor COUT');
model.physics('cir').feature('COUT').set('C', '9.999999999999999E-6');
model.physics('cir').feature.create('RL', 'Resistor');
model.physics('cir').feature('RL').set('Connections', {'6' '0'});
model.physics('cir').feature('RL').label('Resistor RL');
model.physics('cir').feature('RL').set('R', '10000.0');
model.physics('cir').feature.create('Q1', 'BjtNpn');
model.physics('cir').feature('Q1').set('Connections', {'5' '3' '7'});
model.physics('cir').feature('Q1').label('NPN Bipolar Junction Transistor Q1');
model.physics('cir').feature('Q1').set('IS', '1.5000000000000002E-14');
model.physics('cir').feature('Q1').set('ISE', '1.5000000000000002E-14');
model.physics('cir').feature('Q1').set('ISC', '0.0');
model.physics('cir').feature('Q1').set('BF', '260.0');
model.physics('cir').feature('Q1').set('BR', '6.1');
model.physics('cir').feature('Q1').set('IKF', '0.3');
model.physics('cir').feature('Q1').set('NE', '1.3');
model.physics('cir').feature('Q1').set('NC', '2.0');
model.physics('cir').feature('Q1').set('RC', '1.0');
model.physics('cir').feature('Q1').set('RB', '10.0');
model.physics('cir').feature('Q1').set('CJC', '7.5E-12');
model.physics('cir').feature('Q1').set('MJC', '0.35');
model.physics('cir').feature('Q1').set('VJC', '0.75');
model.physics('cir').feature('Q1').set('FC', '0.5');
model.physics('cir').feature('Q1').set('CJE', '2.0E-11');
model.physics('cir').feature('Q1').set('MJE', '0.4');
model.physics('cir').feature('Q1').set('VJE', '0.75');
model.physics('cir').feature('Q1').set('VAF', '75.0');
model.physics('cir').create('IvsU1', 'ModelDeviceIV', -1);
model.physics('cir').feature('IvsU1').setIndex('Connections', 4, 0, 0);
model.physics('cir').feature('IvsU1').setIndex('Connections', 5, 1, 0);
model.physics('cir').feature('VCC').set('value', 'Vappl');

model.study('std1').feature('stat').set('useadvanceddisable', true);
model.study('std1').feature('stat').set('disabledphysics', {'mf/coil2' 'cir'});
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('tlist', 'range(0,5e-6,5e-4)');
model.study('std2').feature('time').set('usertol', true);
model.study('std2').feature('time').set('rtol', '1e-4');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'mf/coil1'});
model.study('std2').feature('stat').set('useparam', true);
model.study('std2').feature('stat').setIndex('pname', 't', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 's', 0);
model.study('std2').feature('stat').setIndex('pname', 't', 0);
model.study('std2').feature('stat').setIndex('plistarr', '', 0);
model.study('std2').feature('stat').setIndex('punit', 's', 0);
model.study('std2').feature('stat').setIndex('pname', 'Vappl', 0);
model.study('std2').feature('stat').setIndex('plistarr', 'range(1,15)', 0);
model.study('std2').feature('stat').set('useadvanceddisable', true);
model.study('std2').feature('stat').set('disabledphysics', {'mf/coil1'});

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').set('stol', 0.001);
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').feature.remove('pDef');
model.sol('sol2').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol2').feature('s1').set('control', 'stat');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol2').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol2').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('s1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol2').feature('s1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 1);
model.sol('sol2').feature('s1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol2').feature('s1').feature('fc1').set('jtech', 'onevery');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').create('su1', 'StoreSolution');
model.sol('sol2').create('st2', 'StudyStep');
model.sol('sol2').feature('st2').set('study', 'std2');
model.sol('sol2').feature('st2').set('studystep', 'time');
model.sol('sol2').create('v2', 'Variables');
model.sol('sol2').feature('v2').set('initmethod', 'sol');
model.sol('sol2').feature('v2').set('initsol', 'sol2');
model.sol('sol2').feature('v2').set('initsoluse', 'sol3');
model.sol('sol2').feature('v2').set('notsolmethod', 'sol');
model.sol('sol2').feature('v2').set('notsol', 'sol2');
model.sol('sol2').feature('v2').set('notsoluse', 'sol3');
model.sol('sol2').feature('v2').set('control', 'time');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').set('tlist', 'range(0,5e-6,5e-4)');
model.sol('sol2').feature('t1').set('plot', 'off');
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').set('plotfreq', 'tout');
model.sol('sol2').feature('t1').set('probesel', 'all');
model.sol('sol2').feature('t1').set('probes', {});
model.sol('sol2').feature('t1').set('probefreq', 'tsteps');
model.sol('sol2').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol2').feature('t1').set('rtol', 1.0E-4);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol2').feature('t1').set('atolglobalfactor', 0.1);
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol2').feature('t1').set('eventtol', 0.01);
model.sol('sol2').feature('t1').set('reacf', true);
model.sol('sol2').feature('t1').set('storeudot', true);
model.sol('sol2').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol2').feature('t1').set('endtimeinterpolation', true);
model.sol('sol2').feature('t1').set('estrat', 'exclude');
model.sol('sol2').feature('t1').set('maxorder', 5);
model.sol('sol2').feature('t1').set('minorder', 1);
model.sol('sol2').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol2').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol2').feature('t1').set('control', 'time');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').create('seDef', 'Segregated');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('t1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol2').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol2').feature('t1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('t1').feature('fc1').set('rstep', 10);
model.sol('sol2').feature('t1').feature('fc1').set('useminsteprecovery', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('t1').feature('fc1').set('minstep', 1.0E-4);
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('ntolfact', 0.2);
model.sol('sol2').feature('t1').feature('fc1').set('ntermauto', 'tol');
model.sol('sol2').feature('t1').feature('fc1').set('initstep', 1);
model.sol('sol2').feature('t1').feature('fc1').set('minsteprecovery', 0.75);
model.sol('sol2').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol2').feature('t1').feature.remove('fcDef');
model.sol('sol2').feature('t1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').set('stol', '1e-6');
model.sol('sol2').feature('t1').set('atolglobalvaluemethod', 'manual');
model.sol('sol2').feature('t1').set('atolglobal', '1e-6');

model.physics('cir').feature('IvsU1').set('V_src', 'root.comp1.mf.VCoil_1');

model.sol('sol2').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Magnetic Flux Density Norm (mf) 1');
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').set('dataisaxisym', 'off');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset2');
model.result('pg3').setIndex('looplevel', 101, 0);
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('surf1').set('colorcalibration', -0.8);
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('solutionparams', 'parent');
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.03);
model.result('pg3').feature('str1').set('maxlen', 0.4);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('solutionparams', 'parent');
model.result('pg3').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg3').feature('con1').set('titletype', 'none');
model.result('pg3').feature('con1').set('number', 10);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('coloring', 'uniform');
model.result('pg3').feature('con1').set('colorlegend', false);
model.result('pg3').feature('con1').set('color', 'custom');
model.result('pg3').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg3').feature('con1').set('resolution', 'fine');
model.result('pg3').feature('con1').set('inheritcolor', false);
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg3').feature('con1').set('inheritplot', 'surf1');
model.result('pg3').feature('con1').feature.create('filt1', 'Filter');
model.result('pg3').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').set('data', 'none');
model.result.dataset('rev2').set('startangle', -90);
model.result.dataset('rev2').set('revangle', 225);
model.result.dataset('rev2').set('data', 'dset2');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Magnetic Flux Density Norm, Revolved Geometry (mf) 1');
model.result('pg4').set('data', 'rev2');
model.result('pg4').setIndex('looplevel', 101, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsmaxmin', true);
model.result('pg4').set('data', 'rev2');
model.result('pg4').setIndex('looplevel', 101, 0);
model.result('pg4').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg4').feature.create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('solutionparams', 'parent');
model.result('pg4').feature('vol1').set('colortable', 'Prism');
model.result('pg4').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('vol1').set('colorcalibration', -0.8);
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('data', 'parent');
model.result('pg4').feature.create('con1', 'Contour');
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('solutionparams', 'parent');
model.result('pg4').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg4').feature('con1').set('titletype', 'none');
model.result('pg4').feature('con1').set('number', 10);
model.result('pg4').feature('con1').set('levelrounding', false);
model.result('pg4').feature('con1').set('coloring', 'uniform');
model.result('pg4').feature('con1').set('colorlegend', false);
model.result('pg4').feature('con1').set('color', 'custom');
model.result('pg4').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg4').feature('con1').set('resolution', 'fine');
model.result('pg4').feature('con1').set('inheritcolor', false);
model.result('pg4').feature('con1').set('showsolutionparams', 'on');
model.result('pg4').feature('con1').set('data', 'parent');
model.result('pg4').feature('con1').set('inheritplot', 'vol1');
model.result('pg4').feature('con1').feature.create('filt1', 'Filter');
model.result('pg4').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg4').feature('con1').feature('filt1').set('shownodespec', 'on');
model.result('pg3').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('data', 'dset2');
model.result('pg5').setIndex('looplevelinput', 'manual', 0);
model.result('pg5').setIndex('looplevel', [81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101], 0);
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Time (s)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Voltage (V)');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').setIndex('expr', 'cir.VIN_v', 0);
model.result('pg5').feature('glob1').setIndex('expr', 'cir.IvsU1_v', 1);
model.result('pg5').feature('glob1').setIndex('expr', 'cir.RL_v', 2);
model.result('pg5').feature('glob1').set('linemarker', 'cycle');
model.result('pg5').feature('glob1').set('markerpos', 'interp');
model.result('pg5').run;
model.result('pg5').label('Voltages');

model.title('Inductor in an Amplifier Circuit');

model.description(['This example shows how to combine an electric circuit simulation with a finite element simulation. The finite element model is an inductor with a nonlinear magnetic core and 1000' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'turns, where the number of turns is modeled using a distributed current technique.' newline 'The circuit is imported into COMSOL Multiphysics as a SPICE netlist, which merges the inductor model and the circuit elements as ODEs.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('inductor_in_circuit.mph');

model.modelNode.label('Components');

out = model;
