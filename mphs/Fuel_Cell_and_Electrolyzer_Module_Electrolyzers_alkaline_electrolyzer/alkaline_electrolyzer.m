function out = model
%
% alkaline_electrolyzer.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Electrolyzers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('we', 'WaterElectrolyzer', 'geom1');
model.physics('we').model('comp1');
model.physics('we').prop('H2GasMixture').set('H2O', '1');
model.physics('we').prop('H2GasMixture').set('GasPhaseDiffusion', '1');
model.physics('we').prop('O2GasMixture').set('H2O', '1');
model.physics('we').prop('O2GasMixture').set('GasPhaseDiffusion', '1');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('ElectrolyteType', 'HydroxideExchange');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('OperationMode', 'Electrolyzer');
model.physics('we').prop('DefaultElectrodeReactionSettings').set('TRHE', '50[degC]');
model.physics.create('ee', 'LaminarEulerEulerModel', 'geom1');
model.physics('ee').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/we', true);
model.study('std1').feature('cdi').setSolveFor('/physics/ee', true);
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/we', true);
model.study('std1').feature('stat').setSolveFor('/physics/ee', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W_H2', '2[mm]', 'Hydrogen compartment width');
model.param.set('W_sep', '1[mm]', 'Separator width');
model.param.set('W_O2', '2[mm]', 'Oxygen compartment width');
model.param.set('W_cell', 'W_H2+W_sep+W_O2', 'Cell width');
model.param.set('H_elec', '0.1[m]', 'Electrode height');
model.param.set('T', '70[degC]', 'Operating temperature');
model.param.set('p_gas', '1[atm]', 'Gas pressure');
model.param.set('p_vapor', '0.61121*exp((18.678-(T-0[degC])/234.5[K])*((T-0[degC])/(257.14+T-0[degC])))[kPa]', 'Vapor pressure');
model.param.set('xH2O', 'p_vapor/p_gas', 'Water molar fraction in gas phase');
model.param.set('xH2', '1-xH2O', 'Hydrogen molar fraction in gas phase');
model.param.set('xO2', '1-xH2O', 'Oxygen molar fraction in gas phase');
model.param.set('d_bubble', '50[um]', 'Bubble diameter');
model.param.set('v_in_H2', '0.1[m/s]', 'Average inlet velocity, hydrogen side');
model.param.set('v_in_O2', '0.1[m/s]', 'Average inlet velocity, oxygen side');
model.param.set('K_H2_div_d', '5[m/s]', 'Hydrogen mix bubble dispersion factor');
model.param.set('K_O2_div_d', 'K_H2_div_d*2', 'Oxygen mix bubble dispersion factor');
model.param.set('i0_ref_H2', '1e2[A/m^2]', 'Exchange current density, hydrogen oxidation');
model.param.set('i0_ref_O2', '1[A/m^2]', 'Exchange current density, oxygen reduction');
model.param.set('MH2O', '18[g/mol]', 'Water molar mass');
model.param.set('MO2', '32[g/mol]', 'Oxygen molar mass');
model.param.set('MH2', '2[g/mol]', 'Hydrogen molar mass');
model.param.set('MOH', '17[g/mol]', 'Hydroxide molar mass');
model.param.set('eps_sep', '0.3', 'Separator porosity');
model.param.set('t', '0[s]', 'Dummy parameter for stationary study steps');
model.param.set('c_KOH', '6[M]', 'Electrolyte concentration');
model.param.set('E_cell', '1.2[V]', 'Cell voltage');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').label('Hydrogen Gas Compartment');
model.geom('geom1').feature('r1').set('size', {'W_H2' 'H_elec'});
model.geom('geom1').feature('r1').set('selresult', true);
model.geom('geom1').run('r1');
model.geom('geom1').create('r2', 'Rectangle');
model.geom('geom1').feature('r2').label('Separator');
model.geom('geom1').feature('r2').set('size', {'W_sep' 'H_elec'});
model.geom('geom1').feature('r2').set('pos', {'W_H2' '0'});
model.geom('geom1').feature('r2').set('selresult', true);
model.geom('geom1').run('r2');
model.geom('geom1').create('r3', 'Rectangle');
model.geom('geom1').feature('r3').label('Oxygen Gas Compartment');
model.geom('geom1').feature('r3').set('size', {'W_O2' 'H_elec'});
model.geom('geom1').feature('r3').set('pos', {'W_H2+W_sep' '0'});
model.geom('geom1').feature('r3').set('selresult', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Hydrogen Electrode');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').selection('selection').set('fin', 1);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Oxygen Electrode');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').selection('selection').set('fin', 10);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Inlets');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('fin', [2 8]);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Outlets');
model.geom('geom1').feature('sel4').selection('selection').init(1);
model.geom('geom1').feature('sel4').selection('selection').set('fin', [3 9]);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Separator Boundaries');
model.geom('geom1').feature('sel5').selection('selection').init(1);
model.geom('geom1').feature('sel5').selection('selection').set('fin', [4 7]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Electrodes');
model.geom('geom1').feature('unisel1').set('entitydim', 1);
model.geom('geom1').feature('unisel1').set('input', {'sel1' 'sel2'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Gas Compartments');
model.geom('geom1').feature('unisel2').set('input', {'r1' 'r3'});

model.view('view1').axis.set('viewscaletype', 'manual');
model.view('view1').axis.set('yscale', 0.2);

model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int3', 'Interpolation');
model.material('mat1').propertyGroup('def').func.create('int4', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').label('Potassium Hydroxide, KOH');
model.material('mat1').comments([ newline ]);
model.material('mat1').set('family', 'water');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'A_rho');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'0' '-0.5031';  ...
'5' '-0.4821';  ...
'10' '-0.5026';  ...
'15' '-0.482';  ...
'20' '-0.4824';  ...
'25' '-0.4931';  ...
'30' '-0.4812';  ...
'35' '-0.4918';  ...
'40' '-0.4863';  ...
'45' '-0.4912';  ...
'50' '-0.4756';  ...
'55' '-0.4898';  ...
'60' '-0.4916';  ...
'65' '-0.4906';  ...
'70' '-0.4876';  ...
'80' '-0.4942';  ...
'90' '-0.5021';  ...
'100' '-0.501';  ...
'150' '-0.5206';  ...
'200' '-0.5538'});
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int2').set('funcname', 'B_rho');
model.material('mat1').propertyGroup('def').func('int2').set('table', {'0' '45.876';  ...
'5' '45.648';  ...
'10' '45.889';  ...
'15' '45.659';  ...
'20' '45.649';  ...
'25' '45.761';  ...
'30' '45.568';  ...
'35' '45.698';  ...
'40' '45.601';  ...
'45' '45.62';  ...
'50' '45.336';  ...
'55' '45.543';  ...
'60' '45.53';  ...
'65' '45.45';  ...
'70' '45.396';  ...
'80' '45.409';  ...
'90' '45.432';  ...
'100' '45.361';  ...
'150' '45.217';  ...
'200' '45.173'});
model.material('mat1').propertyGroup('def').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int2').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int3').set('funcname', 'C_rho');
model.material('mat1').propertyGroup('def').func('int3').set('table', {'0' '1004.4';  ...
'5' '1003.8';  ...
'10' '1002.5';  ...
'15' '1002';  ...
'20' '1001';  ...
'25' '999.63';  ...
'30' '998.66';  ...
'35' '996.7';  ...
'40' '994.89';  ...
'45' '992.84';  ...
'50' '991.51';  ...
'55' '988.4';  ...
'60' '985.91';  ...
'65' '983.39';  ...
'70' '980.71';  ...
'80' '974.59';  ...
'90' '967.98';  ...
'100' '960.99';  ...
'150' '919.52';  ...
'200' '869.35'});
model.material('mat1').propertyGroup('def').func('int3').set('fununit', {'1'});
model.material('mat1').propertyGroup('def').func('int3').set('argunit', {'1'});
model.material('mat1').propertyGroup('def').func('int4').set('source', 'file');
model.material('mat1').propertyGroup('def').func('int4').set('importedname', 'mu_KOH.txt');
model.material('mat1').propertyGroup('def').func('int4').set('importeddim', '2D');
model.material('mat1').propertyGroup('def').func('int4').set('funcs', {'mu' '1'});
model.material('mat1').propertyGroup('def').func('int4').set('fununit', {'mPa*s'});
model.material('mat1').propertyGroup('def').func('int4').set('argunit', {'%' '1'});
model.material('mat1').propertyGroup('def').func('int4').set('sourcetype', 'model');
model.material('mat1').propertyGroup('def').func('int4').set('nargs', '2');
model.material('mat1').propertyGroup('def').func('int4').set('struct', 'spreadsheet');
model.material('mat1').propertyGroup('def').set('T_reg', 'min(max(T,0[degC]),200[degC])');
model.material('mat1').propertyGroup('def').descr('T_reg', '');
model.material('mat1').propertyGroup('def').set('M_reg', 'min(max(c,1e-6[M]),12[M])/1[M]');
model.material('mat1').propertyGroup('def').descr('M_reg', '');
model.material('mat1').propertyGroup('def').set('density', '(A_rho(T_degC)*M_reg^2+B_rho(T_degC)*M_reg+C_rho(T_degC))*1[kg/m^3]');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:density', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat1').propertyGroup('def').set('T_degC', '(T_reg-0[degC])/1[K]');
model.material('mat1').propertyGroup('def').descr('T_degC', '');
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'mu(c*56.1[g/mol]/rho,T_degC)');
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:dynamicviscosity', ['K. I. Kuznetsov et al "Measurements of the Dynamic Viscosity and Density of KOH' newline 'Solutions at Atmospheric Pressure", High Temperature, 2020, Vol. 58, No. 6, pp. 806' native2unicode(hex2dec({'20' '13'}), 'unicode') '811']);
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T_K', 'def.T_reg/1[K]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T_K', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('M', 'def.M_reg');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('M', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('A', '-2.041');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('A', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('B', '-0.0028');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('B', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('C', '0.005332');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('C', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('D', '207.2');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('D', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('E', '0.001043');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('E', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('F', '-0.0000003');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('F', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');

