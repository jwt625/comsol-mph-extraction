function out = model
%
% small_signal_analysis_of_inductor.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Inductive');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('mf', 'InductionCurrents', 'geom1');
model.physics('mf').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/mf', true);
model.study('std1').create('frlin', 'Frequencylinearized');
model.study('std1').feature('frlin').set('outputmap', {});
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').set('ngenAUX', '1');
model.study('std1').feature('frlin').set('goalngenAUX', '1');
model.study('std1').feature('frlin').setSolveFor('/physics/mf', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('dr', '3[cm]', 'Domain radius');
model.param.set('il', '2[cm]', 'Inductor length');
model.param.set('cr', '5[mm]', 'Core radius');
model.param.set('fr', '0.5[mm]', 'Fillet radius');
model.param.set('coor', '10.5[mm]', 'Coil, outer radius');
model.param.set('coir', '7.5[mm]', 'Coil, inner radius');
model.param.set('cwc', 'pi*(0.05[mm])^2', 'Coil, wire cross section');
model.param.set('cn', '1000', 'Coil, number of turns');
model.param.set('f0', '10[kHz]', 'Operating frequency');
model.param.set('csigma', '5e7[S/m]', 'Coil, wire conductivity');
model.param.set('cIdc', '10[mA]', 'DC current bias');
model.param.set('cIac', '1[mA]', 'AC current perturbation');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 'dr');
model.geom('geom1').feature('c1').set('angle', 180);
model.geom('geom1').feature('c1').set('rot', -90);
model.geom('geom1').run('c1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'3*cr' 'il*1.5'});
model.geom('geom1').feature('r1').set('pos', {'0' '-il*1.5/2'});
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').set('size', {'coor-coir' 'il'});
model.geom('geom1').feature('r2').set('pos', {'coir' '-il/2'});
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').set('size', {'(coor-coir)*2' '1'});
model.geom('geom1').feature('r3').setIndex('size', 'il*1.1', 1);
model.geom('geom1').feature('r3').set('pos', {'coir*0.8' '-il/2*1.1'});
model.geom('geom1').run('r3');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r1', [2 3]);
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r2', [1 2 3 4]);
model.geom('geom1').feature('fil1').selection('pointinsketch').set('r3', [1 2 3 4]);
model.geom('geom1').feature('fil1').set('radius', 'fr');
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.physics('mf').create('als1', 'AmperesLawSolid', 2);
model.physics('mf').feature('als1').label('Nonlinear Core');
model.physics('mf').feature('als1').selection.set([2]);
model.physics('mf').feature('als1').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('mf').feature('als1').set('sigma_mat', 'userdef');
model.physics('mf').feature('als1').set('sigma', [1000 0 0 0 1000 0 0 0 1000]);
model.physics('mf').create('coil1', 'Coil', 2);
model.physics('mf').feature('coil1').selection.set([4]);
model.physics('mf').feature('coil1').set('CoilName', 'coil');
model.physics('mf').feature('coil1').set('ConductorModel', 'Multi');
model.physics('mf').feature('coil1').set('N', 'cn');
model.physics('mf').feature('coil1').set('sigmaCoil', 'csigma');
model.physics('mf').feature('coil1').set('coilWindArea', 'cwc');
model.physics('mf').feature('coil1').set('ICoil', 'cIdc');
model.physics('mf').feature('coil1').create('hp1', 'CoilHarmonicPerturbation', -1);
model.physics('mf').feature('coil1').feature('hp1').set('ICoil', 'cIac');

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
model.material('mat1').selection.set([4]);
model.material('mat2').selection.set([2]);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('mur', 'mf.normB/(mu0_const*mf.normH)');
model.variable('var1').descr('mur', 'Relative Permeability');

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'dr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'dr', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'cIdc', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(1,1,50)', 0);
model.study('std1').feature('stat').setIndex('punit', 'mA', 0);
model.study('std1').feature('frlin').set('punit', 'kHz');
model.study('std1').feature('frlin').set('plist', 'f0');
model.study('std1').feature('frlin').set('useparam', true);
model.study('std1').feature('frlin').setIndex('pname_aux', 'dr', 0);
model.study('std1').feature('frlin').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('frlin').setIndex('punit_aux', 'm', 0);
model.study('std1').feature('frlin').setIndex('pname_aux', 'dr', 0);
model.study('std1').feature('frlin').setIndex('plistarr_aux', '', 0);
model.study('std1').feature('frlin').setIndex('punit_aux', 'm', 0);
model.study('std1').feature('frlin').setIndex('pname_aux', 'cIdc', 0);
model.study('std1').feature('frlin').setIndex('plistarr_aux', 'range(1,1,50)', 0);
model.study('std1').feature('frlin').setIndex('punit_aux', 'mA', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s1').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'frlin');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'frlin');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('pname', {'freq' 'cIdc'});
model.sol('sol1').feature('s2').feature('p1').set('punit', {'kHz' 'mA'});
model.sol('sol1').feature('s2').feature('p1').set('sweeptype', 'filled');
model.sol('sol1').feature('s2').feature('p1').set('plistarr', {'f0' 'range(1,1,50)'});
model.sol('sol1').feature('s2').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pcontinuation', '');
model.sol('sol1').feature('s2').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s2').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s2').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s2').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s2').feature('p1').set('probes', {});
model.sol('sol1').feature('s2').feature('p1').set('control', 'frlin');
model.sol('sol1').feature('s2').set('nonlin', 'linper');
model.sol('sol1').feature('s2').set('storelinpoint', true);
model.sol('sol1').feature('s2').set('linpsolnum', 'all');
model.sol('sol1').feature('s2').set('control', 'frlin');
model.sol('sol1').feature('s2').set('linpmethod', 'sol');
model.sol('sol1').feature('s2').set('linpsol', 'sol1');
model.sol('sol1').feature('s2').set('linpsoluse', 'sol2');
model.sol('sol1').feature('s2').set('control', 'frlin');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s2').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 100);
model.sol('sol1').feature('s2').feature('fc1').set('ntolfact', 1);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-6');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Magnetic Flux Density Norm (mf)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 50, 0);
model.result('pg1').setIndex('looplevel', 1, 1);
model.result('pg1').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('evalmethodactive', 'off');
model.result('pg1').feature('surf1').set('colortable', 'Prism');
model.result('pg1').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('surf1').set('colorcalibration', -0.8);
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('evalmethodactive', 'off');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('evalmethodactive', 'off');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('evalmethodactive', 'off');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('evalmethodactive', 'off');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('solutionparams', 'parent');
model.result('pg1').feature('str1').set('evalmethodactive', 'off');
model.result('pg1').feature('str1').set('titletype', 'none');
model.result('pg1').feature('str1').set('posmethod', 'uniform');
model.result('pg1').feature('str1').set('udist', 0.03);
model.result('pg1').feature('str1').set('maxlen', 0.4);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('inheritcolor', false);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('evalmethodactive', 'off');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('evalmethodactive', 'off');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('evalmethodactive', 'off');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('evalmethodactive', 'off');
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 1);
model.result('pg1').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27]);
model.result('pg1').feature('str1').set('inheritplot', 'surf1');
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('evalmethodactive', 'off');
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
model.result('pg1').feature('con1').set('evalmethodactive', 'off');
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
model.result('pg1').feature('con1').set('evalmethodactive', 'off');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('evalmethodactive', 'off');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('evalmethodactive', 'off');
model.result('pg1').feature('con1').set('showsolutionparams', 'on');
model.result('pg1').feature('con1').set('evalmethodactive', 'off');
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
model.result('pg2').setIndex('looplevel', 50, 0);
model.result('pg2').setIndex('looplevel', 1, 1);
model.result('pg2').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond3/pg1');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('solutionparams', 'parent');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('colortable', 'Prism');
model.result('pg2').feature('vol1').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('vol1').set('colorcalibration', -0.8);
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('showsolutionparams', 'on');
model.result('pg2').feature('vol1').set('evalmethodactive', 'off');
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('solutionparams', 'parent');
model.result('pg2').feature('con1').set('expr', 'r*mf.Aphi');
model.result('pg2').feature('con1').set('evalmethodactive', 'off');
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
model.result('pg2').feature('con1').set('evalmethodactive', 'off');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('evalmethodactive', 'off');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('evalmethodactive', 'off');
model.result('pg2').feature('con1').set('showsolutionparams', 'on');
model.result('pg2').feature('con1').set('evalmethodactive', 'off');
model.result('pg2').feature('con1').set('data', 'parent');
model.result('pg2').feature('con1').set('inheritplot', 'vol1');
model.result('pg2').feature('con1').feature.create('filt1', 'Filter');
model.result('pg2').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg2').feature('con1').feature('filt1').set('shownodespec', 'on');
model.result('pg1').run;
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').run;
model.result('pg3').label('Coil Inductance');
model.result('pg3').create('glob1', 'Global');
model.result('pg3').feature('glob1').set('markerpos', 'datapoints');
model.result('pg3').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('glob1').set('expr', {'mf.LCoil_coil'});
model.result('pg3').feature('glob1').set('descr', {'Coil inductance'});
model.result('pg3').feature('glob1').set('unit', {'H'});
model.result('pg3').feature('glob1').set('xdata', 'expr');
model.result('pg3').feature('glob1').set('xdataexpr', 'cIdc');
model.result('pg3').feature('glob1').set('xdataunit', 'mA');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'mur');
model.result('pg1').feature('surf1').set('descr', 'Relative Permeability');
model.result('pg1').feature('surf1').set('evalmethod', 'linpoint');
model.result('pg1').run;

model.physics('mf').feature('coil1').set('ICoil', 'cIdc + linper(cIac)');
model.physics('mf').feature('coil1').feature('hp1').active(false);

model.sol('sol1').runAll;

model.result('pg1').run;

model.title('Small-Signal Analysis of an Inductor');

model.description('A magnetic material in the core of an inductor influences the inductance. If the magnetic material is nonlinear the inductance depends on the current through the inductor. This example analyzes the small-signal behavior of an inductance with a nonlinear core, and investigates how the small-signal inductance depends on the DC current.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('small_signal_analysis_of_inductor.mph');

model.modelNode.label('Components');

out = model;
