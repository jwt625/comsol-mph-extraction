function out = model
%
% li_plating_with_deformation.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_Lithium-Ion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('liion', 'LithiumIonBatteryMPH', 'geom1');
model.physics('liion').model('comp1');

model.multiphysics.create('ndbdg1', 'NonDeformingBoundaryDeformedGeometry', 'geom1', 1);
model.multiphysics('ndbdg1').set('Echem_physics', 'liion');
model.multiphysics('ndbdg1').selection.all;
model.multiphysics.create('desdg1', 'DeformingElectrodeSurfaceDeformedGeometry', 'geom1', 1);
model.multiphysics('desdg1').set('Echem_physics', 'liion');
model.multiphysics('desdg1').selection.all;

model.common.create('free1', 'DeformingDomainDeformedGeometry', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.all;

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/liion', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('cdi').setSolveFor('/multiphysics/desdg1', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/liion', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std1').feature('time').setSolveFor('/multiphysics/desdg1', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('W_cell', '50[um]', 'Computational cell width');
model.param.set('H_prot', '4[um]', 'Height of protrusion');
model.param.set('W_prot', '4[um]', 'Width of protrusion');
model.param.set('H_sep', '50[um]', 'Height of separator');
model.param.set('H_pos', '100[um]', 'Height of positive electrode');
model.param.set('rp_pos', '1[um]', 'Radius of positive electrode particle');
model.param.set('T', '293.15[K]', 'Temperature');
model.param.set('i0', '1e2[A/m^2]', 'Exchange current density');
model.param.set('t_fwd', '0.95', 'Forward current duty cycle');
model.param.set('t_rev', '1-t_fwd', 'Reverse current duty cycle');
model.param.set('T_cycle', '3[min]', 'Cycle time');
model.param.set('C_rate_avg', '1', 'Average C-rate');
model.param.set('C_rate_rev', '15', 'Reverse C-rate');
model.param.set('i_avg', 'C_rate_avg*I_1C', 'Time-averaged plating current density');
model.param.set('i_rev', '-C_rate_rev*I_1C', 'Reverse (dissolution) current density');
model.param.set('i_fwd', '(i_avg-t_rev*i_rev)/t_fwd', 'Forward (plating) current density');
model.param.set('i_app_fwd', 'i_avg', 'Applied current density (forward cycle only)');
model.param.set('sigmas_pos', '5[S/m]', 'Electrical conductivity positive electrode');
model.param.set('csmax_pos', '47664[mol/m^3]', 'Maximum concentration positive electrode');
model.param.set('socminpos', '0.258', 'Minimum SOC positive electrode');
model.param.set('socmaxpos', '0.917', 'Maximum SOC positive electrode');
model.param.set('epss_pos', '0.4', 'Solid phase volume fraction positive electrode');
model.param.set('I_1C', 'H_pos*csmax_pos*(socmaxpos-socminpos)*epss_pos/1[h]*F_const', '1C current density');
model.param.set('cs_init_pos', 'socmaxpos*csmax_pos', 'Initial concentration positive electrode');
model.param.set('rho_Li', '0.53[g*cm^-3]', 'Density of lithium metal');
model.param.set('M_Li', '6.94[g/mol]', 'Molecular weight of lithium metal');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'H_prot', 0, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-W_prot/2', 1, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 1, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-W_cell/2', 2, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 2, 1);
model.geom('geom1').feature('pol1').setIndex('table', '-W_cell/2', 3, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'H_sep', 3, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'W_cell/2', 4, 0);
model.geom('geom1').feature('pol1').setIndex('table', 'H_sep', 4, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'W_cell/2', 5, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 5, 1);
model.geom('geom1').feature('pol1').setIndex('table', 'W_prot/2', 6, 0);
model.geom('geom1').feature('pol1').setIndex('table', 0, 6, 1);
model.geom('geom1').run('pol1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'W_cell' 'H_pos'});
model.geom('geom1').feature('r1').set('pos', {'-W_cell/2' 'H_sep'});
model.geom('geom1').run('r1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('pointinsketch').set('pol1', 1);
model.geom('geom1').feature('fil1').set('radius', 'H_prot/10');
model.geom('geom1').run('fil1');
model.geom('geom1').create('fil2', 'Fillet');
model.geom('geom1').feature('fil2').selection('pointinsketch').set('fil1', [3 6]);
model.geom('geom1').feature('fil2').set('radius', 'W_prot/2');
model.geom('geom1').run('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('SpeciesProperties', 'Species properties');
model.material('mat1').propertyGroup('SpeciesProperties').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('SpeciesProperties').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteSaltConcentration', 'Electrolyte salt concentration');
model.material('mat1').label('LiPF6 in 3:7 EC:EMC (Liquid, Li-ion Battery)');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'DL_int1');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'200' '3.9e-10/(1-200*59e-6)';  ...
'500' '4.12e-10/(1-500*59e-6)';  ...
'800' '4e-10/(1-800*59e-6)';  ...
'1000' '3.8e-10/(1-1000*59e-6)';  ...
'1200' '3.50e-10/(1-1200*59e-6)';  ...
'1600' '2.68e-10/(1-1600*59e-6)';  ...
'2000' '1.9e-10/(1-2000*59e-6)'});
model.material('mat1').propertyGroup('def').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('def').set('diffusion', {'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))' '0' '0' '0' 'DL_int1(c/1[mol/m^3])*exp(16500/8.314*(1/(T_ref/1[K])-1/(T2/1[K])))'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('def').set('T_ref', '298[K]');
model.material('mat1').propertyGroup('def').descr('T_ref', '');
model.material('mat1').propertyGroup('def').set('T2', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('def').descr('T2', '');
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'200' '0.455';  ...
'500' '0.783';  ...
'800' '0.935';  ...
'1000' '0.95';  ...
'1200' '0.927';  ...
'1600' '0.78';  ...
'2000' '0.60';  ...
'2200' '0.515'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {'S/m'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])*exp(4000/8.314*(1/(T_ref2/1[K])-1/(T3/1[K])))'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T_ref2', '298[K]');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T_ref2', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('T3', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('ElectrolyteConductivity').descr('T3', '');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('temperature');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('funcname', 'transpNm_int1');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('table', {'200' '0.37';  ...
'500' '0.322';  ...
'800' '0.27';  ...
'1000' '0.251';  ...
'1200' '0.248';  ...
'1600' '0.236';  ...
'2000' '0.11'});
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('funcname', 'actdep_int1');
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('table', {'200' '0';  ...
'500' '0.29';  ...
'800' '0.695';  ...
'1000' '1';  ...
'1200' '1.32';  ...
'1600' '2.07';  ...
'2000' '2.50'});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('interp', 'piecewisecubic');
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('fununit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').func('int2').set('argunit', {''});
model.material('mat1').propertyGroup('SpeciesProperties').set('transpNum', 'transpNm_int1(c/1[mol/m^3])');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:transpNum', ['A. Nyman, M. Behm, and G. Lindbergh, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Electrochemical characterisation and modelling of the mass transport phenomena in LiPF6-EC-EMC,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Electrochim. Acta, vol. 53, p. 6356, 2008.']);
model.material('mat1').propertyGroup('SpeciesProperties').set('fcl', 'actdep_int1(c/1[mol/m^3])*exp(-1000/8.314*(1/(T_ref3/1[K])-1/(T4/1[K])))');
model.material('mat1').propertyGroup('SpeciesProperties').set('INFO_PREFIX:fcl', 'T. G. Zavalis, M. Behm, and G. Lindbergh, "Investigations of Short-Circuit Scenarios in a Lithium-Ion Battery Cell," J. Electrochem. Soc., vol. 159, p. A848, 2012.');
model.material('mat1').propertyGroup('SpeciesProperties').set('T4', 'min(393.15,max(T,223.15))');
model.material('mat1').propertyGroup('SpeciesProperties').descr('T4', '');
model.material('mat1').propertyGroup('SpeciesProperties').set('T_ref3', '298[K]');
model.material('mat1').propertyGroup('SpeciesProperties').descr('T_ref3', '');
model.material('mat1').propertyGroup('SpeciesProperties').addInput('concentration');
model.material('mat1').propertyGroup('SpeciesProperties').addInput('temperature');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').identifier('cElsalt');
model.material('mat1').propertyGroup('ElectrolyteSaltConcentration').set('cElsalt', '1200[mol/m^3]');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('OperationalSOC', 'Operational electrode state of charge');
model.material('mat2').propertyGroup.create('ic', 'Intercalation strain');
model.material('mat2').propertyGroup('ic').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('EquilibriumConcentration', 'Equilibrium concentration');
model.material('mat2').label('NMC 622, LiNi0.6Mn0.2Co0.2O2 (Positive, Li-ion Battery)');
model.material('mat2').propertyGroup('def').set('diffusion', {'2e-13' '0' '0' '0' '2e-13' '0' '0' '0' '2e-13'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:diffusion', 'Chaouachi et al, "Experimental and theoretical investigation of Li-ion battery active materials properties: Application to a graphite/Ni0.6Mn0.2Co0.2O2 system", Electrochimica Acta 366 (2021) 137428');
model.material('mat2').propertyGroup('def').set('csmax', '47664[mol/m^3]');
model.material('mat2').propertyGroup('def').descr('csmax', '');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'0.258' '4.283';  ...
'0.300' '4.201';  ...
'0.344' '4.120';  ...
'0.381' '4.059';  ...
'0.400' '4.025';  ...
'0.416' '3.998';  ...
'0.454' '3.940';  ...
'0.498' '3.875';  ...
'0.534' '3.834';  ...
'0.556' '3.811';  ...
'0.581' '3.790';  ...
'0.598' '3.780';  ...
'0.624' '3.763';  ...
'0.655' '3.753';  ...
'0.685' '3.736';  ...
'0.710' '3.726';  ...
'0.740' '3.712';  ...
'0.772' '3.695';  ...
'0.799' '3.678';  ...
'0.840' '3.651';  ...
'0.871' '3.631';  ...
'0.898' '3.607';  ...
'0.917' '3.580';  ...
'1' '3.0';  ...
'' ''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('interp', 'piecewisecubic');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('defineinv', true);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcinvname', 'Eeq_inv');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_int1(soc)');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'Chaouachi et al, "Experimental and theoretical investigation of Li-ion battery active materials properties: Application to a graphite/Ni0.6Mn0.2Co0.2O2 system", Electrochimica Acta 366 (2021) 137428');
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:dEeqdT', 'Data unavailable.');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', 'def.csmax');
model.material('mat2').propertyGroup('ElectrodePotential').set('soc', 'c/cEeqref');
model.material('mat2').propertyGroup('ElectrodePotential').descr('soc', '');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat2').propertyGroup('OperationalSOC').set('socmax', 'elpot.Eeq_inv(E_min)');
model.material('mat2').propertyGroup('OperationalSOC').set('socmin', 'elpot.Eeq_inv(E_max)');
model.material('mat2').propertyGroup('OperationalSOC').set('E_max', '4.25[V]');
model.material('mat2').propertyGroup('OperationalSOC').set('E_min', '3.6[V]');
model.material('mat2').propertyGroup('ic').func('int1').set('funcname', 'dVOLdSOL');
model.material('mat2').propertyGroup('ic').func('int1').set('table', {'0.911' '-0.025';  ...
'0.879' '-0.134';  ...
'0.851' '-0.200';  ...
'0.823' '-0.287';  ...
'0.795' '-0.397';  ...
'0.764' '-0.419';  ...
'0.736' '-0.528';  ...
'0.699' '-0.616';  ...
'0.671' '-0.703';  ...
'0.641' '-0.725';  ...
'0.615' '-0.813';  ...
'0.583' '-0.878';  ...
'0.553' '-0.966';  ...
'0.525' '-1.075';  ...
'0.494' '-1.163';  ...
'0.466' '-1.250';  ...
'0.433' '-1.360';  ...
'0.405' '-1.491';  ...
'0.371' '-1.688';  ...
'0.345' '-1.973';  ...
'0.313' '-2.367';  ...
'0.282' '-2.936';  ...
'0.257' '-3.570';  ...
'0.224' '-4.161';  ...
'0.186' '-4.818'});
model.material('mat2').propertyGroup('ic').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ic').func('int1').set('fununit', {'%'});
model.material('mat2').propertyGroup('ic').func('int1').set('argunit', {'1'});
model.material('mat2').propertyGroup('ic').set('dvol', 'dVOLdSOL(c/elpot.cEeqref)');
model.material('mat2').propertyGroup('ic').set('INFO_PREFIX:dvol', ['R. Koerver and others, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'Chemo-mechanical expansion of lithium electrode materials ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' on the route to mechanically optimized all-solid-state batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' Energy Environ. Sci., vol. 11, pp. 2142' native2unicode(hex2dec({'20' '13'}), 'unicode') '2158, 201']);
model.material('mat2').propertyGroup('ic').addInput('concentration');
model.material('mat2').propertyGroup('EquilibriumConcentration').set('csEq', 'def.csmax*elpot.Eeq_inv(V)');
model.material('mat2').propertyGroup('EquilibriumConcentration').addInput('electricpotential');
model.material('mat2').selection.set([2]);
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').label('Lithium Metal, Li (Negative, Li-ion Battery)');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '');
model.material('mat3').propertyGroup('def').set('poissonsratio', '');
model.material('mat3').propertyGroup('def').set('density', '');
model.material('mat3').propertyGroup('def').set('thermalconductivity', '');
model.material('mat3').propertyGroup('def').set('electricconductivity', '');
model.material('mat3').propertyGroup('def').set('heatcapacity', '');
model.material('mat3').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:youngsmodulus', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('poissonsratio', '0.34');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:poissonsratio', 'Yue Qi et al 2010 J. Electrochem. Soc. 157 A558');
model.material('mat3').propertyGroup('def').set('density', '0.534[g/cm^3]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:density', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]' '0' '0' '0' '84.8[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:thermalconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('electricconductivity', {['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])'] '0' '0' '0' ['1/(92.8[n' 'ohm' '*m])']});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('def').set('heatcapacity', '3.58[kJ/kg/K]');
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:heatcapacity', 'https://en.wikipedia.org/wiki/Lithium');
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', '0[V]');
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', '0[M]');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('temperature');
model.material('mat3').selection.geom('geom1', 1);
model.material('mat3').selection.set([2 6 7 8 11 12 13]);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(1);
model.selection('sel1').label('Lithium Electrode Surface');
model.selection('sel1').set([2 6 7 8 11 12 13]);

model.material('mat3').selection.named('sel1');

model.physics('liion').create('pce1', 'PorousElectrode', 2);
model.physics('liion').feature('pce1').selection.set([2]);
model.physics('liion').feature('pce1').set('ElectrolyteMaterial', 'mat1');
model.physics('liion').feature('pce1').set('sigma', {'sigmas_pos' '0' '0' '0' 'sigmas_pos' '0' '0' '0' 'sigmas_pos'});
model.physics('liion').feature('pce1').set('epss', 'epss_pos');
model.physics('liion').feature('pce1').feature('pin1').set('csinit', 'cs_init_pos');
model.physics('liion').feature('pce1').feature('pin1').set('rp', 'rp_pos');
model.physics('liion').create('es1', 'ElectrodeSurface', 1);
model.physics('liion').feature('es1').selection.named('sel1');
model.physics('liion').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('es1').setIndex('Species', 's1', 0, 0);
model.physics('liion').feature('es1').setIndex('rhos', 8960, 0, 0);
model.physics('liion').feature('es1').setIndex('Ms', 0.06355, 0, 0);
model.physics('liion').feature('es1').setIndex('Species', 'Li', 0, 0);
model.physics('liion').feature('es1').setIndex('rhos', 'rho_Li', 0, 0);
model.physics('liion').feature('es1').setIndex('Ms', 'M_Li', 0, 0);
model.physics('liion').feature('es1').set('SolveForDissolvingDepositingConcentrationVariable', false);
model.physics('liion').feature('es1').feature('er1').setIndex('Vib', 1, 0, 0);
model.physics('liion').create('ec1', 'ElectrodeCurrent', 1);
model.physics('liion').feature('ec1').label('Electrode Current: Forward Cycle');
model.physics('liion').feature('ec1').selection.set([5]);
model.physics('liion').feature('ec1').set('ElectronicCurrentType', 'AverageCurrentDensity');
model.physics('liion').feature('ec1').set('Ias', 'i_app_fwd');

model.common('free1').selection.set([1]);

model.multiphysics('ndbdg1').set('BoundaryCondition', 'ZeroNormalDisplacement');

model.physics('liion').prop('ShapeProperty').set('order_electricpotentialionicphase', 1);
model.physics('liion').prop('ShapeProperty').set('order_concentration', 1);
model.physics('liion').prop('ShapeProperty').set('order_electricpotential', 1);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.named('sel1');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hgrad', 1.1);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').label('Study: Forward Cycle');
model.study('std1').feature('time').set('tunit', 'h');
model.study('std1').feature('time').set('tlist', 'range(0,0.05/C_rate_avg,0.75/C_rate_avg)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_material_disp').set('scaleval', '1.027819536689199E-7');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_liion_ec1_phis0').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_material_disp').set('scaleval', '1.027819536689199E-7');
model.sol('sol1').feature('v2').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,0.05/C_rate_avg,0.75/C_rate_avg)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventout', true);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('initialstepbdfactive', true);
model.sol('sol1').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_phil' 'comp1_cl' 'comp1_phis' 'comp1_liion_ec1_phis0' 'comp1_material_disp' 'comp1_material_lm_nv' 'comp1_material_vmbs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.9);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('mumpsalloc', 1.4);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('glob1', 'Global');
model.result('pg1').feature('glob1').set('unit', {''});
model.result('pg1').feature('glob1').set('expr', {'liion.phis0_ec1'});
model.result('pg1').feature('glob1').set('descr', {'Electric potential on boundary'});
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (liion)');
model.result('pg1').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('unit', {''});
model.result('pg2').feature('glob1').set('expr', {'liion.soc_average_pce1'});
model.result('pg2').feature('glob1').set('descr', {'Average SOC, Porous Electrode 1'});
model.result('pg2').label('Average Electrode State of Charge (liion)');
model.result('pg2').feature('glob1').set('xdatasolnumtype', 'level1');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 16, 0);
model.result('pg3').label('Electrolyte Potential (liion)');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', {'phil'});
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg3').feature('arws1').set('arrowbase', 'center');
model.result('pg3').feature('arws1').set('color', 'gray');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 16, 0);
model.result('pg4').label('Electrolyte Current Density (liion)');
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'liion.Ilx' 'liion.Ily'});
model.result('pg4').feature('arws1').set('arrowbase', 'center');
model.result('pg4').feature('arws1').set('color', 'gray');
model.result('pg4').feature('arws1').create('col1', 'Color');
model.result('pg4').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IlMag');
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'abs(liion.itot)'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').feature('line1').set('inherittubescale', false);
model.result('pg4').feature('line1').set('inheritplot', 'arws1');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 16, 0);
model.result('pg5').label('Electrode Potential with Respect to Ground (liion)');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'phis'});
model.result('pg5').create('arws1', 'ArrowSurface');
model.result('pg5').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg5').feature('arws1').set('arrowbase', 'center');
model.result('pg5').feature('arws1').set('color', 'gray');
model.result('pg5').create('line1', 'Line');
model.result('pg5').feature('line1').set('expr', {'liion.phisext'});
model.result('pg5').feature('line1').set('linetype', 'tube');
model.result('pg5').feature('line1').set('inherittubescale', false);
model.result('pg5').feature('line1').set('inheritplot', 'surf1');
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').setIndex('looplevel', 16, 0);
model.result('pg6').label('Electrode Current Density (liion)');
model.result('pg6').create('arws1', 'ArrowSurface');
model.result('pg6').feature('arws1').set('expr', {'liion.Isx' 'liion.Isy'});
model.result('pg6').feature('arws1').set('arrowbase', 'center');
model.result('pg6').feature('arws1').set('color', 'gray');
model.result('pg6').feature('arws1').create('col1', 'Color');
model.result('pg6').feature('arws1').feature('col1').set('expr', 'root.comp1.liion.IsMag');
model.result('pg6').create('line1', 'Line');
model.result('pg6').feature('line1').set('expr', {'abs(liion.itot)'});
model.result('pg6').feature('line1').set('linetype', 'tube');
model.result('pg6').feature('line1').set('inherittubescale', false);
model.result('pg6').feature('line1').set('inheritplot', 'arws1');
model.result.create('pg7', 'PlotGroup2D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').setIndex('looplevel', 16, 0);
model.result('pg7').create('surf1', 'Surface');
model.result('pg7').feature('surf1').set('expr', {'cl'});
model.result('pg7').label('Electrolyte Salt Concentration (liion)');
model.result('pg7').create('arws1', 'ArrowSurface');
model.result('pg7').feature('arws1').set('expr', {'liion.Nposx' 'liion.Nposy'});
model.result('pg7').feature('arws1').set('color', 'red');
model.result('pg7').create('arws2', 'ArrowSurface');
model.result('pg7').feature('arws2').set('expr', {'liion.Nnegx' 'liion.Nnegy'});
model.result('pg7').feature('arws2').set('color', 'black');
model.result('pg7').feature('arws2').set('inheritplot', 'arws1');
model.result('pg7').feature('arws2').set('inheritcolor', 'off');
model.result.create('pg8', 'PlotGroup2D');
model.result('pg8').set('data', 'dset1');
model.result('pg8').setIndex('looplevel', 16, 0);
model.result('pg8').label('Deformed Geometry');
model.result('pg8').create('mesh1', 'Mesh');
model.result('pg8').feature('mesh1').set('meshdomain', 'surface');
model.result('pg8').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg8').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg8').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg8').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg8').feature('mesh1').feature('sel1').selection.set([1]);
model.result('pg8').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg8').feature('mesh1').set('qualexpr', 'comp1.material.relVol');
model.result('pg8').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('Electrode Shape: Forward Cycle');
model.result('pg9').set('titletype', 'manual');
model.result('pg9').set('title', 'Electrode Shape: Forward Cycle');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').selection.named('sel1');
model.result('pg9').feature('lngr1').set('expr', 'y');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'x');
model.result('pg9').run;
model.result('pg9').set('axislimits', true);
model.result('pg9').set('ymin', '-5.5e-7');
model.result('pg9').set('ymax', '1.7e-5');
model.result('pg9').run;

