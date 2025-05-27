function out = model
%
% pb_acid_battery_1d.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Battery_Design_Module/Batteries,_General');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 1);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('leadbat', 'LeadAcidBattery', 'geom1');
model.physics('leadbat').model('comp1');

model.study.create('std1');
model.study('std1').create('cdi', 'CurrentDistributionInitialization');
model.study('std1').feature('cdi').set('solnum', 'auto');
model.study('std1').feature('cdi').set('notsolnum', 'auto');
model.study('std1').feature('cdi').set('outputmap', {});
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').set('ngenAUX', '1');
model.study('std1').feature('cdi').set('goalngenAUX', '1');
model.study('std1').feature('cdi').setSolveFor('/physics/leadbat', true);
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('initialtime', '0');
model.study('std1').feature('time').set('solnum', 'auto');
model.study('std1').feature('time').set('notsolnum', 'auto');
model.study('std1').feature('time').set('outputmap', {});
model.study('std1').feature('time').setSolveFor('/physics/leadbat', true);

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('L_sep', '0.006[cm]', 'Separator thickness');
model.param.set('L_pos', '0.07[cm]', 'Positive electrode thickness');
model.param.set('L_res', '0.176[cm]', 'Reservoir thickness');
model.param.set('L_neg', '0.075[cm]', 'Negative electrode thickness');
model.param.set('T', '298[K]', 'Cell temperature');
model.param.set('sigma_pos', '80[S/cm]', 'Electronic conductivity of PbO2');
model.param.set('sigma_neg', '4.8e4[S/cm]', 'Electronic conductivity of Pb');
model.param.set('cl_ref', '4.89[mol/l]', 'Reference electrolyte concentration');
model.param.set('cl_init', 'cl_ref', 'Initial electrolyte concentration');
model.param.set('ex', '1.5', 'Exponent for efficient liquid phase transport parameters');
model.param.set('exm', '0.5', 'Exponent for efficient electric conductivity');
model.param.set('ex_sep', '3.53', 'Exponent on porosity in separator');
model.param.set('eps_sep', '0.73', 'Separator solution-phase volume fraction');
model.param.set('eps_pos_max', '0.53', 'Fully charged porosity, positive electrode');
model.param.set('eps_pos_min', '0.3466', 'Zero charge porosity, positive electrode');
model.param.set('eps_neg_max', '0.53', 'Fully charged porosity, negative electrode');
model.param.set('eps_neg_min', '0.3066', 'Zero charge porosity, positive electrode');
model.param.set('eps_pos_init', 'eps_pos_max-0.01', 'Initial porosity, positive electrode');
model.param.set('eps_neg_init', 'eps_neg_max-0.01', 'Initial porosity, negative electrode');
model.param.set('a_max_pos', '2.3e5[cm^2/cm^3]', 'Maximum surface area, positive electrode');
model.param.set('a_max_neg', '2.3e4[cm^2/cm^3]', 'Maximum surface area, negative electrode');
model.param.set('morph_pos', '2', 'Morphology parameter on kinetics, positive electrode');
model.param.set('morph_neg', '2', 'Morphology parameter on kinetics, negative electrode');
model.param.set('i0_ref_pos', '3e-7[A/cm^2]', 'Exchange current density, positive electrode');
model.param.set('i0_ref_neg', '3e-6[A/cm^2]', 'Exchange current density, negative electrode');
model.param.set('alpha_a_pos', '1.21', 'Anodic charge transfer coefficient, positive electrode');
model.param.set('alpha_a_neg', '1.55', 'Anodic charge transfer coefficient, negative electrode');
model.param.set('alpha_c_pos', '0.79', 'Cathodic charge transfer coefficient, positive electrode');
model.param.set('alpha_c_neg', '0.45', 'Cathodic charge transfer coefficient, negative electrode');
model.param.set('gamma_pos', '0', 'Charge transfer reaction concentration exponent, positive electrode');
model.param.set('gamma_neg', '0', 'Charge transfer reaction concentration, negative electrode');
model.param.set('i0_O2', '1e-27[A/cm^2]', 'Exchange current density (O2)');
model.param.set('alpha_O2', '2', 'Transfer coefficient (O2)');
model.param.set('i0_H2', '1e-13[A/cm^2]', 'Exchange current density (H2)');
model.param.set('alpha_H2', '0.5', 'Transfer coefficient (H2)');
model.param.set('C_dl_pos', '2e-5[F/cm^2]', 'Double layer capacity, positive electrode');
model.param.set('C_dl_neg', '2e-5[F/cm^2]', 'Double layer capacity, negative electrode');
model.param.set('A_cell', '14*14.4*11.25[cm^2]', 'Total cell area');
model.param.set('I_C1', '60[A]/A_cell', 'C1-current density');
model.param.set('I_disch', '-I_C1*C_factor', 'Applied discharge current');
model.param.set('C_factor', '1/20', 'Current multiplicative factor');

model.func.create('step1', 'Step');
model.func('step1').set('location', '20*3600');
model.func('step1').set('from', 1);
model.func('step1').set('to', 0);

