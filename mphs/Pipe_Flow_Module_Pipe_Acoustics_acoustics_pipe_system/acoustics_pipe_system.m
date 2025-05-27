function out = model
%
% acoustics_pipe_system.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Pipe_Flow_Module/Pipe_Acoustics');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').insertFile('acoustics_pipe_system_geom_sequence.mph', 'geom1');
model.geom('geom1').run('fin');

model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(3);
model.view('view1').hideObjects('hide1').add('fin', [1]);
model.view('view1').hideObjects('hide1').add('fin', [2]);
model.view('view1').hideObjects('hide1').add('fin', [3]);
model.view('view1').set('hidestatus', 'showonlyhidden');
model.view('view1').hideObjects.clear;
model.view('view1').hideObjects.create('hide1');
model.view('view1').hideObjects('hide1').init(3);
model.view('view1').hideObjects('hide1').add('fin', [4]);
model.view('view1').hideObjects('hide1').add('fin', [5]);
model.view('view1').hideObjects('hide1').add('fin', [6]);
model.view('view1').set('hidestatus', 'ignore');
model.view('view1').hideObjects.clear;

model.param.label('Geometry');
model.param.create('par2');
model.param('par2').label('Model Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('f0', '120[Hz]', 'Signal frequency');
model.param('par2').set('c0', '1500[m/s]', 'Speed of sound');
model.param('par2').set('lam0', 'c0/f0', 'Wavelength at f0');
model.param('par2').set('T0', '1/f0', 'Period at f0');
model.param('par2').set('Tend', '2.5*lbent/c0', 'Simulation end time');
model.param('par2').set('Lprop', 'c0*Tend', 'Propagation length at Tend');
model.param('par2').set('lbent', 'L1+L3', 'Total distance to the bend');

model.func.create('rect1', 'Rectangle');
model.func('rect1').model('comp1');
model.func('rect1').set('lower', '0.5*T0');
model.func('rect1').set('upper', '3*T0');
model.func('rect1').set('smooth', 'T0');
model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').label('Volume force');
model.func('an1').set('funcname', 'volforc');
model.func('an1').set('expr', 'rect1(t[1/s])*sin(2*pi*f0*t)');
model.func('an1').set('args', 't');
model.func('an1').setIndex('argunit', 's', 0);
model.func('an1').set('fununit', 'N/m^3');
model.func('an1').setIndex('plotargs', '3.5*T0', 0, 2);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').label('1D Pipes');
model.selection('sel1').geom(1);
model.selection('sel1').set([1 2 20 37 60]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').label('Pipe Ends');
model.selection('sel2').geom(0);
model.selection('sel2').set([1 11 38]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat1').label('Water, liquid');
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat1').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat1').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat1').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat1').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat2').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat2').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat2').label('Water, liquid 1');
model.material('mat2').set('family', 'water');
model.material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat2').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat2').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat2').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat2').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat2').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat2').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat2').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat2').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat2').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat2').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat2').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat2').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat2').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat2').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat2').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat2').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat2').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat2').propertyGroup('def').set('density', 'rho(T)');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('rho', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat3').propertyGroup('def').func.create('cs', 'Interpolation');
model.material('mat3').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat3').propertyGroup('def').func.create('an3', 'Analytic');
model.material('mat3').label('Water, liquid 2');
model.material('mat3').set('family', 'water');
model.material('mat3').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.material('mat3').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.material('mat3').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat3').propertyGroup('def').func('rho').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.material('mat3').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.material('mat3').propertyGroup('def').func('rho').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat3').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat3').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.material('mat3').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat3').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat3').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.material('mat3').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.material('mat3').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.material('mat3').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat3').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.material('mat3').propertyGroup('def').func('an1').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat3').propertyGroup('def').func('an1').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.material('mat3').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.material('mat3').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an2').set('fununit', '1');
model.material('mat3').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat3').propertyGroup('def').func('an3').set('funcname', 'muB');
model.material('mat3').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.material('mat3').propertyGroup('def').func('an3').set('args', {'T'});
model.material('mat3').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.material('mat3').propertyGroup('def').func('an3').set('argunit', {'K'});
model.material('mat3').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.material('mat3').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat3').propertyGroup('def').set('bulkviscosity', '');
model.material('mat3').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.material('mat3').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat3').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat3').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]' '0' '0' '0' '5.5e-6[S/m]'});
model.material('mat3').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat3').propertyGroup('def').set('density', 'rho(T)');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat3').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat3').propertyGroup('def').addInput('temperature');
model.material('mat2').selection.geom('geom1', 1);
model.material('mat2').selection.named('sel1');
model.material('mat3').selection.geom('geom1', 2);
model.material('mat3').selection.set([1]);

