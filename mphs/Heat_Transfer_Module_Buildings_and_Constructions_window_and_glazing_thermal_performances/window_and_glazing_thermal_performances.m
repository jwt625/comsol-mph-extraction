function out = model
%
% window_and_glazing_thermal_performances.m
%
% Model exported on May 26 2025, 21:28 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Heat_Transfer_Module/Buildings_and_Constructions');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('ht', 'HeatTransferInSolidsAndFluids', 'geom1');
model.physics('ht').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/ht', true);

model.modelNode('comp1').label('Window with Insulation Panel');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('C1', '0.025[W/(m*K)]', 'First constant for convective heat transfer coefficient calculation');
model.param.set('C2', '0.73[W/(m^2*K)]', 'Second constant for convective heat transfer coefficient calculation');
model.param.set('epsilon', '0.90', 'Surface emissivity');
model.param.set('Ti', '20[degC]', 'Internal temperature');
model.param.set('Te', '0[degC]', 'External temperature');
model.param.set('Rsi_n', '0.13[m^2*K/W]', 'Internal surface resistance (normal)');
model.param.set('Rsi_p', '0.20[m^2*K/W]', 'Internal surface resistance (protected)');
model.param.set('Rse', '0.04[m^2*K/W]', 'External surface resistance');
model.param.set('lambda_p', '0.035[W/(m*K)]', '  Thermal conductivity of the insulation panel');

model.func.create('an1', 'Analytic');
model.func('an1').set('funcname', 'ha');
model.func('an1').set('expr', 'max(C1[(m*K)/W]/d,C2[(m^2*K)/W]*delta^(1/3))');
model.func('an1').set('args', 'd, delta');
model.func('an1').setIndex('argunit', 'm', 0);
model.func('an1').setIndex('argunit', 'K', 1);
model.func('an1').set('fununit', 'W/(m^2*K)');
model.func.create('an2', 'Analytic');
model.func('an2').set('funcname', 'hr');
model.func('an2').set('expr', '4*sigma_const[(K^4*m^2)/W]*Tm^3/(1/e1+1/e2-1)*(1+sqrt(1+(d/b)^2)-d/b)/2');
model.func('an2').set('args', 'd, b, Tm, e1, e2');
model.func('an2').setIndex('argunit', 'm', 0);
model.func('an2').setIndex('argunit', 'm', 1);
model.func('an2').setIndex('argunit', 'K', 2);
model.func('an2').setIndex('argunit', 1, 3);
model.func('an2').setIndex('argunit', 1, 4);
model.func('an2').set('fununit', 'W/(m^2*K)');

model.geom('geom1').insertFile('window_and_glazing_thermal_performances_insulation_panel_geom_sequence.mph', 'geom1');
model.geom('geom1').run('sel4');

model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').set('opname', 'max_uc1');
model.cpl('maxop1').selection.named('geom1_r4_dom');
model.cpl.create('minop1', 'Minimum', 'geom1');
model.cpl('minop1').set('opname', 'min_uc1');
model.cpl('minop1').selection.named('geom1_r4_dom');
model.cpl.create('aveop1', 'Average', 'geom1');
model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').set('opname', 'ave_uc1');
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.named('geom1_adjsel1');
model.cpl.create('maxop2', 'Maximum', 'geom1');
model.cpl('maxop2').set('opname', 'max_uc2');
model.cpl('maxop2').selection.named('geom1_r8_dom');
model.cpl.create('minop2', 'Minimum', 'geom1');
model.cpl('minop2').set('opname', 'min_uc2');
model.cpl('minop2').selection.named('geom1_r8_dom');
model.cpl.create('aveop2', 'Average', 'geom1');
model.cpl('aveop2').set('axisym', true);
model.cpl('aveop2').set('opname', 'ave_uc2');
model.cpl('aveop2').selection.geom('geom1', 1);
model.cpl('aveop2').selection.named('geom1_adjsel2');
model.cpl.create('maxop3', 'Maximum', 'geom1');
model.cpl('maxop3').set('opname', 'max_svc');
model.cpl('maxop3').selection.named('geom1_r6_dom');
model.cpl.create('minop3', 'Minimum', 'geom1');
model.cpl('minop3').set('opname', 'min_svc');
model.cpl('minop3').selection.named('geom1_r6_dom');
model.cpl.create('aveop3', 'Average', 'geom1');
model.cpl('aveop3').set('axisym', true);
model.cpl('aveop3').set('opname', 'ave_svc');
model.cpl('aveop3').selection.geom('geom1', 1);
model.cpl('aveop3').selection.named('geom1_sel1');
model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').set('opname', 'int_internal');
model.cpl('intop1').selection.geom('geom1', 1);
model.cpl('intop1').selection.named('geom1_unisel1');