model.geom('geom1').create('i1', 'Interval');
model.geom('geom1').feature('i1').set('specify', 'len');
model.geom('geom1').feature('i1').setIndex('len', 'L_pos', 0);
model.geom('geom1').feature('i1').setIndex('len', 'L_res', 1);
model.geom('geom1').feature('i1').setIndex('len', 'L_sep', 2);
model.geom('geom1').feature('i1').setIndex('len', 'L_neg', 3);
model.geom('geom1').runPre('fin');

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ElectrolyteConductivity', 'Electrolyte conductivity');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func.create('int1', 'Interpolation');
model.material('mat1').label('Sulfuric Acid (Lead-Acid Battery)');
model.material('mat1').propertyGroup('def').func('int1').set('funcname', 'Dl_int1');
model.material('mat1').propertyGroup('def').func('int1').set('table', {'100' '1.776E-09';  ...
'200' '1.802E-09';  ...
'300' '1.828E-09';  ...
'400' '1.854E-09';  ...
'500' '1.88E-09';  ...
'600' '1.906E-09';  ...
'700' '1.932E-09';  ...
'800' '1.958E-09';  ...
'900' '1.984E-09';  ...
'1000' '2.01E-09';  ...
'1100' '2.036E-09';  ...
'1200' '2.062E-09';  ...
'1300' '2.088E-09';  ...
'1400' '2.114E-09';  ...
'1500' '2.14E-09';  ...
'1600' '2.166E-09';  ...
'1700' '2.192E-09';  ...
'1800' '2.218E-09';  ...
'1900' '2.244E-09';  ...
'2000' '2.27E-09';  ...
'2100' '2.296E-09';  ...
'2200' '2.322E-09';  ...
'2300' '2.348E-09';  ...
'2400' '2.374E-09';  ...
'2500' '2.4E-09';  ...
'2600' '2.426E-09';  ...
'2700' '2.452E-09';  ...
'2800' '2.478E-09';  ...
'2900' '2.504E-09';  ...
'3000' '2.53E-09';  ...
'3100' '2.556E-09';  ...
'3200' '2.582E-09';  ...
'3300' '2.608E-09';  ...
'3400' '2.634E-09';  ...
'3500' '2.66E-09';  ...
'3600' '2.686E-09';  ...
'3700' '2.712E-09';  ...
'3800' '2.738E-09';  ...
'3900' '2.764E-09';  ...
'4000' '2.79E-09';  ...
'4100' '2.816E-09';  ...
'4200' '2.842E-09';  ...
'4300' '2.868E-09';  ...
'4400' '2.894E-09';  ...
'4500' '2.92E-09';  ...
'4600' '2.946E-09';  ...
'4700' '2.972E-09';  ...
'4800' '2.998E-09';  ...
'4900' '3.024E-09';  ...
'5000' '3.05E-09'});
model.material('mat1').propertyGroup('def').func('int1').set('fununit', {'m^2/s'});
model.material('mat1').propertyGroup('def').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('def').set('diffusion', {'Dl_int1(c/1[mol/m^3])' '0' '0' '0' 'Dl_int1(c/1[mol/m^3])' '0' '0' '0' 'Dl_int1(c/1[mol/m^3])'});
model.material('mat1').propertyGroup('def').set('INFO_PREFIX:diffusion', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat1').propertyGroup('def').addInput('concentration');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('funcname', 'sigmal_int1');
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('table', {'0' '1e-6';  ...
'100' '4.995038022';  ...
'200' '9.852242095';  ...
'300' '14.5697732';  ...
'400' '19.14600473';  ...
'500' '23.57952137';  ...
'600' '27.86911759';  ...
'700' '32.01379583';  ...
'800' '36.01276421';  ...
'900' '39.86543396';  ...
'1000' '43.57141651';  ...
'1100' '47.1305202';  ...
'1200' '50.54274671';  ...
'1300' '53.80828718';  ...
'1400' '56.92751803';  ...
'1500' '59.90099656';  ...
'1600' '62.72945619';  ...
'1700' '65.41380154';  ...
'1800' '67.95510329';  ...
'1900' '70.35459273';  ...
'2000' '72.61365628';  ...
'2100' '74.73382964';  ...
'2200' '76.71679195';  ...
'2300' '78.5643597';  ...
'2400' '80.27848055';  ...
'2500' '81.86122705';  ...
'2600' '83.31479024';  ...
'2700' '84.64147319';  ...
'2800' '85.84368446';  ...
'2900' '86.92393156';  ...
'3000' '87.88481433';  ...
'3100' '88.72901834';  ...
'3200' '89.45930825';  ...
'3300' '90.07852126';  ...
'3400' '90.5895605';  ...
'3500' '90.99538856';  ...
'3600' '91.29902097';  ...
'3700' '91.50351989';  ...
'3800' '91.61198773';  ...
'3900' '91.62756098';  ...
'4000' '91.55340409';  ...
'4100' '91.39270353';  ...
'4200' '91.14866186';  ...
'4300' '90.82449208';  ...
'4400' '90.42341203';  ...
'4500' '89.94863895';  ...
'4600' '89.40338429';  ...
'4700' '88.79084855';  ...
'4800' '88.11421643';  ...
'4900' '87.37665209';  ...
'5000' '86.58129459'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('fununit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').func('int1').set('argunit', {''});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('sigmal', {'sigmal_int1(c/1[mol/m^3])' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])' '0' '0' '0' 'sigmal_int1(c/1[mol/m^3])'});
model.material('mat1').propertyGroup('ElectrolyteConductivity').set('INFO_PREFIX:sigmal', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat1').propertyGroup('ElectrolyteConductivity').addInput('concentration');

model.geom('geom1').run;

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat2').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat2').label('Pb (Negative, Lead-Acid Battery)');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'4.8e4[S/cm]' '0' '0' '0' '4.8e4[S/cm]' '0' '0' '0' '4.8e4[S/cm]'});
model.material('mat2').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_Pb_int1');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('table', {'100' '-0.233101328';  ...
'200' '-0.250742068';  ...
'300' '-0.261341495';  ...
'400' '-0.268981573';  ...
'500' '-0.275051951';  ...
'600' '-0.280170578';  ...
'700' '-0.284659863';  ...
'800' '-0.288706846';  ...
'900' '-0.292428595';  ...
'1000' '-0.295902708';  ...
'1100' '-0.29918299';  ...
'1200' '-0.302308128';  ...
'1300' '-0.305306792';  ...
'1400' '-0.308200773';  ...
'1500' '-0.311007';  ...
'1600' '-0.313738876';  ...
'1700' '-0.31640719';  ...
'1800' '-0.319020755';  ...
'1900' '-0.321586867';  ...
'2000' '-0.324111638';  ...
'2100' '-0.326600246';  ...
'2200' '-0.329057119';  ...
'2300' '-0.331486078';  ...
'2400' '-0.33389045';  ...
'2500' '-0.336273153';  ...
'2600' '-0.338636768';  ...
'2700' '-0.340983588';  ...
'2800' '-0.343315667';  ...
'2900' '-0.345634854';  ...
'3000' '-0.347942826';  ...
'3100' '-0.350241107';  ...
'3200' '-0.35253109';  ...
'3300' '-0.35481406';  ...
'3400' '-0.357091197';  ...
'3500' '-0.3593636';  ...
'3600' '-0.361632287';  ...
'3700' '-0.363898211';  ...
'3800' '-0.366162264';  ...
'3900' '-0.368425284';  ...
'4000' '-0.370688063';  ...
'4100' '-0.372951346';  ...
'4200' '-0.375215843';  ...
'4300' '-0.377482226';  ...
'4400' '-0.379751136';  ...
'4500' '-0.382023185';  ...
'4600' '-0.384298958';  ...
'4700' '-0.386579016';  ...
'4800' '-0.388863897';  ...
'4900' '-0.391154119';  ...
'5000' '-0.393450181'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat2').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat2').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_Pb_int1(c/1[mol/m^3])');
model.material('mat2').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat2').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat2').propertyGroup('ElectrodePotential').set('cEeqref', '1[mol/m^3]');
model.material('mat2').propertyGroup('ElectrodePotential').addInput('concentration');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('ElectrodePotential', 'Equilibrium potential');
model.material('mat3').propertyGroup('ElectrodePotential').func.create('int1', 'Interpolation');
model.material('mat3').label('PbO2 (Positive, Lead-Acid Battery)');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'80[S/cm]' '0' '0' '0' '80[S/cm]' '0' '0' '0' '80[S/cm]'});
model.material('mat3').propertyGroup('def').set('INFO_PREFIX:electricconductivity', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('funcname', 'Eeq_PbO2_int1');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('table', {'100' '1.565887432';  ...
'200' '1.583369855';  ...
'300' '1.594408052';  ...
'400' '1.602318438';  ...
'500' '1.608527137';  ...
'600' '1.613708714';  ...
'700' '1.618222856';  ...
'800' '1.622279294';  ...
'900' '1.626008821';  ...
'1000' '1.629497354';  ...
'1100' '1.63280373';  ...
'1200' '1.635969633';  ...
'1300' '1.639025446';  ...
'1400' '1.64199386';  ...
'1500' '1.64489218';  ...
'1600' '1.647733852';  ...
'1700' '1.650529494';  ...
'1800' '1.653287616';  ...
'1900' '1.656015136';  ...
'2000' '1.658717741';  ...
'2100' '1.661400167';  ...
'2200' '1.664066396';  ...
'2300' '1.666719813';  ...
'2400' '1.669363322';  ...
'2500' '1.671999436';  ...
'2600' '1.674630352';  ...
'2700' '1.677258004';  ...
'2800' '1.679884107';  ...
'2900' '1.682510196';  ...
'3000' '1.685137654';  ...
'3100' '1.687767735';  ...
'3200' '1.690401583';  ...
'3300' '1.693040252';  ...
'3400' '1.695684711';  ...
'3500' '1.698335865';  ...
'3600' '1.700994557';  ...
'3700' '1.703661578';  ...
'3800' '1.706337676';  ...
'3900' '1.709023557';  ...
'4000' '1.711719894';  ...
'4100' '1.714427328';  ...
'4200' '1.717146474';  ...
'4300' '1.719877921';  ...
'4400' '1.722622238';  ...
'4500' '1.725379974';  ...
'4600' '1.72815166';  ...
'4700' '1.730937812';  ...
'4800' '1.733738931';  ...
'4900' '1.736555504';  ...
'5000' '1.739388009'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('fununit', {'V'});
model.material('mat3').propertyGroup('ElectrodePotential').func('int1').set('argunit', {''});
model.material('mat3').propertyGroup('ElectrodePotential').set('Eeq', 'Eeq_PbO2_int1(c/1[mol/m^3])');
model.material('mat3').propertyGroup('ElectrodePotential').set('INFO_PREFIX:Eeq', ['M. Cugnet, S. Laruelle, S. Grugeon, B. Sahut, J. Sabatier, J.M. Tarascon, and A. Oustaloup, ' native2unicode(hex2dec({'20' '1c'}), 'unicode') 'A Mathematical Model for the Simulation of New and Aged Automotive Lead-Acid Batteries,' native2unicode(hex2dec({'20' '1d'}), 'unicode') ' J. Electrochemical Soc., vol. 156, pp.A974' native2unicode(hex2dec({'20' '13'}), 'unicode') 'A985, 2009']);
model.material('mat3').propertyGroup('ElectrodePotential').set('dEeqdT', '0[V/K]');
model.material('mat3').propertyGroup('ElectrodePotential').set('cEeqref', '1[mol/m^3]');
model.material('mat3').propertyGroup('ElectrodePotential').addInput('concentration');
model.material('mat2').selection.set([4]);
model.material('mat3').selection.set([1]);

model.physics('leadbat').create('ppe1', 'PositivePorousElectrode', 1);
model.physics('leadbat').feature('ppe1').selection.set([1]);
model.physics('leadbat').feature('ppe1').set('ElectrolyteMaterial', 'mat1');
model.physics('leadbat').feature('ppe1').set('ex', 'ex');
model.physics('leadbat').feature('ppe1').set('epsilon_0', 'eps_pos_min');
model.physics('leadbat').feature('ppe1').set('epsilon_max', 'eps_pos_max');
model.physics('leadbat').feature('ppe1').set('exm', 'exm');
model.physics('leadbat').feature('ppe1').set('EqPotentialHandlingType', 'FirstReaction');
model.physics('leadbat').create('sep1', 'Separator', 1);
model.physics('leadbat').feature('sep1').selection.set([3]);
model.physics('leadbat').feature('sep1').set('epsilon_sep', 'eps_sep');
model.physics('leadbat').feature('sep1').set('ex', 'ex_sep');
model.physics('leadbat').create('npe1', 'NegativePorousElectrode', 1);
model.physics('leadbat').feature('npe1').selection.set([4]);
model.physics('leadbat').feature('npe1').set('ElectrolyteMaterial', 'mat1');
model.physics('leadbat').feature('npe1').set('ex', 'ex');
model.physics('leadbat').feature('npe1').set('epsilon_0', 'eps_neg_min');
model.physics('leadbat').feature('npe1').set('epsilon_max', 'eps_neg_max');
model.physics('leadbat').feature('npe1').set('exm', 'exm');
model.physics('leadbat').feature('npe1').set('EqPotentialHandlingType', 'FirstReaction');
model.physics('leadbat').feature('ppe1').feature('per1').set('ElectrodeKinetics', 'LeadAcidInsertionDischarge');
model.physics('leadbat').feature('ppe1').feature('per1').set('i0_ref', 'i0_ref_pos');
model.physics('leadbat').feature('ppe1').feature('per1').set('alphaa', 'alpha_a_pos');
model.physics('leadbat').feature('ppe1').feature('per1').set('alphac', 'alpha_c_pos');
model.physics('leadbat').feature('ppe1').feature('per1').set('cl_ref', 'cl_ref');
model.physics('leadbat').feature('ppe1').feature('per1').set('gamma', 'gamma_pos');
model.physics('leadbat').feature('ppe1').feature('per1').set('amax', 'a_max_pos');
model.physics('leadbat').feature('ppe1').feature('per1').set('zetad', 'morph_pos');
model.physics('leadbat').feature('ppe1').create('per2', 'PorousElectrodeReaction', 1);
model.physics('leadbat').feature('ppe1').feature('per2').set('Eeq_mat', 'userdef');
model.physics('leadbat').feature('ppe1').feature('per2').set('Eeq', 1.23);
model.physics('leadbat').feature('ppe1').feature('per2').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('leadbat').feature('ppe1').feature('per2').set('i0', 'i0_O2*(cl/cl_ref)^2');
model.physics('leadbat').feature('ppe1').feature('per2').set('alphaa', 'alpha_O2');
model.physics('leadbat').feature('ppe1').feature('per2').set('alphac', 'alpha_O2');
model.physics('leadbat').feature('ppe1').feature('per2').set('Av', 'a_max_pos*(epsilon-eps_pos_min)/(eps_pos_max-eps_pos_min)');
model.physics('leadbat').feature('ppe1').feature('per2').set('vHplus', -2);
model.physics('leadbat').feature('ppe1').feature('per2').set('vHSO4Minus', 0);
model.physics('leadbat').feature('ppe1').feature('per2').set('vH2O', 1);
model.physics('leadbat').feature('ppe1').feature('per2').set('vPbO2', 0);
model.physics('leadbat').feature('ppe1').feature('per2').set('vPbSO4', 0);
model.physics('leadbat').feature('ppe1').feature('per2').set('dEeqdT_mat', 'userdef');
model.physics('leadbat').feature('ppe1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('leadbat').feature('ppe1').feature('pdl1').set('Cdl', 'C_dl_pos');
model.physics('leadbat').feature('ppe1').feature('pdl1').set('av_dl', 'a_max_pos');
model.physics('leadbat').feature('npe1').feature('per1').set('ElectrodeKinetics', 'LeadAcidInsertionDischarge');
model.physics('leadbat').feature('npe1').feature('per1').set('i0_ref', 'i0_ref_neg');
model.physics('leadbat').feature('npe1').feature('per1').set('alphaa', 'alpha_a_neg');
model.physics('leadbat').feature('npe1').feature('per1').set('alphac', 'alpha_c_neg');
model.physics('leadbat').feature('npe1').feature('per1').set('cl_ref', 'cl_ref');
model.physics('leadbat').feature('npe1').feature('per1').set('gamma', 'gamma_neg');
model.physics('leadbat').feature('npe1').feature('per1').set('amax', 'a_max_neg');
model.physics('leadbat').feature('npe1').feature('per1').set('zetad', 'morph_neg');
model.physics('leadbat').feature('npe1').create('per2', 'PorousElectrodeReaction', 1);
model.physics('leadbat').feature('npe1').feature('per2').set('Eeq_mat', 'userdef');
model.physics('leadbat').feature('npe1').feature('per2').set('Eeq', 0);
model.physics('leadbat').feature('npe1').feature('per2').set('ElectrodeKinetics', 'ButlerVolmer');
model.physics('leadbat').feature('npe1').feature('per2').set('i0', 'i0_H2*cl/cl_ref');
model.physics('leadbat').feature('npe1').feature('per2').set('alphaa', 'alpha_H2');
model.physics('leadbat').feature('npe1').feature('per2').set('alphac', 'alpha_H2');
model.physics('leadbat').feature('npe1').feature('per2').set('Av', 'a_max_neg*(epsilon-eps_neg_min)/(eps_neg_max-eps_neg_min)');
model.physics('leadbat').feature('npe1').feature('per2').set('vHplus', -2);
model.physics('leadbat').feature('npe1').feature('per2').set('vHSO4Minus', 0);
model.physics('leadbat').feature('npe1').feature('per2').set('vPb', 0);
model.physics('leadbat').feature('npe1').feature('per2').set('vPbSO4', 0);
model.physics('leadbat').feature('npe1').feature('per2').set('dEeqdT_mat', 'userdef');
model.physics('leadbat').feature('npe1').create('pdl1', 'PorousMatrixDoubleLayerCapacitance', 1);
model.physics('leadbat').feature('npe1').feature('pdl1').set('Cdl', 'C_dl_neg');
model.physics('leadbat').feature('npe1').feature('pdl1').set('av_dl', 'a_max_neg');

model.common('cminpt').set('modified', {'temperature' 'T'});

model.physics('leadbat').create('egnd1', 'ElectricGround', 0);
model.physics('leadbat').feature('egnd1').selection.set([5]);
model.physics('leadbat').create('ecd1', 'ElectrodeNormalCurrentDensity', 0);
model.physics('leadbat').feature('ecd1').selection.set([1]);
model.physics('leadbat').feature('ecd1').set('nis', 'I_disch*step1(t/1[s])');
model.physics('leadbat').create('init2', 'init', 1);
model.physics('leadbat').feature('init2').selection.set([1 2]);
model.physics('leadbat').feature('init2').set('cl', 'cl_init');
model.physics('leadbat').feature('init2').set('epsilon', 'eps_pos_init');
model.physics('leadbat').feature('init1').set('cl', 'cl_init');
model.physics('leadbat').feature('init1').set('epsilon', 'eps_neg_init');

model.study('std1').feature('time').set('tlist', 'range(0,1800,21*3600)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'cdi');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v1').set('control', 'cdi');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').set('stol', 1.0E-4);
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('d1').label('Direct (leadbat)');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('s1').feature('i1').label('Algebraic Multigrid (leadbat)');
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
model.sol('sol1').feature('s1').feature('i2').label('Geometric Multigrid (leadbat)');
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
model.sol('sol1').feature('v2').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol1').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,1800,21*3600)');
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
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('d1').label('Direct (leadbat)');
model.sol('sol1').feature('t1').create('i1', 'Iterative');
model.sol('sol1').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol1').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol1').feature('t1').feature('i1').label('Algebraic Multigrid (leadbat)');
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
model.sol('sol1').feature('t1').feature('i2').label('Geometric Multigrid (leadbat)');
model.sol('sol1').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tout', 'tsteps');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup1D');
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('ptgr1', 'PointGraph');
model.result('pg1').feature('ptgr1').selection.all;
model.result('pg1').feature('ptgr1').set('expr', {'phis'});
model.result('pg1').feature('ptgr1').selection.set([1]);
model.result('pg1').label('Boundary Electrode Potential with Respect to Ground (leadbat)');
model.result('pg1').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').set('data', 'dset1');
model.result('pg2').label('Electrolyte Potential (leadbat)');
model.result('pg2').create('lngr1', 'LineGraph');
model.result('pg2').feature('lngr1').set('xdata', 'expr');
model.result('pg2').feature('lngr1').set('xdataexpr', 'x');
model.result('pg2').feature('lngr1').selection.geom('geom1', 1);
model.result('pg2').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg2').feature('lngr1').set('expr', {'phil'});
model.result.create('pg3', 'PlotGroup1D');
model.result('pg3').set('data', 'dset1');
model.result('pg3').label('Electrode Potential with Respect to Ground (leadbat)');
model.result('pg3').create('lngr1', 'LineGraph');
model.result('pg3').feature('lngr1').set('xdata', 'expr');
model.result('pg3').feature('lngr1').set('xdataexpr', 'x');
model.result('pg3').feature('lngr1').selection.geom('geom1', 1);
model.result('pg3').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg3').feature('lngr1').set('expr', {'phis'});
model.result.create('pg4', 'PlotGroup1D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').create('lngr1', 'LineGraph');
model.result('pg4').feature('lngr1').set('xdata', 'expr');
model.result('pg4').feature('lngr1').set('xdataexpr', 'x');
model.result('pg4').feature('lngr1').selection.geom('geom1', 1);
model.result('pg4').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg4').feature('lngr1').set('expr', {'cl'});
model.result('pg4').label('Electrolyte Salt Concentration (leadbat)');
model.result('pg1').run;
model.result('pg1').label('Cell voltage C/20');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Cell voltage during a C/20 discharge + 1 h relaxation');
model.result('pg1').set('xlabelactive', true);
model.result('pg1').set('xlabel', 'Time (h)');
model.result('pg1').set('ylabelactive', true);
model.result('pg1').set('ylabel', 'Cell Voltage (V)');
model.result('pg1').run;
model.result('pg1').feature('ptgr1').set('xdata', 'expr');
model.result('pg1').feature('ptgr1').set('xdataexpr', 't/3600');
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').label('Electrolyte conc C/20');
model.result('pg4').set('titletype', 'manual');
model.result('pg4').set('title', 'Electrolyte concentration profile during a C/20 discharge + 1 h relaxation period');
model.result('pg4').set('xlabelactive', true);
model.result('pg4').set('xlabel', 'Distance across the lead-acid cell [m]');
model.result('pg4').set('ylabelactive', true);
model.result('pg4').set('ylabel', 'c<sub>l</sub> [mol/m<sup>3</sup>]');
model.result('pg4').run;
model.result('pg4').feature('lngr1').set('data', 'dset1');
model.result('pg4').feature('lngr1').setIndex('looplevelinput', 'interp', 0);
model.result('pg4').feature('lngr1').setIndex('interp', 3600, 0);
model.result('pg4').feature('lngr1').set('legend', true);
model.result('pg4').feature('lngr1').set('legendmethod', 'manual');
model.result('pg4').feature('lngr1').setIndex('legends', '1 h (After 1 h of discharge)', 0);
model.result('pg4').feature.duplicate('lngr2', 'lngr1');
model.result('pg4').run;
model.result('pg4').feature('lngr2').setIndex('interp', '10*3600', 0);
model.result('pg4').feature('lngr2').setIndex('legends', '10 h (After 10 h of discharge)', 0);
model.result('pg4').feature.duplicate('lngr3', 'lngr2');
model.result('pg4').run;
model.result('pg4').feature('lngr3').setIndex('interp', '20*3600', 0);
model.result('pg4').feature('lngr3').setIndex('legends', '20 h (At end of discharge)', 0);
model.result('pg4').feature.duplicate('lngr4', 'lngr3');
model.result('pg4').run;
model.result('pg4').feature('lngr4').setIndex('interp', '21*3600', 0);
model.result('pg4').feature('lngr4').setIndex('legends', '21 h (After 1 h relaxation)', 0);
model.result('pg4').run;
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Electrode SOC during a C/20 discharge');
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('xlabel', 'Distance across the lead-acid cell (m)');
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('ylabel', 'Electrode state of charge');
model.result('pg5').create('lngr1', 'LineGraph');
model.result('pg5').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg5').feature('lngr1').set('linewidth', 'preference');
model.result('pg5').feature('lngr1').set('data', 'dset1');
model.result('pg5').feature('lngr1').setIndex('looplevelinput', 'interp', 0);
model.result('pg5').feature('lngr1').setIndex('interp', 3600, 0);
model.result('pg5').feature('lngr1').selection.all;
model.result('pg5').feature('lngr1').set('expr', 'leadbat.soc');
model.result('pg5').feature('lngr1').set('descr', 'Electrode state of charge');
model.result('pg5').feature('lngr1').set('legend', true);
model.result('pg5').feature('lngr1').set('legendmethod', 'manual');
model.result('pg5').feature('lngr1').setIndex('legends', '1 h', 0);
model.result('pg5').feature.duplicate('lngr2', 'lngr1');
model.result('pg5').run;
model.result('pg5').feature('lngr2').setIndex('interp', '10*3600', 0);
model.result('pg5').feature('lngr2').setIndex('legends', '10 h', 0);
model.result('pg5').feature.duplicate('lngr3', 'lngr2');
model.result('pg5').run;
model.result('pg5').feature('lngr3').setIndex('interp', '20*3600', 0);
model.result('pg5').feature('lngr3').setIndex('legends', '20 h', 0);
model.result('pg5').run;

model.param.set('C_factor', '20');

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 0);
model.cpl('intop1').selection.set([1]);

