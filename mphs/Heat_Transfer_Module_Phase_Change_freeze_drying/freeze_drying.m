function out = model
%
% freeze_drying.m
%
% Model exported on May 26 2025, 21:29 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Phase_Change');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('dl', 'PorousMediaFlowDarcy', 'geom1');
model.physics('dl').model('comp1');
model.physics.create('ht', 'PorousMediaHeatTransfer', 'geom1');
model.physics('ht').model('comp1');
model.physics.create('dg', 'DeformedGeometry', 'geom1');
model.physics('dg').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/dl', true);
model.study('std1').feature('time').setSolveFor('/physics/ht', true);
model.study('std1').feature('time').setSolveFor('/physics/dg', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('rho_p', '498[kg/m^3]', 'Product density');
model.param.set('Cp_p', '2595[J/kg/K]', 'Product heat capacity');
model.param.set('k_p', '0.027[W/(m*K)]', 'Product thermal conductivity');
model.param.set('por_p', '0.709', 'Product porosity');
model.param.set('theta_p', '1-por_p', 'Product volume fraction');
model.param.set('kappa_p', '3.62e-10[m^2]', 'Product permeability');
model.param.set('rho_ice', '913[kg/m^3]', 'Ice density');
model.param.set('Cp_ice', '1967.8[J/kg/K]', 'Ice heat capacity');
model.param.set('k_ice', '2.1[W/m/K]', 'Ice thermal conductivity');
model.param.set('M_v', '18[g/mol]', 'Vapor molar mass');
model.param.set('Cp_v', '1674.7[J/kg/K]', 'Vapor heat capacity');
model.param.set('k_v', '0.025[W/m/K]', 'Vapor thermal conductivity');
model.param.set('mu_v', '8.36e-6[Pa*s]', 'Vapor viscosity');
model.param.set('DelHs', '2.7912[MJ/kg]', 'Latent heat of sublimation');
model.param.set('Pc', '24[Pa]', 'Vacuum chamber pressure');
model.param.set('Ti', '241.8[K]', 'Initial temperature');
model.param.set('Ts', '263.15[K]', 'Shelf temperature');
model.param.set('Ta', '303.15[K]', 'Ambient temperature');
model.param.set('Z0', '2[cm]', 'Vial height');
model.param.set('Zi', '0.04[cm]', 'Initial ice gap with vial height');
model.param.set('R0', '1[cm]', '  Vial radius');

model.material.create('mat1', 'Common', '');
model.material('mat1').label('Vapor');
model.material.create('mat2', 'Common', '');
model.material('mat2').label('Ice');
model.material.create('mat3', 'Common', '');
model.material('mat3').label('Product (Skim Milk)');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R0');
model.geom('geom1').feature('cyl1').set('h', 'Z0');
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 'Zi', 0);
model.geom('geom1').feature('cyl1').set('layerside', false);
model.geom('geom1').feature('cyl1').set('layertop', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'R0');
model.geom('geom1').feature('cyl2').set('h', 'Z0');
model.geom('geom1').feature('cyl2').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl2').setIndex('layer', 'R0/2', 0);
model.geom('geom1').run('cyl2');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'R0*5' 'R0*2' 'Z0'});
model.geom('geom1').feature('blk1').set('pos', {'-R0*2' '-R0*2' '0'});
model.geom('geom1').run('blk1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1' 'cyl2'});
model.geom('geom1').feature('dif1').selection('input2').set({'blk1'});
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

model.variable('var1').label('Interface');
model.variable('var1').set('T_s', '2.19e-3*DelHs*1[kg/J]/(28.89-log(p*1[1/Pa]))*1[K]');
model.variable('var1').descr('T_s', 'Interface temperature');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.set([1 3 5]);
model.cpl.create('minop1', 'Minimum', 'geom1');
model.cpl('minop1').selection.geom('geom1', 2);
model.cpl('minop1').selection.set([6 13 20]);

model.material.create('pmat1', 'PorousMedia', 'comp1');
model.material.create('pmat2', 'PorousMedia', 'comp1');
model.material('pmat2').selection.set([1 3 5]);

