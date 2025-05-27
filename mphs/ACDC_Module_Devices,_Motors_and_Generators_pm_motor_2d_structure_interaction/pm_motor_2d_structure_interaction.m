function out = model
%
% pm_motor_2d_structure_interaction.m
%
% Model exported on May 26 2025, 21:24 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Devices,_Motors_and_Generators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.physics.create('mbd', 'MultibodyDynamics', 'geom1');
model.physics('mbd').model('comp1');
model.physics('mbd').create('rotf1', 'RotatingFrame');
model.physics('mbd').feature('rotf1').selection.all;
model.physics('mbd').feature('rotf1').set('DefineSpatialFrameRotation', {'1'});
model.physics.create('rmm', 'RotatingMachineryMagnetic', 'geom1');
model.physics('rmm').model('comp1');
model.physics('rmm').feature('al1').set('materialType', {'solid'});
model.physics('rmm').feature('al1').label(['Amp' native2unicode(hex2dec({'00' 'e8'}), 'unicode') 're''s Law, Solid']);

model.multiphysics.create('mfrm1', 'MagneticForcesRotatingMachinery', 'geom1', 2);
model.multiphysics('mfrm1').set('Solid_physics', 'mbd');
model.multiphysics('mfrm1').set('MagneticFields_physics', 'rmm');
model.multiphysics('mfrm1').selection.all;

model.common.create('rotb1', 'RotatingBoundary', 'comp1');
model.common('rotb1').selection.set([]);
model.common.create('free1', 'DeformingDomain', 'comp1');
model.common('free1').set('smoothingType', 'hyperelastic');
model.common('free1').selection.set([]);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').setSolveFor('/physics/mbd', true);
model.study('std1').feature('stat').setSolveFor('/physics/rmm', true);
model.study('std1').feature('stat').setSolveFor('/multiphysics/mfrm1', true);

model.geom('geom1').lengthUnit('mm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Np', '10', 'Number of poles');
model.param.set('Ns', '12', 'Number of slots');
model.param.set('APnr', '5', 'Number of air pockets in rotor');
model.param.set('APfct', '0.7', 'Ratio of air pocket width to lamination width');
model.param.set('geom_scale', '5', 'Geometry scale');
model.param.set('L', '300[mm]', 'Out-of-plane thickness of motor');
model.param.set('Ipk', '10[A]', 'Phase current peak');
model.param.set('init_ang', '198[deg]', 'Initial current angle for peak torque');
model.param.set('w_rot', '700[rpm]', 'Rotational speed');
model.param.set('f_el', 'w_rot*Np/2', 'Electrical frequency');
model.param.set('t_ramp', '1/f_el/20', 'Time for ramping speed');
model.param.set('N_tsteps', '72', 'Number of time steps');
model.param.set('t_step', '1/f_el/N_tsteps', 'Time step');
model.param.set('t_end', '3/f_el', 'Simulation time');
model.param.set('t', '0[s]', 'Time variable alias');

