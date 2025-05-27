function out = model
%
% atmospheric_corrosion.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Atmospheric_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('cdsh', 'CurrentDistributionShell', 'geom1');
model.physics('cdsh').model('comp1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/cdsh', true);

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').set('type', 'open');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', '-12[mm] 0 0 12[mm]');
model.geom('geom1').feature('pol1').set('y', '0 0 0 0');
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('LD', '0.0005[kg/m^2]', 'Salt load density');
model.param.set('RH', '0.8', 'Relative humidity');
model.param.set('sigma', '48250.20-287264*RH+683394*RH^2-811693*RH^3+481365*RH^4-114051*RH^5[S/m]', 'Electrolyte conductivity');
model.param.set('d_film', 'LD[m/(kg/m^2)]*(24.9+14.8*RH-22.58*RH^2)/(5811.95+23909*RH-3291*RH^2-57990*RH^3+31576*RH^4)', 'Electrolyte film thickness');
model.param.set('m_salt', '-25.12*RH+25.253[mol/kg]', 'Concentration of salt in solution');
model.param.set('rho_sol', '1823.2-814.38*RH[kg/m^3]', 'Density of salt solution');
model.param.set('cNaCl', 'm_salt*rho_sol', 'NaCl concentration');
model.param.set('D_O2', '(-0.1464e-3*cNaCl[m^3/mol]+2.0511)*1e-9[m^2/s]', 'Diffusion coefficient of O2');
model.param.set('O2_solubility', '0.0003*exp(6.59*RH)[mol/m^3]', 'O2 solubility');
model.param.set('ilim', '4*F_const*D_O2*O2_solubility/d_film', 'Limiting current density for O2');

model.cpl.create('aveop1', 'Average', 'geom1');

model.geom('geom1').run;