model.physics.create('ev', 'Events', 'geom1');
model.physics('ev').model('comp1');

model.study('std1').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std1').feature('time').setSolveFor('/physics/ev', true);

model.physics('ev').create('es1', 'EventSequence', -1);
model.physics('ev').feature('es1').set('loop', true);
model.physics('ev').feature('es1').feature('sm1').set('stateName', 'state_fwd');
model.physics('ev').feature('es1').feature('sm1').set('endConditionOptions', 'duration');
model.physics('ev').feature('es1').feature('sm1').set('duration', 'T_cycle*t_fwd');
model.physics('ev').feature('es1').create('sm2', 'SequenceMember', -1);
model.physics('ev').feature('es1').feature('sm2').set('stateName', 'state_rev');
model.physics('ev').feature('es1').feature('sm2').set('endConditionOptions', 'duration');
model.physics('ev').feature('es1').feature('sm2').set('duration', 'T_cycle*t_rev');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('i_app', 'state_fwd*i_fwd+state_rev*i_rev');
model.variable('var1').descr('i_app', 'Applied current density (forward and reverse cycle)');

model.physics('liion').feature.duplicate('ec2', 'ec1');
model.physics('liion').feature('ec2').label('Electrode Current: Forward and Reverse Cycle');
model.physics('liion').feature('ec2').set('Ias', 'i_app');