model.physics('we').prop('H2GasMixture').set('GasPhaseDiffusion', false);
model.physics('we').prop('H2GasMixture').set('H2O_l', true);
model.physics('we').prop('O2GasMixture').set('GasPhaseDiffusion', false);
model.physics('we').prop('O2GasMixture').set('H2O_l', true);
model.physics('we').feature('h2gasph1').set('MixtureSpecification', 'HumidifiedMixture');
model.physics('we').feature('h2gasph1').set('T_hum', 'T');
model.physics('we').feature('h2gasph1').set('pA_hum', 'p_gas');
model.physics('we').feature('o2gasph1').set('MixtureSpecification', 'HumidifiedMixture');
model.physics('we').feature('o2gasph1').set('T_hum', 'T');
model.physics('we').feature('o2gasph1').set('pA_hum', 'p_gas');
model.physics('we').create('sep1', 'Separator', 2);
model.physics('we').feature('sep1').selection.set([2]);
model.physics('we').feature('sep1').set('epsl', 'eps_sep');
model.physics('we').create('h2gec1', 'H2GasElectrolyteCompartment', 2);
model.physics('we').feature('h2gec1').selection.set([1]);
model.physics('we').feature('h2gec1').selection.named('geom1_r1_dom');
model.physics('we').create('o2gec1', 'O2GasElectrolyteCompartment', 2);
model.physics('we').feature('o2gec1').selection.named('geom1_r3_dom');
model.physics('we').create('h2es1', 'H2ElectrodeSurface', 1);
model.physics('we').feature('h2es1').selection.named('geom1_sel1');
model.physics('we').feature('h2es1').feature('h2er1').set('nuH2O', 0);
model.physics('we').feature('h2es1').feature('h2er1').set('nuH2O_l', -1);
model.physics('we').feature('h2es1').feature('h2er1').set('i0_ref', 'i0_ref_H2');
model.physics('we').create('o2es1', 'O2ElectrodeSurface', 1);
model.physics('we').feature('o2es1').selection.named('geom1_sel2');
model.physics('we').feature('o2es1').set('phisext0', 'E_cell');
model.physics('we').feature('o2es1').feature('o2er1').set('nuH2O', 0);
model.physics('we').feature('o2es1').feature('o2er1').set('nuH2O_l', -1);
model.physics('we').feature('o2es1').feature('o2er1').set('i0_ref', 'i0_ref_O2');

