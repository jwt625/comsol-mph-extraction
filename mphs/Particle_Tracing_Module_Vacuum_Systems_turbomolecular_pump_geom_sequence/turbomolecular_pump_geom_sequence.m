function out = model
%
% turbomolecular_pump_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Particle_Tracing_Module/Vacuum_Systems');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Nb', '36', 'Number of blades');
model.param.set('psi', '2*pi[rad]/Nb', 'Sector angle');
model.param.set('rtip', '100[mm]', 'Tip radius');
model.param.set('rroot', '0.8*rtip', 'Root radius');
model.param.set('rrms', 'sqrt((rroot^2+rtip^2)/2)', 'Root mean square radius');
model.param.set('S', '2*rrms*sin(psi/2)', 'Blade spacing at rms radius');
model.param.set('B', 'S', 'Blade length, S0=S/B=1');
model.param.set('alpha', '30[deg]', 'Blade angle');
model.param.set('rh', 'B*sin(alpha)', 'Row height');
model.param.set('wp11x', 'rroot', 'Work plane 1, point 1, x-coordinate');
model.param.set('wp11y', '0', 'Work plane 1, point 1, y-coordinate');
model.param.set('wp11z', '0', 'Work plane 1, point 1, z-coordinate');
model.param.set('wp12x', 'rtip', 'Work plane 1, point 2, x-coordinate');
model.param.set('wp12y', '0', 'Work plane 1, point 2, y-coordinate');
model.param.set('wp12z', '0', 'Work plane 1, point 2, z-coordinate');
model.param.set('wp13x', 'rroot', 'Work plane 1, point 3, x-coordinate');
model.param.set('wp13y', '1[cm]', 'Work plane 1, point 3, y-coordinate');
model.param.set('wp13z', '1[cm]*tan(alpha)', 'Work plane 1, point 3, z-coordinate');
model.param.set('wp21x', 'wp11x*cos(psi)-wp11y*sin(psi)', 'Work plane 2, point 1, x-coordinate');
model.param.set('wp21y', 'wp11x*sin(psi)+wp11y*cos(psi)', 'Work plane 2, point 1, y-coordinate');
model.param.set('wp21z', 'wp11z', 'Work plane 2, point 1, z-coordinate');
model.param.set('wp22x', 'wp12x*cos(psi)-wp12y*sin(psi)', 'Work plane 2, point 2, x-coordinate');
model.param.set('wp22y', 'wp12x*sin(psi)+wp12y*cos(psi)', 'Work plane 2, point 2, y-coordinate');
model.param.set('wp22z', 'wp12z', 'Work plane 2, point 2, z-coordinate');
model.param.set('wp23x', 'wp13x*cos(psi)-wp13y*sin(psi)', 'Work plane 2, point 3, x-coordinate');
model.param.set('wp23y', 'wp13x*sin(psi)+wp13y*cos(psi)', 'Work plane 2, point 3, y-coordinate');
model.param.set('wp23z', 'wp13z', 'Work plane 2, point 3, z-coordinate');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'rtip');
model.geom('geom1').feature('cyl1').set('h', 'rh');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-rh/2'});
model.geom('geom1').feature('cyl1').set('rot', 30);
model.geom('geom1').feature.duplicate('cyl2', 'cyl1');
model.geom('geom1').feature('cyl2').set('r', 'rroot');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'cyl1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl2'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'coordinates');
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp11x', 0, 0);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp11y', 0, 1);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp11z', 0, 2);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp12x', 1, 0);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp12y', 1, 1);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp12z', 1, 2);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp13x', 2, 0);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp13y', 2, 1);
model.geom('geom1').feature('wp1').setIndex('genpoints', 'wp13z', 2, 2);
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('planetype', 'coordinates');
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp21x', 0, 0);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp21y', 0, 1);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp21z', 0, 2);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp22x', 1, 0);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp22y', 1, 1);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp22z', 1, 2);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp23x', 2, 0);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp23y', 2, 1);
model.geom('geom1').feature('wp2').setIndex('genpoints', 'wp23z', 2, 2);
model.geom('geom1').run('wp2');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').set({'dif1'});
model.geom('geom1').feature('par1').set('partitionwith', 'workplane');
model.geom('geom1').feature('par1').set('workplane', 'wp1');
model.geom('geom1').run('par1');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').set({'par1'});
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').run('par2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').set('par2', 7);
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').set('par2', [1 2 3]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Inlet Boundary');
model.geom('geom1').feature('sel1').selection('selection').init(2);
model.geom('geom1').feature('sel1').selection('selection').set('del1', 3);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Outlet Boundary');
model.geom('geom1').feature('sel2').selection('selection').init(2);
model.geom('geom1').feature('sel2').selection('selection').set('del1', 4);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Root Wall');
model.geom('geom1').feature('sel3').selection('selection').init(2);
model.geom('geom1').feature('sel3').selection('selection').set('del1', 1);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Tip Wall');
model.geom('geom1').feature('sel4').selection('selection').init(2);
model.geom('geom1').feature('sel4').selection('selection').set('del1', 6);
model.geom('geom1').run('sel4');
model.geom('geom1').create('sel5', 'ExplicitSelection');
model.geom('geom1').feature('sel5').label('Blade Surfaces');
model.geom('geom1').feature('sel5').selection('selection').init(2);
model.geom('geom1').feature('sel5').selection('selection').set('del1', [2 5]);
model.geom('geom1').run('sel5');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('All Moving Walls');
model.geom('geom1').feature('unisel1').set('entitydim', 2);
model.geom('geom1').feature('unisel1').set('input', {'sel3' 'sel5'});

model.title([]);

model.description('');

model.label('turbomolecular_pump_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