model.cpl('aveop1').set('axisym', true);
model.cpl('aveop1').selection.geom('geom1', 1);
model.cpl('aveop1').selection.set([1]);
model.cpl.create('maxop1', 'Maximum', 'geom1');
model.cpl('maxop1').selection.geom('geom1', 1);
model.cpl('maxop1').selection.set([1]);
model.cpl.duplicate('maxop2', 'maxop1');
model.cpl('maxop2').selection.set([2]);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat1').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat1').label('AISI 4340 steel in 0.6M NaCl at pH = 8.3');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-0.99798995' '-2.28795E-05';  ...
'-0.963819095' '-2.05761E-05';  ...
'-0.934673367' '-1.99315E-05';  ...
'-0.906532663' '-2.0359E-05';  ...
'-0.874371859' '-2.10175E-05';  ...
'-0.846231156' '-2.05761E-05';  ...
'-0.812060302' '-1.9307E-05';  ...
'-0.771859296' '-1.89016E-05';  ...
'-0.733668342' '-1.89016E-05';  ...
'-0.686432161' '-1.89016E-05';  ...
'-0.645226131' '-1.87021E-05';  ...
'-0.617085427' '-1.718E-05';  ...
'-0.592964824' '-1.4193E-05';  ...
'-0.578894472' '-1.16016E-05';  ...
'-0.569849246' '-9.28415E-06';  ...
'-0.56080402' '-6.82498E-06';  ...
'-0.553768844' '-4.96424E-06';  ...
'-0.549748744' '-3.31694E-06';  ...
'-0.546733668' '-1.91032E-06';  ...
'-0.543718593' '-9.89E-07';  ...
'-0.543718593' '-5.58E-07';  ...
'-0.543718593' '4.37E-07';  ...
'-0.534673367' '1.04E-07';  ...
'-0.534673367' '5.12E-07';  ...
'-0.533668342' '7.83E-07';  ...
'-0.532663317' '1.3177E-06';  ...
'-0.532663317' '1.718E-06';  ...
'-0.530653266' '2.2638E-06';  ...
'-0.530653266' '3.28193E-06';  ...
'-0.526633166' '5.34701E-06';  ...
'-0.51959799' '9.48328E-06';  ...
'-0.511557789' '1.57818E-05';  ...
'-0.502512563' '2.51722E-05';  ...
'-0.488442211' '4.18909E-05';  ...
'-0.471356784' '7.35122E-05';  ...
'-0.454271357' '0.000127641';  ...
'-0.433165829' '0.000246437';  ...
'-0.417085427' '0.000405784';  ...
'-0.403015075' '0.000682498';  ...
'-0.392964824' '0.001'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/cm^2'});
model.material('mat1').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat1').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', 'D. Mizuno and R.G. Kelly, "Galvanically induced intergranular corrosion of AA5083-H131 under atmospheric exposure conditions: Part 2 - Modeling of the damage distribution", Corrosion, vol. 69, p. 681, 2013.');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat1').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'D. Mizuno and R.G. Kelly, "Galvanically induced intergranular corrosion of AA5083-H131 under atmospheric exposure conditions: Part 2 - Modeling of the damage distribution", Corrosion, vol. 69, p. 681, 2013.');
model.material('mat1').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.535 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat1').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat1').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat1').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat1').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat1').selection.set([2]);
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('LocalCurrentDensity', 'Local current density');
model.material('mat2').propertyGroup('LocalCurrentDensity').func.create('int1', 'Interpolation');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').label('AA5083-H131 in 0.6 M NaCl');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('funcname', 'iloc_exp');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('table', {'-1.00201005' '-5.51995E-06';  ...
'-0.95879397' '-4.8087E-06';  ...
'-0.908542714' '-3.88921E-06';  ...
'-0.873366834' '-3.07949E-06';  ...
'-0.847236181' '-2.41262E-06';  ...
'-0.832160804' '-1.95129E-06';  ...
'-0.820100503' '-1.57818E-06';  ...
'-0.809045226' '-1.26294E-06';  ...
'-0.80201005' '-1.03235E-06';  ...
'-0.795979899' '-8.35E-07';  ...
'-0.789949749' '-6.40E-07';  ...
'-0.783919598' '-4.66E-07';  ...
'-0.778894472' '-3.42E-07';  ...
'-0.774874372' '-2.44E-07';  ...
'-0.774874372' '-1.74E-07';  ...
'-0.773869347' '-1.03E-07';  ...
'-0.766834171' '1.02E-07';  ...
'-0.765829146' '1.25E-07';  ...
'-0.761809045' '1.60E-07';  ...
'-0.75879397' '2.08E-07';  ...
'-0.754773869' '2.68E-07';  ...
'-0.749748744' '3.42E-07';  ...
'-0.745728643' '4.32E-07';  ...
'-0.740703518' '5.40E-07';  ...
'-0.736683417' '6.47E-07';  ...
'-0.734673367' '7.83E-07';  ...
'-0.733668342' '9.79E-07';  ...
'-0.730653266' '1.81161E-06';  ...
'-0.728643216' '2.82887E-06';  ...
'-0.728643216' '4.51209E-06';  ...
'-0.72361809' '7.83446E-06';  ...
'-0.716582915' '1.33175E-05';  ...
'-0.714572864' '2.19287E-05';  ...
'-0.710552764' '3.6108E-05';  ...
'-0.705527638' '6.89779E-05';  ...
'-0.704522613' '0.000103235';  ...
'-0.698492462' '0.000169987';  ...
'-0.692462312' '0.000274024';  ...
'-0.686432161' '0.000432459';  ...
'-0.68241206' '0.000654136';  ...
'-0.679396985' '0.000989445'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('fununit', {'A/cm^2'});
model.material('mat2').propertyGroup('LocalCurrentDensity').func('int1').set('argunit', {'V'});
model.material('mat2').propertyGroup('LocalCurrentDensity').set('ilocmat', 'iloc_exp(E_vs_ref_exp)');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('INFO_PREFIX:ilocmat', 'D. Mizuno and R.G. Kelly, "Galvanically induced intergranular corrosion of AA5083-H131 under atmospheric exposure conditions: Part 2 - Modeling of the damage distribution", Corrosion, vol. 69, p. 681, 2013.');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_SHE', 'V');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_SHE', 'Electrode potential vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').set('E_vs_ref_exp', 'E_vs_SHE-E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('LocalCurrentDensity').descr('E_vs_ref_exp', 'Electrode potential vs. experimental SCE reference electrode');
model.material('mat2').propertyGroup('LocalCurrentDensity').addInput('electricpotential');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', 'D. Mizuno and R.G. Kelly, "Galvanically induced intergranular corrosion of AA5083-H131 under atmospheric exposure conditions: Part 2 - Modeling of the damage distribution", Corrosion, vol. 69, p. 681, 2013.');
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', '0');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_ref_exp', '-0.772[V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_ref_exp', 'Equilibrium (open circuit) potential vs. SCE');
model.material('mat2').propertyGroup('ElectrodePotential').set('E_ref_exp_vs_SHE', '0.241 [V]');
model.material('mat2').propertyGroup('ElectrodePotential').descr('E_ref_exp_vs_SHE', 'Reference electrode potential in experiment vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq_vs_SHE', 'Eeq_vs_ref_exp+E_ref_exp_vs_SHE');
model.material('mat2').propertyGroup('ElectrodePotential').descr('Eeq_vs_SHE', 'Equilibrium (open circuit) potential vs. SHE');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').selection.set([1]);

