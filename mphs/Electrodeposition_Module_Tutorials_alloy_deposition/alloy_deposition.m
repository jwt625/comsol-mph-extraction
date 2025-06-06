function out = model
%
% alloy_deposition.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Electrodeposition_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'cNi' 'cH3PO2' 'cSO4' 'cNa'});
model.physics('tcd').prop('SpeciesProperties').set('ChargeTransportModel', 'WaterBased');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/tcd', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('a', '0.51023', 'Numerical constant in velocity expression');
model.param.set('aNi_ref', '0.5', 'Reference activity for Ni plating');
model.param.set('aP_ref', '0.5', 'Reference activity for P plating');
model.param.set('cH_ref', '0.1[M]', 'Reference concentration of H');
model.param.set('cH0', 'cH_ref', 'Initial concentration of H');
model.param.set('cH3PO2_ref', '0.38[M]', 'Reference concentration of H3PO2');
model.param.set('cH3PO20', 'cH3PO2_ref', 'Initial concentration of H3PO2');
model.param.set('cNa0', '0.3[M]', 'Initial concentration of Na');
model.param.set('cNi_ref', '0.38[M]', 'Reference concentration of Ni');
model.param.set('cNi0', 'cNi_ref', 'Initial concentration of Ni');
model.param.set('cSO40', '0.58[M]', 'Initial concentration of SO4');
model.param.set('DH', '9.312e-5[cm^2/s]', 'Diffusion coefficient of H');
model.param.set('DH3PO2', '1.54e-5[cm^2/s]', 'Diffusion coefficient of H3PO3');
model.param.set('DNa', '1.334e-5[cm^2/s]', 'Diffusion coefficient of Na');
model.param.set('DNi', '0.71e-5[cm^2/s]', 'Diffusion coefficient of Ni');
model.param.set('DOH', '5.26e-5[cm^2/s]', 'Diffusion coefficient of OH');
model.param.set('DSO4', '1.065e-5[cm^2/s]', 'Diffusion coefficient of SO4');
model.param.set('E_app', '-0.5[V]', 'Applied potential');
model.param.set('Eeq_ref_H', '0[V]+R_const*T/F_const*log(cH_ref/(1[M]))', 'Reference equilibrium potential, hydrogen evolution');
model.param.set('Eeq_ref_Ni', '-0.23[V]+R_const*T/(2*F_const)*log(cNi_ref/(1[M]))', 'Reference equilibrium potential, nickel deposition');
model.param.set('Eeq_ref_P', '-0.51[V]+R_const*T/F_const*log(cH3PO2_ref*cH_ref/(1[M])^2)', 'Reference equilibrium potential, phosphorous deposition');
model.param.set('i0_ref_H', '6.3e-10[A/cm^2]', 'Reference exchange current density, hydrogen evolution');
model.param.set('i0_ref_Ni', '1e-8[A/cm^2]', 'Reference exchange current density, nickel deposition');
model.param.set('i0_ref_P', '1e-4[A/cm^2]', 'Reference exchange current density, phosphorous deposition');
model.param.set('M_Ni', '58.60[g/mol]', 'Molar mass of nickel');
model.param.set('M_P', '123.88[g/mol]', 'Molar mass of phosphorous');
model.param.set('nu', '0.0123[cm^2/s]', 'Kinematic viscosity');
model.param.set('omega', '209.44 [rad/s]', 'Rotational speed');
model.param.set('rho_Ni', '8908[kg/m^3]', 'Density of nickel');
model.param.set('rho_P', '1820[kg/m^3]', 'Density of phosphorous');
model.param.set('T', '298.15[K]', 'Temperature');

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', '0.02[cm]', 1);
model.geom('geom1').runPre('fin');

model.variable.create('var1');
model.variable('var1').model('comp1');

model.geom('geom1').run;

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('vx', '-a*omega*(omega/nu)^(1/2)*x^2', 'Fluid velocity');
model.variable('var1').set('xP', '1-xNi', 'Deposition molar fraction of P');
model.variable('var1').set('xNi_expr', 'tcd.R_Ni/(tcd.R_Ni+tcd.R_P)', 'Fractional deposition expression for xNi');