model.variable.create('var1');
model.variable('var1').model('comp1');

% To import content from file, use:
% model.variable('var1').loadFile('FILENAME');
model.variable('var1').set('b1', '5[mm]', 'Clearance');
model.variable('var1').set('b2', '15[mm]', 'Overlap');
model.variable('var1').set('bp', '190[mm]', 'Visible length of the panel');
model.variable('var1').set('dp', '28[mm]', 'Thickness of the insulation panel');
model.variable('var1').set('bf', '110[mm]', 'Width of the frame');
model.variable('var1').set('df', '83[mm]', 'Height of the frame');
model.variable('var1').set('wb1_wb', '63[mm]', 'Width of the bottom part of the first Woob Block');
model.variable('var1').set('wb1_wt', '42[mm]', 'Width of the top part of the first wood block');
model.variable('var1').set('wb1_hl', '66[mm]', 'Height of the left part of the first wood block');
model.variable('var1').set('wb1_hr', '15[mm]', 'Height of the right part of the first wood block');
model.variable('var1').set('uc1_w', '6[mm]', 'Width of the first unventilated cavity');
model.variable('var1').set('uc1_h', '54[mm]', 'Height of the first unventilated cavity');
model.variable('var1').set('ib_h', '3[mm]', 'Height of the insulation blocks');
model.variable('var1').set('ib1_w', '16[mm]', 'Width of the first insulation block');
model.variable('var1').set('ib_w', '15[mm]', 'Width of the others insulations block');
model.variable('var1').set('svc_w', '5[mm]', 'Width of the slightly ventilated cavity');
model.variable('var1').set('svc_h', '18[mm]', 'Height of the slightly ventilated cavity');
model.variable('var1').set('wb2_wb', '42[mm]', 'Width of the bottom part of the second wood block');
model.variable('var1').set('wb2_wt', '84[mm]', 'Width of the top part of the second wood block');
model.variable('var1').set('wb2_hr', '34[mm]', 'Height of the right part of the second wood block');
model.variable('var1').set('wb2_hl', '14[mm]', 'Height of the left part of the second wood block');
model.variable('var1').set('uc2_h', '34[mm]', 'Height of the second unventilated cavity');
model.variable('var1').set('Rp', 'dp/lambda_p', 'Thermal resistance of the central area of the insulation panel');
model.variable('var1').set('Up_n', '1/(Rp+Rsi_n+Rse)', 'Thermal transmittance of the insulation panel (normal)');
model.variable('var1').set('Up_p', '1/(Rp+Rsi_p+Rse)', 'Thermal resistance of the insulation panel (protected)');
model.variable('var1').set('Up', '(Up_p*30[mm]+Up_n*(bp-30[mm]))/bp', 'Thermal transmittance of the insulation panel');
model.variable('var1').set('R_uc1', '1/(ha(uc1_h,max_uc1(T)-min_uc1(T))+hr(uc1_h,uc1_w,ave_uc1(T),epsilon,epsilon))', 'Thermal resistance of the unventilated cavity 1');
model.variable('var1').set('R_uc2', '1/(ha(uc2_h,max_uc2(T)-min_uc2(T))+hr(uc2_h,b1,ave_uc2(T),epsilon,epsilon))', 'Thermal resistance of the second unventilated cavity');
model.variable('var1').set('R_svc', '1/(ha(svc_h,max_svc(T)-min_svc(T))+hr(svc_h,svc_w,ave_svc(T),epsilon,epsilon))', 'Thermal resistance of the slightly ventilated cavity');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').label('Soft Wood');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'0.13'});
model.material('mat1').propertyGroup('def').set('density', {'500'});
model.material('mat1').propertyGroup('def').set('heatcapacity', {'1600'});
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').label('EPDM');
model.material('mat2').selection.named('geom1_csel1_dom');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'0.25'});
model.material('mat2').propertyGroup('def').set('density', {'1150'});
model.material('mat2').propertyGroup('def').set('heatcapacity', {'1000'});
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').label('Insulation Panel');
model.material('mat3').selection.named('geom1_r10_dom');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'lambda_p'});
model.material('mat3').propertyGroup('def').set('density', {'50'});
model.material('mat3').propertyGroup('def').set('heatcapacity', {'1030'});
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').label('Unventilated Cavity 1');
model.material('mat4').selection.named('geom1_r4_dom');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'uc1_h/R_uc1'});
model.material('mat4').propertyGroup('def').set('density', {'1.23'});
model.material('mat4').propertyGroup('def').set('heatcapacity', {'1008'});
model.material.create('mat5', 'Common', 'comp1');
model.material('mat5').label('Unventilated Cavity 2');
model.material('mat5').selection.named('geom1_r8_dom');
model.material('mat5').propertyGroup('def').set('thermalconductivity', {'uc2_h/R_uc2'});
model.material('mat5').propertyGroup('def').set('density', {'1.23'});
model.material('mat5').propertyGroup('def').set('heatcapacity', {'1008'});
model.material.create('mat6', 'Common', 'comp1');
model.material('mat6').label('Slightly Ventilated Cavity');
model.material('mat6').selection.named('geom1_r6_dom');
model.material('mat6').propertyGroup('def').set('thermalconductivity', {'2*svc_h/R_svc'});
model.material('mat6').propertyGroup('def').set('density', {'1.23'});
model.material('mat6').propertyGroup('def').set('heatcapacity', {'1008'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('d1').label('Direct, heat transfer variables (ht)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol1').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol1').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol1').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('AMG, heat transfer variables (ht)');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '1e-6');