model.physics('dl').selection.set([2 4 6]);
model.physics('dl').prop('EquationForm').setIndex('form', 'Stationary', 0);
model.physics('dl').prop('PhysicalModelProperty').set('pref', 0);
model.physics('dl').prop('ShapeProperty').set('boundaryFlux_pressure', true);
model.physics('dl').feature('porous1').feature('fluid1').set('fluidType', 'idealGas');
model.physics('dl').feature('porous1').feature('fluid1').set('gasConstantType', 'numberAve');
model.physics('dl').feature('init1').set('p', 'Pc');
model.physics('dl').create('pr1', 'Pressure', 2);
model.physics('dl').feature('pr1').selection.set([7 14 21]);
model.physics('dl').feature('pr1').set('p0', 'Pc');
model.physics('dl').create('mf1', 'MassFlux', 2);
model.physics('dl').feature('mf1').selection.set([6 13 20]);
model.physics('dl').feature('mf1').set('N0', '-ht.pci1.vn*rho_ice*por_p');
model.physics('dl').create('sym1', 'Symmetry', 2);
model.physics('dl').feature('sym1').selection.set([4 12 25]);
model.physics('ht').feature('porous1').label('Dried Layer');
model.physics('ht').feature('porous1').feature('fluid1').set('u_src', 'root.comp1.dl.u');
model.physics('ht').feature('porous1').feature('fluid1').set('fluidType', 'idealGas');
model.physics('ht').feature('porous1').feature('fluid1').set('gasConstantType', 'numberAve');
model.physics('ht').feature('porous1').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').feature('init1').set('Tinit', 'Ti');
model.physics('ht').create('porous2', 'PorousMediumHeatTransferModel', 3);
model.physics('ht').feature('porous2').label('Frozen Layer');
model.physics('ht').feature('porous2').selection.set([1 3 5]);
model.physics('ht').feature('porous2').feature('pm1').set('porousMatrixPropertiesType', 'solidPhaseProperties');
model.physics('ht').create('hf1', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf1').label('Ambient Heat Flux');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', 3.6);
model.physics('ht').feature('hf1').set('Text', 'Ta');
model.physics('ht').feature('hf1').selection.set([2 5 7 14 21 22 23]);
model.physics('ht').create('sar1', 'SurfaceToAmbientRadiation', 2);
model.physics('ht').feature('sar1').selection.set([7 14 21]);
model.physics('ht').feature('sar1').set('epsilon_rad_mat', 'userdef');
model.physics('ht').feature('sar1').set('epsilon_rad', 0.9);
model.physics('ht').feature('sar1').set('Tamb', 'Ta');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf2').label('Shelf Heat Flux (Center)');
model.physics('ht').feature('hf2').selection.set([10]);
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', 11);
model.physics('ht').feature('hf2').set('Text', 'Ts');
model.physics('ht').create('hf3', 'HeatFluxBoundary', 2);
model.physics('ht').feature('hf3').label('Shelf Heat Flux (Exterior)');
model.physics('ht').feature('hf3').selection.set([3 17]);
model.physics('ht').feature('hf3').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf3').set('h', 62.3);
model.physics('ht').feature('hf3').set('Text', 'Ts');
model.physics('ht').create('sym1', 'Symmetry', 2);
model.physics('ht').feature('sym1').selection.set([1 4 9 12 24 25]);
model.physics('ht').create('pci1', 'PhaseChangeInterface', 2);
model.physics('ht').feature('pci1').selection.set([6 13 20]);
model.physics('ht').feature('pci1').set('Tpc', 'T_s');
model.physics('ht').feature('pci1').set('L', 'DelHs');
model.physics('ht').feature('pci1').set('SolidSideType', 'Downside');
model.physics('dg').prop('FrameSettings').set('geometryShapeOrder', 1);
model.physics('dg').prop('FreeDeformationSettings').set('smoothingType', 'hyperelastic');
model.physics('dg').create('free1', 'FreeDeformation', 3);
model.physics('dg').feature('free1').selection.all;
model.physics('dg').create('disp2', 'PrescribedMeshDisplacement', 2);
model.physics('dg').feature('disp2').selection.set([1 2 4 5 9 12 22 23 24 25]);
model.physics('dg').feature('disp2').setIndex('useDx', 0, 2);