model.physics('tcd').feature('sp1').setIndex('z', 2, 0);
model.physics('tcd').feature('sp1').setIndex('z', -2, 2);
model.physics('tcd').feature('sp1').setIndex('z', 1, 3);
model.physics('tcd').feature('ice1').set('u', {'vx' '0' '0'});
model.physics('tcd').feature('ice1').set('D_cNi', {'DNi' '0' '0' '0' 'DNi' '0' '0' '0' 'DNi'});
model.physics('tcd').feature('ice1').set('D_cH3PO2', {'DH3PO2' '0' '0' '0' 'DH3PO2' '0' '0' '0' 'DH3PO2'});
model.physics('tcd').feature('ice1').set('D_cSO4', {'DSO4' '0' '0' '0' 'DSO4' '0' '0' '0' 'DSO4'});
model.physics('tcd').feature('ice1').set('D_cNa', {'DNa' '0' '0' '0' 'DNa' '0' '0' '0' 'DNa'});
model.physics('tcd').feature('ice1').set('DH', {'DH' '0' '0' '0' 'DH' '0' '0' '0' 'DH'});
model.physics('tcd').feature('ice1').set('DOH', {'DOH' '0' '0' '0' 'DOH' '0' '0' '0' 'DOH'});
model.physics('tcd').feature('init1').setIndex('initc', 'cNi0', 0);
model.physics('tcd').feature('init1').setIndex('initc', 'cH3PO20', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'cSO40', 2);
model.physics('tcd').feature('init1').setIndex('initc', 'cNa0', 3);
model.physics('tcd').create('es1', 'ElectrodeSurface', 0);
model.physics('tcd').feature('es1').selection.set([1]);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'Ni', 0, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 'rho_Ni', 0, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 'M_Ni', 0, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('Species', 's1', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 8960, 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 0.06355, 1, 0);
model.physics('tcd').feature('es1').setIndex('Species', 'P', 1, 0);
model.physics('tcd').feature('es1').setIndex('rhos', 'rho_P', 1, 0);
model.physics('tcd').feature('es1').setIndex('Ms', 'M_P', 1, 0);
model.physics('tcd').feature('es1').set('phisext0', 'E_app');
model.physics('tcd').feature('es1').feature('er1').label('Electrode Reaction: Ni Deposition');
model.physics('tcd').feature('es1').feature('er1').set('nm', 2);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vi0', -1, 0);
model.physics('tcd').feature('es1').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('tcd').feature('es1').feature('er1').set('Eeq_ref', 'Eeq_ref_Ni-R_const*T/(2*F_const)*log(max(xNi,eps^2)/aNi_ref)');
model.physics('tcd').feature('es1').feature('er1').setIndex('cref', 'cNi_ref', 0, 0);
model.physics('tcd').feature('es1').feature('er1').set('i0_ref', 'i0_ref_Ni*(max(xNi,eps)/aNi_ref)^0.75');
model.physics('tcd').feature('es1').create('er2', 'ElectrodeReaction', 0);
model.physics('tcd').feature('es1').feature('er2').label('Electrode Reaction: P Deposition');
model.physics('tcd').feature('es1').feature('er2').setIndex('Vi0', -1, 1);
model.physics('tcd').feature('es1').feature('er2').setIndex('Vib', 1, 1, 0);
model.physics('tcd').feature('es1').feature('er2').set('Eeq_ref', 'Eeq_ref_P-R_const*T/(F_const)*log(max(xP,eps)/aP_ref)');
model.physics('tcd').feature('es1').feature('er2').setIndex('cref', 'cH3PO2_ref', 1, 0);
model.physics('tcd').feature('es1').feature('er2').set('cHref', 'cH_ref');
model.physics('tcd').feature('es1').feature('er2').set('i0_ref', 'i0_ref_P*(max(xP,eps^2)/aP_ref)^0.5');
model.physics('tcd').feature('es1').create('er3', 'ElectrodeReaction', 0);
model.physics('tcd').feature('es1').feature('er3').label('Electrode Reaction: Hydrogen Evolution');
model.physics('tcd').feature('es1').feature('er3').set('Eeq_ref', 'Eeq_ref_H');
model.physics('tcd').feature('es1').feature('er3').set('cHref', 'cH_ref');
model.physics('tcd').feature('es1').feature('er3').set('i0_ref', 'i0_ref_H');
model.physics('tcd').create('conc1', 'Concentration', 0);
model.physics('tcd').feature('conc1').selection.set([2]);
model.physics('tcd').feature('conc1').setIndex('species', true, 0);
model.physics('tcd').feature('conc1').setIndex('species', true, 1);
model.physics('tcd').feature('conc1').setIndex('species', true, 2);
model.physics('tcd').feature('conc1').setIndex('species', true, 3);
model.physics('tcd').feature('conc1').setIndex('c0', 'cNi0', 0);
model.physics('tcd').feature('conc1').setIndex('c0', 'cH3PO20', 1);
model.physics('tcd').feature('conc1').setIndex('c0', 'cSO40', 2);
model.physics('tcd').feature('conc1').setIndex('c0', 'cNa0', 3);
model.physics('tcd').create('eip1', 'ElectrolytePotential', 0);
model.physics('tcd').feature('eip1').selection.set([2]);
model.physics.create('gb', 'GeneralFormBoundaryPDE', 'geom1', {'xNi'});