model.modelNode.create('comp2', true);

model.geom.create('geom2', 2);
model.geom('geom2').model('comp2');

model.mesh.create('mesh2', 'geom2');

model.modelNode('comp2').label('Window with Glazing');

model.geom('geom2').insertFile('window_and_glazing_thermal_performances_glazing_geom_sequence.mph', 'geom1');
model.geom('geom2').run('sel8');

model.physics.create('ht2', 'HeatTransferInSolidsAndFluids', 'geom2');
model.physics('ht2').model('comp2');

model.study('std1').feature('stat').setSolveFor('/physics/ht2', false);

model.cpl.create('maxop4', 'Maximum', 'geom2');
model.cpl('maxop4').set('opname', 'max_uc1');
model.cpl('maxop4').selection.named('geom2_r4_dom');
model.cpl.create('minop4', 'Minimum', 'geom2');
model.cpl('minop4').set('opname', 'min_uc1');
model.cpl('minop4').selection.named('geom2_r4_dom');
model.cpl.create('aveop4', 'Average', 'geom2');
model.cpl('aveop4').set('axisym', true);
model.cpl('aveop4').set('opname', 'ave_uc1');
model.cpl('aveop4').selection.geom('geom2', 1);
model.cpl('aveop4').selection.named('geom2_adjsel1');
model.cpl.create('maxop5', 'Maximum', 'geom2');
model.cpl('maxop5').set('opname', 'max_uc2');
model.cpl('maxop5').selection.named('geom2_r8_dom');
model.cpl.create('minop5', 'Minimum', 'geom2');
model.cpl('minop5').set('opname', 'min_uc2');
model.cpl('minop5').selection.named('geom2_r8_dom');
model.cpl.create('aveop5', 'Average', 'geom2');
model.cpl('aveop5').set('axisym', true);
model.cpl('aveop5').set('opname', 'ave_uc2');
model.cpl('aveop5').selection.geom('geom2', 1);
model.cpl('aveop5').selection.named('geom2_adjsel2');
model.cpl.create('maxop6', 'Maximum', 'geom2');
model.cpl('maxop6').set('opname', 'max_svc');
model.cpl('maxop6').selection.named('geom2_r6_dom');
model.cpl.create('minop6', 'Minimum', 'geom2');
model.cpl('minop6').set('opname', 'min_svc');
model.cpl('minop6').selection.named('geom2_r6_dom');
model.cpl.create('aveop6', 'Average', 'geom2');
model.cpl('aveop6').set('axisym', true);
model.cpl('aveop6').set('opname', 'ave_svc');
model.cpl('aveop6').selection.geom('geom2', 1);
model.cpl('aveop6').selection.named('geom2_sel1');
model.cpl.create('intop2', 'Integration', 'geom2');
model.cpl('intop2').set('axisym', true);
model.cpl('intop2').set('opname', 'int_internal');
model.cpl('intop2').selection.geom('geom2', 1);
model.cpl('intop2').selection.named('geom2_unisel1');