model.material('pmat1').propertyGroup('def').set('hydraulicpermeability', {'kappa_p'});
model.material('pmat1').feature.create('solid1', 'Solid', 'comp1');
model.material('pmat1').feature.create('fluid1', 'Fluid', 'comp1');
model.material('pmat1').feature('solid1').set('link', 'mat3');
model.material('pmat1').feature('solid1').set('vfrac', '1-por_p');
model.material('pmat2').feature.create('fluid1', 'Fluid', 'comp1');
model.material('pmat2').feature.create('solid1', 'Solid', 'comp1');
model.material('pmat2').feature('fluid1').set('link', 'mat2');
model.material('pmat2').feature('solid1').set('link', 'mat3');
model.material('pmat2').feature('solid1').set('vfrac', '1-por_p');
model.material('mat1').propertyGroup('def').set('molarmass', {'M_v'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', {'mu_v'});
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k_v'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'Cp_v'});
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'k_ice'});
model.material('mat2').propertyGroup('def').set('density', {'rho_ice'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'Cp_ice'});
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'k_p'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'Cp_p'});
model.material('mat3').propertyGroup('def').set('density', {'rho_p'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').active(false);
model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.set([7 14 21]);
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([8 29]);
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('bl1').selection.set([7 21]);
model.mesh('mesh1').feature('bl1').feature('blp').selection.set([8 29]);
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 4);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection('sourceface').set([7 14 21]);
model.mesh('mesh1').feature('swe1').selection('targetface').set([3 10 17]);
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.set([2 4 6]);
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 16);
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.set([1 3 5]);
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 8);

