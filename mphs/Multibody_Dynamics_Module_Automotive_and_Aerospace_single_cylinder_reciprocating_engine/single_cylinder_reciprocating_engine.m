function out = model
%
% single_cylinder_reciprocating_engine.m
%
% Model exported on May 26 2025, 21:30 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Multibody_Dynamics_Module/Automotive_and_Aerospace');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbd', 'MultibodyDynamics', 'geom1');
model.physics('mbd').model('comp1');
model.physics.create('hdb', 'HydrodynamicBearing', 'geom1');
model.physics('hdb').model('comp1');

model.study.create('std1');
model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').setSolveFor('/physics/mbd', true);
model.study('std1').feature('time').setSolveFor('/physics/hdb', true);

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'single_cylinder_reciprocating_engine.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.param.set('C', '2e-5[m]');
model.param.descr('C', 'Bearing clearance');
model.param.set('mu0', '0.072[Pa*s]');
model.param.descr('mu0', 'Lubricant viscosity');
model.param.set('t1', '0.025[s]');
model.param.descr('t1', 'Stiffness reduction start');
model.param.set('t2', '0.04[s]');
model.param.descr('t2', 'Stiffness reduction end');
model.param.set('kb', '1e9[N/m]');
model.param.descr('kb', 'Bearing stiffness');
model.param.set('theta0', '240[deg]');
model.param.descr('theta0', 'Initial rotation of crank');

model.nodeGroup.create('grp1', 'Definitions', 'comp1');
model.nodeGroup('grp1').set('type', 'pair');
model.nodeGroup('grp1').add('pair', 'ap1');
model.nodeGroup('grp1').add('pair', 'ap2');
model.nodeGroup('grp1').add('pair', 'ap3');
model.nodeGroup('grp1').add('pair', 'ap5');
model.nodeGroup('grp1').label('Hinge Joint Pairs');

model.pair('ap4').label('Prismatic Joint Pair');
model.pair('ap4').active(false);

model.selection.create('sel1', 'Explicit');
model.selection('sel1').model('comp1');
model.selection('sel1').geom(2);
model.selection('sel1').label('Journal 1');
model.selection('sel1').set([16 17 18 19]);
model.selection.create('sel2', 'Explicit');
model.selection('sel2').model('comp1');
model.selection('sel2').geom(2);
model.selection('sel2').label('Foundation 1');
model.selection('sel2').set([147 148 149 150]);
model.selection.create('sel3', 'Explicit');
model.selection('sel3').model('comp1');
model.selection('sel3').geom(2);
model.selection('sel3').label('Journal 2');
model.selection('sel3').set([60 61 62 63]);
model.selection.create('sel4', 'Explicit');
model.selection('sel4').model('comp1');
model.selection('sel4').geom(2);
model.selection('sel4').label('Foundation 2');
model.selection('sel4').set([269 270 271 272]);
model.selection.create('cyl1', 'Cylinder');
model.selection('cyl1').model('comp1');
model.selection('cyl1').label('Piston top');
model.selection('cyl1').set('entitydim', 2);
model.selection('cyl1').set('r', 0.042);
model.selection('cyl1').set('top', 0.208);
model.selection('cyl1').set('bottom', 0.196);
model.selection('cyl1').set('condition', 'inside');

model.view('view1').hideEntities.create('hide1');
model.view('view1').hideEntities('hide1').geom(3);
model.view('view1').hideEntities('hide1').add([6]);
model.view('view1').hideEntities('hide1').add([8]);
model.view('view1').hideEntities('hide1').add([9]);
model.view('view1').set('hidestatus', 'showonlyhidden');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Journals');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'sel1' 'sel3'});
model.selection.duplicate('uni2', 'uni1');
model.selection('uni2').label('Foundations');
model.selection('uni2').set('input', {'sel2' 'sel4'});
model.selection.duplicate('uni3', 'uni2');
model.selection('uni3').label('Bearing System');
model.selection('uni3').set('input', {'uni1' 'uni2'});
model.selection.create('cyl2', 'Cylinder');
model.selection('cyl2').model('comp1');
model.selection('cyl2').label('Fixed 1');
model.selection('cyl2').set('entitydim', 2);
model.selection('cyl2').set('r', 0.006);
model.selection('cyl2').set('pos', [-0.035 -0.0514 0]);
model.selection('cyl2').set('condition', 'inside');
model.selection.duplicate('cyl3', 'cyl2');
model.selection('cyl3').label('Fixed 2');
model.selection('cyl3').set('pos', [-0.035 0.0514 0]);
model.selection.duplicate('cyl4', 'cyl3');
model.selection('cyl4').label('Fixed 3');
model.selection('cyl4').set('pos', [0.035 0.0514 0]);
model.selection.duplicate('cyl5', 'cyl4');
model.selection('cyl5').label('Fixed 4');
model.selection('cyl5').set('pos', [0.035 -0.0514 0]);
model.selection.create('uni4', 'Union');
model.selection('uni4').model('comp1');
model.selection('uni4').label('Fixed');
model.selection('uni4').set('entitydim', 2);
model.selection('uni4').set('input', {'cyl2' 'cyl3' 'cyl4' 'cyl5'});

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').set('axisym', true);
model.cpl('intop1').selection.geom('geom1', 2);
model.cpl('intop1').selection.named('cyl1');
model.cpl('intop1').set('frame', 'material');
model.cpl('intop1').label('Integration over piston top');