model.geom.load({'part1'}, 'ACDC_Module/Rotating_Machinery_2D/Rotors/Internal/surface_mounted_magnet_internal_rotor_2d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_poles', 'Np');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'number_of_modeled_poles', 'Np');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'magnet_h', '1.5[mm]');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'magnet_w', '7[mm]');
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_shaft.dom', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_magnets', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_rotor_air.dom', true);
model.geom('geom1').run('pi1');
model.geom('geom1').create('spl1', 'Split');
model.geom('geom1').feature('spl1').selection('input').set({'pi1'});
model.geom('geom1').run('spl1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', 11.8);
model.geom('geom1').feature('c1').set('angle', '360/APnr*APfct');
model.geom('geom1').run('c1');
model.geom('geom1').feature.duplicate('c2', 'c1');
model.geom('geom1').feature('c2').set('r', 7);
model.geom('geom1').run('c2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'c1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('fil1', 'Fillet');
model.geom('geom1').feature('fil1').selection('point').set('dif1', [1 2 3 4]);
model.geom('geom1').feature('fil1').set('radius', '2/APnr');
model.geom('geom1').run('fil1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').label('Rotate: Rotor Air Channels');
model.geom('geom1').feature('rot1').set('rot', 'range((360/APnr-360/APnr*APfct)/2,360/APnr,360)');
model.geom('geom1').feature('rot1').selection('input').set({'fil1'});
model.geom('geom1').feature('rot1').set('selresult', true);
model.geom('geom1').run('rot1');
model.geom('geom1').feature.duplicate('dif2', 'dif1');
model.geom('geom1').feature('dif2').label('Difference: Rotor Core');
model.geom('geom1').feature('dif2').selection('input').set({'spl1(12)'});
model.geom('geom1').feature('dif2').selection('input2').set({'rot1'});
model.geom('geom1').feature('dif2').set('keepsubtract', true);
model.geom('geom1').feature('dif2').set('selresult', true);
model.geom('geom1').run('dif2');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').label('Union: Rotor');
model.geom('geom1').feature('uni1').selection('input').set({'dif2' 'rot1' 'spl1(1)' 'spl1(10)' 'spl1(11)' 'spl1(13)' 'spl1(2)' 'spl1(3)' 'spl1(4)' 'spl1(5)'  ...
'spl1(6)' 'spl1(7)' 'spl1(8)' 'spl1(9)'});
model.geom('geom1').feature('uni1').set('selresult', true);
model.geom('geom1').run('uni1');
model.geom('geom1').create('disksel1', 'DiskSelection');
model.geom('geom1').feature('disksel1').label('Rotating Boundaries');
model.geom('geom1').feature('disksel1').set('entitydim', 1);
model.geom('geom1').feature('disksel1').set('r', 'inf');
model.geom('geom1').feature('disksel1').set('rin', '30.5/2*0.99');
model.geom('geom1').nodeGroup.create('grp1');
model.geom('geom1').nodeGroup('grp1').placeAfter([]);
model.geom('geom1').nodeGroup('grp1').add('pi1');
model.geom('geom1').nodeGroup('grp1').add('spl1');
model.geom('geom1').nodeGroup('grp1').add('c1');
model.geom('geom1').nodeGroup('grp1').add('c2');
model.geom('geom1').nodeGroup('grp1').add('dif1');
model.geom('geom1').nodeGroup('grp1').add('fil1');
model.geom('geom1').nodeGroup('grp1').add('rot1');
model.geom('geom1').nodeGroup('grp1').add('dif2');
model.geom('geom1').nodeGroup('grp1').add('uni1');
model.geom('geom1').nodeGroup('grp1').add('disksel1');
model.geom('geom1').nodeGroup('grp1').label('Stator');
model.geom.load({'part2'}, 'ACDC_Module/Rotating_Machinery_2D/Stators/External/slotted_external_stator_2d.mph', {'part1'});
model.geom('geom1').run('disksel1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').nodeGroup('grp1').remove('pi2', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_slots', 'Ns');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'number_of_modeled_slots', 'Ns');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'slot_winding_type', 2);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Arkkio_toggle', 1);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_iron.dom', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_stator_slots', true);
model.geom('geom1').feature('pi2').setEntry('selkeepdom', 'pi2_all.dom', true);
model.geom('geom1').run('pi2');
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').selection('input').set({'pi2' 'uni1'});
model.geom('geom1').feature('sca1').set('isotropic', 'geom_scale');
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').run('fin');

model.func.create('rm1', 'Ramp');
model.func('rm1').model('comp1');
model.func('rm1').set('location', 't_ramp/2');
model.func('rm1').set('smoothzonelocactive', true);
model.func('rm1').set('smoothzoneloc', 't_ramp');

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('alpha', 'w_rot*2*pi*rm1(t)[s]');
model.variable('var1').descr('alpha', 'Rotation angle');