model.physics.create('patd', 'TransientPipeAcoustics', 'geom1');
model.physics('patd').model('comp1');
model.physics.create('actd', 'TransientPressureAcoustics', 'geom1');
model.physics('actd').model('comp1');
model.physics.create('acbm', 'BoundaryModeAcoustics', 'geom1');
model.physics('acbm').model('comp1');
model.physics.create('pafd', 'FrequencyPipeAcoustics', 'geom1');
model.physics('pafd').model('comp1');
model.physics.create('acpr', 'PressureAcoustics', 'geom1');
model.physics('acpr').model('comp1');
model.physics('patd').selection.named('sel1');
model.physics('patd').prop('TransientSettings').set('fmax', 'f0');
model.physics('patd').feature('pipe1').set('shape', 'Round');
model.physics('patd').feature('pipe1').set('innerd', 'Di');
model.physics('patd').create('pipe2', 'PipeProperties', 1);
model.physics('patd').feature('pipe2').selection.set([20]);
model.physics('patd').feature('pipe2').set('shape', 'Round');
model.physics('patd').feature('pipe2').set('innerd', 'Di*2/3');
model.physics('patd').create('endimp1', 'EndImpedance', 0);
model.physics('patd').feature('endimp1').selection.named('sel2');
model.physics('patd').create('vf1', 'VolumeForce', 1);
model.physics('patd').feature('vf1').selection.set([1]);
model.physics('patd').feature('vf1').set('F', {'volforc(t)' '0' '0'});
model.physics('actd').prop('TransientSettings').set('fmax', 'f0');
model.physics('acbm').selection.set([1]);
model.physics('pafd').selection.named('sel1');
model.physics('pafd').feature('pipe1').set('shape', 'Round');
model.physics('pafd').feature('pipe1').set('innerd', 'Di');
model.physics('pafd').create('pipe2', 'PipeProperties', 1);
model.physics('pafd').feature('pipe2').selection.set([20]);
model.physics('pafd').feature('pipe2').set('shape', 'Round');
model.physics('pafd').feature('pipe2').set('innerd', 'Di*2/3');
model.physics('pafd').create('endimp1', 'EndImpedance', 0);
model.physics('pafd').feature('endimp1').selection.named('sel2');
model.physics('pafd').create('vf1', 'VolumeForce', 1);
model.physics('pafd').feature('vf1').selection.set([1]);
model.physics('pafd').feature('vf1').set('F', [1 0 0]);

model.multiphysics.create('apc1', 'AcousticPipeAcousticConnection', 'geom1', -1);
model.multiphysics.create('apc2', 'AcousticPipeAcousticConnection', 'geom1', -1);
model.multiphysics('apc2').set('Acoustics_physics', 'acpr');
model.multiphysics('apc2').set('Pipe_physics', 'pafd');