model.study.create('std2');
model.study('std2').create('cdi', 'CurrentDistributionInitialization');
model.study('std2').feature('cdi').set('solnum', 'auto');
model.study('std2').feature('cdi').set('notsolnum', 'auto');
model.study('std2').feature('cdi').set('outputmap', {});
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').set('ngenAUX', '1');
model.study('std2').feature('cdi').set('goalngenAUX', '1');
model.study('std2').feature('cdi').setSolveFor('/physics/leadbat', true);
model.study('std2').create('time', 'Transient');
model.study('std2').feature('time').set('plotgroup', 'Default');
model.study('std2').feature('time').set('initialtime', '0');
model.study('std2').feature('time').set('solnum', 'auto');
model.study('std2').feature('time').set('notsolnum', 'auto');
model.study('std2').feature('time').set('outputmap', {});
model.study('std2').feature('time').setSolveFor('/physics/leadbat', true);
model.study('std2').feature('time').set('tlist', 'range(0,1,60)');

model.sol.create('sol3');
model.sol('sol3').study('std2');
model.sol('sol3').create('st1', 'StudyStep');
model.sol('sol3').feature('st1').set('study', 'std2');
model.sol('sol3').feature('st1').set('studystep', 'cdi');
model.sol('sol3').create('v1', 'Variables');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v1').set('control', 'cdi');
model.sol('sol3').create('s1', 'Stationary');
model.sol('sol3').feature('s1').set('stol', 1.0E-4);
model.sol('sol3').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol3').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol3').feature('s1').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('d1').label('Direct (leadbat)');
model.sol('sol3').feature('s1').create('i1', 'Iterative');
model.sol('sol3').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i1').label('Algebraic Multigrid (leadbat)');
model.sol('sol3').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').create('i2', 'Iterative');
model.sol('sol3').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('s1').feature('i2').label('Geometric Multigrid (leadbat)');
model.sol('sol3').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('s1').feature('fc1').set('linsolver', 'd1');
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
model.sol('sol3').feature('v2').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol3').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol3').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol3').feature('v2').set('initmethod', 'sol');
model.sol('sol3').feature('v2').set('initsol', 'sol3');
model.sol('sol3').feature('v2').set('initsoluse', 'sol4');
model.sol('sol3').feature('v2').set('notsolmethod', 'sol');
model.sol('sol3').feature('v2').set('notsol', 'sol3');
model.sol('sol3').feature('v2').set('notsoluse', 'sol4');
model.sol('sol3').feature('v2').set('control', 'time');
model.sol('sol3').create('t1', 'Time');
model.sol('sol3').feature('t1').set('tlist', 'range(0,1,60)');
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
model.sol('sol3').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('d1').label('Direct (leadbat)');
model.sol('sol3').feature('t1').create('i1', 'Iterative');
model.sol('sol3').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i1').label('Algebraic Multigrid (leadbat)');
model.sol('sol3').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').create('i2', 'Iterative');
model.sol('sol3').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol3').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol3').feature('t1').feature('i2').label('Geometric Multigrid (leadbat)');
model.sol('sol3').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol3').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol3').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol3').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol3').feature('t1').feature.remove('fcDef');
model.sol('sol3').attach('std2');
model.sol('sol3').feature('t1').create('st1', 'StopCondition');
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', '', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondterminateon', 'true', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondActive', true, 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopconddesc', 'Stop expression 1', 0);
model.sol('sol3').feature('t1').feature('st1').setIndex('stopcondarr', 'comp1.intop1(comp1.phis)<1.5', 0);
model.sol('sol3').feature('t1').feature('st1').set('storestopcondsol', 'stepbefore_stepafter');
model.sol('sol3').feature('t1').feature('st1').set('stopcondwarn', false);
model.sol('sol3').runAll;