model.physics('cdsh').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'SCE');
model.physics('cdsh').feature('ice1').set('s', 'd_film');
model.physics('cdsh').feature('ice1').set('sigmal_mat', 'userdef');
model.physics('cdsh').feature('ice1').set('sigmal', {'sigma' '0' '0' '0' 'sigma' '0' '0' '0' 'sigma'});
model.physics('cdsh').create('eebii1', 'ExternalElectrodeSurface', 1);
model.physics('cdsh').feature('eebii1').selection.set([1]);
model.physics('cdsh').feature('eebii1').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cdsh').create('eebii2', 'ExternalElectrodeSurface', 1);
model.physics('cdsh').feature('eebii2').selection.set([2]);
model.physics('cdsh').feature('eebii2').feature('er1').set('ilocmat_mat', 'from_mat');
model.physics('cdsh').feature('eebii2').feature('er1').set('LimitingCurrentDensity', true);
model.physics('cdsh').feature('eebii2').feature('er1').set('ilim', 'ilim');

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([1 2]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 50);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').feature('edg1').feature('dis1').set('reverse', true);
model.mesh('mesh1').feature('edg1').feature.duplicate('dis2', 'dis1');
model.mesh('mesh1').feature('edg1').feature('dis2').selection.set([2]);
model.mesh('mesh1').feature('edg1').feature('dis2').set('reverse', false);
model.mesh('mesh1').run;