model.func.create('step1', 'Step');
model.func('step1').model('comp1');
model.func('step1').set('location', '3*pi');
model.func('step1').set('smooth', 'pi/18');
model.func('step1').label('Step: Loading Torque Start');
model.func.duplicate('step2', 'step1');
model.func('step2').label('Step: Starting Torque Cutoff');
model.func('step2').set('location', '2*pi');
model.func('step2').set('from', 1);
model.func('step2').set('to', 0);
model.func('step2').set('smooth', 'pi/36');
model.func.create('int1', 'Interpolation');
model.func('int1').model('comp1');
model.func('int1').set('funcname', 'pressure');
model.func('int1').label('Interpolation: pressure');
model.func('int1').set('table', {'0' '0.333341';  ...
'0.062832' '0.333676';  ...
'0.125664' '0.334685';  ...
'0.188496' '0.336374';  ...
'0.251327' '0.338773';  ...
'0.314159' '0.341890';  ...
'0.376991' '0.345720';  ...
'0.439823' '0.350424';  ...
'0.502655' '0.356064';  ...
'0.565487' '0.362558';  ...
'0.628319' '0.369907';  ...
'0.69115' '0.378112';  ...
'0.753982' '0.387171';  ...
'0.816814' '0.397386';  ...
'0.879646' '0.409931';  ...
'0.942478' '0.423785';  ...
'1.00531' '0.438949';  ...
'1.068142' '0.455424';  ...
'1.130973' '0.473208';  ...
'1.193805' '0.493791';  ...
'1.256637' '0.518365';  ...
'1.319469' '0.545340';  ...
'1.382301' '0.574716';  ...
'1.445133' '0.606494';  ...
'1.507964' '0.644267';  ...
'1.570796' '0.688175';  ...
'1.633628' '0.736555';  ...
'1.69646' '0.789407';  ...
'1.759292' '0.852604';  ...
'1.822124' '0.926066';  ...
'1.884956' '1.007690';  ...
'1.947787' '1.102102';  ...
'2.010619' '1.215645';  ...
'2.073451' '1.343468';  ...
'2.136283' '1.495750';  ...
'2.199115' '1.675395';  ...
'2.261947' '1.882994';  ...
'2.324779' '2.135523';  ...
'2.38761' '2.426274';  ...
'2.450442' '2.774202';  ...
'2.513274' '3.174684';  ...
'2.576106' '3.648949';  ...
'2.638938' '4.191032';  ...
'2.70177' '4.809170';  ...
'2.764602' '5.494002';  ...
'2.827433' '6.222693';  ...
'2.890265' '6.958928';  ...
'2.953097' '7.624993';  ...
'3.015929' '8.159523';  ...
'3.078761' '8.602927';  ...
'3.141593' '14.499959';  ...
'3.204425' '20.273087';  ...
'3.267256' '22.978690';  ...
'3.330088' '21.471803';  ...
'3.39292' '19.559541';  ...
'3.455752' '17.533486';  ...
'3.518584' '15.552903';  ...
'3.581416' '13.616194';  ...
'3.644247' '11.891606';  ...
'3.707079' '10.388861';  ...
'3.769911' '9.08177';  ...
'3.832743' '7.961185';  ...
'3.895575' '7.023701';  ...
'3.958407' '6.210162';  ...
'4.021239' '5.530754';  ...
'4.08407' '4.943275';  ...
'4.146902' '4.444838';  ...
'4.209734' '4.014451';  ...
'4.272566' '3.644175';  ...
'4.335398' '3.330475';  ...
'4.39823' '3.052088';  ...
'4.461062' '2.812026';  ...
'4.523893' '2.604513';  ...
'4.586725' '2.421240';  ...
'4.649557' '2.260050';  ...
'4.712389' '2.118594';  ...
'4.775221' '1.995081';  ...
'4.838053' '1.883758';  ...
'4.900885' '1.785708';  ...
'4.963716' '1.700390';  ...
'5.026548' '1.621991';  ...
'5.08938' '1.552126';  ...
'5.152212' '1.490794';  ...
'5.215044' '1.434858';  ...
'5.277876' '1.384069';  ...
'5.340708' '1.339536';  ...
'5.403539' '1.298929';  ...
'5.466371' '1.263264';  ...
'5.529203' '1.231980';  ...
'5.592035' '1.203333';  ...
'5.654867' '1.178288';  ...
'5.717699' '1.156319';  ...
'5.78053' '1.137162';  ...
'5.843362' '1.121068';  ...
'5.906194' '1.107072';  ...
'5.969026' '1.095461';  ...
'6.031858' '1.086239';  ...
'6.09469' '1.079022';  ...
'6.157522' '1.074008';  ...
'6.220353' '1.071081';  ...
'6.283185' '1.070139'});
model.func('int1').setIndex('argunit', 'rad', 0);
model.func('int1').setIndex('fununit', 'bar', 0);

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup('Enu').func.create('int2', 'Interpolation');
model.material('mat1').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat1').propertyGroup.create('ElastoplasticModel', 'Elastoplastic material model');
model.material('mat1').propertyGroup('ElastoplasticModel').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Ludwik', 'Ludwik');
model.material('mat1').propertyGroup('Ludwik').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('JohnsonCook', 'Johnson-Cook');
model.material('mat1').propertyGroup.create('Swift', 'Swift');
model.material('mat1').propertyGroup.create('Voce', 'Voce');
model.material('mat1').propertyGroup('Voce').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('HockettSherby', 'Hockett-Sherby');
model.material('mat1').propertyGroup('HockettSherby').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('ArmstrongFrederick', 'Armstrong-Frederick');
model.material('mat1').propertyGroup('ArmstrongFrederick').func.create('int1', 'Interpolation');
model.material('mat1').propertyGroup.create('Norton', 'Norton');
model.material('mat1').propertyGroup.create('Garofalo', 'Garofalo (hyperbolic sine)');
model.material('mat1').propertyGroup.create('ChabocheViscoplasticity', 'Chaboche viscoplasticity');
model.material('mat1').label('Structural steel');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('customdiffuse', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('customambient', [0.6666666666666666 0.6666666666666666 0.6666666666666666]);
model.material('mat1').set('noise', true);
model.material('mat1').set('fresnel', 0.9);
model.material('mat1').set('roughness', 0.3);
model.material('mat1').set('metallic', 0);
model.material('mat1').set('pearl', 0);
model.material('mat1').set('diffusewrap', 0);
model.material('mat1').set('clearcoat', 0);
model.material('mat1').set('reflectance', 0);
model.material('mat1').propertyGroup('def').set('lossfactor', '0.02');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat1').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat1').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat1').propertyGroup('Enu').func('int1').set('funcname', 'E');
model.material('mat1').propertyGroup('Enu').func('int1').set('table', {'293.15' '200e9'; '793.15' '166.6e9'});
model.material('mat1').propertyGroup('Enu').func('int1').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int1').set('fununit', {'Pa'});
model.material('mat1').propertyGroup('Enu').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').func('int2').set('funcname', 'nu');
model.material('mat1').propertyGroup('Enu').func('int2').set('table', {'293.15' '0.30'; '793.15' '0.315'});
model.material('mat1').propertyGroup('Enu').func('int2').set('extrap', 'linear');
model.material('mat1').propertyGroup('Enu').func('int2').set('fununit', {'1'});
model.material('mat1').propertyGroup('Enu').func('int2').set('argunit', {'K'});
model.material('mat1').propertyGroup('Enu').set('E', 'E(T)');
model.material('mat1').propertyGroup('Enu').set('nu', 'nu(T)');
model.material('mat1').propertyGroup('Enu').addInput('temperature');
model.material('mat1').propertyGroup('Murnaghan').set('l', '-3.0e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('m', '-6.2e11[Pa]');
model.material('mat1').propertyGroup('Murnaghan').set('n', '-7.2e11[Pa]');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ElastoplasticModel').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmags', '350[MPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Et', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('Ek', '1.045[GPa]*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').set('sigmagh', '1.050[GPa]*epe*a(T)');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('temperature');
model.material('mat1').propertyGroup('ElastoplasticModel').addInput('effectiveplasticstrain');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Ludwik').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Ludwik').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Ludwik').set('k_lud', '560[MPa]*a(T)');
model.material('mat1').propertyGroup('Ludwik').set('n_lud', '0.61');
model.material('mat1').propertyGroup('Ludwik').addInput('temperature');
model.material('mat1').propertyGroup('JohnsonCook').set('k_jcook', '560[MPa]');
model.material('mat1').propertyGroup('JohnsonCook').set('n_jcook', '0.61');
model.material('mat1').propertyGroup('JohnsonCook').set('C_jcook', '0.12');
model.material('mat1').propertyGroup('JohnsonCook').set('epet0_jcook', '1[1/s]');
model.material('mat1').propertyGroup('JohnsonCook').set('m_jcook', '0.6');
model.material('mat1').propertyGroup('Swift').set('e0_swi', '0.021');
model.material('mat1').propertyGroup('Swift').set('n_swi', '0.2');
model.material('mat1').propertyGroup('Voce').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('Voce').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('Voce').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('Voce').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('Voce').set('sigma_voc', '249[MPa]*a(T)');
model.material('mat1').propertyGroup('Voce').set('beta_voc', '9.3');
model.material('mat1').propertyGroup('Voce').addInput('temperature');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('HockettSherby').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('HockettSherby').set('sigma_hoc', '684[MPa]*a(T)');
model.material('mat1').propertyGroup('HockettSherby').set('m_hoc', '3.9');
model.material('mat1').propertyGroup('HockettSherby').set('n_hoc', '0.85');
model.material('mat1').propertyGroup('HockettSherby').addInput('temperature');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('funcname', 'a');
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('table', {'600' '1'; '1100' '0.1'; '1643' '0'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('fununit', {'1'});
model.material('mat1').propertyGroup('ArmstrongFrederick').func('int1').set('argunit', {'K'});
model.material('mat1').propertyGroup('ArmstrongFrederick').set('Ck', '2.070[GPa]*a(T)');
model.material('mat1').propertyGroup('ArmstrongFrederick').set('gammak', '8.0');
model.material('mat1').propertyGroup('ArmstrongFrederick').addInput('temperature');
model.material('mat1').propertyGroup('Norton').set('A_nor', '1.2e-15[1/s]');
model.material('mat1').propertyGroup('Norton').set('sigRef_nor', '1[MPa]');
model.material('mat1').propertyGroup('Norton').set('n_nor', '4.5');
model.material('mat1').propertyGroup('Garofalo').set('A_gar', '1e-6[1/s]');
model.material('mat1').propertyGroup('Garofalo').set('sigRef_gar', '100[MPa]');
model.material('mat1').propertyGroup('Garofalo').set('n_gar', '4.6');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('A_cha', '1');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('sigRef_cha', '490[MPa]');
model.material('mat1').propertyGroup('ChabocheViscoplasticity').set('n_cha', '9');

model.physics('mbd').create('rd1', 'RigidDomain', 3);

model.view('view1').set('hidestatus', 'ignore');

model.physics('mbd').feature('rd1').selection.set([2 3 4 5]);
model.physics('mbd').feature('rd1').label('Rigid Material: Cylinder');
model.physics('mbd').feature('rd1').create('fix1', 'FixedConstraint', -1);
model.physics('mbd').create('rd2', 'RigidDomain', 3);
model.physics('mbd').feature('rd2').selection.set([7]);
model.physics('mbd').feature('rd2').label('Rigid Material: Piston');
model.physics('mbd').create('rd3', 'RigidDomain', 3);
model.physics('mbd').feature('rd3').selection.set([8]);
model.physics('mbd').feature('rd3').label('Rigid Material: Connecting Rod');
model.physics('mbd').prop('AutoModeling').set('PlnBnd', 'none');
model.physics('mbd').prop('AutoModeling').set('SprBnd', 'none');
model.physics('mbd').prop('AutoModeling').runCommand('createJoints');
model.physics('mbd').feature('att1').label('Attachment: Journal 1');
model.physics('mbd').feature('att2').label('Attachment: Foundation 1');
model.physics('mbd').feature('hgj1').set('JointElasticity', 'ElasticJoint');
model.physics('mbd').feature('hgj1').feature('je1').set('k_u', {'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)' '0' '0' '0' 'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)' '0' '0' '0' 'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)'});
model.physics('mbd').feature('att3').label('Attachment: Crankpin');
model.physics('mbd').feature('att4').label('Attachment: Journal 2');
model.physics('mbd').feature('att5').label('Attachment: Foundation 2');
model.physics('mbd').feature('hgj3').set('JointElasticity', 'ElasticJoint');
model.physics('mbd').feature('hgj3').feature('je1').set('k_u', {'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)' '0' '0' '0' 'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)' '0' '0' '0' 'kb*(1-(t-t1)/(t2-t1)*(t>t1))*(t<=t2)'});

model.nodeGroup('grp1').active(false);

model.pair('ap4').active(true);

model.physics('mbd').prop('AutoModeling').set('CylBnd', 'PrismaticJoint');
model.physics('mbd').prop('AutoModeling').runCommand('createJoints');
model.physics('mbd').create('fix1', 'Fixed', 2);
model.physics('mbd').feature('fix1').selection.named('uni4');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('theta', 'abs(mbd.hgj1.th)');
model.variable('var1').descr('theta', 'Shaft rotation');
model.variable('var1').set('p', 'pressure(mod(theta+theta0,2*pi))');
model.variable('var1').descr('p', 'Cylinder pressure');
model.variable('var1').set('Ti', '100[N*m]*step2(theta)');
model.variable('var1').descr('Ti', 'Starting torque');
model.variable('var1').set('To', '0.05[N*m*s/rad]*d(theta,t)*step1(theta)');
model.variable('var1').descr('To', 'Output torque');
model.variable('var1').set('A', 'intop1(root.nZ)');
model.variable('var1').descr('A', 'Projected area of piston');
model.variable('var1').set('P', '-p*A*mbd.prj1.u_t/746[W]');
model.variable('var1').descr('P', 'Power generated');
model.variable('var1').set('BHP', 'To*d(theta,t)/746[W]');
model.variable('var1').descr('BHP', 'Brake horse power');

model.physics('mbd').create('bndl1', 'BoundaryLoad', 2);
model.physics('mbd').feature('bndl1').selection.named('cyl1');
model.physics('mbd').feature('bndl1').set('LoadType', 'FollowerPressure');
model.physics('mbd').feature('bndl1').set('FollowerPressure', 'p');
model.physics('mbd').create('rig1', 'RigidConnector', 2);

model.view('view1').set('hidestatus', 'hide');

model.physics('mbd').feature('rig1').selection.set([78]);
model.physics('mbd').feature('rig1').create('rm1', 'RigidBodyMoment', -1);
model.physics('mbd').feature('rig1').feature('rm1').set('Mt', {'Ti' '0' '0'});
model.physics('mbd').feature('rig1').feature.duplicate('rm2', 'rm1');
model.physics('mbd').feature('rig1').feature('rm2').set('Mt', {'-To' '0' '0'});
model.physics('mbd').prop('Results').set('ReferenceFrame', 'att1');
model.physics('hdb').selection.named('uni1');
model.physics('hdb').prop('EquationType').set('EquationType', 'ReynoldsEquationWithCavitation');
model.physics('hdb').feature('hjb1').set('C_plain', 'C');
model.physics('hdb').feature('hjb1').set('BearingCenterType', 'fromGeom');
model.physics('hdb').feature('hjb1').set('mure_mat', 'userdef');
model.physics('hdb').feature('hjb1').set('mure', 'mu0');
model.physics('hdb').feature('hjb1').set('rho_c', '866[kg/m^3]');
model.physics('hdb').feature.duplicate('hjb2', 'hjb1');
model.physics('hdb').feature('hjb2').selection.named('sel3');

model.multiphysics.create('sbco1', 'SolidBearingCoupling', 'geom1', 2);
model.multiphysics('sbco1').selection.named('sel1');
model.multiphysics('sbco1').set('includeFoundation', true);
model.multiphysics('sbco1').selection('Foundation').named('sel2');
model.multiphysics.duplicate('sbco2', 'sbco1');
model.multiphysics('sbco2').selection.named('sel3');
model.multiphysics('sbco2').selection('Foundation').named('sel4');

model.selection.create('sel5', 'Explicit');
model.selection('sel5').model('comp1');
model.selection('sel5').geom(1);
model.selection('sel5').label('Bearing Exterior Edges');
model.selection('sel5').set([33 34 36 38 41 42 44 46 145 146 148 150 153 154 156 158]);
model.selection.create('sel6', 'Explicit');
model.selection('sel6').model('comp1');
model.selection('sel6').geom(1);
model.selection('sel6').set([314 666]);
model.selection('sel6').set('groupcontang', true);
model.selection('sel6').label('Foundation Exterior Edges');
model.selection.create('uni5', 'Union');
model.selection('uni5').model('comp1');
model.selection('uni5').set('entitydim', 1);
model.selection('uni5').set('input', {'sel5' 'sel6'});
model.selection('uni5').label('Bearing System Exterior Edges');

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.named('uni3');
model.mesh('mesh1').feature('map1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis1').selection.set([39 151]);

model.view('view1').set('hidestatus', 'showonlyhidden');

model.mesh('mesh1').feature('map1').feature('dis1').selection.set([39 151 321 631]);
model.mesh('mesh1').feature('map1').feature('dis1').set('numelem', 10);
model.mesh('mesh1').feature('map1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('map1').feature('dis2').selection.named('uni5');
model.mesh('mesh1').feature('map1').feature('dis2').set('numelem', 12);
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);

model.view('view1').set('hidestatus', 'hide');

model.mesh('mesh1').feature('swe1').selection.set([2 3 4 5]);
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').selection.set([8]);
model.mesh('mesh1').feature('size').set('hauto', 3);
model.mesh('mesh1').run;

model.study('std1').feature('time').set('tlist', 'range(0,5e-5,0.12)');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'time');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_sbco2_thr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_betar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_thb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappazr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_ubc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappazb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_betab').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_urc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_thb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_betab').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_thr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappazb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappayr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_urc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_betar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappayr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_ubc').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_alphar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappayb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_alphar').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappayb').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco1_alphab').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_alphab').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappazr').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_disp').set('resscalemethod', 'parent');
model.sol('sol1').feature('v1').feature('comp1_sbco2_thr').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_sbco1_betar').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco1_thb').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappazr').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_ubc').set('scaleval', '1e-5*0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappazb').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_disp').set('scaleval', '0.003991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_betab').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco1_urc').set('scaleval', '1e-5*0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_thb').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_pfilm').set('scaleval', '1000000');
model.sol('sol1').feature('v1').feature('comp1_sbco1_betab').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_disp').set('scaleval', '0.003991691370835177');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_sbco1_thr').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_att_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappazb').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappayr').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_urc').set('scaleval', '1e-5*0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_betar').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappayr').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco1_ubc').set('scaleval', '1e-5*0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco1_alphar').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco1_kappayb').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_alphar').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappayb').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco1_alphab').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_mbd_jnt_disp').set('scaleval', '0.003991691370835177');
model.sol('sol1').feature('v1').feature('comp1_sbco2_alphab').set('scaleval', '1e-4');
model.sol('sol1').feature('v1').feature('comp1_sbco2_kappazr').set('scaleval', '1e-3/0.3991691370835177');
model.sol('sol1').feature('v1').feature('comp1_mbd_rd_rot').set('scaleval', '0.1');
model.sol('sol1').feature('v1').feature('comp1_mbd_rig_disp').set('scaleval', '0.003991691370835177');
model.sol('sol1').feature('v1').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,5e-5,0.12)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventtol', 0.01);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsgenalpha', 'intermediate');
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('minorder', 1);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('fc1').set('dtech', 'const');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'onevery');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('tstepsbdf', 'intermediate');
model.sol('sol1').feature('t1').feature('fc1').set('jtech', 'once');
model.sol('sol1').feature('t1').feature('fc1').set('maxiter', 10);
model.sol('sol1').feature('t1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Displacement (mbd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 2401, 0);
model.result('pg1').set('defaultPlotID', 'displacement');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result('pg1').feature('surf1').feature.create('def1', 'Deform');
model.result('pg1').feature('surf1').feature('def1').label('Deformation');
model.result('pg1').feature('surf1').feature('def1').set('scaleactive', true);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Velocity (mbd)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 2401, 0);
model.result('pg2').set('defaultPlotID', 'velocity');
model.result('pg2').feature.create('vol1', 'Volume');
model.result('pg2').feature('vol1').label('Volume');
model.result('pg2').feature('vol1').set('expr', 'mod(dom,10)');
model.result('pg2').feature('vol1').set('unit', '1');
model.result('pg2').feature('vol1').set('colortable', 'Cyclic');
model.result('pg2').feature('vol1').set('colorlegend', false);
model.result('pg2').feature('vol1').set('data', 'parent');
model.result('pg2').feature('vol1').feature.create('def1', 'Deform');
model.result('pg2').feature('vol1').feature('def1').label('Deformation');
model.result('pg2').feature('vol1').feature('def1').set('scaleactive', true);
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').label('Arrow Line');
model.result('pg2').feature('arwl1').set('expr', {'mbd.u_tX' 'mbd.u_tY' 'mbd.u_tZ'});
model.result('pg2').feature('arwl1').set('placement', 'elements');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result('pg2').feature('arwl1').feature.create('def1', 'Deform');
model.result('pg2').feature('arwl1').feature('def1').label('Deformation');
model.result('pg2').feature('arwl1').feature('def1').set('scaleactive', true);
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Fluid Pressure (hdb)');
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 2401, 0);
model.result('pg3').set('defaultPlotID', 'fluidPressure');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'pfilm');
model.result('pg3').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg3').feature('surf1').set('smooth', 'internal');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').set('expr', 'pfilm');
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('colorlegend', false);
model.result('pg3').feature('con1').set('smooth', 'internal');
model.result('pg3').feature('con1').set('inherittubescale', false);
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg3').feature('con1').set('inheritplot', 'surf1');
model.result('pg1').run;
model.result.dataset.duplicate('dset2', 'dset1');
model.result.dataset('dset2').label('Study 1/Solution 1: Cylinder');