model.common('cminpt').set('modified', {'temperature' 'T'; 'concentration' 'c_KOH'; 'pressure' 'p_gas'});

model.probe.create('bnd1', 'Boundary');
model.probe('bnd1').model('comp1');
model.probe('bnd1').set('intsurface', true);
model.probe('bnd1').selection.named('geom1_sel2');
model.probe('bnd1').set('expr', 'we.iloc_o2er1');
model.probe('bnd1').set('descr', 'Local current density');
model.probe('bnd1').set('unit', 'A/cm^2');
model.probe('bnd1').set('descractive', true);
model.probe('bnd1').set('descr', 'Average cell current density');

model.study('std1').label('Study 1 - No Gas Evolution');
model.study('std1').feature('stat').setEntry('activate', 'ee', false);
model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'W_H2', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'W_H2', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'm', 0);
model.study('std1').feature('stat').setIndex('pname', 'E_cell', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(1.2,0.05,1.9)', 0);
model.study('std1').feature('stat').setIndex('punit', 'V', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 2 3]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (we)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').create('i2', 'Iterative');
model.sol('sol1').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol1').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'stat');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('control', 'stat');
model.sol('sol1').create('s2', 'Stationary');
model.sol('sol1').feature('s2').set('stol', 1.0E-4);
model.sol('sol1').feature('s2').create('p1', 'Parametric');
model.sol('sol1').feature('s2').feature.remove('pDef');
model.sol('sol1').feature('s2').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s2').feature('p1').set('control', 'stat');
model.sol('sol1').feature('s2').set('control', 'stat');
model.sol('sol1').feature('s2').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (we)');
model.sol('sol1').feature('s2').create('i1', 'Iterative');
model.sol('sol1').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol1').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').create('i2', 'Iterative');
model.sol('sol1').feature('s2').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('s2').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol1').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');

model.probe('bnd1').genResult('none');

