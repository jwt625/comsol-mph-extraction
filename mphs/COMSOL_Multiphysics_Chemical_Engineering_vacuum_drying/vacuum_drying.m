function out = model
%
% vacuum_drying.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Chemical_Engineering');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('c', 'CoefficientFormPDE', 'geom1', {'thetaL'});
model.physics('c').prop('EquationForm').set('form', 'Automatic');
model.physics('c').field('dimensionless').field('theta');
model.physics('c').prop('Units').set('CustomSourceTermUnit', '1/s');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/c', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('A', '5.31384', 'Constant in Antoine equation');
model.param.set('alpha', '1e-6[m^2/s]', 'Proportionality constant for apparent diffusion coefficient');
model.param.set('B', '1690.864[K]', 'Constant in Antoine equation');
model.param.set('C', '-51.804[K]', 'Constant in Antoine equation');
model.param.set('CpG', '1[kJ/(kg*K)]', 'Specific heat capacity, gas');
model.param.set('CpL', '2.544[kJ/(kg*K)]', 'Specific heat capacity, liquid');
model.param.set('CpS', '2060[J/(kg*K)]', 'Specific heat capacity, solid');
model.param.set('deltaH', '9780[cal/mol]/Mn', 'Latent heat of vaporization');
model.param.set('H0', '10[cm]', 'Cake depth');
model.param.set('hq', '10[W/(m^2*K)]', 'Wall heat transfer coefficient');
model.param.set('kvap', '1e-6[1/s]', 'Evaporation rate constant');
model.param.set('lambda_dry', '.058[W/(m*K)]', 'Effective thermal conductivity, dry cake');
model.param.set('lambda_wet', '.1[W/(m*K)]', 'Effective thermal conductivity, wet cake');
model.param.set('Mn', '60.1[g/mol]', 'Molar mass');
model.param.set('pG', '15[mbar]', 'Head-space pressure');
model.param.set('R0', '40[cm]', 'Cake radius');
model.param.set('rhoG', '1[kg/m^3]', 'Density, gas');
model.param.set('rhoL', '787.4[kg/m^3]', 'Density, liquid');
model.param.set('rhoS', '1000[kg/m^3]', 'Density, solid');
model.param.set('T0', '20[degC]', 'Initial temperature');
model.param.set('Th', '60[degC]', 'Jacket temperature');
model.param.set('thetaL_star', '.05', 'Residual saturation');
model.param.set('thetaS', '0.7', 'Solid phase volume fraction');
model.param.set('wL0', '.20', 'Initial moisture content');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('mdot', 'kvap*rhoL*(p_star-pG)/pG*step2(thetaL)*step1(p_star/pG)', 'Evaporation rate');
model.variable('var1').set('p_star', '10^(A-B/(C+T))*1e5[Pa]', 'Vapor pressure from Antoine equation');
model.variable('var1').set('thetaG', '1-thetaL-thetaS', 'Volume fraction of gas');
model.variable('var1').set('DL', 'alpha*(thetaL-thetaL_star)*step1(thetaL/thetaL_star)', 'Apparent moisture diffusivity');
model.variable('var1').set('thetaL0', 'thetaS*(rhoS/rhoL)*(wL0/(1-wL0))', 'Initial volume fraction of liquid');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', 1.005);
model.func('step1').set('smooth', 0.01);
model.func.create('step2', 'Step');
model.func('step2').model('comp1');
model.func('step2').set('location', 0.005);
model.func('step2').set('smooth', 0.01);

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'R0' 'H0'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run;

model.material.create('mpmat1', 'Multiphase', 'comp1');
model.material('mpmat1').feature('phase1').label('Constrained Gas Phase');
model.material('mpmat1').feature('phase1').propertyGroup('def').set('thermalconductivity', {'lambda_dry/(1-thetaS)'});
model.material('mpmat1').feature('phase1').propertyGroup('def').set('density', {'rhoG'});
model.material('mpmat1').feature('phase1').propertyGroup('def').set('heatcapacity', {'CpG'});
model.material('mpmat1').feature.create('phase2', 'PhaseLink', 'comp1');
model.material('mpmat1').feature('phase2').label('Liquid Phase');
model.material('mpmat1').feature('phase2').set('Vf', 'thetaL');
model.material('mpmat1').feature('phase2').propertyGroup('def').set('thermalconductivity', {'lambda_wet/(1-thetaS)'});
model.material('mpmat1').feature('phase2').propertyGroup('def').set('density', {'rhoL'});
model.material('mpmat1').feature('phase2').propertyGroup('def').set('heatcapacity', {'CpL'});
model.material('mpmat1').feature.create('phase3', 'PhaseLink', 'comp1');
model.material('mpmat1').feature('phase3').label('Solid Phase');
model.material('mpmat1').feature('phase3').set('Vf', 'thetaS');
model.material('mpmat1').feature('phase3').propertyGroup('def').set('thermalconductivity', {'0'});
model.material('mpmat1').feature('phase3').propertyGroup('def').set('density', {'rhoS'});
model.material('mpmat1').feature('phase3').propertyGroup('def').set('heatcapacity', {'CpS'});