model.variable.create('var2');
model.variable('var2').model('comp2');

% To import content from file, use:
% model.variable('var2').loadFile('FILENAME');
model.variable('var2').set('b1', '5[mm]', 'Clearance');
model.variable('var2').set('b2', '15[mm]', 'Overlap');
model.variable('var2').set('bg', '190[mm]', 'Visible length of the glazing');
model.variable('var2').set('dg', '28[mm]', 'Thickness of the glazing');
model.variable('var2').set('bf', '110[mm]', 'Width of the frame');
model.variable('var2').set('df', '83[mm]', 'Height of the frame');
model.variable('var2').set('wb1_wb', '63[mm]', 'Width of the bottom part of the first Woob Block');
model.variable('var2').set('wb1_wt', '42[mm]', 'Width of the top part of the first wood block');
model.variable('var2').set('wb1_hl', '66[mm]', 'Height of the left part of the first wood block');
model.variable('var2').set('wb1_hr', '15[mm]', 'Height of the right part of the first wood block');
model.variable('var2').set('uc1_w', '6[mm]', 'Width of the first unventilated cavity');
model.variable('var2').set('uc1_h', '54[mm]', 'Height of the first unventilated cavity');
model.variable('var2').set('ib_h', '3[mm]', 'Height of the insulation blocks');
model.variable('var2').set('ib1_w', '16[mm]', 'Width of the first insulation block');
model.variable('var2').set('ib_w', '15[mm]', 'Width of the others insulations block');
model.variable('var2').set('svc_w', '5[mm]', 'Width of the slightly ventilated cavity');
model.variable('var2').set('svc_h', '18[mm]', 'Height of the slightly ventilated cavity');
model.variable('var2').set('wb2_wb', '42[mm]', 'Width of the bottom part of the second wood block');
model.variable('var2').set('wb2_wt', '84[mm]', 'Width of the top part of the second wood block');
model.variable('var2').set('wb2_hr', '34[mm]', 'Height of the right part of the second wood block');
model.variable('var2').set('wb2_hl', '14[mm]', 'Height of the left part of the second wood block');
model.variable('var2').set('uc2_h', '34[mm]', 'Height of the second unventilated cavity');
model.variable('var2').set('a_t', '0.5[mm]', 'Aluminum thickness');
model.variable('var2').set('p_w', '3[mm]', 'Width of the polysulfide block');
model.variable('var2').set('g_t', '4[mm]', 'Glass thickness');
model.variable('var2').set('sg_h', '19[mm]', 'Height of the silica gel block');
model.variable('var2').set('sg_w', '9[mm]', 'Width of the silica gel block');
model.variable('var2').set('Rp', 'dg/lambda_p', 'Thermal resistance of the central area of the insulation panel');
model.variable('var2').set('Up_n', '1/(Rp+Rsi_n+Rse)', 'Thermal transmittance of the insulation panel (normal)');
model.variable('var2').set('Up_p', '1/(Rp+Rsi_p+Rse)', 'Thermal resistance of the insulation panel (protected)');
model.variable('var2').set('Up', '(Up_p*30[mm]+Up_n*(bg-30[mm]))/bg', 'Thermal transmittance of the insulation panel');
model.variable('var2').set('Ug', '1.3[W/(m^2*K)]', 'Thermal transmittance of the central area of glazing');
model.variable('var2').set('Uf', '1.375[W/(m^2*K)]', 'Thermal transmittance of the frame (c.f result of the first model)');
model.variable('var2').set('R_uc1', '1/(ha(uc1_h,max_uc1(T2)-min_uc1(T2))+hr(uc1_h,uc1_w,ave_uc1(T2),epsilon,epsilon))', 'Thermal resistance of the unventilated cavity 1');
model.variable('var2').set('R_uc2', '1/(ha(uc2_h,max_uc2(T2)-min_uc2(T2))+hr(uc2_h,b1,ave_uc2(T2),epsilon,epsilon))', 'Thermal resistance of the second unventilated cavity');
model.variable('var2').set('R_svc', '1/(ha(svc_h,max_svc(T2)-min_svc(T2))+hr(svc_h,svc_w,ave_svc(T2),epsilon,epsilon))', 'Thermal resistance of the slightly ventilated cavity');