model.view('view1').set('hidestatus', 'hide');

model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.geom('geom1', 3);
model.result.dataset('dset2').selection.set([2 3 4 5]);
model.result.dataset.duplicate('dset3', 'dset2');
model.result.dataset('dset3').label('Study 1/Solution 1: Engine without cylinder');
model.result.dataset('dset3').selection.geom('geom1', 3);
model.result.dataset('dset3').selection.set([]);
model.result.dataset('dset3').selection.geom('geom1', 3);
model.result.dataset('dset3').selection.set([1 6 7 8 9]);
model.result('pg1').run;
model.result('pg1').set('data', 'dset3');
model.result('pg1').run;
model.result('pg1').feature.duplicate('surf2', 'surf1');
model.result('pg1').run;
model.result('pg1').feature('surf2').set('data', 'dset2');
model.result('pg1').feature('surf2').set('solutionparams', 'parent');
model.result('pg1').feature('surf2').create('tran1', 'Transparency');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf2').create('mtrl1', 'MaterialAppearance');
model.result('pg1').run;
model.result('pg1').feature('surf2').feature('mtrl1').set('usematerialsel', false);
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 2401, 0);
model.result('pg4').set('defaultPlotID', 'boundaryLoads');
model.result('pg4').label('Boundary Loads (mbd)');
model.result('pg4').set('showlegends', true);
model.result('pg4').set('titletype', 'label');
model.result('pg4').set('frametype', 'spatial');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', {'1'});
model.result('pg4').feature('surf1').label('Gray Surfaces');
model.result('pg4').feature('surf1').set('coloring', 'uniform');
model.result('pg4').feature('surf1').set('color', 'gray');
model.result('pg4').feature('surf1').set('inheritcolor', false);
model.result('pg4').feature('surf1').set('inheritrange', false);
model.result('pg4').feature('surf1').set('inherittransparency', false);
model.result('pg4').feature('surf1').create('def', 'Deform');
model.result('pg4').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg4').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg4').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg4').feature('surf1').feature('def').set('scale', 1);
model.result('pg4').feature('surf1').create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('surf1').feature('sel1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286]);
model.result('pg4').feature('surf1').create('tran1', 'Transparency');
model.result('pg4').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg4').create('arws1', 'ArrowSurface');
model.result('pg4').feature('arws1').set('expr', {'mbd.bndl1.F_Ax' 'mbd.bndl1.F_Ay' 'mbd.bndl1.F_Az'});
model.result('pg4').feature('arws1').set('placement', 'gausspoints');
model.result('pg4').feature('arws1').set('arrowbase', 'head');
model.result('pg4').feature('arws1').label('Boundary Load 1');
model.result('pg4').feature('arws1').set('inheritplot', 'none');
model.result('pg4').feature('arws1').create('col', 'Color');
model.result('pg4').feature('arws1').feature('col').set('colortable', 'Rainbow');
model.result('pg4').feature('arws1').feature('col').set('colortabletrans', 'none');
model.result('pg4').feature('arws1').feature('col').set('colorscalemode', 'linear');
model.result('pg4').feature('arws1').feature('col').set('colordata', 'arrowlength');
model.result('pg4').feature('arws1').feature('col').set('coloring', 'gradient');
model.result('pg4').feature('arws1').feature('col').set('topcolor', 'red');
model.result('pg4').feature('arws1').feature('col').set('bottomcolor', 'custom');
model.result('pg4').feature('arws1').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg4').feature('arws1').set('color', 'red');
model.result('pg4').feature('arws1').create('def', 'Deform');
model.result('pg4').feature('arws1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg4').feature('arws1').feature('def').set('descr', 'Displacement field');
model.result('pg4').feature('arws1').feature('def').set('scaleactive', true);
model.result('pg4').feature('arws1').feature('def').set('scale', 1);
model.result('pg4').feature.move('surf1', 1);
model.result('pg4').label('Boundary Loads (mbd)');

model.nodeGroup.create('dset1mbdlgrp', 'Results');
model.nodeGroup('dset1mbdlgrp').label('Applied Loads (mbd)');
model.nodeGroup('dset1mbdlgrp').set('type', 'plotgroup');
model.nodeGroup('dset1mbdlgrp').placeAfter('plotgroup', 'pg3');
model.nodeGroup('dset1mbdlgrp').label('Applied Loads (mbd)');
model.nodeGroup('dset1mbdlgrp').placeAfter('plotgroup', 'pg4');

model.result.create('pg5', 'PlotGroup3D');
model.result('pg5').set('data', 'dset1');
model.result('pg5').setIndex('looplevel', 2401, 0);
model.result('pg5').set('defaultPlotID', 'globalMoments');
model.result('pg5').label('Global Moments (mbd)');
model.result('pg5').set('showlegends', true);
model.result('pg5').set('titletype', 'label');
model.result('pg5').set('frametype', 'spatial');
model.result('pg5').set('showlegendsunit', true);
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', {'1'});
model.result('pg5').feature('surf1').label('Gray Surfaces');
model.result('pg5').feature('surf1').set('coloring', 'uniform');
model.result('pg5').feature('surf1').set('color', 'gray');
model.result('pg5').feature('surf1').set('inheritcolor', false);
model.result('pg5').feature('surf1').set('inheritrange', false);
model.result('pg5').feature('surf1').set('inherittransparency', false);
model.result('pg5').feature('surf1').create('def', 'Deform');
model.result('pg5').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg5').feature('surf1').feature('def').set('descr', 'Displacement field');
model.result('pg5').feature('surf1').feature('def').set('scaleactive', true);
model.result('pg5').feature('surf1').feature('def').set('scale', 1);
model.result('pg5').feature('surf1').create('sel1', 'Selection');
model.result('pg5').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg5').feature('surf1').feature('sel1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286]);
model.result('pg5').feature('surf1').create('tran1', 'Transparency');
model.result('pg5').feature('surf1').feature('tran1').set('transparency', 0.8);
model.result('pg5').create('pttraj1', 'PointTrajectories');
model.result('pg5').feature('pttraj1').set('plotdata', 'global');
model.result('pg5').feature('pttraj1').set('expr', {'mbd.rig1.rm1.momposx' 'mbd.rig1.rm1.momposy' 'mbd.rig1.rm1.momposz'});
model.result('pg5').feature('pttraj1').set('pointtype', 'arrow');
model.result('pg5').feature('pttraj1').set('arrowexpr', {'mbd.rig1.rm1.Mx' 'mbd.rig1.rm1.My' 'mbd.rig1.rm1.Mz'});
model.result('pg5').feature('pttraj1').set('linetype', 'none');
model.result('pg5').feature('pttraj1').set('arrowtype', 'double');
model.result('pg5').feature('pttraj1').set('arrowbase', 'tail');
model.result('pg5').feature('pttraj1').label('Applied Moment 1 (Rigid Connector 1)');
model.result('pg5').feature('pttraj1').set('inheritplot', 'none');
model.result('pg5').feature('pttraj1').create('col', 'Color');
model.result('pg5').feature('pttraj1').feature('col').set('colortable', 'Rainbow');
model.result('pg5').feature('pttraj1').feature('col').set('colortabletrans', 'none');
model.result('pg5').feature('pttraj1').feature('col').set('colorscalemode', 'linear');
model.result('pg5').feature('pttraj1').feature('col').set('colordata', 'arrowlength');
model.result('pg5').feature('pttraj1').feature('col').set('coloring', 'gradient');
model.result('pg5').feature('pttraj1').feature('col').set('topcolor', 'red');
model.result('pg5').feature('pttraj1').feature('col').set('bottomcolor', 'custom');
model.result('pg5').feature('pttraj1').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg5').feature('pttraj1').set('pointcolor', 'blue');
model.result('pg5').feature.move('surf1', 1);
model.result('pg5').create('pttraj2', 'PointTrajectories');
model.result('pg5').feature('pttraj2').set('plotdata', 'global');
model.result('pg5').feature('pttraj2').set('expr', {'mbd.rig1.rm2.momposx' 'mbd.rig1.rm2.momposy' 'mbd.rig1.rm2.momposz'});
model.result('pg5').feature('pttraj2').set('pointtype', 'arrow');
model.result('pg5').feature('pttraj2').set('arrowexpr', {'mbd.rig1.rm2.Mx' 'mbd.rig1.rm2.My' 'mbd.rig1.rm2.Mz'});
model.result('pg5').feature('pttraj2').set('linetype', 'none');
model.result('pg5').feature('pttraj2').set('arrowtype', 'double');
model.result('pg5').feature('pttraj2').set('arrowbase', 'tail');
model.result('pg5').feature('pttraj2').label('Applied Moment 2 (Rigid Connector 1)');
model.result('pg5').feature('pttraj2').set('inheritplot', 'pttraj1');
model.result('pg5').feature('pttraj2').create('col', 'Color');
model.result('pg5').feature('pttraj2').feature('col').set('colortable', 'Rainbow');
model.result('pg5').feature('pttraj2').feature('col').set('colortabletrans', 'none');
model.result('pg5').feature('pttraj2').feature('col').set('colorscalemode', 'linear');
model.result('pg5').feature('pttraj2').feature('col').set('colordata', 'arrowlength');
model.result('pg5').feature('pttraj2').feature('col').set('coloring', 'gradient');
model.result('pg5').feature('pttraj2').feature('col').set('topcolor', 'red');
model.result('pg5').feature('pttraj2').feature('col').set('bottomcolor', 'custom');
model.result('pg5').feature('pttraj2').feature('col').set('custombottomcolor', [0.5882353186607361 0.5137255191802979 0.5176470875740051]);
model.result('pg5').feature('pttraj2').set('pointcolor', 'blue');
model.result('pg5').feature.move('surf1', 2);
model.result('pg5').label('Global Moments (mbd)');