model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 'min(lam0/12,Di/2)');
model.mesh('mesh1').feature('size').set('hmin', 'min(lam0/24,Di/6)');
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.named('sel1');
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([1]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'Di/12');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'Di/12');
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/patd', true);
model.study('std1').feature('time').setSolveFor('/physics/actd', true);
model.study('std1').feature('time').setSolveFor('/physics/acbm', false);
model.study('std1').feature('time').setSolveFor('/physics/pafd', false);
model.study('std1').feature('time').setSolveFor('/physics/acpr', false);
model.study('std1').feature('time').setSolveFor('/multiphysics/apc1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/apc2', false);
model.study('std1').feature('time').set('tlist', 'range(0,T0/24,Tend)');
model.study('std1').setGenPlots(false);
model.study('std1').label('Study 1 - Pipe System Transient');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,T0/24,Tend)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 1.0E-4);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'manual');
model.sol('sol1').feature('t1').set('timestepgenalpha', 'min(1/(60*f0),1/(60*f0))');
model.sol('sol1').feature('t1').set('timestepbdf', 'min(1/(60*f0),1/(60*f0))');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('timemethod', 'genalpha');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', 'min(1/(100*f0),1/(100*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintbdf', 'const');
model.sol('sol1').feature('t1').set('maxstepbdf', 'min(min(1e100,1/(30*f0)),1/(30*f0))');
model.sol('sol1').feature('t1').set('initialstepgenalphaactive', true);
model.sol('sol1').feature('t1').set('initialstepgenalpha', 'min(1/(100*f0),1/(100*f0))');
model.sol('sol1').feature('t1').set('maxstepconstraintgenalpha', 'const');
model.sol('sol1').feature('t1').set('maxstepgenalpha', 'min(min(1e100,1/(30*f0)),1/(30*f0))');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.study.create('std2');
model.study('std2').create('mode', 'ModeAnalysis');
model.study('std2').feature('mode').set('chkeigregion', true);
model.study('std2').feature('mode').set('conrad', '1');
model.study('std2').feature('mode').set('conradynhm', '1');
model.study('std2').feature('mode').set('storefact', false);
model.study('std2').feature('mode').set('linpsolnum', 'auto');
model.study('std2').feature('mode').set('solnum', 'auto');
model.study('std2').feature('mode').set('notsolnum', 'auto');
model.study('std2').feature('mode').set('outputmap', {});
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').set('ngenAUX', '1');
model.study('std2').feature('mode').set('goalngenAUX', '1');
model.study('std2').feature('mode').setSolveFor('/physics/patd', false);
model.study('std2').feature('mode').setSolveFor('/physics/actd', false);
model.study('std2').feature('mode').setSolveFor('/physics/acbm', true);
model.study('std2').feature('mode').setSolveFor('/physics/pafd', false);
model.study('std2').feature('mode').setSolveFor('/physics/acpr', false);
model.study('std2').feature('mode').setSolveFor('/multiphysics/apc1', false);
model.study('std2').feature('mode').setSolveFor('/multiphysics/apc2', false);
model.study('std2').label('Study 2 - Mode Analysis Cut on/off');
model.study('std2').setGenPlots(false);
model.study('std2').feature('mode').set('modeFreq', 'f0');
model.study('std2').feature('mode').set('neigsactive', true);
model.study('std2').feature('mode').set('neigs', 10);
model.study('std2').feature('mode').set('shiftactive', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'mode');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'mode');
model.sol('sol2').create('e1', 'Eigenvalue');
model.sol('sol2').feature('e1').set('neigs', 6);
model.sol('sol2').feature('e1').set('shift', '0');
model.sol('sol2').feature('e1').set('rtol', 1.0E-6);
model.sol('sol2').feature('e1').set('transform', 'none');
model.sol('sol2').feature('e1').set('eigref', '0');
model.sol('sol2').feature('e1').set('eigvfunscale', 'average');
model.sol('sol2').feature('e1').set('control', 'mode');
model.sol('sol2').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol2').feature('e1').feature('aDef').set('cachepattern', false);
model.sol('sol2').feature('e1').feature('aDef').set('matherr', true);
model.sol('sol2').feature('e1').feature('aDef').set('blocksizeactive', false);
model.sol('sol2').feature('e1').feature('aDef').set('nullfun', 'auto');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.study.create('std3');
model.study('std3').create('freq', 'Frequency');
model.study('std3').feature('freq').setSolveFor('/physics/patd', false);
model.study('std3').feature('freq').setSolveFor('/physics/actd', false);
model.study('std3').feature('freq').setSolveFor('/physics/acbm', false);
model.study('std3').feature('freq').setSolveFor('/physics/pafd', true);
model.study('std3').feature('freq').setSolveFor('/physics/acpr', true);
model.study('std3').feature('freq').setSolveFor('/multiphysics/apc1', false);
model.study('std3').feature('freq').setSolveFor('/multiphysics/apc2', true);
model.study('std3').label('Study 3 - Pipe System Frequency Domain');
model.study('std3').setGenPlots(false);
model.study('std3').feature('freq').set('plist', 'f0');

model.sol.create('sol3');
model.sol('sol3').study('std3');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std3');
model.sol('sol3').feature('st1').set('studystep', 'freq');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').set('control', 'freq');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 0.001);
model.sol('sol3').feature('s1').create('p1', 'Parametric');
model.sol('sol3').feature('s1').feature.remove('pDef');
model.sol('sol3').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol3').feature('s1').feature('p1').set('plistarr', {'f0'});
model.sol('sol3').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol3').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol3').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol3').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol3').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol3').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol3').feature('s1').feature('p1').set('probes', {});
model.sol('sol3').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol3').feature('s1').set('linpmethod', 'sol');
model.sol('sol3').feature('s1').set('linpsol', 'zero');
model.sol('sol3').feature('s1').set('control', 'freq');
model.sol('sol3').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol3').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s1').feature('aDef').set('matherr', true);
model.sol('sol3').feature('s1').feature('aDef').set('blocksizeactive', false);
model.sol('sol3').feature('s1').create('seDef', 'Segregated');
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').feature('s1').feature.remove('seDef');
model.sol('sol3').attach('std3');
model.sol('sol3').runAll;