model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,0.1,0.5) range(0.5,0.5,24)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 4 6]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 2 3 4 5 6]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.6074062410157737E-4');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.1,0.5) range(0.5,0.5,24)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.005);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('atolmethod', {'comp1_ht_T_lm' 'global' 'comp1_material_disp' 'global' 'comp1_material_lm_nv' 'global' 'comp1_p' 'global' 'comp1_T' 'global'});
model.sol('sol1').feature('t1').set('atol', {'comp1_ht_T_lm' '1e-3' 'comp1_material_disp' '1e-3' 'comp1_material_lm_nv' '1e-3' 'comp1_p' '1e-3' 'comp1_T' '1e-3'});
model.sol('sol1').feature('t1').set('atolvaluemethod', {'comp1_ht_T_lm' 'factor' 'comp1_material_disp' 'factor' 'comp1_material_lm_nv' 'factor' 'comp1_p' 'factor' 'comp1_T' 'factor'});
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('stabcntrl', true);
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_p'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'once');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d1').label('Direct, pressure (dl)');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Pressure p');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_T' 'comp1_ht_T_lm'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.7);
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d2', 'Direct');
model.sol('sol1').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature('d2').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Temperature');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_material_disp' 'comp1_material_lm_nv'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Material Frame Variables');
model.sol('sol1').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol1').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol1').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol1').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol1').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol1').feature('t1').feature('se1').create('ll1', 'LowerLimit');
model.sol('sol1').feature('t1').feature('se1').feature('ll1').set('lowerlimit', 'comp1.T 0 ');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i1').set('rhob', 400);
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 50);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('AMG, pressure (dl)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.7);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'mesh');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('linemethod', 'coupled');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('linsolver', 'gmres');
model.sol('sol1').feature('t1').feature('i2').set('prefuntype', 'left');
model.sol('sol1').feature('t1').feature('i2').set('itrestart', 50);
model.sol('sol1').feature('t1').feature('i2').set('rhob', 20);
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 10000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('saamgcompwise', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'sor');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('vankavars', {'comp1_ht_T_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('seconditer', 1);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.6);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'soru');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('vankavars', {'comp1_ht_T_lm'});
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('seconditer', 2);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('relax', 0.4);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.6);
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').create('st1', 'StopCondition');
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.minop1(z)/Z0-0.03', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopcondterminateon', 'negative', 0);
model.sol('sol1').feature('t1').feature('st1').setIndex('stopconddesc', 'Interface close to the vial bottom', 0);
model.sol('sol1').feature('t1').feature('st1').set('storestopcondsol', 'stepafter');
model.sol('sol1').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('damp', '0.9');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('stabacc', 'aacc');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (dl)');
model.result('pg1').set('titletype', 'custom');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 27, 0);
model.result('pg1').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond1/pg1');
model.result('pg1').feature.create('str1', 'Streamline');
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('posmethod', 'start');
model.result('pg1').feature('str1').set('pointtype', 'arrow');
model.result('pg1').feature('str1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('str1').set('smooth', 'internal');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('showsolutionparams', 'on');
model.result('pg1').feature('str1').set('maxlen', Inf);
model.result('pg1').feature('str1').set('maxtime', Inf);
model.result('pg1').feature('str1').set('data', 'parent');
model.result('pg1').feature('str1').selection.geom('geom1', 2);
model.result('pg1').feature('str1').selection.set([4 5 6 7 11 12 13 14 18 19 20 21 23 25]);
model.result('pg1').feature('str1').feature.create('col1', 'Color');
model.result('pg1').feature('str1').feature('col1').set('expr', 'dl.U');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (dl)');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 27, 0);
model.result('pg2').set('defaultPlotID', 'PhysicsInterfaces_PorousMediaFlow/icom6/pdef1/pcond1/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 27, 0);
model.result('pg3').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond3/pcond3/pg1');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result('pg1').run;
model.result.dataset.create('mir1', 'Mirror3D');
model.result.dataset('mir1').set('quickplane', 'xz');
model.result.dataset.create('cpt1', 'CutPoint3D');
model.result.dataset('cpt1').set('pointx', 0);
model.result.dataset('cpt1').set('pointy', 0);
model.result.dataset('cpt1').set('pointz', 'range(Z0,-Z0/6,0)');
model.result.dataset('cpt1').set('snapping', 'boundary');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').run;
model.result('pg4').label('Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').set('colortable', 'AuroraBorealis');
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([1 2 3 6 9 10 13 17 20 22 24]);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg5').label('Initial Mesh');
model.result('pg5').set('looplevel', [1]);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Sublimation Interface');
model.result('pg6').set('data', 'mir1');
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Left: Final interface position; right: temperature and total heat fluxes');
model.result('pg6').create('slc1', 'Slice');
model.result('pg6').feature('slc1').set('expr', 'T');
model.result('pg6').feature('slc1').set('quickxnumber', 1);
model.result('pg6').feature('slc1').set('colortable', 'HeatCameraLight');
model.result('pg6').run;
model.result('pg6').create('iso1', 'Isosurface');
model.result('pg6').feature('iso1').set('expr', 'Zg');
model.result('pg6').feature('iso1').set('levelmethod', 'levels');
model.result('pg6').feature('iso1').set('levels', 'Z0-Zi');
model.result('pg6').feature('iso1').set('colortable', 'JupiterAuroraBorealis');
model.result('pg6').feature('iso1').set('colorlegend', false);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').create('str1', 'Streamline');
model.result('pg6').feature('str1').selection.set([1 2 3 6 9 10 13 17 20 22 24]);
model.result('pg6').feature('str1').set('expr', {'ht.tfluxx' 'ht.tfluxy' 'ht.tfluxz'});
model.result('pg6').feature('str1').set('descr', 'Total heat flux (spatial and material frames)');
model.result('pg6').feature('str1').set('posmethod', 'magnitude');
model.result('pg6').feature('str1').set('linetype', 'tube');
model.result('pg6').feature('str1').create('col1', 'Color');
model.result('pg6').run;
model.result('pg6').feature('str1').feature('col1').set('expr', 'T');
model.result('pg6').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg6').feature('str1').feature('col1').set('colortable', 'HeatCameraLight');
model.result('pg6').run;
model.result('pg6').create('line1', 'Line');
model.result('pg6').feature('line1').set('expr', '1');
model.result('pg6').feature('line1').set('coloring', 'uniform');
model.result('pg6').feature('line1').set('color', 'gray');
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').create('vol1', 'Volume');
model.result('pg6').feature('vol1').set('data', 'dset1');
model.result('pg6').feature('vol1').set('expr', 'dom==1||dom==3||dom==5');
model.result('pg6').feature('vol1').set('solutionparams', 'parent');
model.result('pg6').feature('vol1').set('colortable', 'AuroraBorealis');
model.result('pg6').feature('vol1').set('colorlegend', false);
model.result('pg6').feature('vol1').create('trn1', 'Translation');
model.result('pg6').run;
model.result('pg6').feature('vol1').feature('trn1').set('trans', {'-2.5*R0' '0' '0'});
model.result('pg6').feature('vol1').feature('trn1').set('applytodatasetedges', false);
model.result('pg6').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Temperature history');
model.result('pg7').set('data', 'none');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Temperature history at seven different heights at the center of the vial');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('xlabel', 'Time (h)');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Temperature (K)');
model.result('pg7').set('legendpos', 'upperleft');
model.result('pg7').create('ptgr1', 'PointGraph');
model.result('pg7').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('ptgr1').set('linewidth', 'preference');
model.result('pg7').feature('ptgr1').set('data', 'cpt1');
model.result('pg7').feature('ptgr1').set('expr', 'T');
model.result('pg7').run;
model.result('pg7').feature('ptgr1').set('linewidth', 2);
model.result('pg7').feature('ptgr1').set('legend', true);
model.result('pg7').feature('ptgr1').set('legendmethod', 'evaluated');
model.result('pg7').feature('ptgr1').set('legendpattern', 'z/Z0=eval(z/Z0)');
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Ice mass');
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Ice mass relative to initial amount');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'Time (h)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', '(%)');
model.result('pg8').set('showlegends', false);
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('glob1').setIndex('expr', 'comp1.intop1(1)*2/(pi*R0^2*(Z0-Zi))', 0);
model.result('pg8').feature('glob1').setIndex('unit', 1, 0);
model.result('pg8').feature('glob1').setIndex('descr', '', 0);
model.result('pg8').run;
model.result('pg8').feature('glob1').set('linewidth', 2);
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Initial Ice Mass');
model.result.numerical('gev1').setIndex('expr', 'comp1.intop1(rho_ice)*2*por_p', 0);
model.result.numerical('gev1').setIndex('unit', 'mg', 0);
model.result.numerical('gev1').setIndex('descr', 'Ice mass', 0);
model.result.numerical('gev1').set('dataseries', 'maximum');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Initial Ice Mass');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result.numerical.duplicate('gev2', 'gev1');
model.result.numerical('gev2').label('Final Ice Mass');
model.result.numerical('gev2').set('dataseries', 'minimum');
model.result.numerical('gev2').set('table', 'tbl1');
model.result.numerical('gev2').appendResult;
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').set('intvolume', true);
model.result.numerical('int1').label('Vapor Flux');
model.result.numerical('int1').selection.set([7 14 21]);
model.result.numerical('int1').setIndex('expr', 'dl.bndflux*2', 0);
model.result.numerical('int1').setIndex('unit', 'mg/h', 0);
model.result.numerical('int1').setIndex('descr', 'Vapor flux leaving the vial', 0);
model.result.numerical('int1').set('intorderactive', true);
model.result.numerical('int1').set('dataseries', 'integral');
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Vapor Flux');
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').setResult;
model.result('pg6').run;

model.title('Freeze-Drying');

model.description('This example models the process of ice sublimation in a vial under vacuum-chamber conditions, a test case for many freeze-drying setups. The example uses the Deformed Geometry interface to compute the coupled heat and mass balances to handle the advancing vapor-ice interface through porous medium.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('freeze_drying.mph');

model.modelNode.label('Components');

out = model;