model.nodeGroup('dset1mbdlgrp').add('plotgroup', 'pg4');
model.nodeGroup('dset1mbdlgrp').add('plotgroup', 'pg5');

model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').feature.copy('arws1', 'pg4/arws1');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('legendpos', 'rightdouble');
model.result('pg1').run;
model.result.dataset.duplicate('dset4', 'dset1');
model.result.dataset('dset4').label('Study 1/Solution 1: Bearing');
model.result.dataset('dset4').selection.geom('geom1', 2);
model.result.dataset('dset4').selection.named('uni1');
model.result('pg3').run;
model.result('pg3').set('data', 'dset4');
model.result('pg3').set('edges', false);
model.result('pg3').set('view', 'new');
model.result('pg3').create('arws1', 'ArrowSurface');
model.result('pg3').feature('arws1').set('expr', {'hdb.fbx' 'hdb.fby' 'w'});
model.result('pg3').feature('arws1').setIndex('expr', 'hdb.fbz', 2);
model.result('pg3').feature('arws1').set('placement', 'elements');
model.result('pg3').feature('arws1').set('scaleactive', true);
model.result('pg3').feature('arws1').set('scale', '1e-8');
model.result('pg3').run;
model.result.dataset.duplicate('dset5', 'dset1');
model.result.dataset('dset5').label('Study 1/Solution 1: Crankshaft');
model.result.dataset('dset5').selection.geom('geom1', 3);
model.result.dataset('dset5').selection.geom('geom1', 3);
model.result.dataset('dset5').selection.set([1]);
model.result.dataset.duplicate('dset6', 'dset5');
model.result.dataset('dset6').label('Study 1/Solution 1: Foundation');
model.result.dataset('dset6').selection.geom('geom1', 3);
model.result.dataset('dset6').selection.set([]);