model.material.create('mat7', 'Common', 'comp2');
model.material('mat7').label('Soft Wood');
model.material('mat7').propertyGroup('def').set('thermalconductivity', {'0.13'});
model.material('mat7').propertyGroup('def').set('density', {'500'});
model.material('mat7').propertyGroup('def').set('heatcapacity', {'1600'});
model.material.create('mat8', 'Common', 'comp2');
model.material('mat8').label('EPDM');
model.material('mat8').selection.named('geom2_csel1_dom');
model.material('mat8').propertyGroup('def').set('thermalconductivity', {'0.25'});
model.material('mat8').propertyGroup('def').set('density', {'1150'});
model.material('mat8').propertyGroup('def').set('heatcapacity', {'1000'});
model.material.create('mat9', 'Common', 'comp2');
model.material('mat9').label('Glass');
model.material('mat9').selection.named('geom2_sel5');
model.material('mat9').propertyGroup('def').set('thermalconductivity', {'1.00'});
model.material('mat9').propertyGroup('def').set('density', {'2500'});
model.material('mat9').propertyGroup('def').set('heatcapacity', {'750'});
model.material.create('mat10', 'Common', 'comp2');
model.material('mat10').label('Aluminum');
model.material('mat10').selection.named('geom2_sel7');
model.material('mat10').propertyGroup('def').set('thermalconductivity', {'160'});
model.material('mat10').propertyGroup('def').set('density', {'2800'});
model.material('mat10').propertyGroup('def').set('heatcapacity', {'880'});
model.material.create('mat11', 'Common', 'comp2');
model.material('mat11').label('Polysulfide');
model.material('mat11').selection.named('geom2_sel8');
model.material('mat11').propertyGroup('def').set('thermalconductivity', {'0.40'});
model.material('mat11').propertyGroup('def').set('density', {'1700'});
model.material('mat11').propertyGroup('def').set('heatcapacity', {'1000'});
model.material.create('mat12', 'Common', 'comp2');
model.material('mat12').label('Silica Gel');
model.material('mat12').selection.named('geom2_r12_dom');
model.material('mat12').propertyGroup('def').set('thermalconductivity', {'0.13'});
model.material('mat12').propertyGroup('def').set('density', {'720'});
model.material('mat12').propertyGroup('def').set('heatcapacity', {'1000'});
model.material.create('mat13', 'Common', 'comp2');
model.material('mat13').label('Polyamide');
model.material('mat13').selection.named('geom2_r13_dom');
model.material('mat13').propertyGroup('def').set('thermalconductivity', {'0.25'});
model.material('mat13').propertyGroup('def').set('density', {'1150'});
model.material('mat13').propertyGroup('def').set('heatcapacity', {'1600'});
model.material.create('mat14', 'Common', 'comp2');
model.material('mat14').label('Filling Gas');
model.material('mat14').selection.named('geom2_sel6');
model.material('mat14').propertyGroup('def').set('thermalconductivity', {'0.034'});
model.material('mat14').propertyGroup('def').set('density', {'1.23'});
model.material('mat14').propertyGroup('def').set('heatcapacity', {'1008'});
model.material.create('mat15', 'Common', 'comp2');
model.material('mat15').label('Unventilated Cavity 1');
model.material('mat15').selection.named('geom2_r4_dom');
model.material('mat15').propertyGroup('def').set('thermalconductivity', {'uc1_h/R_uc1'});
model.material('mat15').propertyGroup('def').set('density', {'1.23'});
model.material('mat15').propertyGroup('def').set('heatcapacity', {'1008'});
model.material.create('mat16', 'Common', 'comp2');
model.material('mat16').label('Unventilated Cavity 2');
model.material('mat16').selection.named('geom2_r8_dom');
model.material('mat16').propertyGroup('def').set('thermalconductivity', {'uc2_h/R_uc2'});
model.material('mat16').propertyGroup('def').set('density', {'1.23'});
model.material('mat16').propertyGroup('def').set('heatcapacity', {'1008'});
model.material.create('mat17', 'Common', 'comp2');
model.material('mat17').label('Slightly Ventilated Cavity');
model.material('mat17').selection.named('geom2_r6_dom');
model.material('mat17').propertyGroup('def').set('thermalconductivity', {'2*svc_h/R_svc'});
model.material('mat17').propertyGroup('def').set('density', {'1.23'});
model.material('mat17').propertyGroup('def').set('heatcapacity', {'1008'});