model.sol('sol1').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 15, 0);
model.result('pg2').label('Electrolyte Potential (we)');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', {'we.phil'});
model.result('pg2').create('arws1', 'ArrowSurface');
model.result('pg2').feature('arws1').set('expr', {'we.Ilx' 'we.Ily'});
model.result('pg2').feature('arws1').set('arrowbase', 'center');
model.result('pg2').feature('arws1').set('color', 'gray');
model.result('pg2').feature('arws1').create('filt1', 'Filter');
model.result('pg2').feature('arws1').feature('filt1').set('expr', 'isdefined(we.phil)');
model.result('pg2').feature('arws1').feature('filt1').set('nodespec', 'all');
model.result('pg2').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').set('switchxy', true);
model.result('pg1').set('showlegends', false);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').label('Variables 1 - Hydrogen Gas Compartment');
model.variable('var1').selection.geom('geom1', 2);
model.variable('var1').selection.named('geom1_r1_dom');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('v_in', 'v_in_H2*6/W_H2^2*x*(W_H2-x)', 'Inlet velocity');
model.variable('var1').set('m_OH', '-we.Ilx/F_const*MOH', 'Ion mass flow rate');
model.variable('var1').set('eps_liquid', 'max(ee.phic,1e-4)', 'Electrolyte volume fraction');
model.variable('var1').set('slipevelmag', 'sqrt(max((udx-ucx)^2+(udy-ucy)^2,eps^2))', 'Slip velocity magnitude');
model.variable('var1').set('prefac', '-ee.rhoc*K_H2_div_d*slipevelmag', 'Prefactor');
model.variable('var1').set('FD_BDx', 'prefac*d(phid,x)', 'Bubble dispersion volume force, x-component in dispersed phase');
model.variable('var1').set('FD_BDy', 'prefac*d(phid,y)', 'Bubble dispersion volume force, y-component in dispersed phase');
model.variable('var1').set('FC_BDx', '-prefac*d(phid,x)*phid/max(ee.phic,1e-4)', 'Bubble dispersion volume force, x-component in continuous phase');
model.variable('var1').set('FC_BDy', '-prefac*d(phid,y)*phid/max(ee.phic,1e-4)', 'Bubble dispersion volume force, y-component in continuous phase');
model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').label('Variables 2 - Oxygen Gas Compartment');
model.variable('var2').selection.geom('geom1', 2);
model.variable('var2').selection.named('geom1_r3_dom');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('v_in', 'v_in_O2*6/W_O2^2*(x-W_sep-W_H2)*(W_H2-(x-W_sep-W_H2))', 'Inlet velocity');
model.variable('var2').set('m_OH', 'we.Ilx/F_const*MOH', 'Ion mass flow rate');
model.variable('var2').set('eps_liquid', 'max(ee.phic,1e-4)', 'Electrolyte volume fraction');
model.variable('var2').set('slipevelmag', 'sqrt(max((udx-ucx)^2+(udy-ucy)^2,eps^2))', 'Slip velocity magnitude');
model.variable('var2').set('prefac', '-ee.rhoc*K_O2_div_d*slipevelmag', 'Prefactor');
model.variable('var2').set('FD_BDx', 'prefac*d(phid,x)', 'Bubble dispersion volume force, x-component in dispersed phase');
model.variable('var2').set('FD_BDy', 'prefac*d(phid,y)', 'Bubble dispersion volume force, y-component in dispersed phase');
model.variable('var2').set('FC_BDx', '-prefac*d(phid,x)*phid/max(ee.phic,1e-4)', 'Bubble dispersion volume force, x-component in continuous phase');
model.variable('var2').set('FC_BDy', '-prefac*d(phid,y)*phid/max(ee.phic,1e-4)', 'Bubble dispersion volume force, y-component in continuous phase');
model.variable.create('var3');
model.variable('var3').model('comp1');
model.variable('var3').label('Variables 3 - Hydrogen Electrode');
model.variable('var3').selection.geom('geom1', 1);
model.variable('var3').selection.named('geom1_sel1');

% To import content from file, use:
% model.variable('var3').loadFile('FILENAME');
model.variable('var3').set('N_H2_far', '-we.iloc_h2er1/(2*F_const)', 'Faradaic gas evolution rate');
model.variable('var3').set('N_H2O_evap', 'N_H2_far*xH2O/(1-xH2O)', 'Water evaporation rate');
model.variable('var3').set('m_gas', 'N_H2O_evap*MH2O+N_H2_far*MH2', 'Gas phase mass flow rate');
model.variable('var3').set('m_liquid', '-m_gas', 'Liquid phase mass flow rate');
model.variable.create('var4');
model.variable('var4').model('comp1');
model.variable('var4').label('Variables 4 - Oxygen Electrode');
model.variable('var4').selection.geom('geom1', 1);
model.variable('var4').selection.named('geom1_sel2');

% To import content from file, use:
% model.variable('var4').loadFile('FILENAME');
model.variable('var4').set('N_O2_far', 'we.iloc_o2er1/(4*F_const)', 'Faradaic gas evolution rate');
model.variable('var4').set('N_H2O_evap', 'N_O2_far*xH2O/(1-xH2O)', 'Water evaporation rate');
model.variable('var4').set('m_gas', 'N_H2O_evap*MH2O+N_O2_far*MO2', 'Gas phase mass flow rate');
model.variable('var4').set('m_liquid', '-m_gas', 'Liquid phase mass flow rate');

