function out = model
%
% atmospheric_corrosion_mass_transport.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Corrosion_Module/Atmospheric_Corrosion');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('chem', 'Chemistry', 'geom1');
model.physics('chem').model('comp1');
model.physics.create('tcd', 'TertiaryCurrentDistributionNernstPlanck', 'geom1', {'cNa' 'cCl' 'cH' 'cOH' 'cAl' 'cAlOH' 'cAlOH2' 'cAlOH3' 'cAlCl' 'cAlOHCl'});

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/chem', true);
model.study('std1').feature('cdi').setSolveFor('/physics/tcd', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/chem', true);
model.study('std1').feature('time').setSolveFor('/physics/tcd', true);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').setIndex('coord', '-5[cm]', 0);
model.geom('geom1').feature('i1').setIndex('coord', 0, 1);
model.geom('geom1').feature('i1').setIndex('coord', '5[cm]', 2);
model.geom('geom1').runPre('fin');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('d_film', '50e-6[m]', 'Electrolyte film thickness');
model.param.set('DNa', '1.334e-9[m^2/s]', 'Diffusivity of Na');
model.param.set('DCl', '2.032e-9[m^2/s]', 'Diffusivity of Cl');
model.param.set('DH', '9.311e-9[m^2/s]', 'Diffusivity of H');
model.param.set('DOH', '5.273e-9[m^2/s]', 'Diffusivity of OH');
model.param.set('DAl', '0.541e-9[m^2/s]', 'Diffusivity of Al');
model.param.set('DAlOH', '0.541e-9[m^2/s]', 'Diffusivity of AlOH');
model.param.set('DAlOH2', '0.541e-9[m^2/s]', 'Diffusivity of AlOH2');
model.param.set('DAlOH3', '0.541e-9[m^2/s]', 'Diffusivity of AlOH3');
model.param.set('DAlCl', '0.541e-9[m^2/s]', 'Diffusivity of AlCl');
model.param.set('DAlOHCl', '0.541e-9[m^2/s]', 'Diffusivity of AlOHCl');
model.param.set('c0Na', '600[mol/m^3]', 'Initial concentration of Na');
model.param.set('c0Cl', '600[mol/m^3]', 'Initial concentration of Cl');
model.param.set('c0H', '1e-4[mol/m^3]', 'Initial concentration of H');
model.param.set('c0OH', '1e-4[mol/m^3]', 'Initial concentration of OH');
model.param.set('c0Al', '4.47e-13[mol/m^3]', 'Initial concentration of Al');
model.param.set('c0AlOH', '4.27e-11[mol/m^3]', 'Initial concentration of AlOH');
model.param.set('c0AlOH2', '4.98e-9[mol/m^3]', 'Initial concentration of AlOH2');
model.param.set('c0AlOH3', '9.94e-7[mol/m^3]', 'Initial concentration of AlOH3');
model.param.set('c0AlCl', '6.72e-13[mol/m^3]', 'Initial concentration of AlCl');
model.param.set('c0AlOHCl', '7.12e-11[mol/m^3]', 'Initial concentration of AlOHCl');
model.param.set('zNa', '1', 'Charge number of Na');
model.param.set('zCl', '-1', 'Charge number of Cl');
model.param.set('zH', '1', 'Charge number of H');
model.param.set('zOH', '-1', 'Charge number of OH');
model.param.set('zAl', '3', 'Charge number of Al');
model.param.set('zAlOH', '2', 'Charge number of AlOH');
model.param.set('zAlOH2', '1', 'Charge number of AlOH2');
model.param.set('zAlOH3', '0', 'Charge number of AlOH3');
model.param.set('zAlCl', '2', 'Charge number of AlCl');
model.param.set('zAlOHCl', '1', 'Charge number of AlOHCl');
model.param.set('kfH2O', '1e-8[1/s]', 'Forward rate constant for H2O');
model.param.set('krH2O', '1[m^3/mol/s]', 'Reverse rate constant for H2O');
model.param.set('kfAlOH', '1e3[m^3/mol/s]', 'Forward rate constant for AlOH');
model.param.set('krAlOH', '1.05e-4[1/s]', 'Reverse rate constant for AlOH');
model.param.set('kfAlOH2', '1e3[m^3/mol/s]', 'Forward rate constant for AlOH2');
model.param.set('krAlOH2', '8.58e-4[1/s]', 'Reverse rate constant for AlOH2');
model.param.set('kfAlOH3', '1e3[m^3/mol/s]', 'Forward rate constant for AlOH3');
model.param.set('krAlOH3', '5.02e-4[1/s]', 'Reverse rate constant for AlOH3');
model.param.set('kfAlCl', '2.26e-1[m^3/mol/s]', 'Forward rate constant for AlCl');
model.param.set('krAlCl', '75.27[1/s]', 'Reverse rate constant for AlCl');
model.param.set('kfAlOHCl', '19[m^3/mol/s]', 'Forward rate constant for AlOHCl');
model.param.set('krAlOHCl', '5.7e3[1/s]', 'Reverse rate constant for AlOHCl');
model.param.set('cH2O', '1[mol/m^3]', 'Water reference concentration');

model.geom('geom1').run;

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

model.physics('chem').create('rch1', 'ReactionChem', 1);
model.physics('chem').feature('rch1').set('formula', 'H2O<=>H+OH');
model.physics('chem').feature('rch1').set('kf', 'kfH2O');
model.physics('chem').feature('rch1').set('kr', 'krH2O');
model.physics('chem').create('rch2', 'ReactionChem', 1);
model.physics('chem').feature('rch2').set('formula', 'Al+OH<=>AlOH');
model.physics('chem').feature('rch2').set('kf', 'kfAlOH');
model.physics('chem').feature('rch2').set('kr', 'krAlOH');
model.physics('chem').create('rch3', 'ReactionChem', 1);
model.physics('chem').feature('rch3').set('formula', 'AlOH+OH<=>AlOH2');
model.physics('chem').feature('rch3').set('kf', 'kfAlOH2');
model.physics('chem').feature('rch3').set('kr', 'krAlOH2');
model.physics('chem').create('rch4', 'ReactionChem', 1);
model.physics('chem').feature('rch4').set('formula', 'AlOH2+OH<=>AlOH3');
model.physics('chem').feature('rch4').set('kf', 'kfAlOH3');
model.physics('chem').feature('rch4').set('kr', 'krAlOH3');
model.physics('chem').create('rch5', 'ReactionChem', 1);
model.physics('chem').feature('rch5').set('formula', 'Al+Cl<=>AlCl');
model.physics('chem').feature('rch5').set('kf', 'kfAlCl');
model.physics('chem').feature('rch5').set('kr', 'krAlCl');
model.physics('chem').create('rch6', 'ReactionChem', 1);
model.physics('chem').feature('rch6').set('formula', 'AlOH+Cl<=>AlOHCl');
model.physics('chem').feature('rch6').set('kf', 'kfAlOHCl');
model.physics('chem').feature('rch6').set('kr', 'krAlOHCl');
model.physics('tcd').prop('PhysicsVsMaterialsReferenceElectrodePotential').set('PhysicsVsMaterialsReferenceElectrodePotential', 'SCE');
model.physics('tcd').feature('sp1').setIndex('z', 'zNa', 0);
model.physics('tcd').feature('sp1').setIndex('z', 'zCl', 1);
model.physics('tcd').feature('sp1').setIndex('z', 'zH', 2);
model.physics('tcd').feature('sp1').setIndex('z', 'zOH', 3);
model.physics('tcd').feature('sp1').setIndex('z', 'zAl', 4);
model.physics('tcd').feature('sp1').setIndex('z', 'zAlOH', 5);
model.physics('tcd').feature('sp1').setIndex('z', 'zAlOH2', 6);
model.physics('tcd').feature('sp1').setIndex('z', 'zAlOH3', 7);
model.physics('tcd').feature('sp1').setIndex('z', 'zAlCl', 8);
model.physics('tcd').feature('sp1').setIndex('z', 'zAlOHCl', 9);
model.physics('tcd').feature('init1').setIndex('initc', 'c0Cl', 1);
model.physics('tcd').feature('init1').setIndex('initc', 'c0H', 2);
model.physics('tcd').feature('init1').setIndex('initc', 'c0OH', 3);
model.physics('tcd').feature('init1').setIndex('initc', 'c0Al', 4);
model.physics('tcd').feature('init1').setIndex('initc', 'c0AlOH', 5);
model.physics('tcd').feature('init1').setIndex('initc', 'c0AlOH2', 6);
model.physics('tcd').feature('init1').setIndex('initc', 'c0AlOH3', 7);
model.physics('tcd').feature('init1').setIndex('initc', 'c0AlCl', 8);
model.physics('tcd').feature('init1').setIndex('initc', 'c0AlOHCl', 9);
model.physics('tcd').create('hcpce1', 'HighlyConductivePorousElectrode', 1);
model.physics('tcd').feature('hcpce1').selection.set([1]);
model.physics('tcd').feature('hcpce1').set('D_cNa', {'DNa' '0' '0' '0' 'DNa' '0' '0' '0' 'DNa'});
model.physics('tcd').feature('hcpce1').set('D_cCl', {'DCl' '0' '0' '0' 'DCl' '0' '0' '0' 'DCl'});
model.physics('tcd').feature('hcpce1').set('D_cH', {'DH' '0' '0' '0' 'DH' '0' '0' '0' 'DH'});
model.physics('tcd').feature('hcpce1').set('D_cOH', {'DOH' '0' '0' '0' 'DOH' '0' '0' '0' 'DOH'});
model.physics('tcd').feature('hcpce1').set('D_cAl', {'DAl' '0' '0' '0' 'DAl' '0' '0' '0' 'DAl'});
model.physics('tcd').feature('hcpce1').set('D_cAlOH', {'DAlOH' '0' '0' '0' 'DAlOH' '0' '0' '0' 'DAlOH'});
model.physics('tcd').feature('hcpce1').set('D_cAlOH2', {'DAlOH2' '0' '0' '0' 'DAlOH2' '0' '0' '0' 'DAlOH2'});
model.physics('tcd').feature('hcpce1').set('D_cAlOH3', {'DAlOH3' '0' '0' '0' 'DAlOH3' '0' '0' '0' 'DAlOH3'});
model.physics('tcd').feature('hcpce1').set('D_cAlCl', {'DAlCl' '0' '0' '0' 'DAlCl' '0' '0' '0' 'DAlCl'});
model.physics('tcd').feature('hcpce1').set('D_cAlOHCl', {'DAlOHCl' '0' '0' '0' 'DAlOHCl' '0' '0' '0' 'DAlOHCl'});
model.physics('tcd').feature('hcpce1').set('epsl', 1);
model.physics('tcd').feature('hcpce1').feature('per1').set('nm', 3);
model.physics('tcd').feature('hcpce1').feature('per1').setIndex('Vi0', -1, 4);
model.physics('tcd').feature('hcpce1').feature('per1').set('ilocmat_mat', 'from_mat');
model.physics('tcd').feature('hcpce1').feature('per1').set('Av', '1/d_film');
model.physics('tcd').feature.duplicate('hcpce2', 'hcpce1');
model.physics('tcd').feature('hcpce2').selection.set([2]);
model.physics('tcd').feature('hcpce2').feature('per1').set('nm', 4);
model.physics('tcd').feature('hcpce2').feature('per1').setIndex('Vi0', 4, 3);
model.physics('tcd').feature('hcpce2').feature('per1').setIndex('Vi0', 0, 4);
model.physics('tcd').create('reac1', 'Reactions', 1);
model.physics('tcd').feature('reac1').selection.set([1 2]);
model.physics('tcd').feature('reac1').setIndex('R_cCl_src', 'root.comp1.chem.R_Cl', 0);
model.physics('tcd').feature('reac1').setIndex('R_cH_src', 'root.comp1.chem.R_H', 0);
model.physics('tcd').feature('reac1').setIndex('R_cOH_src', 'root.comp1.chem.R_OH', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAl_src', 'root.comp1.chem.R_Al', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAlOH_src', 'root.comp1.chem.R_AlOH', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAlOH2_src', 'root.comp1.chem.R_AlOH2', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAlOH3_src', 'root.comp1.chem.R_AlOH3', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAlCl_src', 'root.comp1.chem.R_AlCl', 0);
model.physics('tcd').feature('reac1').setIndex('R_cAlOHCl_src', 'root.comp1.chem.R_AlOHCl', 0);

model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.geom('geom1', 1);
model.mesh('mesh1').feature('edg1').selection.set([1 2]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('type', 'predefined');
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemcount', 300);
model.mesh('mesh1').feature('edg1').feature('dis1').set('elemratio', 10);
model.mesh('mesh1').feature('edg1').feature('dis1').set('reverse', true);
model.mesh('mesh1').feature('edg1').feature.duplicate('dis2', 'dis1');
model.mesh('mesh1').feature('edg1').feature('dis2').selection.set([2]);
model.mesh('mesh1').feature('edg1').feature('dis2').set('reverse', false);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', '0 60 range(600,600,3600)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (tcd)');
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
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', '0 60 range(600,600,3600)');
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
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (tcd)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').create('i2', 'Iterative');
model.sol('sol1').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (tcd)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').label('Electrolyte Potential (tcd)');
model.result('pg1').create('lngr1', 'LineGraph');
model.result('pg1').feature('lngr1').set('xdata', 'expr');
model.result('pg1').feature('lngr1').set('xdataexpr', 'x');
model.result('pg1').feature('lngr1').selection.geom('geom1', 1);
model.result('pg1').feature('lngr1').selection.set([1 2]);
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
model.result('pg2').feature('lngr1').selection.set([1 2]);
model.result('pg2').feature('lngr1').set('expr', {'cNa'});
model.result('pg2').feature('lngr1').label('Species Na');
model.result('pg2').feature('lngr1').set('legend', true);
model.result('pg2').feature('lngr1').set('autosolution', false);
model.result('pg2').feature('lngr1').set('autoexpr', false);
model.result('pg2').feature('lngr1').set('autodescr', false);
model.result('pg2').feature('lngr1').set('legendprefix', 'Na ');
model.result('pg2').create('lngr2', 'LineGraph');
model.result('pg2').feature('lngr2').set('xdata', 'expr');
model.result('pg2').feature('lngr2').set('xdataexpr', 'x');
model.result('pg2').feature('lngr2').selection.geom('geom1', 1);
model.result('pg2').feature('lngr2').selection.set([1 2]);
model.result('pg2').feature('lngr2').set('expr', {'cCl'});
model.result('pg2').feature('lngr2').label('Species Cl');
model.result('pg2').feature('lngr2').set('legend', true);
model.result('pg2').feature('lngr2').set('autosolution', false);
model.result('pg2').feature('lngr2').set('autoexpr', false);
model.result('pg2').feature('lngr2').set('autodescr', false);
model.result('pg2').feature('lngr2').set('legendprefix', 'Cl ');
model.result('pg2').create('lngr3', 'LineGraph');
model.result('pg2').feature('lngr3').set('xdata', 'expr');
model.result('pg2').feature('lngr3').set('xdataexpr', 'x');
model.result('pg2').feature('lngr3').selection.geom('geom1', 1);
model.result('pg2').feature('lngr3').selection.set([1 2]);
model.result('pg2').feature('lngr3').set('expr', {'cH'});
model.result('pg2').feature('lngr3').label('Species H');
model.result('pg2').feature('lngr3').set('legend', true);
model.result('pg2').feature('lngr3').set('autosolution', false);
model.result('pg2').feature('lngr3').set('autoexpr', false);
model.result('pg2').feature('lngr3').set('autodescr', false);
model.result('pg2').feature('lngr3').set('legendprefix', 'H ');
model.result('pg2').create('lngr4', 'LineGraph');
model.result('pg2').feature('lngr4').set('xdata', 'expr');
model.result('pg2').feature('lngr4').set('xdataexpr', 'x');
model.result('pg2').feature('lngr4').selection.geom('geom1', 1);
model.result('pg2').feature('lngr4').selection.set([1 2]);
model.result('pg2').feature('lngr4').set('expr', {'cOH'});
model.result('pg2').feature('lngr4').label('Species OH');
model.result('pg2').feature('lngr4').set('legend', true);
model.result('pg2').feature('lngr4').set('autosolution', false);
model.result('pg2').feature('lngr4').set('autoexpr', false);
model.result('pg2').feature('lngr4').set('autodescr', false);
model.result('pg2').feature('lngr4').set('legendprefix', 'OH ');
model.result('pg2').create('lngr5', 'LineGraph');
model.result('pg2').feature('lngr5').set('xdata', 'expr');
model.result('pg2').feature('lngr5').set('xdataexpr', 'x');
model.result('pg2').feature('lngr5').selection.geom('geom1', 1);
model.result('pg2').feature('lngr5').selection.set([1 2]);
model.result('pg2').feature('lngr5').set('expr', {'cAl'});
model.result('pg2').feature('lngr5').label('Species Al');
model.result('pg2').feature('lngr5').set('legend', true);
model.result('pg2').feature('lngr5').set('autosolution', false);
model.result('pg2').feature('lngr5').set('autoexpr', false);
model.result('pg2').feature('lngr5').set('autodescr', false);
model.result('pg2').feature('lngr5').set('legendprefix', 'Al ');
model.result('pg2').create('lngr6', 'LineGraph');
model.result('pg2').feature('lngr6').set('xdata', 'expr');
model.result('pg2').feature('lngr6').set('xdataexpr', 'x');
model.result('pg2').feature('lngr6').selection.geom('geom1', 1);
model.result('pg2').feature('lngr6').selection.set([1 2]);
model.result('pg2').feature('lngr6').set('expr', {'cAlOH'});
model.result('pg2').feature('lngr6').label('Species AlOH');
model.result('pg2').feature('lngr6').set('legend', true);
model.result('pg2').feature('lngr6').set('autosolution', false);
model.result('pg2').feature('lngr6').set('autoexpr', false);
model.result('pg2').feature('lngr6').set('autodescr', false);
model.result('pg2').feature('lngr6').set('legendprefix', 'AlOH ');
model.result('pg2').create('lngr7', 'LineGraph');
model.result('pg2').feature('lngr7').set('xdata', 'expr');
model.result('pg2').feature('lngr7').set('xdataexpr', 'x');
model.result('pg2').feature('lngr7').selection.geom('geom1', 1);
model.result('pg2').feature('lngr7').selection.set([1 2]);
model.result('pg2').feature('lngr7').set('expr', {'cAlOH2'});
model.result('pg2').feature('lngr7').label('Species AlOH2');
model.result('pg2').feature('lngr7').set('legend', true);
model.result('pg2').feature('lngr7').set('autosolution', false);
model.result('pg2').feature('lngr7').set('autoexpr', false);
model.result('pg2').feature('lngr7').set('autodescr', false);
model.result('pg2').feature('lngr7').set('legendprefix', 'AlOH2 ');
model.result('pg2').create('lngr8', 'LineGraph');
model.result('pg2').feature('lngr8').set('xdata', 'expr');
model.result('pg2').feature('lngr8').set('xdataexpr', 'x');
model.result('pg2').feature('lngr8').selection.geom('geom1', 1);
model.result('pg2').feature('lngr8').selection.set([1 2]);
model.result('pg2').feature('lngr8').set('expr', {'cAlOH3'});
model.result('pg2').feature('lngr8').label('Species AlOH3');
model.result('pg2').feature('lngr8').set('legend', true);
model.result('pg2').feature('lngr8').set('autosolution', false);
model.result('pg2').feature('lngr8').set('autoexpr', false);
model.result('pg2').feature('lngr8').set('autodescr', false);
model.result('pg2').feature('lngr8').set('legendprefix', 'AlOH3 ');
model.result('pg2').create('lngr9', 'LineGraph');
model.result('pg2').feature('lngr9').set('xdata', 'expr');
model.result('pg2').feature('lngr9').set('xdataexpr', 'x');
model.result('pg2').feature('lngr9').selection.geom('geom1', 1);
model.result('pg2').feature('lngr9').selection.set([1 2]);
model.result('pg2').feature('lngr9').set('expr', {'cAlCl'});
model.result('pg2').feature('lngr9').label('Species AlCl');
model.result('pg2').feature('lngr9').set('legend', true);
model.result('pg2').feature('lngr9').set('autosolution', false);
model.result('pg2').feature('lngr9').set('autoexpr', false);
model.result('pg2').feature('lngr9').set('autodescr', false);
model.result('pg2').feature('lngr9').set('legendprefix', 'AlCl ');
model.result('pg2').create('lngr10', 'LineGraph');
model.result('pg2').feature('lngr10').set('xdata', 'expr');
model.result('pg2').feature('lngr10').set('xdataexpr', 'x');
model.result('pg2').feature('lngr10').selection.geom('geom1', 1);
model.result('pg2').feature('lngr10').selection.set([1 2]);
model.result('pg2').feature('lngr10').set('expr', {'cAlOHCl'});
model.result('pg2').feature('lngr10').label('Species AlOHCl');
model.result('pg2').feature('lngr10').set('legend', true);
model.result('pg2').feature('lngr10').set('autosolution', false);
model.result('pg2').feature('lngr10').set('autoexpr', false);
model.result('pg2').feature('lngr10').set('autodescr', false);
model.result('pg2').feature('lngr10').set('legendprefix', 'AlOHCl ');
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Concentration, Na (tcd)');
model.result('pg3').set('titletype', 'custom');
model.result('pg3').set('prefixintitle', 'Species Na:');
model.result('pg3').set('expressionintitle', false);
model.result('pg3').set('typeintitle', false);
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2]);
model.result('pg3').feature('lngr1').set('expr', {'cNa'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').label('Concentration, Cl (tcd)');
model.result('pg4').set('titletype', 'custom');
model.result('pg4').set('prefixintitle', 'Species Cl:');
model.result('pg4').set('expressionintitle', false);
model.result('pg4').set('typeintitle', false);
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1 2]);
model.result('pg4').feature('lngr1').set('expr', {'cCl'});
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').label('Concentration, H (tcd)');
model.result('pg5').set('titletype', 'custom');
model.result('pg5').set('prefixintitle', 'Species H:');
model.result('pg5').set('expressionintitle', false);
model.result('pg5').set('typeintitle', false);
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('xdata', 'expr');
model.result('pg5').feature('lngr1').set('xdataexpr', 'x');
model.result('pg5').feature('lngr1').selection.geom('geom1', 1);
model.result('pg5').feature('lngr1').selection.set([1 2]);
model.result('pg5').feature('lngr1').set('expr', {'cH'});
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset1');
model.result('pg6').label('Concentration, OH (tcd)');
model.result('pg6').set('titletype', 'custom');
model.result('pg6').set('prefixintitle', 'Species OH:');
model.result('pg6').set('expressionintitle', false);
model.result('pg6').set('typeintitle', false);
model.result('pg6').create('lngr1', 'LineGraph');
model.result('pg6').feature('lngr1').set('xdata', 'expr');
model.result('pg6').feature('lngr1').set('xdataexpr', 'x');
model.result('pg6').feature('lngr1').selection.geom('geom1', 1);
model.result('pg6').feature('lngr1').selection.set([1 2]);
model.result('pg6').feature('lngr1').set('expr', {'cOH'});
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').set('data', 'dset1');
model.result('pg7').label('Concentration, Al (tcd)');
model.result('pg7').set('titletype', 'custom');
model.result('pg7').set('prefixintitle', 'Species Al:');
model.result('pg7').set('expressionintitle', false);
model.result('pg7').set('typeintitle', false);
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'x');
model.result('pg7').feature('lngr1').selection.geom('geom1', 1);
model.result('pg7').feature('lngr1').selection.set([1 2]);
model.result('pg7').feature('lngr1').set('expr', {'cAl'});
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset1');
model.result('pg8').label('Concentration, AlOH (tcd)');
model.result('pg8').set('titletype', 'custom');
model.result('pg8').set('prefixintitle', 'Species AlOH:');
model.result('pg8').set('expressionintitle', false);
model.result('pg8').set('typeintitle', false);
model.result('pg8').create('lngr1', 'LineGraph');
model.result('pg8').feature('lngr1').set('xdata', 'expr');
model.result('pg8').feature('lngr1').set('xdataexpr', 'x');
model.result('pg8').feature('lngr1').selection.geom('geom1', 1);
model.result('pg8').feature('lngr1').selection.set([1 2]);
model.result('pg8').feature('lngr1').set('expr', {'cAlOH'});
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').set('data', 'dset1');
model.result('pg9').label('Concentration, AlOH2 (tcd)');
model.result('pg9').set('titletype', 'custom');
model.result('pg9').set('prefixintitle', 'Species AlOH2:');
model.result('pg9').set('expressionintitle', false);
model.result('pg9').set('typeintitle', false);
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'x');
model.result('pg9').feature('lngr1').selection.geom('geom1', 1);
model.result('pg9').feature('lngr1').selection.set([1 2]);
model.result('pg9').feature('lngr1').set('expr', {'cAlOH2'});
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').set('data', 'dset1');
model.result('pg10').label('Concentration, AlOH3 (tcd)');
model.result('pg10').set('titletype', 'custom');
model.result('pg10').set('prefixintitle', 'Species AlOH3:');
model.result('pg10').set('expressionintitle', false);
model.result('pg10').set('typeintitle', false);
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('xdata', 'expr');
model.result('pg10').feature('lngr1').set('xdataexpr', 'x');
model.result('pg10').feature('lngr1').selection.geom('geom1', 1);
model.result('pg10').feature('lngr1').selection.set([1 2]);
model.result('pg10').feature('lngr1').set('expr', {'cAlOH3'});
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').set('data', 'dset1');
model.result('pg11').label('Concentration, AlCl (tcd)');
model.result('pg11').set('titletype', 'custom');
model.result('pg11').set('prefixintitle', 'Species AlCl:');
model.result('pg11').set('expressionintitle', false);
model.result('pg11').set('typeintitle', false);
model.result('pg11').create('lngr1', 'LineGraph');
model.result('pg11').feature('lngr1').set('xdata', 'expr');
model.result('pg11').feature('lngr1').set('xdataexpr', 'x');
model.result('pg11').feature('lngr1').selection.geom('geom1', 1);
model.result('pg11').feature('lngr1').selection.set([1 2]);
model.result('pg11').feature('lngr1').set('expr', {'cAlCl'});
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').set('data', 'dset1');
model.result('pg12').label('Concentration, AlOHCl (tcd)');
model.result('pg12').set('titletype', 'custom');
model.result('pg12').set('prefixintitle', 'Species AlOHCl:');
model.result('pg12').set('expressionintitle', false);
model.result('pg12').set('typeintitle', false);
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').feature('lngr1').set('xdata', 'expr');
model.result('pg12').feature('lngr1').set('xdataexpr', 'x');
model.result('pg12').feature('lngr1').selection.geom('geom1', 1);
model.result('pg12').feature('lngr1').selection.set([1 2]);
model.result('pg12').feature('lngr1').set('expr', {'cAlOHCl'});
model.result('pg1').run;
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').feature('lngr1').set('legend', true);
model.result('pg6').run;
model.result('pg7').run;
model.result('pg7').run;
model.result('pg7').feature('lngr1').set('legend', true);
model.result('pg7').run;
model.result('pg10').run;
model.result('pg10').run;
model.result('pg10').feature('lngr1').set('legend', true);
model.result('pg11').run;
model.result('pg11').run;
model.result('pg11').feature('lngr1').set('legend', true);
model.result('pg11').run;

model.title('Atmospheric Corrosion with Mass Transport');

model.description(['This example simulates atmospheric corrosion of a galvanic couple, comprising of an aluminum alloy and steel, which is in contact with electrolyte film of 50' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'micrometer thickness. The model presented here accounts for charge transport as well mass transport involving 10' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'species and 6' native2unicode(hex2dec({'00' 'a0'}), 'unicode') 'homogeneous reactions. The model computes the transient and spatial distribution of species in the film, including the corrosion products.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('atmospheric_corrosion_mass_transport.mph');

model.modelNode.label('Components');

out = model;