model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').set('data', 'dset3');
model.result('pg6').create('ptgr1', 'PointGraph');
model.result('pg6').feature('ptgr1').selection.all;
model.result('pg6').feature('ptgr1').set('expr', {'phis'});
model.result('pg6').feature('ptgr1').selection.set([1]);
model.result('pg6').label('Boundary Electrode Potential with Respect to Ground (leadbat)');
model.result('pg6').feature('ptgr1').set('xdatasolnumtype', 'level1');
model.result.create('pg7', 'PlotGroup1D');
model.result('pg7').set('data', 'dset3');
model.result('pg7').label('Electrolyte Potential (leadbat) 1');
model.result('pg7').create('lngr1', 'LineGraph');
model.result('pg7').feature('lngr1').set('xdata', 'expr');
model.result('pg7').feature('lngr1').set('xdataexpr', 'x');
model.result('pg7').feature('lngr1').selection.geom('geom1', 1);
model.result('pg7').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg7').feature('lngr1').set('expr', {'phil'});
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').set('data', 'dset3');
model.result('pg8').label('Electrode Potential with Respect to Ground (leadbat) 1');
model.result('pg8').create('lngr1', 'LineGraph');
model.result('pg8').feature('lngr1').set('xdata', 'expr');
model.result('pg8').feature('lngr1').set('xdataexpr', 'x');
model.result('pg8').feature('lngr1').selection.geom('geom1', 1);
model.result('pg8').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg8').feature('lngr1').set('expr', {'phis'});
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').set('data', 'dset3');
model.result('pg9').create('lngr1', 'LineGraph');
model.result('pg9').feature('lngr1').set('xdata', 'expr');
model.result('pg9').feature('lngr1').set('xdataexpr', 'x');
model.result('pg9').feature('lngr1').selection.geom('geom1', 1);
model.result('pg9').feature('lngr1').selection.set([1 2 3 4]);
model.result('pg9').feature('lngr1').set('expr', {'cl'});
model.result('pg9').label('Electrolyte Salt Concentration (leadbat)');
model.result('pg6').run;
model.result('pg9').run;
model.result('pg9').label('Electrolyte conc at 20C discharge');
model.result('pg9').set('xlabelactive', true);
model.result('pg9').set('xlabel', 'Distance across the lead-acid cell (m)');
model.result('pg9').set('ylabelactive', true);
model.result('pg9').set('ylabel', 'c<sub>l</sub> (mol/m<sup>3</sup>)');
model.result('pg9').set('titletype', 'label');
model.result('pg9').run;
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').label('SOC 20C');
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('xlabelactive', true);
model.result('pg10').set('xlabel', 'Distance across the lead-acid cell (m)');
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'Electrode state of charge');
model.result('pg10').create('lngr1', 'LineGraph');
model.result('pg10').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg10').feature('lngr1').set('linewidth', 'preference');
model.result('pg10').feature('lngr1').set('data', 'dset3');
model.result('pg10').feature('lngr1').selection.all;
model.result('pg10').feature('lngr1').set('expr', 'leadbat.soc');
model.result('pg10').feature('lngr1').set('descr', 'Electrode state of charge');
model.result('pg10').run;