model.physics('ht').create('hs1', 'HeatSource', 2);
model.physics('ht').feature('hs1').selection.set([1]);
model.physics('ht').feature('hs1').set('Q0', '-mdot*deltaH');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.set([2 4]);
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 'hq');
model.physics('ht').feature('hf1').set('Text', 'Th');
model.physics('ht').feature('init1').set('Tinit', 'T0');
model.physics('c').feature('cfeq1').setIndex('c', {'DL' '0' '0' 'DL'}, 0);
model.physics('c').feature('cfeq1').setIndex('f', '-mdot/rhoL', 0);
model.physics('c').feature('init1').set('thetaL', 'thetaL0');

model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,1)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_T' 'global' 'comp1_thetaL' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_T' '1e-3' 'comp1_thetaL' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_T' 'factor' 'comp1_thetaL' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').feature('t1').feature('fc1').set('aaccdim', 5);
model.sol('sol1').feature('t1').feature('fc1').set('aaccdelay', 0);
model.sol('sol1').feature('t1').feature('fc1').set('aaccmix', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('damp', 0.9);
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').feature('comp1_thetaL').set('scalemethod', 'manual');

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,1,70)');

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('dataisaxisym', 'off');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 71, 0);
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 71, 0);
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').label('Coefficient Form PDE');
model.result('pg2').feature('surf1').set('expr', 'thetaL');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('rev1').set('data', 'dset1');
model.result.dataset('rev1').set('revangle', 225);
model.result.dataset('rev1').set('startangle', -90);
model.result.dataset('rev1').set('hasspacevars', false);
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').set('data', 'rev1');
model.result('pg3').setIndex('looplevel', 71, 0);
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').label('Coefficient Form PDE 1');
model.result('pg3').feature('surf1').set('expr', 'thetaL');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').setIndex('looplevel', 31, 0);
model.result('pg3').run;
model.result.dataset.create('rev2', 'Revolve2D');
model.result.dataset('rev2').set('startangle', -90);
model.result.dataset('rev2').set('revangle', 225);
model.result.dataset('rev2').set('data', 'dset1');
model.result.dataset('rev2').set('defaultPlotIDs', {'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pcond2/pg2|ht' 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pcond2/pg3|ht' 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pcond2/pg4|ht'});
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Temperature (ht) 1');
model.result('pg4').set('data', 'rev2');
model.result('pg4').setIndex('looplevel', 71, 0);
model.result('pg4').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pcond2/pg2');
model.result('pg4').feature.create('vol1', 'Volume');
model.result('pg4').feature('vol1').set('solutionparams', 'parent');
model.result('pg4').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('vol1').set('smooth', 'internal');
model.result('pg4').feature('vol1').set('showsolutionparams', 'on');
model.result('pg4').feature('vol1').set('data', 'parent');
model.result('pg4').label('Temperature (ht) 1');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result('pg5').label('Apparent moisture diffusivity');
model.result('pg5').setIndex('looplevel', 31, 0);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'DL');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').label('Evaporation rate');
model.result('pg6').setIndex('looplevel', 31, 0);
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'mdot');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 21, 0);
model.result('pg6').run;
model.result('pg6').setIndex('looplevel', 11, 0);
model.result('pg6').run;
model.result('pg3').run;
model.result('pg3').run;

model.title('Vacuum Drying');

model.description('Vacuum drying is a chemical process frequently used in the pharmaceutical and food industries to remove water or an organic solvent from a wet powder. When designing a vacuum drying system, engineers aim to minimize the drying time while maintaining high quality in the product. This model investigates vacuum drying in a Nutsche filter dryer, which consists of a cylindrical drum filled with wet cake. The top of the cake is exposed to a low-pressure head space, and the side and bottom walls are exposed to heating fluid. By operating at a very low pressure and an elevated temperature, the evaporation rate of the liquid increases, thus accelerating the drying process of the powder. By modeling the heat transfer and evaporation of the solvent in the powder, the temperature and liquid phase profiles can be studied. This example is based on the paper published by Murru and others for a powder dried with n-propanol under static conditions.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('vacuum_drying.mph');

model.modelNode.label('Components');

out = model;