model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Structural Domains');
model.selection('uni1').set('input', {'geom1_pi1_rotor_magnets' 'geom1_dif2_dom'});
model.selection.duplicate('uni2', 'uni1');
model.selection('uni2').label('Deforming Domains');
model.selection('uni2').set('input', {'geom1_pi1_rotor_air_dom' 'geom1_rot1_dom'});
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Shaft Boundaries');
model.selection('adj1').set('input', {'geom1_pi1_shaft_dom'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.material('mat1').propertyGroup.create('idealGas', 'Ideal gas');
model.material('mat1').propertyGroup('idealGas').func.create('Cp', 'Piecewise');
model.material('mat1').label('Air');
model.material('mat1').set('family', 'air');
model.material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.material('mat1').propertyGroup('def').func('rho').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('rho').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('rho').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '293.15'});
model.material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.material('mat1').propertyGroup('def').func('cs').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('cs').set('plotfixedvalue', {'273.15'});
model.material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.material('mat1').propertyGroup('def').func('an1').set('argunit', {'Pa' 'K'});
model.material('mat1').propertyGroup('def').func('an1').set('plotaxis', {'off' 'on'});
model.material('mat1').propertyGroup('def').func('an1').set('plotfixedvalue', {'101325' '273.15'});
model.material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.material('mat1').propertyGroup('def').func('an2').set('argunit', {'K'});
model.material('mat1').propertyGroup('def').func('an2').set('plotfixedvalue', {'200'});
model.material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.material('mat1').propertyGroup('def').set('molarmass', '');
model.material('mat1').propertyGroup('def').set('bulkviscosity', '');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.material('mat1').propertyGroup('def').addInput('temperature');
model.material('mat1').propertyGroup('def').addInput('pressure');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('NonlinearModel').set('BA', 'def.gamma-1');
model.material('mat1').propertyGroup('idealGas').func('Cp').label('Piecewise 2');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('arg', 'T');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.material('mat1').propertyGroup('idealGas').func('Cp').set('argunit', 'K');
model.material('mat1').propertyGroup('idealGas').func('Cp').set('fununit', 'J/(kg*K)');
model.material('mat1').propertyGroup('idealGas').set('Rs', 'R_const/Mn');
model.material('mat1').propertyGroup('idealGas').set('heatcapacity', 'Cp(T)');
model.material('mat1').propertyGroup('idealGas').set('ratioofspecificheat', '1.4');
model.material('mat1').propertyGroup('idealGas').set('molarmass', '0.02897');
model.material('mat1').propertyGroup('idealGas').addInput('temperature');
model.material('mat1').propertyGroup('idealGas').addInput('pressure');
model.material('mat1').materialType('nonSolid');
model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');
model.material('mat2').label('Silicon Steel NGO 35PN440');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'2.631578[MS/m]' '0' '0' '0' '2.631578[MS/m]' '0' '0' '0' '2.631578[MS/m]'});
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1[1]' '0' '0' '0' '1[1]' '0' '0' '0' '1[1]'});
model.material('mat2').propertyGroup('BHCurve').label('B-H Curve');
model.material('mat2').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'20' '0.059405941';  ...
'22.5' '0.0730455860807292';  ...
'25' '0.0868399341458333';  ...
'27.5' '0.100943688179687';  ...
'30' '0.115511551166667';  ...
'32.5' '0.130852929054687';  ...
'35' '0.147896039645833';  ...
'37.5' '0.167723803705729';  ...
'40' '0.191419142';  ...
'42.5260416666667' '0.220052083388021';  ...
'45.2083333333333' '0.254641089104167';  ...
'48.203125' '0.296191728476563';  ...
'51.6666666666667' '0.345709570833333';  ...
'55.7291666666667' '0.403671617015625';  ...
'60.4166666666667' '0.468440593916667';  ...
'65.7291666666667' '0.537850659942708';  ...
'71.6666666666667' '0.6097359735';  ...
'78.3854166666667' '0.682459261479167';  ...
'86.6666666666667' '0.756497524708333';  ...
'97.4479166666667' '0.8328563325';  ...
'111.666666666667' '0.912541254166667';  ...
'129.921875' '0.995539397796875';  ...
'151.458333333333' '1.07776402658333';  ...
'175.182291666667' '1.15410994249479';  ...
'200' '1.2194719475';  ...
'225.260416666667' '1.27022741370313';  ...
'252.083333333333' '1.30868399375';  ...
'282.03125' '1.33863191042188';  ...
'316.666666666667' '1.3638613865';  ...
'357.03125' '1.38744069756771';  ...
'402.083333333333' '1.40955033041667';  ...
'450.260416666667' '1.42964882464062';  ...
'500' '1.44719471983333';  ...
'550.260416666667' '1.46186571813281';  ...
'602.083333333333' '1.47421617185417';  ...
'657.03125' '1.48501959585677';  ...
'716.666666666667' '1.495049505';  ...
'783.854166666667' '1.50504073840104';  ...
'866.666666666667' '1.51557343220833';  ...
'974.479166666667' '1.52718904682813';  ...
'1116.66666666667' '1.54042904266667';  ...
'1299.21875' '1.55557704184375';  ...
'1514.58333333333' '1.57188531333333';  ...
'1751.82291666667' '1.58834828782292';  ...
'2000' '1.603960396';  ...
'2252.60416666667' '1.61801258257552';  ...
'2520.83333333333' '1.63098184835417';  ...
'2820.3125' '1.64364170816406';  ...
'3166.66666666667' '1.65676567683333';  ...
'3570.3125' '1.67092099857292';  ...
'4020.83333333333' '1.685849835125';  ...
'4502.60416666667' '1.70108807761458';  ...
'5000' '1.71617161716667';  ...
'5502.60416666667' '1.73076526403646';  ...
'6020.83333333333' '1.745049505';  ...
'6570.3125' '1.75933374596354';  ...
'7166.66666666667' '1.77392739283333';  ...
'7838.54166666667' '1.7891527434401';  ...
'8666.66666666667' '1.8053836633125';  ...
'9744.79166666667' '1.82300690990365';  ...
'11166.6666666667' '1.84240924066667';  ...
'12992.1875' '1.86368089902344';  ...
'15145.8333333333' '1.88572607227083';  ...
'17518.2291666667' '1.90715243367448';  ...
'20000' '1.9265676565';  ...
'22552.0833333333' '1.9429661714349';  ...
'25416.6666666667' '1.95688943885417';  ...
'28906.25' '1.96926567655469';  ...
'33333.3333333333' '1.98102310233333';  ...
'38843.7447916667' '1.99281304837785';  ...
'44916.625' '2.00417930443947';  ...
'50864.4427083333' '2.01438877466029';  ...
'55999.6666666667' '2.02270836318242';  ...
'60093.015625' '2.02898975888627';  ...
'64748.2083333333' '2.03542378960551';  ...
'72027.2135416667' '2.04478606791211';  ...
'83992' '2.05985220637807';  ...
'102079.71875' '2.08258190411622';  ...
'125228.25' '2.11167120640287';  ...
'151750.65625' '2.14500024505519';  ...
'179960' '2.18044915189034'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.material('mat2').propertyGroup('BHCurve').func('BH').set('fununit', {'T'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('argunit', {'A/m'});
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.material('mat2').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.material('mat2').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.material('mat2').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.material('mat2').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.material('mat2').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.material('mat2').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfield');
model.material('mat2').propertyGroup('BHCurve').addInput('magneticfluxdensity');
model.material.create('mat3', 'Common', 'comp1');
model.material('mat3').propertyGroup.create('RemanentFluxDensity', 'Remanent flux density');
model.material('mat3').propertyGroup('RemanentFluxDensity').func.create('int1', 'Interpolation');
model.material('mat3').label('BMN-42');
model.material('mat3').set('family', 'chrome');
model.material('mat3').propertyGroup('def').set('thermalconductivity', {'9.0[W/(m*K)]' '0' '0' '0' '9.0[W/(m*K)]' '0' '0' '0' '9.0[W/(m*K)]'});
model.material('mat3').propertyGroup('def').set('density', '7.55[g/cm^3]');
model.material('mat3').propertyGroup('def').set('heatcapacity', '440[J/(kg*K)]');
model.material('mat3').propertyGroup('def').set('electricconductivity', {'1/1.50[uohm*m]' '0' '0' '0' '1/1.50[uohm*m]' '0' '0' '0' '1/1.50[uohm*m]'});
model.material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat3').propertyGroup('RemanentFluxDensity').func('int1').set('funcname', 'Br');
model.material('mat3').propertyGroup('RemanentFluxDensity').func('int1').set('table', {'293.15' '1.330'; '353.15' '1.23'});
model.material('mat3').propertyGroup('RemanentFluxDensity').func('int1').set('extrap', 'linear');
model.material('mat3').propertyGroup('RemanentFluxDensity').func('int1').set('fununit', {'T'});
model.material('mat3').propertyGroup('RemanentFluxDensity').func('int1').set('argunit', {'K'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('murec', {'1.05' '0' '0' '0' '1.05' '0' '0' '0' '1.05'});
model.material('mat3').propertyGroup('RemanentFluxDensity').set('normBr', 'Br(T)');
model.material('mat3').propertyGroup('RemanentFluxDensity').addInput('temperature');
model.material.create('mat4', 'Common', 'comp1');
model.material('mat4').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat4').propertyGroup.create('Murnaghan', 'Murnaghan');
model.material('mat4').label('High-strength alloy steel');
model.material('mat4').set('family', 'custom');
model.material('mat4').set('customspecular', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat4').set('customdiffuse', [0.9803921568627451 0.9803921568627451 0.9803921568627451]);
model.material('mat4').set('customambient', [0.5882352941176471 0.5882352941176471 0.5882352941176471]);
model.material('mat4').set('noise', true);
model.material('mat4').set('fresnel', 0.99);
model.material('mat4').set('roughness', 0.12);
model.material('mat4').set('metallic', 0);
model.material('mat4').set('pearl', 0);
model.material('mat4').set('diffusewrap', 0);
model.material('mat4').set('clearcoat', 0);
model.material('mat4').set('reflectance', 0);
model.material('mat4').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('heatcapacity', '475[J/(kg*K)]');
model.material('mat4').propertyGroup('def').set('thermalconductivity', {'44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]' '0' '0' '0' '44.5[W/(m*K)]'});
model.material('mat4').propertyGroup('def').set('electricconductivity', {'4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]' '0' '0' '0' '4.032e6[S/m]'});
model.material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]' '0' '0' '0' '12.3e-6[1/K]'});
model.material('mat4').propertyGroup('def').set('density', '7850[kg/m^3]');
model.material('mat4').propertyGroup('Enu').set('E', '200[GPa]');
model.material('mat4').propertyGroup('Enu').set('nu', '0.30');
model.material('mat4').propertyGroup('Murnaghan').set('l', '-300[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('m', '-620[GPa]');
model.material('mat4').propertyGroup('Murnaghan').set('n', '-720[GPa]');
model.material('mat2').selection.set([2 35]);
model.material('mat2').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat2').propertyGroup('Enu').set('E', {'195[GPa]'});
model.material('mat2').propertyGroup('Enu').set('nu', {'0.25'});
model.material('mat2').propertyGroup('def').set('density', {'7700'});
model.material('mat2').propertyGroup('def').set('electricconductivity', {'0'});
model.material('mat3').selection.named('geom1_pi1_rotor_magnets');
model.material('mat3').propertyGroup.create('Enu', 'Young''s_modulus_and_Poisson''s_ratio');
model.material('mat3').propertyGroup('Enu').set('E', {'160[GPa]'});
model.material('mat3').propertyGroup('Enu').set('nu', {'0.24'});
model.material('mat3').propertyGroup('def').set('density', {'7600'});
model.material('mat4').selection.named('geom1_pi1_shaft_dom');

model.physics('mbd').selection.named('uni1');
model.physics('mbd').prop('d').set('d', 'L');
model.physics('mbd').feature('rotf1').selection.named('uni1');
model.physics('mbd').feature('rotf1').set('RotationalFrequency', 'userdef');
model.physics('mbd').feature('rotf1').set('alpha', 'alpha');
model.physics('mbd').create('fix1', 'Fixed', 1);
model.physics('mbd').feature('fix1').selection.named('adj1');
model.physics('rmm').prop('d').set('d', 'L');
model.physics('rmm').create('al2', 'AmperesLaw', 2);
model.physics('rmm').feature('al2').selection.set([2 35]);
model.physics('rmm').feature('al2').set('ConstitutiveRelationBH', 'BHCurve');
model.physics('rmm').create('cmag1', 'ConductingMagnet', 2);
model.physics('rmm').feature('cmag1').selection.named('geom1_pi1_rotor_magnets');
model.physics('rmm').feature('cmag1').set('PatternType', 'CircularPattern');
model.physics('rmm').feature('cmag1').set('PeriodicType', 'Alternating');
model.physics('rmm').feature('cmag1').feature('north1').selection.set([326]);
model.physics('rmm').feature('cmag1').feature('south1').selection.set([323]);
model.physics('rmm').create('wnd1', 'MultiphaseWinding', 2);
model.physics('rmm').feature('wnd1').selection.named('geom1_pi2_stator_slots');
model.physics('rmm').feature('wnd1').set('Ipk', 'Ipk');
model.physics('rmm').feature('wnd1').set('alpha_i', 'init_ang+2*pi*f_el*rm1(t)[s]');
model.physics('rmm').feature('wnd1').set('WindingLayout', 'automatic');
model.physics('rmm').feature('wnd1').set('NoPoles', 'Np');
model.physics('rmm').feature('wnd1').set('NoSlots', 'Ns');
model.physics('rmm').feature('wnd1').set('NoCoilsPerSlot', 2);
model.physics('rmm').feature('wnd1').set('AreaFrom', 'FillingFactor');
model.physics('rmm').feature('wnd1').create('aPh1', 'Phase');
model.physics('rmm').feature('wnd1').feature('aPh1').label('Automatic Phase 1');
model.physics('rmm').feature('wnd1').feature('aPh1').create('rcd1', 'ReversedCurrentDirection', 2);
model.physics('rmm').feature('wnd1').create('aPh2', 'Phase');
model.physics('rmm').feature('wnd1').feature('aPh2').label('Automatic Phase 2');
model.physics('rmm').feature('wnd1').feature('aPh2').create('rcd1', 'ReversedCurrentDirection', 2);
model.physics('rmm').feature('wnd1').create('aPh3', 'Phase');
model.physics('rmm').feature('wnd1').feature('aPh3').label('Automatic Phase 3');
model.physics('rmm').feature('wnd1').feature('aPh3').create('rcd1', 'ReversedCurrentDirection', 2);
model.physics('rmm').feature('wnd1').feature('aPh1').selection.set([22 4 1 25 24 6 3 26]);
model.physics('rmm').feature('wnd1').feature('aPh1').feature('rcd1').selection.set([22 4 1 25]);
model.physics('rmm').feature('wnd1').feature('aPh1').active(true);
model.physics('rmm').feature('wnd1').feature('aPh1').feature('rcd1').active(true);
model.physics('rmm').feature('wnd1').feature('aPh2').selection.set([15 16 18 9 13 14 20 11]);
model.physics('rmm').feature('wnd1').feature('aPh2').feature('rcd1').selection.set([15 16 18 9]);
model.physics('rmm').feature('wnd1').feature('aPh2').active(true);
model.physics('rmm').feature('wnd1').feature('aPh2').feature('rcd1').active(true);
model.physics('rmm').feature('wnd1').feature('aPh3').selection.set([5 21 19 12 7 23 17 10]);
model.physics('rmm').feature('wnd1').feature('aPh3').feature('rcd1').selection.set([5 21 19 12]);
model.physics('rmm').feature('wnd1').feature('aPh3').active(true);
model.physics('rmm').feature('wnd1').feature('aPh3').feature('rcd1').active(true);
model.physics('rmm').feature('wnd1').feature.move('aPh1', 3);
model.physics('rmm').feature('wnd1').feature.move('aPh2', 3);
model.physics('rmm').feature('wnd1').feature.move('aPh3', 3);
model.physics('rmm').feature('wnd1').feature('aPh1').set('alpha_o', '0[deg]');
model.physics('rmm').feature('wnd1').feature('aPh2').set('alpha_o', '-120[deg]');
model.physics('rmm').feature('wnd1').feature('aPh3').set('alpha_o', '-240[deg]');
model.physics('rmm').create('ark1', 'ArkkioTorqueCalculation', 2);
model.physics('rmm').feature('ark1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46]);

model.common('free1').selection.named('uni2');
model.common('rotb1').selection.named('geom1_disksel1');
model.common('rotb1').set('rotationAngle', 'alpha');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', 10);
model.mesh('mesh1').feature('size').set('hmin', 1);
model.mesh('mesh1').feature('size').set('hcurve', 0.5);
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftri1').feature('size1').selection.set([30]);
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 1.3);
model.mesh('mesh1').run;

model.study('std1').create('time', 'Transient');
model.study('std1').feature('time').set('tlist', 'range(0,t_step,t_end)');

model.sol.create('sol1');

model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([30 34 36 37 40 41]);
model.mesh('mesh1').stat.selection.geom(2);
model.mesh('mesh1').stat.selection.set([30 34 36 37 40 41]);

model.sol('sol1').study('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v1').feature('comp1_spatial_disp').set('scaleval', '1e-2*0.39597979746446665');
model.sol('sol1').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.39597979746446665');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('se1', 'Segregated');
model.sol('sol1').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_A'});
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subdtech', 'const');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('se1').feature('ss1').label('Magnetic Potential');
model.sol('sol1').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subdtech', 'const');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol1').feature('s1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subdtech', 'const');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').create('su1', 'StoreSolution');
model.sol('sol1').create('st2', 'StudyStep');
model.sol('sol1').feature('st2').set('study', 'std1');
model.sol('sol1').feature('st2').set('studystep', 'time');
model.sol('sol1').create('v2', 'Variables');
model.sol('sol1').feature('v2').feature('comp1_spatial_disp').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol1').feature('v2').feature('comp1_spatial_disp').set('scaleval', '1e-2*0.39597979746446665');
model.sol('sol1').feature('v2').feature('comp1_u').set('scaleval', '1e-2*0.39597979746446665');
model.sol('sol1').feature('v2').set('initmethod', 'sol');
model.sol('sol1').feature('v2').set('initsol', 'sol1');
model.sol('sol1').feature('v2').set('initsoluse', 'sol2');
model.sol('sol1').feature('v2').set('notsolmethod', 'sol');
model.sol('sol1').feature('v2').set('notsol', 'sol1');
model.sol('sol1').feature('v2').set('notsoluse', 'sol2');
model.sol('sol1').feature('v2').set('control', 'time');
model.sol('sol1').create('t1', 'Time');
model.sol('sol1').feature('t1').set('tlist', 'range(0,t_step,t_end)');
model.sol('sol1').feature('t1').set('plot', 'off');
model.sol('sol1').feature('t1').set('plotgroup', 'Default');
model.sol('sol1').feature('t1').set('plotfreq', 'tout');
model.sol('sol1').feature('t1').set('probesel', 'all');
model.sol('sol1').feature('t1').set('probes', {});
model.sol('sol1').feature('t1').set('probefreq', 'tsteps');
model.sol('sol1').feature('t1').set('tout', 'tstepsclosest');
model.sol('sol1').feature('t1').set('rtol', 0.001);
model.sol('sol1').feature('t1').set('atolglobalvaluemethod', 'factor');
model.sol('sol1').feature('t1').set('eventtol', 0.01);
model.sol('sol1').feature('t1').set('reacf', true);
model.sol('sol1').feature('t1').set('storeudot', true);
model.sol('sol1').feature('t1').set('tstepsbdf', 'strict');
model.sol('sol1').feature('t1').set('endtimeinterpolation', true);
model.sol('sol1').feature('t1').set('estrat', 'exclude');
model.sol('sol1').feature('t1').set('maxorder', 2);
model.sol('sol1').feature('t1').set('minorder', 1);
model.sol('sol1').feature('t1').set('rescaleafterinitbw', false);
model.sol('sol1').feature('t1').set('bwinitstepfrac', '0.001');
model.sol('sol1').feature('t1').set('control', 'time');
model.sol('sol1').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol1').feature('t1').create('seDef', 'Segregated');
model.sol('sol1').feature('t1').create('se1', 'Segregated');
model.sol('sol1').feature('t1').feature('se1').feature.remove('ssDef');
model.sol('sol1').feature('t1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('segvar', {'comp1_A' 'comp1_rmm_cmag1_V_d'});
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').create('d1', 'Direct');
model.sol('sol1').feature('t1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('linsolver', 'd1');
model.sol('sol1').feature('t1').feature('se1').feature('ss1').label('Magnetic Potential');
model.sol('sol1').feature('t1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('segvar', {'comp1_u'});
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss2').label('Displacement Field');
model.sol('sol1').feature('t1').feature('se1').create('ss3', 'SegregatedStep');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('segvar', {'comp1_spatial_disp'});
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subdtech', 'const');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('subjtech', 'onevery');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').set('linsolver', 'dDef');
model.sol('sol1').feature('t1').feature('se1').feature('ss3').label('Spatial Mesh Displacement');
model.sol('sol1').feature('t1').feature.remove('fcDef');
model.sol('sol1').feature('t1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('t1').set('bwinitstepfrac', 0.01);
model.sol('sol1').feature('t1').feature('se1').feature('ss1').set('subdtech', 'auto');
model.sol('sol1').runAll;

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label('Displacement (mbd)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').setIndex('looplevel', 217, 0);
model.result('pg1').set('defaultPlotID', 'displacement');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'SpectrumLight');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label('Velocity (mbd)');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').setIndex('looplevel', 217, 0);
model.result('pg2').set('defaultPlotID', 'velocity');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('expr', 'mod(dom,10)');
model.result('pg2').feature('surf1').set('unit', '1');
model.result('pg2').feature('surf1').set('colortable', 'Cyclic');
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature.create('arwl1', 'ArrowLine');
model.result('pg2').feature('arwl1').label('Arrow Line');
model.result('pg2').feature('arwl1').set('expr', {'mbd.u_tX' 'mbd.u_tY'});
model.result('pg2').feature('arwl1').set('placement', 'elements');
model.result('pg2').feature('arwl1').set('data', 'parent');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').label('Magnetic Flux Density Norm (rmm)');
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').set('data', 'dset1');
model.result('pg3').setIndex('looplevel', 217, 0);
model.result('pg3').set('defaultPlotID', 'InterfaceComponents/PlotDefaults/icom6/pdef1/pcond2/pcond2/pg1');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('solutionparams', 'parent');
model.result('pg3').feature('surf1').set('expr', 'rmm.normB');
model.result('pg3').feature('surf1').set('colortable', 'Prism');
model.result('pg3').feature('surf1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('surf1').set('colorcalibration', -0.8);
model.result('pg3').feature('surf1').set('showsolutionparams', 'on');
model.result('pg3').feature('surf1').set('data', 'parent');
model.result('pg3').feature.create('str1', 'Streamline');
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('solutionparams', 'parent');
model.result('pg3').feature('str1').set('expr', {'rmm.Bx' 'rmm.By'});
model.result('pg3').feature('str1').set('titletype', 'none');
model.result('pg3').feature('str1').set('posmethod', 'uniform');
model.result('pg3').feature('str1').set('udist', 0.03);
model.result('pg3').feature('str1').set('maxlen', 0.4);
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('inheritcolor', false);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('showsolutionparams', 'on');
model.result('pg3').feature('str1').set('maxtime', Inf);
model.result('pg3').feature('str1').set('data', 'parent');
model.result('pg3').feature('str1').selection.geom('geom1', 1);
model.result('pg3').feature('str1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380]);
model.result('pg3').feature('str1').set('inheritplot', 'surf1');
model.result('pg3').feature('str1').feature.create('col1', 'Color');
model.result('pg3').feature('str1').feature('col1').set('expr', 'rmm.normB');
model.result('pg3').feature('str1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('str1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('str1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('str1').feature('col1').set('colorcalibration', -0.8);
model.result('pg3').feature('str1').feature.create('filt1', 'Filter');
model.result('pg3').feature('str1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result('pg3').feature.create('con1', 'Contour');
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('solutionparams', 'parent');
model.result('pg3').feature('con1').set('expr', 'rmm.Az');
model.result('pg3').feature('con1').set('titletype', 'none');
model.result('pg3').feature('con1').set('number', 10);
model.result('pg3').feature('con1').set('levelrounding', false);
model.result('pg3').feature('con1').set('coloring', 'uniform');
model.result('pg3').feature('con1').set('colorlegend', false);
model.result('pg3').feature('con1').set('color', 'custom');
model.result('pg3').feature('con1').set('customcolor', [0.3764705955982208 0.3764705955982208 0.3764705955982208]);
model.result('pg3').feature('con1').set('resolution', 'fine');
model.result('pg3').feature('con1').set('inheritcolor', false);
model.result('pg3').feature('con1').set('showsolutionparams', 'on');
model.result('pg3').feature('con1').set('data', 'parent');
model.result('pg3').feature('con1').set('inheritplot', 'surf1');
model.result('pg3').feature('con1').feature.create('filt1', 'Filter');
model.result('pg3').feature('con1').feature('filt1').set('expr', '!isScalingSystemDomain');
model.result.create('pg4', 'PlotGroup2D');
model.result('pg4').set('data', 'dset1');
model.result('pg4').setIndex('looplevel', 217, 0);
model.result('pg4').label('Moving Mesh');
model.result('pg4').create('mesh1', 'Mesh');
model.result('pg4').feature('mesh1').set('meshdomain', 'surface');
model.result('pg4').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg4').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg4').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg4').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg4').feature('mesh1').feature('sel1').selection.set([29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45]);
model.result('pg4').feature('mesh1').set('qualmeasure', 'custom');
model.result('pg4').feature('mesh1').set('qualexpr', 'comp1.spatial.relVol');
model.result('pg4').feature('mesh1').set('colorrangeunitinterval', false);
model.result('pg1').run;

model.view('view1').set('showgrid', false);

model.result('pg1').run;
model.result('pg1').create('arwl1', 'ArrowLine');
model.result('pg1').feature('arwl1').set('arrowcount', 1500);
model.result('pg1').feature('arwl1').set('scaleactive', true);
model.result('pg1').feature('arwl1').set('scale', 2000);
model.result('pg1').feature('arwl1').set('color', 'blue');
model.result.configuration.create('gsty1', 'GraphStyle');
model.result.configuration('gsty1').set('linewidth', 'unspecified');
model.result.configuration('gsty1').set('linecolor', 'cycle');
model.result.configuration('gsty1').set('autodescr', true);
model.result.configuration('gsty1').set('autosolution', false);
model.result.configuration('gsty1').set('linewidth', 2);
model.result.create('pg5', 'PlotGroup1D');
model.result('pg5').run;
model.result('pg5').label('Displacement');
model.result('pg5').set('titletype', 'none');
model.result('pg5').set('styleconfig', 'gsty1');
model.result('pg5').create('ptgr1', 'PointGraph');
model.result('pg5').feature('ptgr1').set('markerpos', 'datapoints');
model.result('pg5').feature('ptgr1').set('linewidth', 'preference');
model.result('pg5').feature('ptgr1').selection.set([222]);
model.result('pg5').feature('ptgr1').set('expr', 'u');
model.result('pg5').feature('ptgr1').set('legend', true);
model.result('pg5').feature('ptgr1').set('legendmethod', 'manual');
model.result('pg5').feature('ptgr1').setIndex('legends', 'X-component', 0);
model.result('pg5').feature.duplicate('ptgr2', 'ptgr1');
model.result('pg5').run;
model.result('pg5').feature('ptgr2').set('expr', 'v');
model.result('pg5').feature('ptgr2').setIndex('legends', 'Y-component', 0);
model.result('pg5').run;
model.result('pg5').set('twoyaxes', true);
model.result('pg5').setIndex('plotonsecyaxis', true, 1, 1);
model.result('pg5').set('xlabelactive', true);
model.result('pg5').set('ylabelactive', true);
model.result('pg5').set('yseclabelactive', true);
model.result.create('pg6', 'PlotGroup1D');
model.result('pg6').run;
model.result('pg6').label('Torque');
model.result('pg6').set('titletype', 'none');
model.result('pg6').set('styleconfig', 'gsty1');
model.result('pg6').set('showlegends', false);
model.result('pg6').create('glob1', 'Global');
model.result('pg6').feature('glob1').set('markerpos', 'datapoints');
model.result('pg6').feature('glob1').set('linewidth', 'preference');
model.result('pg6').feature('glob1').setIndex('expr', 'rmm.Tark_1', 0);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg6').set('axislimits', true);
model.result('pg6').set('xmin', 0);
model.result('pg6').set('ymin', 0);
model.result('pg6').run;
model.result('pg1').run;

model.nodeGroup.create('grp1', 'Results');
model.nodeGroup('grp1').set('type', 'plotgroup');
model.nodeGroup('grp1').add('plotgroup', 'pg1');
model.nodeGroup('grp1').add('plotgroup', 'pg2');
model.nodeGroup('grp1').add('plotgroup', 'pg5');
model.nodeGroup('grp1').label('Structural Plots');

model.result('pg3').run;

model.nodeGroup.create('grp2', 'Results');
model.nodeGroup('grp2').set('type', 'plotgroup');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('plotgroup', 'pg3');
model.nodeGroup('grp2').add('plotgroup', 'pg6');
model.nodeGroup('grp2').label('Electromagnetic Plots');

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
model.result.export('anim1').label('Displacement (mbd)');
model.result.export('anim1').set('maxframes', 50);
model.result.export.duplicate('anim2', 'anim1');
model.result.export('anim2').showFrame;
model.result.export('anim2').label('Magnetic Flux Density Norm (rmm)');
model.result.export('anim2').set('plotgroup', 'pg3');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 140, 0);
model.result('pg1').run;

model.title(['Magnetic' native2unicode(hex2dec({'20' '13'}), 'unicode') 'Structure Interaction in a Permanent Magnet Motor']);

model.description('In this example, the coupling between Multibody Dynamics and Rotating Machinery, Magnetic for performing electromagnetic and mechanical analysis is demonstrated. A permanent magnet motor with 10 rotor poles and 12 stator slots is modeled in 2D. The magnets are attached to the circumference of the rotor. To model magnetic-structure coupling integrated with moving mesh, the electromagnetic force is transferred to the rotor, and the rotor motion is transferred to the moving mesh. A time-dependent problem, computing the magnetic flux density and displacement, is solved for three complete electrical periods.');

model.mesh.clearMeshes;

model.sol('sol1').clearSolutionData;
model.sol('sol2').clearSolutionData;

model.label('pm_motor_2d_structure_interaction.mph');

model.modelNode.label('Components');

out = model;