model.physics('we').feature('h2gec1').set('epsl', 'eps_liquid');
model.physics('we').feature('o2gec1').set('epsl', 'eps_liquid');
model.physics('we').feature('h2es1').feature('h2er1').set('i0_ref', 'i0_ref_H2*eps_liquid');
model.physics('we').feature('o2es1').feature('o2er1').set('i0_ref', 'i0_ref_O2*eps_liquid');
model.physics('ee').selection.named('geom1_unisel2');
model.physics('ee').prop('PhysicalModelProperty').set('DispersedPhase', 'LiquidDropletsBubbles');
model.physics('ee').feature('pp1').set('minput_concentration_src', 'fromCommonDef');
model.physics('ee').feature('pp1').set('rhod_mat', 'root.comp1.we.rho');
model.physics('ee').feature('pp1').set('mud_mat', 'root.comp1.we.mu');
model.physics('ee').feature('pp1').set('diam', 'd_bubble');
model.physics('ee').feature('init1').set('uc', {'0' 'v_in' '0'});
model.physics('ee').feature('init1').set('ud', {'0' 'v_in' '0'});
model.physics('ee').feature('init1').set('p', 'g_const*1000[kg/m^3]*(H_elec-y)');
model.physics('ee').create('gr1', 'Gravity', 2);
model.physics('ee').feature('gr1').selection.all;
model.physics('ee').create('vf1', 'VolumeForce', 2);
model.physics('ee').feature('vf1').label('Volume Force - Bubble Dispersion');
model.physics('ee').feature('vf1').set('Fc', {'FC_BDx' 'FC_BDy' '0'});
model.physics('ee').feature('vf1').set('Fd', {'FD_BDx' 'FD_BDy' '0'});
model.physics('ee').feature('vf1').selection.all;
model.physics('ee').create('inl1', 'Inlet', 1);
model.physics('ee').feature('inl1').set('uc0', {'0' 'v_in' '0'});
model.physics('ee').feature('inl1').set('ud0', {'0' 'v_in' '0'});
model.physics('ee').feature('inl1').set('phidConditionMixtureDispersed', 'NoDispersedPhaseFlux');
model.physics('ee').feature('inl1').selection.named('geom1_sel3');
model.physics('ee').create('out1', 'Outlet', 1);
model.physics('ee').feature('out1').selection.named('geom1_sel4');
model.physics('ee').create('wallbc2', 'WallBC', 1);
model.physics('ee').feature('wallbc2').label('Wall 2 - Electrodes');
model.physics('ee').feature('wallbc2').selection.named('geom1_unisel1');
model.physics('ee').feature('wallbc2').set('leakageC', true);
model.physics('ee').feature('wallbc2').set('mPricC', 'm_liquid');
model.physics('ee').feature('wallbc2').set('DispersedPhaseBoundaryCondition', 'DispersedPhaseLeakage');
model.physics('ee').feature('wallbc2').set('mPricD', 'm_gas');
model.physics('ee').create('wallbc3', 'WallBC', 1);
model.physics('ee').feature('wallbc3').label('Wall 3 - Separator');
model.physics('ee').feature('wallbc3').selection.named('geom1_sel5');
model.physics('ee').feature('wallbc3').set('leakageC', true);
model.physics('ee').feature('wallbc3').set('mPricC', 'm_OH');

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');

model.physics('we').feature('o2es1').set('phisext0', 'E_cell+rm1(t[1/min])*0.1[V]');

model.probe.duplicate('bnd2', 'bnd1');

model.result.table.create('tbl2', 'Table');

model.probe('bnd2').set('table', 'tbl2');

model.mesh('mesh1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('dis1').selection.set([1 4 7 10]);
model.mesh('mesh1').feature('dis1').set('numelem', 500);
model.mesh('mesh1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('dis2').selection.set([2 3 8 9]);
model.mesh('mesh1').feature('dis2').set('numelem', 20);
model.mesh('mesh1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('dis3').selection.set([5 6]);
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(2);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').set('smoothtransition', false);
model.mesh('mesh1').feature('bl1').feature('blp').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 2);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', '3e-5');
model.mesh('mesh1').run;

model.study.create('std2');
model.study('std2').create('cdi', 'CurrentDistributionInitialization');
model.study('std2').feature('cdi').set('solnum', 'auto');
model.study('std2').feature('cdi').set('notsolnum', 'auto');
model.study('std2').feature('cdi').set('outputmap', {});
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').setSolveFor('/physics/we', true);
model.study('std2').feature('cdi').setSolveFor('/physics/ee', true);
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('plotgroup', 'Default');
model.study('std2').feature('stat').set('solnum', 'auto');
model.study('std2').feature('stat').set('notsolnum', 'auto');
model.study('std2').feature('stat').set('outputmap', {});
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').set('ngenAUX', '1');
model.study('std2').feature('stat').set('goalngenAUX', '1');
model.study('std2').feature('stat').setSolveFor('/physics/we', true);
model.study('std2').feature('stat').setSolveFor('/physics/ee', true);
model.study('std2').label('Study 2 - Including Gas Evolution');
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('tunit', 'min');
model.study('std2').feature('time').set('tlist', 'range(0,1,7)');
model.study('std2').feature('stat').set('probesel', 'none');
model.study('std2').feature('time').set('probesel', 'manual');
model.study('std2').feature('time').set('probes', {'bnd2'});
model.study('std1').feature('stat').set('probesel', 'manual');
model.study('std1').feature('stat').set('probes', {'bnd1'});

model.sol.create('sol3');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1 3]);