model.study.create('std2');
model.study('std2').create('cdi', 'CurrentDistributionInitialization');
model.study('std2').feature('cdi').set('solnum', 'auto');
model.study('std2').feature('cdi').set('notsolnum', 'auto');
model.study('std2').feature('cdi').set('outputmap', {});
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').setSolveFor('/physics/liion', true);
model.study('std2').feature('cdi').setSolveFor('/physics/ev', true);
model.study('std2').feature('cdi').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std2').feature('cdi').setSolveFor('/multiphysics/desdg1', true);
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('plotgroup', 'Default');
model.study('std2').feature('time').set('initialtime', '0');
model.study('std2').feature('time').set('solnum', 'auto');
model.study('std2').feature('time').set('notsolnum', 'auto');
model.study('std2').feature('time').set('outputmap', {});
model.study('std2').feature('time').setSolveFor('/physics/liion', true);
model.study('std2').feature('time').setSolveFor('/physics/ev', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/ndbdg1', true);
model.study('std2').feature('time').setSolveFor('/multiphysics/desdg1', true);
model.study('std2').label('Study: Forward and Reverse Cycle');
model.study('std2').create('param', 'Parametric');
model.study('std2').feature('param').setIndex('pname', 'W_cell', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 'W_cell', 0);
model.study('std2').feature('param').setIndex('plistarr', '', 0);
model.study('std2').feature('param').setIndex('punit', 'm', 0);
model.study('std2').feature('param').setIndex('pname', 't_fwd', 0);
model.study('std2').feature('param').setIndex('plistarr', '0.95 0.9 0.85', 0);
model.study('std2').feature('cdi').set('useadvanceddisable', true);
model.study('std2').feature('cdi').set('disabledphysics', {'liion/ec1'});
model.study('std2').feature('time').set('tunit', 'h');
model.study('std2').feature('time').set('tlist', 'range(0,0.05/C_rate_avg,0.75/C_rate_avg)');
model.study('std2').feature('time').set('useadvanceddisable', true);
model.study('std2').feature('time').set('disabledphysics', {'liion/ec1'});
model.study('std2').feature('time').set('autoremesh', true);
model.study('std1').feature('cdi').set('useadvanceddisable', true);
model.study('std1').feature('cdi').set('disabledphysics', {'liion/ec2'});
model.study('std1').feature('time').setEntry('activate', 'ev', false);
model.study('std1').feature('time').set('useadvanceddisable', true);
model.study('std1').feature('time').set('disabledphysics', {'liion/ec2'});
model.study('std2').setGenPlots(false);

model.sol.create('sol3');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([1]);

model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_liion_ec2_phis0').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_material_disp').set('scaleval', '1.027819536689199E-7');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v1').feature('comp1_liion_ec2_phis0').set('scaleval', '1');
model.sol('sol3').feature('v1').set('control', 'cdi');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 1.0E-4);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').feature.remove('fcDef');
model.sol('sol3').create('su1', 'StoreSolution');
model.sol('sol3').create('st2', 'StudyStep');
model.sol('sol3').feature('st2').set('study', 'std2');
model.sol('sol3').feature('st2').set('studystep', 'time');
model.sol('sol3').create('v2', 'Variables');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_material_disp').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_pce1_cs').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_liion_ec2_phis0').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_material_disp').set('scaleval', '1.027819536689199E-7');
model.sol('sol3').feature('v2').feature('comp1_liion_pce1_cs').set('scaleval', '10000');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v2').feature('comp1_liion_ec2_phis0').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_material_lm_nv').set('out', 'off');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('notsoluse', 'sol4');
model.sol('sol3').feature('v2').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,0.05/C_rate_avg,0.75/C_rate_avg)');
model.sol('sol3').feature('t1').set('plot', 'off');
model.sol('sol3').feature('t1').set('plotgroup', 'Default');
model.sol('sol3').feature('t1').set('plotfreq', 'tout');
model.sol('sol3').feature('t1').set('probesel', 'all');
model.sol('sol3').feature('t1').set('probes', {});
model.sol('sol3').feature('t1').set('probefreq', 'tsteps');
model.sol('sol3').feature('t1').set('rtol', 0.001);
model.sol('sol3').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol3').feature('t1').set('eventout', true);
model.sol('sol3').feature('t1').set('reacf', true);
model.sol('sol3').feature('t1').set('storeudot', true);
model.sol('sol3').feature('t1').set('endtimeinterpolation', true);
model.sol('sol3').feature('t1').set('maxorder', 2);
model.sol('sol3').feature('t1').set('initialstepbdfactive', true);
model.sol('sol3').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol3').feature('t1').set('control', 'time');
model.sol('sol3').feature('t1').feature('arDef').set('autoremeshgeom', 'geom1');
model.sol('sol3').feature('t1').feature('arDef').set('stopcondtype', 'quality');
model.sol('sol3').feature('t1').feature('arDef').set('stopexpr', 'comp1.material.minqual');
model.sol('sol3').feature('t1').feature('arDef').set('stopval', '0.2');
model.sol('sol3').feature('t1').feature('arDef').set('consistentremesh', 'bweuler');
model.sol('sol3').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol3').feature('t1').create('seDef', 'Segregated');
model.sol('sol3').feature('t1').create('se1', 'Segregated');
model.sol('sol3').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol3').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_ev_es1_sm1_currentState' 'comp1_ev_es1_sm1_currentTimeStart' 'comp1_ev_es1_sm1_ind' 'comp1_ev_es1_sm2_currentState' 'comp1_ev_es1_sm2_currentTimeStart' 'comp1_ev_es1_sm2_ind' 'comp1_phil' 'comp1_cl' 'comp1_phis' 'comp1_liion_ec2_phis0'  ...
'comp1_material_disp' 'comp1_material_lm_nv' 'comp1_material_vmbs'});
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('subdamp', 0.9);
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').label('Direct (Merged)');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss1').label('Merged Variables');
model.sol('sol3').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_liion_pce1_cs'});
model.sol('sol3').feature('t1').feature('se1').feature('ss2').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('se1').feature('ss2').label('Insertion Particle Concentration Variables');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').feature('t1').feature.remove('seDef');
model.sol('sol3').attach('std2');