model.study('std1').create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype', 'filled');
model.study('std1').feature('param').setIndex('pname', 'LD', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'kg/m^2', 0);
model.study('std1').feature('param').setIndex('pname', 'LD', 0);
model.study('std1').feature('param').setIndex('plistarr', '', 0);
model.study('std1').feature('param').setIndex('punit', 'kg/m^2', 0);
model.study('std1').feature('param').setIndex('plistarr', '0.0005 0.001 0.002 0.0035 0.007[kg/m^2]', 0);
model.study('std1').feature('param').setIndex('pname', 'RH', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('pname', 'RH', 1);
model.study('std1').feature('param').setIndex('plistarr', '', 1);
model.study('std1').feature('param').setIndex('punit', '', 1);
model.study('std1').feature('param').setIndex('plistarr', 'range(0.8,0.03,0.98)', 1);

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
model.sol('sol1').feature('s1').feature('p1').set('pname', {'LD' 'RH'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'0.0005 0.001 0.002 0.0035 0.007[kg/m^2]' 'range(0.8,0.03,0.98)'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'kg/m^2' ''});
model.sol('sol1').feature('s1').feature('p1').set('sweeptype', 'filled');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('porder', 'constant');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'param');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (cdsh)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (cdsh)');
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
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (cdsh)');
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
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').set('stol', '0.00001');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 7, 0);
model.result('pg1').setIndex('looplevel', 5, 1);
model.result('pg1').create('line1', 'Line');
model.result('pg1').feature('line1').set('expr', {'phil'});
model.result('pg1').feature('line1').set('linetype', 'tube');
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('expr', {'cdsh.tIlx' 'cdsh.tIly'});
model.result('pg1').feature('arwl1').set('arrowbase', 'center');
model.result('pg1').feature('arwl1').set('arrowtype', 'cone');
model.result('pg1').feature('arwl1').set('arrowcount', 50);
model.result('pg1').feature('arwl1').set('color', 'black');
model.result('pg1').label('Electrolyte Potential (cdsh)');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 7, 0);
model.result('pg2').setIndex('looplevel', 5, 1);
model.result('pg2').create('line1', 'Line');
model.result('pg2').feature('line1').set('expr', {'cdsh.tIlMag'});
model.result('pg2').feature('line1').set('linetype', 'tube');
model.result('pg2').create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').set('expr', {'cdsh.tIlx' 'cdsh.tIly'});
model.result('pg2').feature('arwl1').set('arrowbase', 'center');
model.result('pg2').feature('arwl1').set('arrowtype', 'cone');
model.result('pg2').feature('arwl1').set('arrowcount', 50);
model.result('pg2').feature('arwl1').set('color', 'black');
model.result('pg2').label('Tangential Electrolyte Current Density (cdsh)');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 7, 0);
model.result('pg3').setIndex('looplevel', 5, 1);
model.result('pg3').create('line1', 'Line');
model.result('pg3').feature('line1').set('expr', {'abs(cdsh.itot)'});
model.result('pg3').feature('line1').set('linetype', 'tube');
model.result('pg3').label('Total Interface Current Density (cdsh)');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 7, 0);
model.result('pg4').setIndex('looplevel', 5, 1);
model.result('pg4').create('line1', 'Line');
model.result('pg4').feature('line1').set('expr', {'cdsh.Evsref'});
model.result('pg4').feature('line1').set('linetype', 'tube');
model.result('pg4').label('Electrode Potential vs. Adjacent Reference (cdsh)');
model.result('pg1').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').set('ylog', true);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('data', 'dset1');
model.result('pg5').feature('lngr1').setIndex('looplevelinput', 'first', 1);
model.result('pg5').feature('lngr1').selection.set([1 2]);
model.result('pg5').feature('lngr1').set('expr', 'abs(cdsh.iloc_er1)');
model.result('pg5').feature('lngr1').set('descractive', true);
model.result('pg5').feature('lngr1').set('descr', 'Local current density');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'maxop1(cdsh.iloc_er1)', 0);
model.result('pg6').feature('glob1').setIndex('unit', 'A/m^2', 0);
model.result('pg6').feature('glob1').setIndex('descr', '', 0);
model.result('pg6').run;
model.result('pg6').set('titletype', 'manual');
model.result('pg6').set('title', 'Maximum anode current density');
model.result('pg6').set('xlabelactive', true);
model.result('pg6').set('xlabel', 'Relative humidity (1)');
model.result('pg6').set('ylabelactive', true);
model.result('pg6').set('ylabel', 'Current density (A/m<sup>2</sup>)');
model.result('pg6').set('legendpos', 'upperleft');
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').feature('glob1').setIndex('expr', 'maxop2(-cdsh.iloc_er1)', 0);
model.result('pg7').feature('glob1').setIndex('unit', 'A/m^2', 0);
model.result('pg7').feature('glob1').setIndex('descr', '', 0);
model.result('pg7').run;
model.result('pg7').set('title', 'Maximum cathode current density');
model.result('pg7').run;
model.result('pg6').run;
model.result.duplicate('pg8', 'pg6');
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').feature('glob1').setIndex('expr', 'aveop1(cdsh.iloc_er1)', 0);
model.result('pg8').feature('glob1').setIndex('unit', 'A/m^2', 0);
model.result('pg8').feature('glob1').setIndex('descr', '', 0);
model.result('pg8').run;
model.result('pg8').set('title', 'Average anode current density');
model.result('pg8').run;
model.result('pg5').run;
model.result('pg5').label('Local Current Density');
model.result('pg6').run;
model.result('pg6').label('Maximum Anode Current Density');
model.result('pg7').run;
model.result('pg7').label('Maximum Cathode Current Density');
model.result('pg8').run;
model.result('pg8').label('Average Anode Current Density');

model.func.create('an1', 'Analytic');
model.func('an1').model('comp1');
model.func('an1').set('expr', 'LD[m/(kg/m^2)]*(24.9+14.8*RH-22.58*RH^2)/(5811.95+23909*RH-3291*RH^2-57990*RH^3+31576*RH^4)');
model.func('an1').set('args', 'RH, LD');
model.func('an1').set('fununit', 'm');
model.func('an1').setIndex('argunit', 1, 0);
model.func('an1').setIndex('argunit', 'kg/m^2', 1);
model.func.create('an2', 'Analytic');
model.func('an2').model('comp1');
model.func('an2').set('expr', '0.0003*exp(6.59*RH)[mol/m^3]');
model.func('an2').set('args', 'RH');
model.func('an2').set('fununit', 'mol/m^3');
model.func.create('an3', 'Analytic');
model.func('an3').model('comp1');
model.func('an3').set('expr', '48250.20-287264*RH+683394*RH^2-811693*RH^3+481365*RH^4-114051*RH^5[S/m]');
model.func('an3').set('args', 'RH');
model.func('an3').set('fununit', 'S/m');
model.func.create('an4', 'Analytic');
model.func('an4').model('comp1');
model.func('an4').set('expr', '(-0.1464e-3*(-25.12*RH+25.253[mol/kg])*(1823.2-814.38*RH[kg/m^3])[m^3/mol]+2.0511)*1e-9[m^2/s]');
model.func('an4').set('args', 'RH');
model.func('an4').set('fununit', 'm^2/s');