model.param.set('C_factor', '0');

model.study.create('std3');
model.study('std3').create('cdi', 'CurrentDistributionInitialization');
model.study('std3').feature('cdi').set('solnum', 'auto');
model.study('std3').feature('cdi').set('notsolnum', 'auto');
model.study('std3').feature('cdi').set('outputmap', {});
model.study('std3').feature('cdi').set('ngenAUX', '1');
model.study('std3').feature('cdi').set('goalngenAUX', '1');
model.study('std3').feature('cdi').set('ngenAUX', '1');
model.study('std3').feature('cdi').set('goalngenAUX', '1');
model.study('std3').feature('cdi').setSolveFor('/physics/leadbat', true);
model.study('std3').create('time', 'Transient');
model.study('std3').feature('time').set('plotgroup', 'Default');
model.study('std3').feature('time').set('initialtime', '0');
model.study('std3').feature('time').set('solnum', 'auto');
model.study('std3').feature('time').set('notsolnum', 'auto');
model.study('std3').feature('time').set('outputmap', {});
model.study('std3').feature('time').setSolveFor('/physics/leadbat', true);
model.study('std3').feature('time').set('tlist', '0 range(1,7*24*3600,365*24*3600)');
model.study('std3').setGenPlots(false);

model.sol.create('sol5');
model.sol('sol5').study('std3');
model.sol('sol5').create('st1', 'StudyStep');
model.sol('sol5').feature('st1').set('study', 'std3');
model.sol('sol5').feature('st1').set('studystep', 'cdi');
model.sol('sol5').create('v1', 'Variables');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol5').feature('v1').feature('comp1_phil').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_phis').set('scaleval', '1');
model.sol('sol5').feature('v1').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol5').feature('v1').set('control', 'cdi');
model.sol('sol5').create('s1', 'Stationary');
model.sol('sol5').feature('s1').set('stol', 1.0E-4);
model.sol('sol5').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol5').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol5').feature('s1').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').feature('d1').label('Direct (leadbat)');
model.sol('sol5').feature('s1').create('i1', 'Iterative');
model.sol('sol5').feature('s1').feature('i1').set('maxlinit', 1000);
model.sol('sol5').feature('s1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol5').feature('s1').feature('i1').label('Algebraic Multigrid (leadbat)');
model.sol('sol5').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').create('i2', 'Iterative');
model.sol('sol5').feature('s1').feature('i2').set('maxlinit', 1000);
model.sol('sol5').feature('s1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol5').feature('s1').feature('i2').label('Geometric Multigrid (leadbat)');
model.sol('sol5').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('s1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('s1').feature('fc1').set('maxiter', 50);
model.sol('sol5').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol5').feature('s1').feature.remove('fcDef');
model.sol('sol5').create('su1', 'StoreSolution');
model.sol('sol5').create('st2', 'StudyStep');
model.sol('sol5').feature('st2').set('study', 'std3');
model.sol('sol5').feature('st2').set('studystep', 'time');
model.sol('sol5').create('v2', 'Variables');
model.sol('sol5').feature('v2').feature('comp1_phil').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_epsilon').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_phis').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_cl').set('scalemethod', 'manual');
model.sol('sol5').feature('v2').feature('comp1_phil').set('scaleval', '1');
model.sol('sol5').feature('v2').feature('comp1_epsilon').set('scaleval', '1');
model.sol('sol5').feature('v2').feature('comp1_phis').set('scaleval', '1');
model.sol('sol5').feature('v2').feature('comp1_cl').set('scaleval', '1000');
model.sol('sol5').feature('v2').set('initmethod', 'sol');
model.sol('sol5').feature('v2').set('initsol', 'sol5');
model.sol('sol5').feature('v2').set('initsoluse', 'sol6');
model.sol('sol5').feature('v2').set('notsolmethod', 'sol');
model.sol('sol5').feature('v2').set('notsol', 'sol5');
model.sol('sol5').feature('v2').set('notsoluse', 'sol6');
model.sol('sol5').feature('v2').set('control', 'time');
model.sol('sol5').create('t1', 'Time');
model.sol('sol5').feature('t1').set('tlist', '0 range(1,7*24*3600,365*24*3600)');
model.sol('sol5').feature('t1').set('plot', 'off');
model.sol('sol5').feature('t1').set('plotgroup', 'Default');
model.sol('sol5').feature('t1').set('plotfreq', 'tout');
model.sol('sol5').feature('t1').set('probesel', 'all');
model.sol('sol5').feature('t1').set('probes', {});
model.sol('sol5').feature('t1').set('probefreq', 'tsteps');
model.sol('sol5').feature('t1').set('rtol', 0.001);
model.sol('sol5').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol5').feature('t1').set('eventout', true);
model.sol('sol5').feature('t1').set('reacf', true);
model.sol('sol5').feature('t1').set('storeudot', true);
model.sol('sol5').feature('t1').set('endtimeinterpolation', true);
model.sol('sol5').feature('t1').set('maxorder', 2);
model.sol('sol5').feature('t1').set('initialstepbdfactive', true);
model.sol('sol5').feature('t1').set('initialstepbdf', '(1)[s]');
model.sol('sol5').feature('t1').set('control', 'time');
model.sol('sol5').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol5').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('t1').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('d1').label('Direct (leadbat)');
model.sol('sol5').feature('t1').create('i1', 'Iterative');
model.sol('sol5').feature('t1').feature('i1').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i1').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i1').label('Algebraic Multigrid (leadbat)');
model.sol('sol5').feature('t1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('prefun', 'saamg');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('maxcoarsedof', 50000);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('saamgcompwise', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').set('compactaggregation', true);
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i1').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').create('i2', 'Iterative');
model.sol('sol5').feature('t1').feature('i2').set('maxlinit', 1000);
model.sol('sol5').feature('t1').feature('i2').set('nlinnormuse', 'on');
model.sol('sol5').feature('t1').feature('i2').label('Geometric Multigrid (leadbat)');
model.sol('sol5').feature('t1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('pr').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('po').create('sl1', 'SORLine');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').create('d1', 'Direct');
model.sol('sol5').feature('t1').feature('i2').feature('mg1').feature('cs').feature('d1').set('linsolver', 'pardiso');
model.sol('sol5').feature('t1').feature('fc1').set('linsolver', 'd1');
model.sol('sol5').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol5').feature('t1').feature.remove('fcDef');
model.sol('sol5').attach('std3');
model.sol('sol5').runAll;