model.batch.create('p1', 'Parametric');
model.batch('p1').study('std2');
model.batch('p1').create('so1', 'Solutionseq');
model.batch('p1').feature('so1').set('seq', 'sol3');
model.batch('p1').feature('so1').set('store', 'on');
model.batch('p1').feature('so1').set('clear', 'on');
model.batch('p1').feature('so1').set('psol', 'none');
model.batch('p1').set('pname', {'t_fwd'});
model.batch('p1').set('plistarr', {'0.95 0.9 0.85'});
model.batch('p1').set('sweeptype', 'sparse');
model.batch('p1').set('probesel', 'all');
model.batch('p1').set('probes', {});
model.batch('p1').set('plot', 'off');
model.batch('p1').set('err', 'on');
model.batch('p1').attach('std2');
model.batch('p1').set('control', 'param');

model.sol.create('sol5');
model.sol('sol5').label('Remeshed Solution 1');
model.sol('sol5').study('std2');
model.sol('sol3').feature('t1').feature('arDef').set('tadapsol', 'sol5');
model.sol.create('sol6');
model.sol('sol6').study('std2');
model.sol('sol6').label('Parametric Solutions 1');

model.batch('p1').feature('so1').set('psol', 'sol6');
model.batch('p1').run('compute');

model.result('pg9').run;
model.result.duplicate('pg10', 'pg9');
model.result('pg10').run;
model.result('pg10').label('Electrode Shape: Forward and Reverse Cycle');
model.result('pg10').set('data', 'dset6');
model.result('pg10').setIndex('looplevelinput', 'manual', 1);
model.result('pg10').setIndex('looplevel', [3], 1);
model.result('pg10').set('title', 'Electrode Shape: t_fwd = eval(t_fwd)');
model.result('pg10').setIndex('looplevelinput', 'interp', 0);
model.result('pg10').setIndex('interp', 'range(0,0.05,0.75)', 0);
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Electrode Shape Comparison');
model.result('pg11').set('data', 'none');
model.result('pg11').set('titletype', 'manual');
model.result('pg11').set('title', 'Electrode Shape Comparison');
model.result('pg11').create('lngr1', 'LineGraph');
model.result('pg11').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg11').feature('lngr1').set('linewidth', 'preference');
model.result('pg11').feature('lngr1').set('data', 'dset1');
model.result('pg11').feature('lngr1').setIndex('looplevelinput', 'last', 0);
model.result('pg11').feature('lngr1').selection.named('sel1');
model.result('pg11').feature('lngr1').set('expr', 'y');
model.result('pg11').feature('lngr1').set('xdata', 'expr');
model.result('pg11').feature('lngr1').set('xdataexpr', 'x');
model.result('pg11').feature('lngr1').set('legend', true);
model.result('pg11').feature('lngr1').set('legendmethod', 'evaluated');
model.result('pg11').feature('lngr1').set('legendpattern', 't_fwd = 1');
model.result('pg11').feature.duplicate('lngr2', 'lngr1');
model.result('pg11').run;
model.result('pg11').feature('lngr2').set('data', 'dset6');
model.result('pg11').feature('lngr2').setIndex('looplevelinput', 'last', 0);
model.result('pg11').feature('lngr2').set('legendpattern', 't_fwd = eval(t_fwd)');
model.result('pg11').run;
model.result('pg11').set('axislimits', true);
model.result('pg11').set('ymin', '-5.5e-7');
model.result('pg11').set('ymax', '1.7e-5');
model.result('pg11').set('legendpos', 'lowerright');
model.result('pg11').run;

model.title('Lithium Plating with Deformation');

model.description('This tutorial models lithium plating and dendrite growth in a lithium-ion battery. Pulse reverse plating is used to attenuate small protrusions during lithium metal deposition. By matching the process parameters, including the length of the forward and reverse pulses (duty cycles), spikes of lithium dendrites can be avoided.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;
model.sol('sol7').clearSolutionData;
model.sol('sol8').clearSolutionData;
model.sol('sol9').clearSolutionData;

model.label('li_plating_with_deformation.mph');

model.modelNode.label('Components');

out = model;
