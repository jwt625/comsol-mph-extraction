function out = model
%
% flow_meter_piezoelectric_transducers_geom_sequence.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Acoustics_Module/Ultrasound');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('D', '5[mm]', 'Main duct diameter');
model.param.set('L', '4*D', 'Main duct length');
model.param.set('alpha', '45[deg]', 'Transducer tube pitch angle');
model.param.set('D_transducer', '2[mm]', 'Transducer diameter');
model.param.set('L_transducer', 'D/cos(alpha)+3/2*D_transducer/cos(alpha)*tan(alpha)', 'Transducer duct length');
model.param.set('L2', 'D/sin(alpha)', 'Transducer duct length in main flow');
model.param.set('L1', '0.5*(L_transducer-L2)', 'Transducer duct length of side branches');
model.param.set('L_matching', 'cp_match/f0/4', 'Matching layer thickness');
model.param.set('L_piezo', 'cp_pzt/f0/2', 'Piezoelectric transducer thickness');
model.param.set('nLx', 'cos(alpha)', 'Unit vector in transducer duct direction (x-component)');
model.param.set('nLy', '0', 'Unit vector in transducer duct direction (y-component)');
model.param.set('nLz', 'sin(alpha)', 'Unit vector in transducer duct direction (z-component)');
model.param.label('Geometry Parameters');
model.param.create('par2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('Uin', '10[m/s]', 'Background mean flow average velocity at the inlet');
model.param('par2').set('V0', '50[V]', 'Driving voltage');
model.param('par2').set('f0', '2.5[MHz]', 'Carrier signal center frequency');
model.param('par2').set('T0', '1/f0', 'Carrier signal period');
model.param('par2').set('lam0', 'cp_water/f0', 'Signal wavelength in water');
model.param('par2').set('cp_water', '1481[m/s]', 'Speed of sound, water');
model.param('par2').set('cp_pzt', '4620[m/s]', 'Pressure wave speed, PZT');
model.param('par2').set('cs_pzt', '1750[m/s]', 'Shear wave speed, PZT');
model.param('par2').set('cp_match', '3400[m/s]', 'Pressure wave speed, matching material');
model.param('par2').set('cs_match', '1920[m/s]', 'Shear wave speed, matching material');
model.param('par2').set('rho_match', '2280[kg/m^3]', 'Density, matching material');
model.param('par2').set('cp_damp', '1500[m/s]', 'Pressure wave speed, damping material');
model.param('par2').set('cs_damp', '775[m/s]', 'Shear wave speed, damping material');
model.param('par2').set('rho_damp', '6580[kg/m^3]', 'Density, damping material');
model.param('par2').label('Model Parameters');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').set('r', 'D/2');
model.geom('geom1').feature('cyl1').set('h', 'L');
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', '0.5*D', 0);
model.geom('geom1').feature('cyl1').set('layerside', false);
model.geom('geom1').feature('cyl1').set('layerbottom', true);
model.geom('geom1').feature('cyl1').set('layertop', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').feature('cyl2').set('r', 'D_transducer/2');
model.geom('geom1').feature('cyl2').set('h', 'L_transducer');
model.geom('geom1').feature('cyl2').set('pos', {'L/2' '0' '-L_transducer/2'});
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').feature('cyl3').set('r', 'D_transducer/2');
model.geom('geom1').feature('cyl3').set('h', 'L_matching');
model.geom('geom1').feature('cyl3').set('pos', {'L/2' '0' 'L_transducer/2'});
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').feature('cyl4').set('r', 'D_transducer/4');
model.geom('geom1').feature('cyl4').set('h', 'L_piezo');
model.geom('geom1').feature('cyl4').set('pos', {'L/2' '0' 'L_transducer/2+L_matching'});
model.geom('geom1').run('cyl4');
model.geom('geom1').create('cyl5', 'Cylinder');
model.geom('geom1').feature('cyl5').set('r', 'D_transducer/2');
model.geom('geom1').feature('cyl5').set('h', '2*L_piezo');
model.geom('geom1').feature('cyl5').set('pos', {'L/2' '0' 'L_transducer/2+L_matching'});
model.geom('geom1').run('cyl5');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl5'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl4'});
model.geom('geom1').feature('dif1').set('keepsubtract', true);
model.geom('geom1').run('dif1');
model.geom('geom1').create('copy1', 'Copy');
model.geom('geom1').feature('copy1').selection('input').set({'cyl3' 'cyl4' 'dif1'});
model.geom('geom1').feature('copy1').set('displz', '-L_transducer');
model.geom('geom1').run('copy1');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'copy1'});
model.geom('geom1').feature('mir1').set('pos', {'0' '0' '-L_transducer/2'});
model.geom('geom1').run('mir1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'cyl2' 'cyl3' 'cyl4' 'dif1' 'mir1'});
model.geom('geom1').feature('rot1').set('axistype', 'y');
model.geom('geom1').feature('rot1').set('rot', 'alpha');
model.geom('geom1').feature('rot1').set('pos', {'L/2' '0' '0'});
model.geom('geom1').run('rot1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').run('wp1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'cyl1' 'rot1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').run('par1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set({'par1(1)' 'par1(2)' 'par1(3)' 'par1(4)' 'par1(5)' 'par1(6)' 'par1(7)' 'par1(8)'}, [1 3 5; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0]);
model.geom('geom1').run('del1');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').set({'del1(1)' 'del1(2)'});
model.geom('geom1').run('uni1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').set('uni1', [13 14 16 19]);
model.geom('geom1').feature('fin').set('action', 'assembly');
model.geom('geom1').feature('fin').set('imprint', true);
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [19 20 23 27]);
model.geom('geom1').run('ige1');

model.title([]);

model.description('');

model.label('flow_meter_piezoelectric_transducers_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