model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').setSolveFor('/physics/ht', false);
model.study('std2').feature('stat').setSolveFor('/physics/ht2', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('d1').label('Direct, heat transfer variables (ht2)');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'gmres');
model.sol('sol2').feature('s1').feature('i1').set('prefuntype', 'left');
model.sol('sol2').feature('s1').feature('i1').set('itrestart', 50);
model.sol('sol2').feature('s1').feature('i1').set('rhob', 20);
model.sol('sol2').feature('s1').feature('i1').set('maxlinit', 10000);
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol2').feature('s1').feature('i1').label('AMG, heat transfer variables (ht2)');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('mgcycle', 'v');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('strconn', 0.01);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('nullspace', 'constant');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('usesmooth', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('loweramg', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').set('compactaggregation', false);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('iter', 2);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('so1').set('relax', 0.9);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('pivotperturb', 1.0E-13);
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol2').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol2').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol2').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol2').feature('s1').feature('fc1').set('termonres', 'off');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').set('stol', '1e-6');

model.result.dataset.remove('dset1');
model.result.dataset.remove('dset2');
model.result.dataset.remove('dset3');

model.title('Parameterized Window and Glazing, Preset Model');

model.description('This is a template MPH-file containing the physics interfaces and the parameterized geometry for the model Glazing Influence on Thermal Performances of a Window.');

model.label('window_and_glazing_thermal_performances_preset.mph');

model.variable('var1').set('L2D', 'int_internal(ht.ntflux/(Te-Ti))');
model.variable('var1').descr('L2D', 'Thermal conductance of the frame');

model.physics('ht').feature('fluid1').selection.set([4 6 7]);
model.physics('ht').prop('ShapeProperty').set('order_temperature', 2);
model.physics('ht').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf1').selection.named('geom1_sel4');
model.physics('ht').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf1').set('h', '1/Rse');
model.physics('ht').feature('hf1').set('Text', 'Te');
model.physics('ht').create('hf2', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf2').selection.named('geom1_sel3');
model.physics('ht').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf2').set('h', '1/Rsi_n');
model.physics('ht').feature('hf2').set('Text', 'Ti');
model.physics('ht').create('hf3', 'HeatFluxBoundary', 1);
model.physics('ht').feature('hf3').selection.named('geom1_sel2');
model.physics('ht').feature('hf3').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht').feature('hf3').set('h', '1/Rsi_p');
model.physics('ht').feature('hf3').set('Text', 'Ti');

model.result.dataset.create('dset1', 'Solution');
model.result.dataset('dset1').set('solution', 'sol1');
model.result.dataset('dset1').set('comp', 'none');
model.result.dataset('dset1').set('geom', 'geom1');
model.result.dataset.create('dset2', 'Solution');
model.result.dataset('dset2').set('solution', 'sol1');
model.result.dataset('dset2').set('geom', 'geom2');
model.result.dataset('dset2').set('comp', 'comp2');

model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Temperature (ht)');
model.result('pg1').set('data', 'dset1');
model.result('pg1').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('solutionparams', 'parent');
model.result('pg1').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg1').feature('surf1').set('showsolutionparams', 'on');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').label('Thermal Properties, Window with Insulation Panel');
model.result.numerical('gev1').setIndex('expr', 'L2D', 0);
model.result.numerical('gev1').setIndex('descr', 'Thermal Conductance of the Section (L2D)', 0);
model.result.numerical('gev1').setIndex('expr', '(L2D-Up*bp)/bf', 1);
model.result.numerical('gev1').setIndex('descr', 'Thermal Transmittance of the Frame (Uf)', 1);
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Thermal Properties, Window with Insulation Panel');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('unit', 'degC');
model.result('pg1').run;

