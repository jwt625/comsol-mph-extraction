function out = model
%
% aec_shunt_currents.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Fuel_Cell_and_Electrolyzer_Module/Electrolyzers');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
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
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('solnum', 'auto');
model.study('std1').feature('stat').set('notsolnum', 'auto');
model.study('std1').feature('stat').set('outputmap', {});
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').set('ngenAUX', '1');
model.study('std1').feature('stat').set('goalngenAUX', '1');
model.study('std1').feature('stat').setSolveFor('/physics/we', true);

model.geom('geom1').insertFile('aec_shunt_currents_geom_sequence.mph', 'geom1');
model.geom('geom1').run('unisel7');

model.view.create('view20', 'geom1');
model.view('view20').model('comp1');
model.view('view20').camera.set('viewscaletype', 'manual');
model.view('view20').camera.set('xscale', 10);

model.param.label('Geometry Parameters');
model.param.create('par2');
model.param('par2').label('Physics Parameters');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('c_KOH', '6[M]', 'KOH concentration');
model.param('par2').set('E_cell', '1.3[V]', 'Cell voltage (varied in sweep)');
model.param('par2').set('E_stack', 'N_cells*E_cell', 'Stack voltage');
model.param('par2').set('T', '85[degC]', 'Cell temperature');
model.param('par2').set('epsl_upper', '50[%]', 'Electrolyte volume fraction in upper channels');
model.param('par2').set('epsl_lower', '100[%]', 'Electrolyte volume fraction in lower channels');
model.param('par2').set('p_abs', '80[bar]', 'Stack operating pressure');
model.param('par2').set('epsl_sep', '50[%]', 'Electrolyte volume fraction in separator');
model.param('par2').set('i0_ref_h2', '100[A/m^2]', 'Reference exchange current density, hydrogen evolution');
model.param('par2').set('i0_ref_o2', '1[A/m^2]', 'Reference exchange current density, oxygen evolution');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').label('Steel AISI 4340');
model.material('mat1').set('family', 'steel');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('Enu').set('E', '205[GPa]');
model.material('mat1').propertyGroup('Enu').set('nu', '0.28');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('int2', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('int3', 'Interpolation');
model.material('mat2').propertyGroup('def').func.create('int4', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat2').label('Potassium Hydroxide, KOH');
model.material('mat2').comments([ newline ]);
model.material('mat2').set('family', 'water');
model.material('mat2').propertyGroup('def').func('int1').set('funcname', 'A_rho');
model.material('mat2').propertyGroup('def').func('int1').set('table', {'0' '-0.5031';  ...
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
model.material('mat2').propertyGroup('def').func('int1').set('fununit', {'1'});
model.material('mat2').propertyGroup('def').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('def').func('int2').set('funcname', 'B_rho');
model.material('mat2').propertyGroup('def').func('int2').set('table', {'0' '45.876';  ...
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
model.material('mat2').propertyGroup('def').func('int2').set('fununit', {'1'});
model.material('mat2').propertyGroup('def').func('int2').set('argunit', {'1'});
model.material('mat2').propertyGroup('def').func('int3').set('funcname', 'C_rho');
model.material('mat2').propertyGroup('def').func('int3').set('table', {'0' '1004.4';  ...
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
model.material('mat2').propertyGroup('def').func('int3').set('fununit', {'1'});
model.material('mat2').propertyGroup('def').func('int3').set('argunit', {'1'});
model.material('mat2').propertyGroup('def').func('int4').set('source', 'file');
model.material('mat2').propertyGroup('def').func('int4').set('importedname', 'mu_KOH.txt');
model.material('mat2').propertyGroup('def').func('int4').set('importeddim', '2D');
model.material('mat2').propertyGroup('def').func('int4').set('funcs', {'mu' '1'});
model.material('mat2').propertyGroup('def').func('int4').set('fununit', {'mPa*s'});
model.material('mat2').propertyGroup('def').func('int4').set('argunit', {'%' '1'});
model.material('mat2').propertyGroup('def').func('int4').set('sourcetype', 'model');
model.material('mat2').propertyGroup('def').func('int4').set('nargs', '2');
model.material('mat2').propertyGroup('def').func('int4').set('struct', 'spreadsheet');
model.material('mat2').propertyGroup('def').set('T_reg', 'min(max(T,0[degC]),200[degC])');
model.material('mat2').propertyGroup('def').descr('T_reg', '');
model.material('mat2').propertyGroup('def').set('M_reg', 'min(max(c,1e-6[M]),12[M])/1[M]');
model.material('mat2').propertyGroup('def').descr('M_reg', '');
model.material('mat2').propertyGroup('def').set('density', '(A_rho(T_degC)*M_reg^2+B_rho(T_degC)*M_reg+C_rho(T_degC))*1[kg/m^3]');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:density', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat2').propertyGroup('def').set('T_degC', '(T_reg-0[degC])/1[K]');
model.material('mat2').propertyGroup('def').descr('T_degC', '');
model.material('mat2').propertyGroup('def').set('dynamicviscosity', 'mu(c*56.1[g/mol]/rho,T_degC)');
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:dynamicviscosity', ['K. I. Kuznetsov et al "Measurements of the Dynamic Viscosity and Density of KOH' newline 'Solutions at Atmospheric Pressure", High Temperature, 2020, Vol. 58, No. 6, pp. 806' native2unicode(hex2dec({'20' '13'}), 'unicode') '811']);
model.material('mat2').propertyGroup('def').addInput('concentration');
model.material('mat2').propertyGroup('def').addInput('temperature');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('sigmal', {'(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]' '0' '0' '0' '(A*M+B*M^2+C*M*T_K+D*M/T_K+E*M^3+F*M^2*T_K^2)*1[S/cm]'});
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['R.J. Gilliama, J.W. Graydonb, D.W. Kirkb, S.J. Thorpea, Int. J. Hydrogen Energy 32 (2007) 359 ' native2unicode(hex2dec({'20' '13'}), 'unicode') ' 364']);
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('T_K', 'def.T_reg/1[K]');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('T_K', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('M', 'def.M_reg');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('M', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('A', '-2.041');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('A', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('B', '-0.0028');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('B', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('C', '0.005332');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('C', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('D', '207.2');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('D', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('E', '0.001043');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('E', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').set('F', '-0.0000003');
model.material('mat2').propertyGroup('ElectrolyteConductivity').descr('F', '');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat2').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').selection.named('geom1_csel1_dom');
model.material('mat2').selection.named('geom1_unisel3');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('epsl', 'if(z<-H_active/2,epsl_lower,if(z>H_active/2,epsl_upper, (z+H_active/2)/H_active*(epsl_upper-epsl_lower)+epsl_lower))', 'Electrolyte volume fraction');
model.variable('var1').set('Eeq_cell', 'intop_point_o2(we.Eeq_o2er1)-intop_point_h2(we.Eeq_h2er1)', 'Cell equilibrium voltage');
model.variable('var1').set('Etherm_cell', 'intop_point_o2(we.Etherm_o2er1)-intop_point_h2(we.Etherm_h2er1)', 'Cell thermoneutral voltage');
model.variable('var1').set('I_stack', 'intop_cc(we.nIs)', 'Stack current');
model.variable('var1').set('I_h2', '-intop_h2_electrodes(we.iloc_h2er1)', 'Total hydrogen production current');
model.variable('var1').set('Eff_coulombic', 'I_h2/(I_stack*N_cells)', 'Current-to-hydrogen coloumbic efficiency');
model.variable('var1').set('Eff_energy', 'I_h2*Eeq_cell/(E_stack*I_stack)', 'Electrical energy-to-hydrogen energy efficiency');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'intop_point_h2');
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([15]);
model.cpl.create('intop2', 'Integration', 'geom1');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'intop_point_o2');
model.cpl('intop2').selection.geom('geom1', 0);
model.cpl('intop2').selection.set([57]);
model.cpl.create('intop3', 'Integration', 'geom1');
model.cpl('intop3').set('axisym', true);
model.cpl('intop3').set('opname', 'intop_h2_electrodes');
model.cpl('intop3').selection.geom('geom1', 2);
model.cpl('intop3').selection.named('geom1_intsel1');
model.cpl.create('intop4', 'Integration', 'geom1');
model.cpl('intop4').set('axisym', true);
model.cpl('intop4').set('opname', 'intop_cc');
model.cpl('intop4').selection.geom('geom1', 2);
model.cpl('intop4').selection.set([1]);
model.cpl.create('intop5', 'Integration', 'geom1');
model.cpl('intop5').set('axisym', true);
model.cpl('intop5').set('opname', 'intop_upper');
model.cpl('intop5').selection.geom('geom1', 2);
model.cpl('intop5').selection.named('geom1_intsel3');
model.cpl.create('intop6', 'Integration', 'geom1');
model.cpl('intop6').set('axisym', true);
model.cpl('intop6').set('opname', 'intop_lower');
model.cpl('intop6').selection.geom('geom1', 2);
model.cpl('intop6').selection.named('geom1_intsel4');

model.physics('we').prop('H2GasMixture').set('H2O', false);
model.physics('we').prop('H2GasMixture').set('H2O_l', true);
model.physics('we').prop('O2GasMixture').set('H2O', false);
model.physics('we').prop('O2GasMixture').set('H2O_l', true);
model.physics('we').create('sep1', 'Separator', 3);
model.physics('we').feature('sep1').selection.named('geom1_csel3_dom');
model.physics('we').feature('sep1').set('epsl', 'epsl_sep');
model.physics('we').create('cc1', 'CurrentCollector', 3);
model.physics('we').feature('cc1').selection.named('geom1_csel1_dom');
model.physics('we').feature('cc1').set('sigmas_mat', 'from_mat');
model.physics('we').create('h2gec1', 'H2GasElectrolyteCompartment', 3);
model.physics('we').feature('h2gec1').selection.named('geom1_csel2_dom');
model.physics('we').feature('h2gec1').set('epsl', 'epsl');
model.physics('we').create('o2gec1', 'O2GasElectrolyteCompartment', 3);
model.physics('we').feature('o2gec1').selection.named('geom1_csel4_dom');
model.physics('we').feature('o2gec1').set('epsl', 'epsl');
model.physics('we').create('ih2es1', 'InternalH2ElectrodeSurface', 2);
model.physics('we').feature('ih2es1').selection.named('geom1_intsel1');
model.physics('we').feature('ih2es1').feature('h2er1').set('nuH2O_l', -1);
model.physics('we').feature('ih2es1').feature('h2er1').set('i0Type', 'LumpedMultistep');
model.physics('we').feature('ih2es1').feature('h2er1').set('i0_ref', 'i0_ref_h2');
model.physics('we').feature('ih2es1').feature('h2er1').set('PressureDependenceType', 'CathodicReactionOrders');
model.physics('we').feature('ih2es1').feature('h2er1').set('rcathodicH2', 1);
model.physics('we').create('io2es1', 'InternalO2ElectrodeSurface', 2);
model.physics('we').feature('io2es1').selection.named('geom1_intsel2');
model.physics('we').feature('io2es1').feature('o2er1').set('nuH2O_l', -1);
model.physics('we').feature('io2es1').feature('o2er1').set('i0Type', 'LumpedMultistep');
model.physics('we').feature('io2es1').feature('o2er1').set('i0_ref', 'i0_ref_o2');
model.physics('we').feature('io2es1').feature('o2er1').set('PressureDependenceType', 'AnodicReactionOrders');
model.physics('we').feature('io2es1').feature('o2er1').set('ranodicO2', 1);
model.physics('we').feature('ecph1').create('egnd1', 'ElectricGround', 2);
model.physics('we').feature('ecph1').feature('egnd1').selection.set([1]);
model.physics('we').feature('ecph1').create('pot1', 'ElectricPotential', 2);
model.physics('we').feature('ecph1').feature('pot1').selection.set([1610]);
model.physics('we').feature('ecph1').feature('pot1').set('phisbnd', 'E_stack');
model.physics('we').feature('icph1').set('minput_concentration_src', 'userdef');
model.physics('we').feature('icph1').set('minput_concentration', 'c_KOH');

model.common('cminpt').set('modified', {'temperature' 'T'; 'pressure' 'p_abs'});

model.mesh('mesh1').create('size1', 'Size');
model.mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('size1').selection.named('geom1_unisel5');
model.mesh('mesh1').feature('size1').set('hauto', 2);
model.mesh('mesh1').create('size2', 'Size');
model.mesh('mesh1').feature('size2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('size2').selection.named('geom1_unisel2');
model.mesh('mesh1').feature('size2').set('hauto', 3);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.named('geom1_csel2_dom');
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.named('geom1_csel1_dom');
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 1);
model.mesh('mesh1').feature('swe1').create('dis3', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis3').selection.named('geom1_csel4_dom');
model.mesh('mesh1').feature('swe1').create('dis4', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis4').selection.named('geom1_csel3_dom');
model.mesh('mesh1').feature('swe1').feature('dis4').set('numelem', 2);
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('bl1', 'BndLayer');
model.mesh('mesh1').feature('bl1').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl1').selection.geom(3);
model.mesh('mesh1').feature('bl1').selection.set([]);
model.mesh('mesh1').feature('bl1').selection.allGeom;
model.mesh('mesh1').feature('bl1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('bl1').selection.named('geom1_comsel1');
model.mesh('mesh1').feature('bl1').set('smoothtransition', false);
model.mesh('mesh1').feature('bl1').feature('blp').selection.named('geom1_unisel6');
model.mesh('mesh1').feature('bl1').feature('blp').set('blnlayers', 5);
model.mesh('mesh1').feature('bl1').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl1').feature('blp').set('blhmin', 'D_o2/3');
model.mesh('mesh1').create('bl2', 'BndLayer');
model.mesh('mesh1').feature('bl2').create('blp', 'BndLayerProp');
model.mesh('mesh1').feature('bl2').selection.geom('geom1', 3);
model.mesh('mesh1').feature('bl2').selection.named('geom1_unisel1');
model.mesh('mesh1').feature('bl2').set('smoothtransition', false);
model.mesh('mesh1').feature('bl2').feature('blp').selection.named('geom1_unisel4');
model.mesh('mesh1').feature('bl2').feature('blp').set('blnlayers', 2);
model.mesh('mesh1').feature('bl2').feature('blp').set('inittype', 'blhmin');
model.mesh('mesh1').feature('bl2').feature('blp').set('blhmin', 'D_o2/3');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('useparam', true);
model.study('std1').feature('stat').setIndex('pname', 'c_KOH', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'mol/m^3', 0);
model.study('std1').feature('stat').setIndex('pname', 'c_KOH', 0);
model.study('std1').feature('stat').setIndex('plistarr', '', 0);
model.study('std1').feature('stat').setIndex('punit', 'mol/m^3', 0);
model.study('std1').feature('stat').setIndex('pname', 'E_cell', 0);
model.study('std1').feature('stat').setIndex('plistarr', 'range(1.3,0.1,1.8)', 0);
model.study('std1').feature('stat').setIndex('punit', 'V', 0);

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 17 33 49 65 81 97 113 129 145 161 177 193 209 225 241 257 273 289 305 320]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 306 307 308 309 310 311 312 313 314 315 316 317 318 319 321]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([1 17 33 49 65 81 97 113 129 145 161 177 193 209 225 241 257 273 289 305 320]);
model.mesh('mesh1').stat.selection.geom(3);
model.mesh('mesh1').stat.selection.set([2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 306 307 308 309 310 311 312 313 314 315 316 317 318 319 321]);

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
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (we)');
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
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
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
model.sol('sol1').feature('s2').create('d1', 'Direct');
model.sol('sol1').feature('s2').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s2').feature('d1').label('Direct (we)');
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
model.sol('sol1').feature('s2').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s2').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s2').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s2').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s2').feature.remove('fcDef');
model.sol('sol1').feature('v2').set('notsolnum', 'auto');
model.sol('sol1').feature('v2').set('notsolvertype', 'solnum');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 6, 0);
model.result('pg1').label('Electrode Potential with Respect to Ground (we)');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('expr', {'we.phis'});
model.result('pg1').create('arwv1', 'ArrowVolume');
model.result('pg1').feature('arwv1').set('expr', {'we.Isx' 'we.Isy' 'we.Isz'});
model.result('pg1').feature('arwv1').set('arrowbase', 'center');
model.result('pg1').feature('arwv1').set('color', 'gray');
model.result('pg1').feature('arwv1').create('filt1', 'Filter');
model.result('pg1').feature('arwv1').feature('filt1').set('expr', 'isdefined(root.comp1.we.phis)');
model.result('pg1').feature('arwv1').feature('filt1').set('nodespec', 'all');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 6, 0);
model.result('pg2').label('Electrolyte Potential (we)');
model.result('pg2').create('mslc1', 'Multislice');
model.result('pg2').feature('mslc1').set('expr', {'we.phil'});
model.result('pg2').create('arwv1', 'ArrowVolume');
model.result('pg2').feature('arwv1').set('expr', {'we.Ilx' 'we.Ily' 'we.Ilz'});
model.result('pg2').feature('arwv1').set('arrowbase', 'center');
model.result('pg2').feature('arwv1').set('color', 'gray');
model.result('pg2').feature('arwv1').create('filt1', 'Filter');
model.result('pg2').feature('arwv1').feature('filt1').set('expr', 'isdefined(we.phil)');
model.result('pg2').feature('arwv1').feature('filt1').set('nodespec', 'all');
model.result('pg1').run;
model.result('pg1').label('Electrode Potential with Respect to Ground');
model.result('pg1').run;
model.result('pg1').feature('mslc1').active(false);
model.result('pg1').feature('arwv1').active(false);
model.result('pg1').run;
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'we.phis');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').label('Electrolyte Potential');
model.result('pg2').set('edges', false);
model.result('pg2').run;
model.result('pg2').feature('mslc1').active(false);
model.result('pg2').feature('arwv1').active(false);
model.result('pg2').run;
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').run;
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').label('Shunt Current Streamlines');
model.result('pg3').set('edges', false);
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('str1').set('selnumber', 100);
model.result('pg3').feature('str1').selection.named('geom1_unisel4');
model.result('pg3').feature('str1').set('pointtype', 'arrow');
model.result('pg3').feature('str1').create('sel1', 'Selection');
model.result('pg3').feature('str1').feature('sel1').selection.named('geom1_unisel7');
model.result('pg3').run;
model.result('pg3').feature('str1').create('col1', 'Color');
model.result('pg3').run;
model.result('pg3').feature('str1').feature('col1').set('titletype', 'auto');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'AuroraBorealis');
model.result('pg3').run;
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('titletype', 'none');
model.result('pg3').feature('surf1').create('mtrl1', 'MaterialAppearance');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').create('surf2', 'Surface');
model.result('pg3').feature('surf2').set('expr', '1');
model.result('pg3').feature('surf2').set('titletype', 'none');
model.result('pg3').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('mtrl1').set('material', 'mat2');
model.result('pg3').run;
model.result('pg3').feature('surf2').create('tran1', 'Transparency');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('tran1').set('transparency', 0.9);
model.result('pg3').run;
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').run;
model.result('pg4').label('Polarization Plot');
model.result('pg4').create('glob1', 'Global');
model.result('pg4').feature('glob1').set('markerpos', 'datapoints');
model.result('pg4').feature('glob1').set('linewidth', 'preference');
model.result('pg4').feature('glob1').set('expr', {'E_cell'});
model.result('pg4').feature('glob1').set('descr', {'Cell voltage (varied in sweep)'});
model.result('pg4').feature('glob1').set('unit', {'V'});
model.result('pg4').feature('glob1').set('expr', {'E_cell' 'Eeq_cell'});
model.result('pg4').feature('glob1').set('descr', {'Cell voltage (varied in sweep)' 'Cell equilibrium voltage'});
model.result('pg4').feature('glob1').set('expr', {'E_cell' 'Eeq_cell' 'Etherm_cell'});
model.result('pg4').feature('glob1').set('descr', {'Cell voltage (varied in sweep)' 'Cell equilibrium voltage' 'Cell thermoneutral voltage'});
model.result('pg4').feature('glob1').set('xdata', 'expr');
model.result('pg4').feature('glob1').set('xdataexpr', 'I_stack');
model.result('pg4').feature('glob1').set('xdatadescr', 'Stack current');
model.result('pg4').feature('glob1').set('linestyle', 'cycle');
model.result('pg4').feature('glob1').set('legendmethod', 'manual');
model.result('pg4').feature('glob1').setIndex('legends', 'E<sub>cell</sub>', 0);
model.result('pg4').feature('glob1').setIndex('legends', 'E<sub>ocv</sub>', 1);
model.result('pg4').feature('glob1').setIndex('legends', 'E<sub>therm</sub>', 2);
model.result('pg4').run;
model.result('pg4').set('legendpos', 'upperleft');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'Voltage (V)');
model.result('pg4').set('titletype', 'none');
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Coulombic Efficiency');
model.result('pg5').create('glob1', 'Global');
model.result('pg5').feature('glob1').set('markerpos', 'datapoints');
model.result('pg5').feature('glob1').set('linewidth', 'preference');
model.result('pg5').feature('glob1').set('expr', {'Eff_coulombic'});
model.result('pg5').feature('glob1').set('descr', {'Current-to-hydrogen coloumbic efficiency'});
model.result('pg5').feature('glob1').set('unit', {'1'});
model.result('pg5').feature('glob1').setIndex('unit', '%', 0);
model.result('pg5').feature('glob1').set('xdata', 'expr');
model.result('pg5').feature('glob1').set('xdataexpr', 'I_stack');
model.result('pg5').feature('glob1').set('xdatadescr', 'Stack current');
model.result('pg5').feature('glob1').set('legend', false);
model.result('pg5').run;
model.result('pg5').set('titletype', 'none');
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Energy Efficiency');
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').set('expr', {'Eff_energy'});
model.result('pg6').feature('glob1').set('descr', {'Electrical energy-to-hydrogen energy efficiency'});
model.result('pg6').feature('glob1').set('unit', {'1'});
model.result('pg6').feature('glob1').setIndex('unit', '%', 0);
model.result('pg6').feature('glob1').set('xdata', 'expr');
model.result('pg6').feature('glob1').set('xdataexpr', 'I_stack');
model.result('pg6').feature('glob1').set('xdatadescr', 'Stack current');
model.result('pg6').feature('glob1').set('legend', false);
model.result('pg6').run;
model.result('pg6').set('titletype', 'none');
model.result('pg6').run;
model.result.numerical.create('gevs1', 'EvalGlobalSweep');
model.result.numerical('gevs1').setIndex('looplevel', 1, 0);
model.result.numerical('gevs1').setIndex('pname', 'Cell', 0);
model.result.numerical('gevs1').setIndex('plistarr', 'range(1,1,N_cells)', 0);
model.result.numerical('gevs1').set('expr', {'comp1.intop_upper(if(x>(Cell-1)*D_cell+D_endplate,if(x<(Cell-1)*D_cell+D_endplate+D_h2,we.Ilz,0[A/m^2]),0[A/m^2]))' 'comp1.intop_lower(if(x>(Cell-1)*D_cell+D_endplate,if(x<(Cell-1)*D_cell+D_endplate+D_h2,-we.Ilz,0[A/m^2]),0[A/m^2]))' 'comp1.intop_upper(if(x>(Cell-1)*D_cell+D_endplate+D_h2+D_sep,if(x<(Cell-1)*D_cell+D_endplate+D_cell,we.Ilz,0[A/m^2]),0[A/m^2]))' 'comp1.intop_lower(if(x>(Cell-1)*D_cell+D_endplate+D_h2+D_sep,if(x<(Cell-1)*D_cell+D_endplate+D_cell,-we.Ilz,0[A/m^2]),0[A/m^2]))'});
model.result.numerical('gevs1').set('unit', {'A' 'A' 'A' 'A'});
model.result.numerical('gevs1').set('descr', {'Hydrogen, upper' 'Hydrogen, lower' 'Oxygen, upper' 'Oxygen, lower'});
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation Sweep 1');
model.result.numerical('gevs1').set('table', 'tbl1');
model.result.numerical('gevs1').setResult;
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').run;
model.result('pg7').label('Shunt Currents');
model.result('pg7').label('Shunt Currents per Cell');
model.result('pg7').create('tblp1', 'Table');
model.result('pg7').feature('tblp1').set('markerpos', 'datapoints');
model.result('pg7').feature('tblp1').set('linewidth', 'preference');
model.result('pg7').feature('tblp1').set('legend', true);
model.result('pg7').run;
model.result('pg7').feature('tblp1').set('linestyle', 'none');
model.result('pg7').feature('tblp1').set('linemarker', 'cycle');
model.result('pg7').run;
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('ylabel', 'Current (A)');
model.result('pg7').set('legendpos', 'upperleft');
model.result('pg7').run;
model.result.numerical('gevs1').setIndex('looplevel', 6, 0);
model.result.numerical('gevs1').set('table', 'tbl1');
model.result.numerical('gevs1').setResult;
model.result('pg7').run;
model.result('pg7').run;

model.title('Shunt Currents in an Alkaline Electrolyzer Stack');

model.description(['In an alkaline electrolyzer stack, all cells share the same electrolyte. As a result of all cells being in ionic contact, parasitic shunt currents flow between the cells through the manifolds and the electrolyte channels, on both the inlet and outlet side.' newline  newline 'This example models a secondary current distribution in a stack comprising 20' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'cells. The electricity-to-hydrogen coulombic and energy efficiencies for the stack are computed, as well as the individual shunt currents entering or exiting each cell.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('aec_shunt_currents.mph');

model.modelNode.label('Components');

out = model;