model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol3').feature('v1').set('control', 'cdi');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 1.0E-4);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').label('Direct (we)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').create('i2', 'Iterative');
model.sol('sol3').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol3').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std2');
model.sol('sol3').feature('st2').set('studystep', 'stat');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phid').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_phid').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('control', 'stat');
model.sol('sol3').create('s2', 'Stationary');
model.sol('sol3').feature('s2').set('stol', 1.0E-4);
model.sol('sol3').feature('s2').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('s2').create('seDef', 'Segregated');
model.sol('sol3').feature('s2').create('se1', 'Segregated');
model.sol('sol3').feature('s2').feature('se1').feature.remove('ssDef');
model.sol('sol3').feature('s2').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('s2').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_uc' 'comp1_ud' 'comp1_we_phil' 'comp1_we_phis'});
model.sol('sol3').feature('s2').feature('se1').feature('ss1').set('subdamp', 0.5);
model.sol('sol3').feature('s2').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol3').feature('s2').create('d1', 'Direct');
model.sol('sol3').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s2').feature('d1').label('Direct, fluid flow variables (ee) (Merged)');
model.sol('sol3').feature('s2').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol3').feature('s2').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol3').feature('s2').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('segvar', {'comp1_phid'});
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('subdamp', 0.35);
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('subntolfact', 1);
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('subiter', 2);
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('subtermconst', 'itertol');
model.sol('sol3').feature('s2').create('d2', 'Direct');
model.sol('sol3').feature('s2').feature('d2').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s2').feature('d2').label('Direct, volume fraction (ee)');
model.sol('sol3').feature('s2').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol3').feature('s2').feature('se1').feature('ss2').label('Volume Fraction');
model.sol('sol3').feature('s2').feature('se1').set('segstabacc', 'segcflcmp');
model.sol('sol3').feature('s2').feature('se1').set('subinitcfl', 5);
model.sol('sol3').feature('s2').feature('se1').set('submincfl', 10000);
model.sol('sol3').feature('s2').feature('se1').set('subkppid', 0.65);
model.sol('sol3').feature('s2').feature('se1').set('subkdpid', 0.05);
model.sol('sol3').feature('s2').feature('se1').set('subkipid', 0.05);
model.sol('sol3').feature('s2').feature('se1').set('subcfltol', 0.1);
model.sol('sol3').feature('s2').feature('se1').set('segcflaa', true);
model.sol('sol3').feature('s2').feature('se1').set('segcflaacfl', 9000);
model.sol('sol3').feature('s2').feature('se1').set('segcflaafact', 1);
model.sol('sol3').feature('s2').feature('se1').set('maxsegiter', 200);
model.sol('sol3').feature('s2').create('i1', 'Iterative');
model.sol('sol3').feature('s2').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('s2').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s2').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol3').feature('s2').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s2').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s2').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s2').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').create('i2', 'Iterative');
model.sol('sol3').feature('s2').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('s2').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('s2').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol3').feature('s2').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s2').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').create('i3', 'Iterative');
model.sol('sol3').feature('s2').feature('i3').set('linsolver', 'gmres');
model.sol('sol3').feature('s2').feature('i3').set('prefuntype', 'left');
model.sol('sol3').feature('s2').feature('i3').set('itrestart', 50);
model.sol('sol3').feature('s2').feature('i3').set('rhob', 20);
model.sol('sol3').feature('s2').feature('i3').set('maxlinit', 1000);
model.sol('sol3').feature('s2').feature('i3').set('nlinnormuse', 'on');
model.sol('sol3').feature('s2').feature('i3').label('AMG, fluid flow variables (ee)');
model.sol('sol3').feature('s2').feature('i3').create('mg1', 'Multigrid');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('strconn', 0.02);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsfilter', false);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsfilter', false);
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s2').create('i4', 'Iterative');
model.sol('sol3').feature('s2').feature('i4').set('linsolver', 'gmres');
model.sol('sol3').feature('s2').feature('i4').set('prefuntype', 'left');
model.sol('sol3').feature('s2').feature('i4').set('itrestart', 50);
model.sol('sol3').feature('s2').feature('i4').set('rhob', 400);
model.sol('sol3').feature('s2').feature('i4').set('maxlinit', 1000);
model.sol('sol3').feature('s2').feature('i4').set('nlinnormuse', 'on');
model.sol('sol3').feature('s2').feature('i4').label('AMG, volume fraction (ee)');
model.sol('sol3').feature('s2').feature('i4').create('mg1', 'Multigrid');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('strconn', 0.01);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('iter', 0);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.3);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('pr').feature('sl1').set('maxline', 15);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.3);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('po').feature('sl1').set('maxline', 15);
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s2').feature('i4').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('s2').feature.remove('fcDef');
model.sol('sol3').feature('s2').feature.remove('seDef');
model.sol('sol3').create('su2', 'StoreSolution');
model.sol('sol3').create('st3', 'StudyStep');
model.sol('sol3').feature('st3').set('study', 'std2');
model.sol('sol3').feature('st3').set('studystep', 'time');
model.sol('sol3').create('v3', 'Variables');
model.sol('sol3').feature('v3').feature('comp1_we_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v3').feature('comp1_phid').set('scalemethod', 'manual');
model.sol('sol3').feature('v3').feature('comp1_we_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v3').feature('comp1_we_phil').set('scaleval', '1');
model.sol('sol3').feature('v3').feature('comp1_phid').set('scaleval', '1');
model.sol('sol3').feature('v3').feature('comp1_we_phis').set('scaleval', '1');
model.sol('sol3').feature('v3').set('initmethod', 'sol');
model.sol('sol3').feature('v3').set('initsol', 'sol3');
model.sol('sol3').feature('v3').set('initsoluse', 'sol5');
model.sol('sol3').feature('v3').set('notsolmethod', 'sol');
model.sol('sol3').feature('v3').set('notsol', 'sol3');
model.sol('sol3').feature('v3').set('notsoluse', 'sol5');
model.sol('sol3').feature('v3').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,1,7)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'pg1');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'manual');
model.sol('sol3').feature('t1').set('probes', {'bnd2'});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 0.001);
model.sol('sol3').feature('t1').set('atolglobalmethod', 'scaled');
model.sol('sol3').feature('t1').set('atolglobalfactor', 0.05);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('atolmethod', {'comp1_p' 'scaled' 'comp1_phid' 'global' 'comp1_uc' 'global' 'comp1_ud' 'global' 'comp1_we_phil' 'global'  ...
'comp1_we_phis' 'global'});
model.sol('sol3').feature('t1').set('atolvaluemethod', {'comp1_p' 'factor' 'comp1_phid' 'factor' 'comp1_uc' 'factor' 'comp1_ud' 'factor' 'comp1_we_phil' 'factor'  ...
'comp1_we_phis' 'factor'});
model.sol('sol3').feature('t1').set('atolfactor', {'comp1_p' '1' 'comp1_phid' '0.1' 'comp1_uc' '0.1' 'comp1_ud' '0.1' 'comp1_we_phil' '0.1'  ...
'comp1_we_phis' '0.1'});
model.sol('sol3').feature('t1').set('eventout', true);
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('estrat', 'exclude');
model.sol('sol3').feature('t1').set('rhoinf', 0.5);
model.sol('sol3').feature('t1').set('predictor', 'constant');
model.sol('sol3').feature('t1').set('maxorder', 2);
model.sol('sol3').feature('t1').set('stabcntrl', true);
model.sol('sol3').feature('t1').set('bwinitstepfrac', '0.01');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('seDef', 'Segregated');
model.sol('sol3').feature('t1').create('se1', 'Segregated');
model.sol('sol3').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol3').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_p' 'comp1_uc' 'comp1_ud' 'comp1_we_phil' 'comp1_we_phis'});
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.8);
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').feature('d1').label('Direct, fluid flow variables (ee) (Merged)');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol3').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_phid'});
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('subdamp', 0.8);
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('subiter', 1);
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('subntolfact', 0.1);
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('subtermconst', 'iter');
model.sol('sol3').feature('t1').create('d2', 'Direct');
model.sol('sol3').feature('t1').feature('d2').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d2').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').feature('d2').label('Direct, volume fraction (ee)');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd2');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').label('Volume Fraction');
model.sol('sol3').feature('t1').feature('se1').set('ntolfact', 0.5);
model.sol('sol3').feature('t1').feature('se1').set('segstabacc', 'segaacc');
model.sol('sol3').feature('t1').feature('se1').set('segaaccdim', 5);
model.sol('sol3').feature('t1').feature('se1').set('segaaccmix', 0.9);
model.sol('sol3').feature('t1').feature('se1').set('segaaccdelay', 0);
model.sol('sol3').feature('t1').feature('se1').set('maxsegiter', 10);
model.sol('sol3').feature('t1').feature('se1').set('ratelimitactive', 'on');
model.sol('sol3').feature('t1').feature('se1').set('ratelimit', 10);
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i1').label('Algebraic Multigrid (we)');
model.sol('sol3').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').create('i2', 'Iterative');
model.sol('sol3').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i2').label('Geometric Multigrid (we)');
model.sol('sol3').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').create('i3', 'Iterative');
model.sol('sol3').feature('t1').feature('i3').set('linsolver', 'gmres');
model.sol('sol3').feature('t1').feature('i3').set('prefuntype', 'left');
model.sol('sol3').feature('t1').feature('i3').set('itrestart', 50);
model.sol('sol3').feature('t1').feature('i3').set('rhob', 20);
model.sol('sol3').feature('t1').feature('i3').set('maxlinit', 100);
model.sol('sol3').feature('t1').feature('i3').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i3').label('AMG, fluid flow variables (ee)');
model.sol('sol3').feature('t1').feature('i3').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('maxcoarsedof', 80000);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('strconn', 0.02);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('iter', 0);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgssolv', 'stored');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('approxscgs', true);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('pr').feature('sc1').set('scgsfilter', false);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').create('sc1', 'SCGS');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsrelax', 0.7);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsmethod', 'lines');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsvertexrelax', 0.7);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgssolv', 'stored');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('approxscgs', true);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsdirectmaxsize', 1000);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('po').feature('sc1').set('scgsfilter', false);
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('i3').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').create('i4', 'Iterative');
model.sol('sol3').feature('t1').feature('i4').set('linsolver', 'gmres');
model.sol('sol3').feature('t1').feature('i4').set('prefuntype', 'left');
model.sol('sol3').feature('t1').feature('i4').set('itrestart', 50);
model.sol('sol3').feature('t1').feature('i4').set('rhob', 400);
model.sol('sol3').feature('t1').feature('i4').set('maxlinit', 200);
model.sol('sol3').feature('t1').feature('i4').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i4').label('AMG, volume fraction (ee)');
model.sol('sol3').feature('t1').feature('i4').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('mgcycle', 'v');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('strconn', 0.01);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('nullspace', 'constant');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('usesmooth', false);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('loweramg', true);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').set('compactaggregation', false);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('iter', 0);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linerelax', 0.3);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('pr').feature('sl1').set('maxline', 15);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('linesweeptype', 'ssor');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('iter', 1);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('linerelax', 0.3);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('linealgorithm', 'matrix');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('linemethod', 'uncoupled');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('seconditer', 1);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('relax', 0.5);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('po').feature('sl1').set('maxline', 15);
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('i4').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').feature('t1').feature.remove('seDef');
model.sol('sol3').feature('v2').set('notsolnum', 'auto');
model.sol('sol3').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol3').attach('std2');

