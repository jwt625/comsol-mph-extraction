function out = model
%
% microstrip_line_mixed_mode.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/RF_Module/EMI_EMC_Applications');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.physics('emw').model('comp1');

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').set('solnum', 'auto');
model.study('std1').feature('freq').set('notsolnum', 'auto');
model.study('std1').feature('freq').set('outputmap', {});
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').set('ngenAUX', '1');
model.study('std1').feature('freq').set('goalngenAUX', '1');
model.study('std1').feature('freq').setSolveFor('/physics/emw', true);

model.param.set('sub_l', '15[mm]');
model.param.descr('sub_l', 'Substrate length');
model.param.set('sub_w', '15[mm]');
model.param.descr('sub_w', 'Substrate width');
model.param.set('sub_t', '20[mil]');
model.param.descr('sub_t', 'Substrate thickness');
model.param.set('line_w', '1.13[mm]');
model.param.descr('line_w', 'Line width');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'sub_l' 'sub_w' 'sub_t'});
model.geom('geom1').feature('blk1').set('pos', {'0' '0' 'sub_t/2'});
model.geom('geom1').feature('blk1').set('base', 'center');
model.geom('geom1').run('blk1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickz', 'sub_t');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'5' 'line_w'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', 45);
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.feature.duplicate('r2', 'r1');
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'sub_l/2-5/2/sqrt(2)+line_w/2/sqrt(2)' 'line_w'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'-sub_l/2+(sub_l/2-5/2/sqrt(2)+line_w/2/sqrt(2))/2' '0'});
model.geom('geom1').feature('wp1').geom.feature('r2').setIndex('pos', '-5/2/sqrt(2)+(line_w/2-line_w/2/sqrt(2))', 1);
model.geom('geom1').feature('wp1').geom.run('r2');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'r2'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('keep', true);
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', 180);
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').feature('wp1').geom.create('uni1', 'Union');
model.geom('geom1').feature('wp1').geom.feature('uni1').selection('input').set({'r2' 'rot1' 'rot2'});
model.geom('geom1').feature('wp1').geom.feature('uni1').set('intbnd', false);
model.geom('geom1').feature('wp1').geom.run('uni1');
model.geom('geom1').feature('wp1').geom.create('mov1', 'Move');
model.geom('geom1').feature('wp1').geom.feature('mov1').selection('input').set({'uni1'});
model.geom('geom1').feature('wp1').geom.feature('mov1').set('disply', 3);
model.geom('geom1').feature('wp1').geom.run('mov1');
model.geom('geom1').feature('wp1').geom.create('mir1', 'Mirror');
model.geom('geom1').feature('wp1').geom.feature('mir1').selection('input').set({'mov1'});
model.geom('geom1').feature('wp1').geom.feature('mir1').set('axis', [0 1]);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.feature('mir1').set('keep', true);
model.geom('geom1').feature('wp1').geom.run('mir1');
model.geom('geom1').feature('wp1').geom.create('r3', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r3').set('size', {'2' 'line_w'});
model.geom('geom1').feature('wp1').geom.feature('r3').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('r3');
model.geom('geom1').feature('wp1').geom.create('rot3', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot3').selection('input').set({'r3'});
model.geom('geom1').feature('wp1').geom.feature('rot3').set('rot', -45);
model.geom('geom1').feature('wp1').geom.run('rot3');
model.geom('geom1').feature('wp1').geom.create('mov2', 'Move');
model.geom('geom1').feature('wp1').geom.feature('mov2').selection('input').set({'rot3'});
model.geom('geom1').feature('wp1').geom.feature('mov2').set('disply', -3);
model.geom('geom1').feature('wp1').geom.run('mov2');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'mir1'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'mov2'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'sub_t', 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('tor1', 'Torus');
model.geom('geom1').feature('tor1').set('rmaj', 1.3);
model.geom('geom1').feature('tor1').set('rmin', 0.15);
model.geom('geom1').feature('tor1').set('angle', 180);
model.geom('geom1').feature('tor1').set('pos', {'0' '0' 'sub_t'});
model.geom('geom1').feature('tor1').set('axistype', 'y');
model.geom('geom1').feature('tor1').set('rot', 90);
model.geom('geom1').run('tor1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'tor1'});
model.geom('geom1').feature('rot1').set('rot', -45);
model.geom('geom1').run('rot1');
model.geom('geom1').create('mov1', 'Move');
model.geom('geom1').feature('mov1').selection('input').set({'rot1'});
model.geom('geom1').feature('mov1').set('disply', -3);
model.geom('geom1').run('mov1');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'sub_l+4[mm]' '1' '1'});
model.geom('geom1').feature('blk2').setIndex('size', 'sub_w+2[mm]', 1);
model.geom('geom1').feature('blk2').setIndex('size', 'sub_t*15', 2);
model.geom('geom1').feature('blk2').set('pos', {'-sub_l/2-2[mm]' '0' '0'});
model.geom('geom1').feature('blk2').setIndex('pos', '-sub_w/2-1[mm]', 1);
model.geom('geom1').feature('blk2').setIndex('pos', '-1[mm]', 2);
model.geom('geom1').runPre('fin');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').selection.set([2 3 4 5 7]);
model.material('mat2').propertyGroup('def').set('relpermittivity', {'3.38'});
model.material('mat2').propertyGroup('def').set('relpermeability', {'1'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});

model.physics('emw').create('pec2', 'PerfectElectricConductor', 2);
model.physics('emw').feature('pec2').selection.set([8 12 13 18 19 22 31 32 33 34 35 36 37 38 41 42]);
model.physics('emw').create('lport1', 'LumpedPort', 2);
model.physics('emw').feature('lport1').selection.set([16]);
model.physics('emw').create('lport2', 'LumpedPort', 2);
model.physics('emw').feature('lport2').selection.set([52]);
model.physics('emw').create('lport3', 'LumpedPort', 2);
model.physics('emw').feature('lport3').selection.set([10]);
model.physics('emw').create('lport4', 'LumpedPort', 2);
model.physics('emw').feature('lport4').selection.set([50]);
model.physics('emw').create('sctr1', 'Scattering', 2);
model.physics('emw').feature('sctr1').selection.set([1 2 3 4 5 54]);

model.view('view1').set('renderwireframe', false);
model.view('view1').set('transparency', true);

model.physics('emw').create('mms1', 'MixedModeSparameters', -1);
model.physics('emw').feature('mms1').set('portB', 3);
model.physics('emw').feature('mms1').set('portC', 2);
model.physics('emw').prop('PortSweepSettings').set('useSweep', true);

model.param('default').setShowInParamSel(true);
model.param.set('PortName', '1');

model.study('std1').create('param1', 'Parametric');
model.study('std1').feature('param1').set('pname', 'PortName');
model.study('std1').feature('param1').set('plistarr', '1 2 3 4');

model.mesh('mesh1').run;

model.view('view1').set('transparency', false);
model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom('geom1', 2);
model.view('view1').hideEntities('hide1').set([1 2 4]);

model.study('std1').feature('freq').set('plist', 'range(1[GHz],0.5[GHz],3[GHz])');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(1[GHz],0.5[GHz],3[GHz])'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'GHz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'right');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', '300');
model.sol('sol1').feature('s1').feature('i1').label('Suggested Iterative Solver (emw)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('iter', '1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('prefun', 'sorvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sv1', 'SORVector');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('prefun', 'soruvec');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('relax', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sv1').set('sorvecdof', {'comp1_E'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std1');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'PortName'});
model.batch('p1').set('plistarr', {'1 2 3 4'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std1');
model.batch('p1').set('control', 'param1');

model.sol.create('sol2');
model.sol('sol2').study('std1');
model.sol('sol2').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').run('compute');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 5, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').set('data', 'dset2');
model.result('pg1').setIndex('looplevel', 5, 0);
model.result('pg1').setIndex('looplevel', 4, 1);
model.result('pg1').set('defaultPlotID', 'ElectromagneticWaves/phys1/pdef1/pcond1/pg1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').label('Multislice');
model.result('pg1').feature('mslc1').set('smooth', 'internal');
model.result('pg1').feature('mslc1').set('data', 'parent');
model.result('pg1').feature('mslc1').feature.create('filt1', 'Filter');
model.result('pg1').feature('mslc1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset2');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {'' '' '' '' '' '' '' '' '' ''  ...
'' '' '' '' '' ''});
model.result('pg2').feature('glob1').set('expr', {'emw.S11dB' 'emw.S12dB' 'emw.S13dB' 'emw.S14dB' 'emw.S21dB' 'emw.S22dB' 'emw.S23dB' 'emw.S24dB' 'emw.S31dB' 'emw.S32dB'  ...
'emw.S33dB' 'emw.S34dB' 'emw.S41dB' 'emw.S42dB' 'emw.S43dB' 'emw.S44dB'});
model.result('pg2').feature('glob1').set('descr', {'S11' 'S12' 'S13' 'S14' 'S21' 'S22' 'S23' 'S24' 'S31' 'S32'  ...
'S33' 'S34' 'S41' 'S42' 'S43' 'S44'});
model.result('pg2').label('S-parameter (emw)');
model.result('pg2').feature('glob1').set('titletype', 'none');
model.result('pg2').feature('glob1').set('xdata', 'expr');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'S-parameter (dB)');
model.result('pg2').feature('glob1').set('xdataexpr', 'freq');
model.result('pg2').feature('glob1').set('xdataunit', 'GHz');
model.result('pg2').feature('glob1').set('markerpos', 'datapoints');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'all');
model.result('pg2').feature('glob1').active(true);
model.result.create('pg3', 'SmithGroup');
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('rgr1', 'ReflectionGraph');
model.result('pg3').feature('rgr1').set('unit', {'' '' '' ''});
model.result('pg3').feature('rgr1').set('expr', {'emw.S11' 'emw.S22' 'emw.S33' 'emw.S44'});
model.result('pg3').feature('rgr1').set('descr', {'S11' 'S22' 'S33' 'S44'});
model.result('pg3').label('Smith Plot (emw)');
model.result('pg3').feature('rgr1').set('titletype', 'manual');
model.result('pg3').feature('rgr1').set('title', 'Reflection Graph: S-parameter, Color: Frequency (GHz)');
model.result('pg3').feature('rgr1').set('linemarker', 'point');
model.result('pg3').feature('rgr1').set('markerpos', 'datapoints');
model.result('pg3').feature('rgr1').create('col1', 'Color');
model.result('pg3').feature('rgr1').feature('col1').set('expr', 'emw.freq/1e9');
model.result('pg3').feature('rgr1').feature('col1').set('colortable', 'Spectrum');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mslc1').active(false);
model.result('pg1').run;
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').feature('vol1').create('sel1', 'Selection');
model.result('pg1').feature('vol1').feature('sel1').selection.set([2 3 4 5 6 7]);
model.result('pg1').run;
model.result('pg1').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('vol1').set('colortabletrans', 'reverse');
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('legendpos', 'lowerright');
model.result('pg2').run;
model.result('pg2').feature('glob1').set('expr', {});
model.result('pg2').feature('glob1').set('descr', {});
model.result('pg2').feature('glob1').set('expr', {'emw.Scc11dB'});
model.result('pg2').feature('glob1').set('descr', {'Scc11'});
model.result('pg2').feature('glob1').set('expr', {'emw.Scc11dB' 'emw.Scd12dB'});
model.result('pg2').feature('glob1').set('descr', {'Scc11' 'Scd12'});
model.result('pg2').feature('glob1').set('expr', {'emw.Scc11dB' 'emw.Scd12dB' 'emw.Sdc21dB'});
model.result('pg2').feature('glob1').set('descr', {'Scc11' 'Scd12' 'Sdc21'});
model.result('pg2').feature('glob1').set('expr', {'emw.Scc11dB' 'emw.Scd12dB' 'emw.Sdc21dB' 'emw.Sdd22dB'});
model.result('pg2').feature('glob1').set('descr', {'Scc11' 'Scd12' 'Sdc21' 'Sdd22'});
model.result('pg2').feature('glob1').set('linemarker', 'cycle');
model.result('pg2').run;

model.title('Mixed-Mode S-Parameters Analysis');

model.description('Mixed-mode S-parameters describe the responses of a circuit with balanced ports excited and terminated by two types of modes: common and differential modes. They are calculated using a full S-parameter matrix of a four-port network that is composed of four single-ended lines. This example analyzes two adjacent microstrip lines and computes the mixed-mode S-parameters.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('microstrip_line_mixed_mode.mph');

model.modelNode.label('Components');

out = model;