model.variable('var2').set('L2D', 'int_internal(ht2.ntflux/(Te-Ti))', 'Thermal conductance of the frame');
model.variable('var2').descr('L2D', 'Thermal conductance of the frame');

model.physics('ht2').feature('fluid1').selection.set([4 6 7 16]);
model.physics('ht2').prop('ShapeProperty').set('order_temperature', 2);
model.physics('ht2').create('hf1', 'HeatFluxBoundary', 1);
model.physics('ht2').feature('hf1').selection.named('geom2_sel4');
model.physics('ht2').feature('hf1').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht2').feature('hf1').set('h', '1/Rse');
model.physics('ht2').feature('hf1').set('Text', 'Te');
model.physics('ht2').create('hf2', 'HeatFluxBoundary', 1);
model.physics('ht2').feature('hf2').selection.named('geom2_sel3');
model.physics('ht2').feature('hf2').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht2').feature('hf2').set('h', '1/Rsi_n');
model.physics('ht2').feature('hf2').set('Text', 'Ti');
model.physics('ht2').create('hf3', 'HeatFluxBoundary', 1);
model.physics('ht2').feature('hf3').selection.named('geom2_sel2');
model.physics('ht2').feature('hf3').set('HeatFluxType', 'ConvectiveHeatFlux');
model.physics('ht2').feature('hf3').set('h', '1/Rsi_p');
model.physics('ht2').feature('hf3').set('Text', 'Ti');

model.result.dataset.create('dset3', 'Solution');
model.result.dataset('dset3').set('solution', 'sol2');
model.result.dataset('dset3').set('comp', 'none');
model.result.dataset('dset3').set('geom', 'geom1');
model.result.dataset.create('dset4', 'Solution');
model.result.dataset('dset4').set('solution', 'sol2');
model.result.dataset('dset4').set('geom', 'geom2');
model.result.dataset('dset4').set('comp', 'comp2');
model.result.dataset.move('dset3', 2);
model.result.dataset('dset3').tag('dset3');
model.result.dataset.move('dset4', 3);
model.result.dataset('dset4').tag('dset4');

model.sol('sol2').runAll;

model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Temperature (ht2)');
model.result('pg2').set('data', 'dset4');
model.result('pg2').set('defaultPlotID', 'ht/HT_PhysicsInterfaces/icom8/pdef1/pcond2/pcond4/pg2');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('solutionparams', 'parent');
model.result('pg2').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').run;
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical('gev2').label('Thermal Properties, Window with Glazing');
model.result.numerical('gev2').set('data', 'dset4');
model.result.numerical('gev2').setIndex('expr', 'L2D', 0);
model.result.numerical('gev2').setIndex('descr', 'Thermal Conductance of the Section (L2D)', 0);
model.result.numerical('gev2').setIndex('expr', 'L2D-Uf*bf-Ug*bg', 1);
model.result.numerical('gev2').setIndex('descr', 'Linear Thermal Transmittance of the Frame (psi)', 1);
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Thermal Properties, Window with Glazing');
model.result.numerical('gev2').set('table', 'tbl2');
model.result.numerical('gev2').setResult;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('unit', 'degC');
model.result('pg2').run;
model.result('pg2').run;

model.title('Glazing Influence on Thermal Performances of a Window');

model.description('This benchmark reproduces the two test cases from the ISO 10077-2:2012 standard related to double-glazed windows. The thermal performance of each window is computed from its thermal conductance and thermal transmittance. Finally, the results are compared with given data for validation.');

model.label('window_and_glazing_thermal_performances.mph');

model.modelNode.label('Components');

out = model;