model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Cell Voltage Comparison');
model.result('pg11').set('titletype', 'label');
model.result('pg11').set('xlabelactive', true);
model.result('pg11').set('xlabel', 'Time (s)');
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'Cell Voltage (V)');
model.result('pg11').set('xlog', true);
model.result('pg11').set('legendpos', 'lowerright');
model.result('pg11').create('ptgr1', 'PointGraph');
model.result('pg11').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg11').feature('ptgr1').set('linewidth', 'preference');
model.result('pg11').feature('ptgr1').set('data', 'dset1');
model.result('pg11').feature('ptgr1').selection.set([1]);
model.result('pg11').feature('ptgr1').set('expr', 'phis');
model.result('pg11').feature('ptgr1').set('descr', 'Electric potential');
model.result('pg11').feature('ptgr1').set('legend', true);
model.result('pg11').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg11').feature('ptgr1').setIndex('legends', 'C/20 + 1 h relaxation', 0);
model.result('pg11').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg11').run;
model.result('pg11').feature('ptgr2').set('data', 'dset3');
model.result('pg11').feature('ptgr2').setIndex('legends', '20C', 0);
model.result('pg11').feature.duplicate('ptgr3', 'ptgr2');
model.result('pg11').run;
model.result('pg11').feature('ptgr3').set('data', 'dset5');
model.result('pg11').feature('ptgr3').setIndex('legends', 'Self discharge (One year)', 0);
model.result('pg11').run;
model.result.create('pg12', 'PlotGroup1D');
model.result('pg12').run;
model.result('pg12').label('SOC self discharge one year');
model.result('pg12').set('titletype', 'label');
model.result('pg12').set('xlabelactive', true);
model.result('pg12').set('xlabel', 'Distance across the lead-acid cell (m)');
model.result('pg12').set('ylabelactive', true);
model.result('pg12').set('ylabel', 'Electrode state of charge');
model.result('pg12').create('lngr1', 'LineGraph');
model.result('pg12').feature('lngr1').set('markerpos', 'datapoints');
model.result('pg12').feature('lngr1').set('linewidth', 'preference');
model.result('pg12').feature('lngr1').set('data', 'dset5');
model.result('pg12').feature('lngr1').selection.all;
model.result('pg12').feature('lngr1').set('expr', 'leadbat.soc');
model.result('pg12').feature('lngr1').set('descr', 'Electrode state of charge');
model.result('pg12').run;
model.result('pg2').run;
model.result.remove('pg2');
model.result.remove('pg3');
model.result.remove('pg6');
model.result.remove('pg7');
model.result.remove('pg8');
model.result('pg4').run;

model.title(['Discharge and Self-Discharge of a Lead' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Acid Battery']);

model.description(['This example simulates the discharge of a lead' native2unicode(hex2dec({'20' '13'}), 'unicode') 'acid battery. High and low discharge rates are compared, and by using side-reactions in the porous electrodes also the long-term self-discharge behavior is studied.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;
model.sol('sol3').clearSolutionData;
model.sol('sol4').clearSolutionData;
model.sol('sol5').clearSolutionData;
model.sol('sol6').clearSolutionData;

model.label('pb_acid_battery_1d.mph');

model.modelNode.label('Components');

out = model;