model.probe('bnd2').genResult('none');

model.sol('sol3').runAll;

model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset4');
model.result('pg3').setIndex('looplevel', 8, 0);
model.result('pg3').label('Electrolyte Potential (we) 1');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'we.phil'});
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'we.Ilx' 'we.Ily'});
model.result('pg3').feature('arws1').set('arrowbase', 'center');
model.result('pg3').feature('arws1').set('color', 'gray');
model.result('pg3').feature('arws1').create('filt1', 'Filter');
model.result('pg3').feature('arws1').feature('filt1').set('expr', 'isdefined(we.phil)');
model.result('pg3').feature('arws1').feature('filt1').set('nodespec', 'all');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').label('Continuous Phase (ee)');
model.result('pg4').set('data', 'dset4');
model.result('pg4').setIndex('looplevel', 8, 0);
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('data', 'dset4');
model.result('pg4').setIndex('looplevel', 8, 0);
model.result('pg4').set('defaultPlotID', 'eulereulermodel/EE_ResultDefaults/icom1/pdef1/pcond1/pg1');
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Velocity Magnitude, Continuous Phase');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('expr', 'ee.Uc');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').label('Dispersed Phase (ee)');
model.result('pg5').set('data', 'dset4');
model.result('pg5').setIndex('looplevel', 8, 0);
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('data', 'dset4');
model.result('pg5').setIndex('looplevel', 8, 0);
model.result('pg5').set('defaultPlotID', 'eulereulermodel/EE_ResultDefaults/icom1/pdef1/pcond1/pg2');
model.result('pg5').feature.create('surf1', 'Surface');
model.result('pg5').feature('surf1').label('Dispersed Phase Volume Fraction');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('expr', 'phid');
model.result('pg5').feature('surf1').set('smooth', 'internal');
model.result('pg5').feature('surf1').set('showsolutionparams', 'on');
model.result('pg5').feature('surf1').set('data', 'parent');
model.result('pg3').run;
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').label('Polarization Plots');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Average Electrode Current Density (A/cm<sup>2</sup>)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell Voltage (V)');
model.result('pg1').set('showlegends', true);
model.result('pg1').set('legendpos', 'lowerright');
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp1').set('legendmethod', 'manual');
model.result('pg1').feature('tblp1').setIndex('legends', 'Study 1 - No gas evolution', 0);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg1').feature('tblp2').set('preprocx', 'linear');
model.result('pg1').feature('tblp2').set('scalingx', 0.1);
model.result('pg1').feature('tblp2').set('shiftx', 'E_cell');
model.result('pg1').feature('tblp2').set('legendmethod', 'manual');
model.result('pg1').feature('tblp2').setIndex('legends', 'Study 2 - With gas evolution', 0);
model.result('pg1').set('window', 'window1');
model.result('pg1').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.dataset.create('cln1', 'CutLine2D');
model.result.dataset('cln1').set('data', 'dset4');
model.result.dataset('cln1').setIndex('genpoints', 'W_cell/2', 0, 0);
model.result.dataset('cln1').setIndex('genpoints', 'W_cell/2', 1, 0);
model.result.dataset('cln1').setIndex('genpoints', 'H_elec', 1, 1);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Mid-separator Current Density');
model.result('pg6').set('data', 'cln1');
model.result('pg6').setIndex('looplevelinput', 'last', 0);
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Mid-separator current density (A/m<sup>2</sup>)');
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg6').feature('lngr1').set('linewidth', 'preference');
model.result('pg6').feature('lngr1').set('expr', '-we.Ilx');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'y');
model.result('pg6').run;
model.result('pg2').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').placeAfter('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').label('Group 1 - Study 1');

model.result('pg3').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup('grp2').placeAfter('plotgroup', 'pg1');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg3');
model.nodeGroup('grp2').add('plotgroup', 'pg4');
model.nodeGroup('grp2').add('plotgroup', 'pg5');
model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').label('Group 2 - Study 2');

model.title('Alkaline Electrolyzer');

model.description(['Alkaline water electrolysis is a well-established industrial process for producing hydrogen gas. In the cell, hydrogen gas is formed at the cathode whereas oxygen gas is formed at the anode.' newline  newline 'The electrolyte is an aqueous liquid, and when the evolved gases form bubbles, the effective ionic conductivity is lowered. The generated gases may have a detrimental effect on cell performance also due to a lowered accessible surface area for the electrode reactions.' newline  newline 'This example investigates the impact of the gas formation on the performance of an alkaline electrolysis cell.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;

model.label('alkaline_electrolyzer.mph');

model.modelNode.label('Components');

out = model;