model.result.dataset.create('grid1', 'Grid1D');
model.result.dataset('grid1').set('source', 'data');
model.result.dataset('grid1').set('par1', 'RH');
model.result.dataset('grid1').set('source', 'function');
model.result.dataset('grid1').set('function', 'all');
model.result.dataset('grid1').set('parmin1', 0.8);
model.result.dataset('grid1').set('parmax1', 0.98);
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').set('data', 'grid1');
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'Relative humidity (1)');
model.result('pg9').set('ylabelactive', true);
model.result('pg9').set('ylabel', 'Film thickness (\mu m)');
model.result('pg9').set('titletype', 'none');
model.result('pg9').set('legendpos', 'upperleft');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg9').feature('lngr1').set('linewidth', 'preference');
model.result('pg9').feature('lngr1').set('expr', 'comp1.an1(root.RH[1], 5e-4[kg/m^2])');
model.result('pg9').feature('lngr1').set('unit', [native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'root.RH');
model.result('pg9').feature('lngr1').set('legend', true);
model.result('pg9').feature('lngr1').set('legendmethod', 'manual');
model.result('pg9').feature('lngr1').setIndex('legends', '0.5 g/m<sup>2</sup>', 0);
model.result('pg9').feature.duplicate('lngr2', 'lngr1');
model.result('pg9').run;
model.result('pg9').feature('lngr2').set('expr', 'comp1.an1(root.RH[1], 7e-3[kg/m^2])');
model.result('pg9').feature('lngr2').setIndex('legends', '7 g/m<sup>2</sup>', 0);
model.result('pg9').run;
model.result('pg9').run;
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').set('titletype', 'none');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', 'Relative humidity (1)');
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'O<sub>2</sub> solubility (mol/m<sup>3</sup>)');
model.result('pg10').set('data', 'grid1');
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg10').feature('lngr1').set('linewidth', 'preference');
model.result('pg10').feature('lngr1').set('expr', 'comp1.an2(root.RH[1])');
model.result('pg10').feature('lngr1').set('xdata', 'expr');
model.result('pg10').feature('lngr1').set('xdataexpr', 'root.RH');
model.result('pg10').run;
model.result('pg10').run;
model.result.duplicate('pg11', 'pg10');
model.result('pg11').run;
model.result('pg11').run;
model.result('pg11').feature('lngr1').set('expr', 'comp1.an3(root.RH[1])');
model.result('pg11').run;
model.result('pg11').set('ylabel', 'Conductivity (S/m)');
model.result('pg11').run;
model.result.duplicate('pg12', 'pg11');
model.result('pg12').run;
model.result('pg12').set('ylabel', 'O<sub>2</sub> diffusivity (m<sup>2</sup>/s)');
model.result('pg12').run;
model.result('pg12').feature('lngr1').set('expr', 'comp1.an4(root.RH[1])');
model.result('pg12').run;
model.result('pg9').run;
model.result.remove('pg9');
model.result('pg10').run;
model.result.remove('pg10');
model.result('pg11').run;
model.result.remove('pg11');
model.result('pg12').run;
model.result.remove('pg12');

model.func.remove('an1');
model.func.remove('an2');
model.func.remove('an3');
model.func.remove('an4');

model.result.dataset.remove('grid1');

model.title('Atmospheric Corrosion');

model.description('This example simulates atmospheric galvanic corrosion of an aluminum alloy in contact with steel. The electrolyte film thickness depends on the relative humidity of the surrounding air and the salt load density of NaCl crystals on the metal surfaces. Empirical expressions for the oxygen diffusivity and solubility are also included in the model in order to derive an expression for the limiting oxygen reduction current density.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('atmospheric_corrosion.mph');

model.modelNode.label('Components');

out = model;