model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').set('data', 'dset2');
model.result.dataset('surf1').selection.set([1]);
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').run;
model.result('pg1').label('Acoustic Pressure (patd)');
model.result('pg1').setIndex('looplevel', 73, 0);
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Pressure (Pa)');
model.result('pg1').set('paramindicator', 'Time= eval(t,s) s');
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('rangecoloractive', true);
model.result('pg1').feature('line1').set('rangecolormin', -0.005);
model.result('pg1').feature('line1').set('rangecolormax', 0.005);
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').feature('line1').set('radiusexpr', '0.5*patd.dh');
model.result('pg1').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('line1').set('colortable', 'Wave');
model.result('pg1').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg1').feature('line1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('line1').feature('def1').set('expr', {'0' '0' 'p'});
model.result('pg1').feature('line1').feature('def1').set('descractive', true);
model.result('pg1').feature('line1').feature('def1').set('descr', '20');
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'p2');
model.result('pg1').feature('surf1').set('inheritplot', 'line1');
model.result('pg1').feature('surf1').create('def1', 'Deform');
model.result('pg1').run;
model.result('pg1').feature('surf1').feature('def1').set('expr', {'0' '0' 'p2'});
model.result('pg1').run;
model.result('pg1').create('tlan1', 'TableAnnotation');
model.result('pg1').feature('tlan1').set('source', 'localtable');
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L1+Lj/2', 0, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 0, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point A', 0, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-Lj/2', 1, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L2', 1, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 1, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point B', 1, 3);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'L3', 2, 0);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', '-L4', 2, 1);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 0, 2, 2);
model.result('pg1').feature('tlan1').setIndex('localtablematrix', 'Point C', 2, 3);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 145, 0);
model.result('pg1').setIndex('looplevel', 217, 0);
model.result('pg1').setIndex('looplevel', 289, 0);
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result('pg2').label('Acoustic Pressure in Points');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Pressure at various points (Pa)');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Time (s)');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('ylabel', 'Pressure (Pa)');
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr1').set('linewidth', 'preference');
model.result('pg2').feature('ptgr1').label('Point A');
model.result('pg2').feature('ptgr1').selection.set([2]);
model.result('pg2').feature('ptgr1').set('legend', true);
model.result('pg2').feature('ptgr1').set('autoplotlabel', true);
model.result('pg2').feature('ptgr1').set('autopoint', false);
model.result('pg2').feature('ptgr1').set('autosolution', false);
model.result('pg2').run;
model.result('pg2').create('ptgr2', 'PointGraph');
model.result('pg2').feature('ptgr2').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr2').set('linewidth', 'preference');
model.result('pg2').feature('ptgr2').label('Point B');
model.result('pg2').feature('ptgr2').selection.set([11]);
model.result('pg2').feature('ptgr2').set('expr', 'p+1[Pa]');
model.result('pg2').feature('ptgr2').set('legend', true);
model.result('pg2').feature('ptgr2').set('autoplotlabel', true);
model.result('pg2').feature('ptgr2').set('autopoint', false);
model.result('pg2').feature('ptgr2').set('autosolution', false);
model.result('pg2').feature('ptgr2').set('legendsuffix', ' (offset by 1 Pa)');
model.result('pg2').run;
model.result('pg2').create('ptgr3', 'PointGraph');
model.result('pg2').feature('ptgr3').set('markerpos', 'datapoints');
model.result('pg2').feature('ptgr3').set('linewidth', 'preference');
model.result('pg2').feature('ptgr3').label('Point C');
model.result('pg2').feature('ptgr3').selection.set([38]);
model.result('pg2').feature('ptgr3').set('expr', 'p+2[Pa]');
model.result('pg2').feature('ptgr3').set('legend', true);
model.result('pg2').feature('ptgr3').set('autoplotlabel', true);
model.result('pg2').feature('ptgr3').set('autopoint', false);
model.result('pg2').feature('ptgr3').set('autosolution', false);
model.result('pg2').feature('ptgr3').set('legendsuffix', ' (offset by 2 Pa)');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Mode Analysis Pressure (acbm)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'p3');
model.result('pg3').feature('surf1').set('colortable', 'Wave');
model.result('pg3').feature('surf1').set('colorscalemode', 'linearsymmetric');
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Acoustic Pressure (pafd)');
model.result('pg4').set('data', 'dset3');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Pressure (Pa)');
model.result('pg4').set('paramindicator', 'freq =eval(freq,Hz) Hz');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', 'p4');
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('radiusexpr', '0.5*pafd.dh');
model.result('pg4').feature('line1').set('tuberadiusscaleactive', true);
model.result('pg4').feature('line1').set('colortable', 'Wave');
model.result('pg4').feature('line1').set('colorscalemode', 'linearsymmetric');
model.result('pg4').feature('line1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('line1').feature('def1').set('expr', {'0' '0' 'p4'});
model.result('pg4').feature('line1').feature('def1').set('scaleactive', true);
model.result('pg4').feature('line1').feature('def1').set('scale', 2);
model.result('pg4').run;
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'p5');
model.result('pg4').feature('surf1').set('inheritplot', 'line1');
model.result('pg4').feature('surf1').create('def1', 'Deform');
model.result('pg4').run;
model.result('pg4').feature('surf1').feature('def1').set('expr', {'0' '0' 'p5'});
model.result('pg4').run;
model.result('pg4').run;

model.title('Acoustics of a Pipe System with 3D Bend and Junction');

model.description(['This tutorial shows how to model the propagation of acoustic waves in large pipe systems by coupling the Pipe Acoustics interface to the Pressure Acoustics interface. The tutorial is set up in both the time domain and the frequency domain.' newline  newline '1D pipe acoustics is used to model the propagation in the long straight pipe portions. A 3D model of a pipe junction and pipe bend is coupled to the 1D pipe model in order to model these parts in detail.' newline  newline 'This kind of model can be used to model and predict the response of pipe systems, such as when detecting leaks or deformations, for example, and is relevant in the oil and gas industry and in water delivery pipe systems.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;

model.label('acoustics_pipe_system.mph');

model.modelNode.label('Components');

out = model;