model.study('std1').feature('stat').setSolveFor('/physics/gb', true);

model.physics('gb').prop('EquationForm').set('form', 'Automatic');
model.physics('gb').selection.set([1]);
model.physics('gb').prop('Units').setIndex('CustomSourceTermUnit', 1, 0, 0);
model.physics('gb').feature('gfeq1').setIndex('f', 'xNi-xNi_expr', 0);
model.physics('gb').feature('gfeq1').setIndex('da', 0, 0);
model.physics('gb').feature('init1').set('xNi', 1);

model.common('cminpt').set('modified', {'temperature' 'T'});

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('hauto', 2);
model.mesh('mesh1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('size1').set('hmax', 1.0E-6);
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'a', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'a', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', '', 0);
model.study('std1').feature('stat').setIndex('pname', 'E_app', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(-0.5, -0.025, -1.1)', 0);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').label('Direct (Merged)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Electrolyte Potential (tcd)');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1]);
model.result('pg1').feature('lngr1').set('expr', {'phil'});
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').set('title', 'Concentrations, All Species');
model.result('pg2').label('Concentrations, All Species (tcd)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1]);
model.result('pg2').feature('lngr1').set('expr', {'cNi'});
model.result('pg2').feature('lngr1').label('Species Ni');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autoexpr', false);
model.result('pg2').feature('lngr1').set('autodescr', false);
model.result('pg2').feature('lngr1').set('legendprefix', 'Ni ');
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'x');
model.result('pg2').feature('lngr2').selection.geom('geom1', 1);
model.result('pg2').feature('lngr2').selection.set([1]);
model.result('pg2').feature('lngr2').set('expr', {'cH3PO2'});
model.result('pg2').feature('lngr2').label('Species H3PO2');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('autosolution', false);
model.result('pg2').feature('lngr2').set('autoexpr', false);
model.result('pg2').feature('lngr2').set('autodescr', false);
model.result('pg2').feature('lngr2').set('legendprefix', 'H3PO2 ');
model.result('pg2').create('lngr3', 'LineGraph');
model.result('pg2').feature('lngr3').set('xdata', 'expr');
model.result('pg2').feature('lngr3').set('xdataexpr', 'x');
model.result('pg2').feature('lngr3').selection.geom('geom1', 1);
model.result('pg2').feature('lngr3').selection.set([1]);
model.result('pg2').feature('lngr3').set('expr', {'cSO4'});
model.result('pg2').feature('lngr3').label('Species SO4');
model.result('pg2').feature('lngr3').set('legend', true);
model.result('pg2').feature('lngr3').set('autosolution', false);
model.result('pg2').feature('lngr3').set('autoexpr', false);
model.result('pg2').feature('lngr3').set('autodescr', false);
model.result('pg2').feature('lngr3').set('legendprefix', 'SO4 ');
model.result('pg2').create('lngr4', 'LineGraph');
model.result('pg2').feature('lngr4').set('xdata', 'expr');
model.result('pg2').feature('lngr4').set('xdataexpr', 'x');
model.result('pg2').feature('lngr4').selection.geom('geom1', 1);
model.result('pg2').feature('lngr4').selection.set([1]);
model.result('pg2').feature('lngr4').set('expr', {'cNa'});
model.result('pg2').feature('lngr4').label('Species Na');
model.result('pg2').feature('lngr4').set('legend', true);
model.result('pg2').feature('lngr4').set('autosolution', false);
model.result('pg2').feature('lngr4').set('autoexpr', false);
model.result('pg2').feature('lngr4').set('autodescr', false);
model.result('pg2').feature('lngr4').set('legendprefix', 'Na ');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Concentration, Ni (tcd)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species Ni:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', false);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1]);
model.result('pg3').feature('lngr1').set('expr', {'cNi'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Concentration, H3PO2 (tcd)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', 'Species H3PO2:');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', false);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1]);
model.result('pg4').feature('lngr1').set('expr', {'cH3PO2'});
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').label('Concentration, SO4 (tcd)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', 'Species SO4:');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', false);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1]);
model.result('pg5').feature('lngr1').set('expr', {'cSO4'});
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').label('Concentration, Na (tcd)');
model.result('pg6').set('titletype', 'custom');
model.result('pg6').set('prefixintitle', 'Species Na:');
model.result('pg6').set('expressionintitle', false);
model.result('pg6').set('typeintitle', false);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').selection.geom('geom1', 1);
model.result('pg6').feature('lngr1').selection.set([1]);
model.result('pg6').feature('lngr1').set('expr', {'cNa'});
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').setIndex('looplevelinput', 'manual', 0);
model.result('pg2').setIndex('looplevel', [13], 0);
model.result('pg2').set('title', 'Concentrations of all species at applied potential of -0.8 V/SHE');
model.result('pg2').set('xlabelactive', true);
model.result('pg2').set('xlabel', 'Normalized distance');
model.result('pg2').set('ylabelactive', true);
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', 0);
model.result('pg2').set('xmax', 2);
model.result('pg2').set('legendpos', 'upperleft');
model.result('pg2').run;
model.result('pg2').feature('lngr1').set('xdataexpr', 'x/1.1517e-3[cm]');
model.result('pg2').feature('lngr1').set('linewidth', 2);
model.result('pg2').run;
model.result('pg2').feature('lngr2').set('xdataexpr', 'x/1.1517e-3[cm]');
model.result('pg2').feature('lngr2').set('linewidth', 2);
model.result('pg2').run;
model.result('pg2').feature('lngr3').set('xdataexpr', 'x/1.1517e-3[cm]');
model.result('pg2').feature('lngr3').set('linewidth', 2);
model.result('pg2').run;
model.result('pg2').feature('lngr4').set('xdataexpr', 'x/1.1517e-3[cm]');
model.result('pg2').feature('lngr4').set('linewidth', 2);
model.result('pg2').feature.duplicate('lngr5', 'lngr4');
model.result('pg2').run;
model.result('pg2').feature('lngr5').label('Species H');
model.result('pg2').feature('lngr5').set('expr', 'tcd.cH');
model.result('pg2').feature('lngr5').set('legendprefix', 'H');
model.result('pg2').run;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Polarization Plot');
model.result('pg7').set('titletype', 'manual');
model.result('pg7').set('title', 'Polarization plot');
model.result('pg7').create('ptgr1', 'PointGraph');
model.result('pg7').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg7').feature('ptgr1').set('linewidth', 'preference');
model.result('pg7').feature('ptgr1').selection.set([1]);
model.result('pg7').feature('ptgr1').set('expr', 'tcd.itot');
model.result('pg7').feature('ptgr1').set('descr', 'Total interface current density');
model.result('pg7').feature('ptgr1').set('unit', 'A/cm^2');
model.result('pg7').feature('ptgr1').set('xdata', 'expr');
model.result('pg7').feature('ptgr1').set('xdataexpr', 'E_app');
model.result('pg7').feature('ptgr1').set('linewidth', 2);
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Deposition Mole Fraction');
model.result('pg8').set('titletype', 'manual');
model.result('pg8').set('title', 'Deposition mole fraction');
model.result('pg8').set('xlabelactive', true);
model.result('pg8').set('xlabel', 'Applied potential (V)');
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Deposition mole fraction (1)');
model.result('pg8').set('legendpos', 'middleleft');
model.result('pg8').create('ptgr1', 'PointGraph');
model.result('pg8').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg8').feature('ptgr1').set('linewidth', 'preference');
model.result('pg8').feature('ptgr1').selection.set([1]);
model.result('pg8').feature('ptgr1').set('expr', 'xNi');
model.result('pg8').feature('ptgr1').set('xdata', 'expr');
model.result('pg8').feature('ptgr1').set('xdataexpr', 'E_app');
model.result('pg8').feature('ptgr1').set('linewidth', 2);
model.result('pg8').feature('ptgr1').set('legend', true);
model.result('pg8').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg8').feature('ptgr1').setIndex('legends', 'Ni', 0);
model.result('pg8').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg8').run;
model.result('pg8').feature('ptgr2').set('expr', 'xP');
model.result('pg8').feature('ptgr2').setIndex('legends', 'P', 0);
model.result('pg8').run;

model.title('Alloy Deposition');

model.description('This tutorial model demonstrates electrodeposition of a nickel-phosphorous alloy. The model accounts for charge and mass transport of a multitude of species along with multiple electrode reactions such as nickel and phosphorus electrodeposition and hydrogen evolution. The model computes the steady state spatial distributions of the various species along the diffusion layer. The polarization plot along with deposition mole fraction plot reveal the desirable operating conditions for alloy preparation.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('alloy_deposition.mph');

model.modelNode.label('Components');

out = model;