model.view('view1').set('hidestatus', 'showonlyhidden');

model.result.dataset('dset6').selection.geom('geom1', 3);
model.result.dataset('dset6').selection.set([6 9]);
model.result.create('pg6', 'PlotGroup3D');
model.result('pg6').run;
model.result('pg6').label('Crankshaft Stress');
model.result('pg6').set('data', 'dset5');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'mbd.mises');
model.result('pg6').feature('surf1').set('colortable', 'Prism');
model.result('pg6').feature('surf1').set('rangecoloractive', true);
model.result('pg6').feature('surf1').set('rangecolormax', '1e7');
model.result('pg6').feature('surf1').create('def1', 'Deform');
model.result('pg6').run;
model.result('pg6').feature('surf1').feature('def1').set('expr', {'u_ref' 'v_ref' 'w_ref'});
model.result('pg6').feature('surf1').feature('def1').set('descr', 'Displacement field, reference frame (spatial frame)');
model.result('pg6').feature('surf1').feature('def1').set('scaleactive', true);
model.result('pg6').feature('surf1').feature('def1').set('scale', 800);
model.result('pg6').run;
model.result('pg6').set('view', 'new');
model.result('pg6').run;
model.result.duplicate('pg7', 'pg6');
model.result('pg7').run;
model.result('pg7').set('data', 'dset6');
model.result('pg7').label('Foundation Stress (mbd)');
model.result('pg7').set('view', 'new');
model.result('pg7').run;
model.result('pg7').feature('surf1').set('rangecolormax', '3e6');
model.result('pg7').run;
model.result('pg7').feature('surf1').feature('def1').set('expr', {'u' 'v' 'w'});
model.result('pg7').feature('surf1').feature('def1').set('descr', 'Displacement field');
model.result('pg7').feature('surf1').feature('def1').set('scale', '3e3');
model.result('pg7').run;
model.result('pg7').run;
model.result.create('pg8', 'PlotGroup1D');
model.result('pg8').run;
model.result('pg8').label('Engine Speed');
model.result('pg8').create('glob1', 'Global');
model.result('pg8').feature('glob1').set('markerpos', 'datapoints');
model.result('pg8').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('glob1').setIndex('expr', 'd(theta,t)*60[s]/(2*pi[rad])', 0);
model.result('pg8').feature('glob1').setIndex('unit', 'RPM', 0);
model.result('pg8').feature('glob1').setIndex('descr', 'Engine speed', 0);
model.result('pg8').run;
model.result('pg8').run;
model.result('pg8').set('ylabelactive', true);
model.result('pg8').set('ylabel', 'Engine speed (RPM)');
model.result('pg8').set('titletype', 'label');
model.result('pg8').set('showlegends', false);
model.result('pg8').run;
model.result.create('pg9', 'PlotGroup1D');
model.result('pg9').run;
model.result('pg9').label('Bearing Reactions and Piston Load');
model.result('pg9').create('glob1', 'Global');
model.result('pg9').feature('glob1').set('markerpos', 'datapoints');
model.result('pg9').feature('glob1').set('linewidth', 'preference');
model.result('pg9').feature('glob1').set('expr', {'hdb.hjb1.Fjz'});
model.result('pg9').feature('glob1').set('descr', {'Fluid load on journal, z-component'});
model.result('pg9').feature('glob1').set('unit', {'N'});
model.result('pg9').feature('glob1').set('expr', {'hdb.hjb1.Fjz' 'hdb.hjb2.Fjz'});
model.result('pg9').feature('glob1').set('descr', {'Fluid load on journal, z-component' 'Fluid load on journal, z-component'});
model.result('pg9').feature('glob1').set('expr', {'hdb.hjb1.Fjz' 'hdb.hjb2.Fjz' 'mbd.hgj1.F_elz'});
model.result('pg9').feature('glob1').set('descr', {'Fluid load on journal, z-component' 'Fluid load on journal, z-component' 'Joint force (elastic), z-component'});
model.result('pg9').feature('glob1').set('expr', {'hdb.hjb1.Fjz' 'hdb.hjb2.Fjz' 'mbd.hgj1.F_elz' 'mbd.hgj3.F_elz'});
model.result('pg9').feature('glob1').set('descr', {'Fluid load on journal, z-component' 'Fluid load on journal, z-component' 'Joint force (elastic), z-component' 'Joint force (elastic), z-component'});
model.result('pg9').feature('glob1').setIndex('unit', 'N', 0);
model.result('pg9').feature('glob1').setIndex('descr', 'Bearing (left)', 0);
model.result('pg9').feature('glob1').setIndex('unit', 'N', 1);
model.result('pg9').feature('glob1').setIndex('descr', 'Bearing (right)', 1);
model.result('pg9').feature('glob1').setIndex('unit', 'N', 2);
model.result('pg9').feature('glob1').setIndex('descr', 'Elastic joint (left)', 2);
model.result('pg9').feature('glob1').setIndex('unit', 'N', 3);
model.result('pg9').feature('glob1').setIndex('descr', 'Elastic joint (right)', 3);
model.result('pg9').feature('glob1').setIndex('expr', 'p*A', 4);
model.result('pg9').feature('glob1').setIndex('unit', 'N', 4);
model.result('pg9').feature('glob1').setIndex('descr', 'Piston load', 4);
model.result('pg9').feature('glob1').setIndex('expr', 'hdb.hjb1.Fjz+hdb.hjb2.Fjz+mbd.hgj1.F_elz+mbd.hgj3.F_elz', 5);
model.result('pg9').feature('glob1').setIndex('unit', 'N', 5);
model.result('pg9').feature('glob1').setIndex('descr', 'Total', 5);
model.result('pg9').run;
model.result('pg9').run;
model.result('pg9').set('titletype', 'label');
model.result('pg9').set('ylabelactive', true);
model.result('pg9').set('ylabel', 'Force (N)');
model.result('pg9').set('legendpos', 'upperleft');
model.result('pg9').run;
model.result.create('pg10', 'PlotGroup1D');
model.result('pg10').run;
model.result('pg10').label('Crankshaft Torque');
model.result('pg10').set('titletype', 'label');
model.result('pg10').set('ylabelactive', true);
model.result('pg10').set('ylabel', 'Torque (N*m)');
model.result('pg10').create('glob1', 'Global');
model.result('pg10').feature('glob1').set('markerpos', 'datapoints');
model.result('pg10').feature('glob1').set('linewidth', 'preference');
model.result('pg10').feature('glob1').setIndex('expr', '-p*A*sin(theta+theta0)*0.02[m]', 0);
model.result('pg10').feature('glob1').setIndex('unit', 'N*m', 0);
model.result('pg10').feature('glob1').setIndex('descr', 'Torque on crankshaft (approximate)', 0);
model.result('pg10').feature('glob1').setIndex('expr', 'Ti', 1);
model.result('pg10').feature('glob1').setIndex('unit', 'N*m', 1);
model.result('pg10').feature('glob1').setIndex('descr', 'Starting torque', 1);
model.result('pg10').feature('glob1').setIndex('expr', 'To', 2);
model.result('pg10').feature('glob1').setIndex('unit', 'N*m', 2);
model.result('pg10').feature('glob1').setIndex('descr', 'Output torque', 2);
model.result('pg10').run;
model.result.create('pg11', 'PlotGroup1D');
model.result('pg11').run;
model.result('pg11').label('Power Generated');
model.result('pg11').create('glob1', 'Global');
model.result('pg11').feature('glob1').set('markerpos', 'datapoints');
model.result('pg11').feature('glob1').set('linewidth', 'preference');
model.result('pg11').feature('glob1').setIndex('expr', 'P', 0);
model.result('pg11').feature('glob1').setIndex('unit', 'HP', 0);
model.result('pg11').feature('glob1').setIndex('descr', 'Power generated', 0);
model.result('pg11').run;
model.result('pg11').feature('glob1').set('legend', false);
model.result('pg11').run;
model.result('pg11').set('ylabelactive', true);
model.result('pg11').set('ylabel', 'Power generated (HP)');
model.result('pg11').set('titletype', 'label');
model.result.duplicate('pg12', 'pg11');
model.result('pg12').run;
model.result('pg12').label('BHP');
model.result('pg12').set('ylabel', 'BHP');
model.result('pg12').run;
model.result('pg12').feature('glob1').setIndex('expr', 'BHP', 0);
model.result('pg12').feature('glob1').setIndex('unit', 'HP', 0);
model.result('pg12').feature('glob1').setIndex('descr', 'Brake horse power', 0);
model.result('pg12').run;
model.result.create('pg13', 'PlotGroup1D');
model.result('pg13').run;
model.result('pg13').create('glob1', 'Global');
model.result('pg13').feature('glob1').set('markerpos', 'datapoints');
model.result('pg13').feature('glob1').set('linewidth', 'preference');
model.result('pg13').feature('glob1').set('expr', {'mbd.att1.w'});
model.result('pg13').feature('glob1').set('descr', {'Rigid body displacement, z-component'});
model.result('pg13').feature('glob1').set('unit', {'m'});
model.result('pg13').feature('glob1').setIndex('expr', 'mbd.att1.w/C', 0);
model.result('pg13').feature('glob1').setIndex('unit', 1, 0);
model.result('pg13').feature('glob1').setIndex('descr', '', 0);
model.result('pg13').feature('glob1').set('xdata', 'expr');
model.result('pg13').feature('glob1').set('xdataexpr', 'mbd.att1.v');
model.result('pg13').feature('glob1').set('xdatadescr', 'Rigid body displacement, y-component');
model.result('pg13').feature('glob1').set('xdataexpr', 'mbd.att1.v/C');
model.result('pg13').run;
model.result('pg13').run;
model.result('pg13').label('Journal 1 Orbit');
model.result('pg13').set('titletype', 'label');
model.result('pg13').set('showlegends', false);
model.result('pg13').set('xlabelactive', true);
model.result('pg13').set('xlabel', 'Relative y displacement');
model.result('pg13').set('ylabelactive', true);
model.result('pg13').set('ylabel', 'Relative z displacement');
model.result('pg13').run;
model.result.duplicate('pg14', 'pg13');
model.result('pg14').run;
model.result('pg14').label('Journal Eccentricity');
model.result('pg14').set('xlabelactive', false);
model.result('pg14').set('ylabel', 'Relative eccentricity');
model.result('pg14').run;
model.result('pg14').feature('glob1').setIndex('expr', 'sqrt(mbd.att1.v^2+mbd.att1.w^2)/C', 0);
model.result('pg14').feature('glob1').setIndex('unit', 1, 0);
model.result('pg14').feature('glob1').setIndex('descr', 'Relative eccentricity', 0);
model.result('pg14').feature('glob1').set('xdata', 'solution');
model.result('pg14').run;
model.result.export.create('anim1', 'Animation');
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'on');
model.result.export('anim1').set('options2d', 'off');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'on');
model.result.export('anim1').set('showgrid', 'on');
model.result.export('anim1').showFrame;
model.result.export('anim1').label('Animation: Displacement');
model.result.export('anim1').set('looplevelinput', 'manualindices');
model.result.export('anim1').set('looplevelindices', 'range(1000,1,1201)');
model.result.export('anim1').set('maxframes', 100);
model.result.export('anim1').run;
model.result('pg3').run;
model.result.export.create('anim2', 'Animation');
model.result.export('anim2').set('target', 'player');
model.result.export('anim2').set('fontsize', '9');
model.result.export('anim2').set('colortheme', 'globaltheme');
model.result.export('anim2').set('customcolor', [1 1 1]);
model.result.export('anim2').set('background', 'color');
model.result.export('anim2').set('gltfincludelines', 'on');
model.result.export('anim2').set('title1d', 'on');
model.result.export('anim2').set('legend1d', 'on');
model.result.export('anim2').set('logo1d', 'on');
model.result.export('anim2').set('options1d', 'on');
model.result.export('anim2').set('title2d', 'on');
model.result.export('anim2').set('legend2d', 'on');
model.result.export('anim2').set('logo2d', 'on');
model.result.export('anim2').set('options2d', 'off');
model.result.export('anim2').set('title3d', 'on');
model.result.export('anim2').set('legend3d', 'on');
model.result.export('anim2').set('logo3d', 'on');
model.result.export('anim2').set('options3d', 'off');
model.result.export('anim2').set('axisorientation', 'on');
model.result.export('anim2').set('grid', 'on');
model.result.export('anim2').set('axes1d', 'on');
model.result.export('anim2').set('axes2d', 'on');
model.result.export('anim2').set('showgrid', 'on');
model.result.export('anim2').showFrame;
model.result.export('anim2').label('Animation: Fluid Pressure');
model.result.export('anim2').set('plotgroup', 'pg3');
model.result.export('anim2').set('maxframes', 100);
model.result.export('anim2').set('looplevelinput', 'manualindices');
model.result.export('anim2').set('looplevelindices', 'range(700,1,801)');
model.result.export('anim2').run;
model.result.export.create('anim3', 'Animation');
model.result.export('anim3').set('target', 'player');
model.result.export('anim3').set('fontsize', '9');
model.result.export('anim3').set('colortheme', 'globaltheme');
model.result.export('anim3').set('customcolor', [1 1 1]);
model.result.export('anim3').set('background', 'color');
model.result.export('anim3').set('gltfincludelines', 'on');
model.result.export('anim3').set('title1d', 'on');
model.result.export('anim3').set('legend1d', 'on');
model.result.export('anim3').set('logo1d', 'on');
model.result.export('anim3').set('options1d', 'on');
model.result.export('anim3').set('title2d', 'on');
model.result.export('anim3').set('legend2d', 'on');
model.result.export('anim3').set('logo2d', 'on');
model.result.export('anim3').set('options2d', 'off');
model.result.export('anim3').set('title3d', 'on');
model.result.export('anim3').set('legend3d', 'on');
model.result.export('anim3').set('logo3d', 'on');
model.result.export('anim3').set('options3d', 'off');
model.result.export('anim3').set('axisorientation', 'on');
model.result.export('anim3').set('grid', 'on');
model.result.export('anim3').set('axes1d', 'on');
model.result.export('anim3').set('axes2d', 'on');
model.result.export('anim3').set('showgrid', 'on');
model.result.export('anim3').showFrame;
model.result.export('anim3').label('Animation: Foundation Stress');
model.result.export('anim3').set('plotgroup', 'pg7');
model.result.export('anim3').set('looplevelinput', 'manualindices');
model.result.export('anim3').set('looplevelindices', 'range(1100,1,1200)');
model.result.export('anim3').run;

model.nodeGroup('grp1').active(true);

model.result('pg1').run;

model.title('Reciprocating Engine with Hydrodynamic Bearings');

model.description(['A single cylinder reciprocating engine supported on hydrodynamic bearings is studied. A starting torque is applied to bring the engine to required rpm. The loading torque is switched on once the engine picks up speed. After the start-up, the engine operates on its own driven by the cylinder pressure' newline  newline 'The engine assembly is modeled using the Multibody Dynamics interface in the Multibody Dynamics Module, and the bearing is modeled using the Hydrodynamic Bearing interface in the Rotordynamics Module. A Solid' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Bearing Coupling multiphysics coupling is used to combine the two interfaces.' newline  newline 'The results include stress in the crankshaft and foundation, pressure in the bearings, engine speed variation, generated power, brake horse power, and orbit of the shaft in the bearing.']);

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;

model.label('single_cylinder_reciprocating_engine.mph');

model.modelNode.label('Components');

out = model;
