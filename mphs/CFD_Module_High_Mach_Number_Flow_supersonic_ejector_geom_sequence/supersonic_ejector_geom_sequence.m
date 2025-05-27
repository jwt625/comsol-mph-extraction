function out = model
%
% supersonic_ejector_geom_sequence.m
%
% Model exported on May 26 2025, 21:26 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/CFD_Module/High_Mach_Number_Flow');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 2);
model.geom('geom1').model('comp1');
model.geom('geom1').axisymmetric(true);

model.mesh.create('mesh1', 'geom1');

model.param.set('d_throat', '8[mm]');
model.param.descr('d_throat', 'Diameter of the throat');
model.param.set('d_secondary', '160[mm]');
model.param.descr('d_secondary', 'Diameter of the secondary inlet');
model.param.set('d_primary', '16[mm]');
model.param.descr('d_primary', 'Diameter of the primary inlet');
model.param.set('d_divergent', '12[mm]');
model.param.descr('d_divergent', 'Diameter of the divergent section of the nozzle');
model.param.set('d_diffuser', '51[mm]');
model.param.descr('d_diffuser', 'Diameter of the diffuser');
model.param.set('d_mixing', '24[mm]');
model.param.descr('d_mixing', 'Diameter of the mixing chamber');
model.param.set('L_mixing', '240[mm]');
model.param.descr('L_mixing', 'Length of the mixing chamber');
model.param.set('L_diffuser', '70[mm]');
model.param.descr('L_diffuser', 'Length of the diffuser');
model.param.set('NXP', '15[mm]');
model.param.descr('NXP', 'Distance between the outlet of the nozzle and the inlet of the mixing chamber');
model.param.set('L_convergent', '7[mm]');
model.param.descr('L_convergent', 'Length of the convergent section of the nozzle');
model.param.set('L_secondary', '90[mm]');
model.param.descr('L_secondary', 'Length of the secondary nozzle');
model.param.set('L_divergent', '23[mm]');
model.param.descr('L_divergent', 'Length of the divergent section of the nozzle');
model.param.set('L_in', '15[mm]');
model.param.descr('L_in', 'Length at the inlet');
model.param.set('L_out', 'L_in');
model.param.descr('L_out', 'Length at the outlet');
model.param.set('thickness', '0.8[mm]');
model.param.descr('thickness', 'Maximum thickness of the nozzle''s walls');

model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'table');
model.geom('geom1').feature('pol1').label('Wall');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', 'd_primary/2, d_primary/2, d_primary/2, d_throat/2, d_throat/2, d_divergent/2, d_divergent/2, d_throat/2+thickness, d_throat/2+thickness, d_primary/2+thickness, d_primary/2+thickness, d_primary/2+thickness, d_primary/2+thickness, d_primary/2');
model.geom('geom1').feature('pol1').set('y', '-L_in-L_secondary, -NXP-L_divergent-L_convergent, -NXP-L_divergent-L_convergent, -L_divergent-NXP, -L_divergent-NXP, -NXP, -NXP, -NXP-L_divergent, -NXP-L_divergent, -NXP-L_divergent-L_convergent, -NXP-L_divergent-L_convergent, -L_in-L_secondary, -L_in-L_secondary, -L_in-L_secondary');
model.geom('geom1').run('pol1');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'table');
model.geom('geom1').feature('pol2').label('Ejector');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', '0 0 0 d_diffuser/2 d_diffuser/2 d_diffuser/2 d_diffuser/2 d_mixing/2 d_mixing/2 d_mixing/2 d_mixing/2 d_secondary/2 d_secondary/2 d_secondary/2 d_secondary/2 0');
model.geom('geom1').feature('pol2').set('y', '-L_in-L_secondary L_mixing+L_diffuser+L_out L_mixing+L_diffuser+L_out L_mixing+L_diffuser+L_out L_mixing+L_diffuser+L_out L_mixing+L_diffuser L_mixing+L_diffuser L_mixing L_mixing 0 0 -L_secondary -L_secondary -L_secondary-L_in -L_secondary-L_in -L_secondary-L_in');
model.geom('geom1').run('pol2');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'pol2'});
model.geom('geom1').feature('dif1').selection('input2').set({'pol1'});
model.geom('geom1').run('dif1');
model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'d_primary/2' '1'});
model.geom('geom1').feature('r1').setIndex('size', 'L_secondary-NXP-L_divergent-L_convergent', 1);
model.geom('geom1').feature('r1').set('pos', {'0' '-L_secondary-L_in'});
model.geom('geom1').run('r1');
model.geom('geom1').create('dif2', 'Difference');
model.geom('geom1').feature('dif2').selection('input').set({'dif1'});
model.geom('geom1').feature('dif2').selection('input2').set({'r1'});
model.geom('geom1').run('dif2');
model.geom('geom1').create('ls1', 'LineSegment');
model.geom('geom1').feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('ls1').set('coord1', {'0' '-NXP-L_divergent-L_convergent'});
model.geom('geom1').feature('ls1').set('coord2', {'d_primary/2' '0'});
model.geom('geom1').feature('ls1').setIndex('coord2', '-NXP-L_divergent-L_convergent', 1);
model.geom('geom1').run('ls1');
model.geom('geom1').create('ls2', 'LineSegment');
model.geom('geom1').feature('ls2').set('specify1', 'coord');
model.geom('geom1').feature('ls2').set('specify2', 'coord');
model.geom('geom1').feature('ls2').set('coord1', {'d_divergent/2' '0'});
model.geom('geom1').feature('ls2').setIndex('coord1', '-NXP', 1);
model.geom('geom1').feature('ls2').set('coord2', {'d_divergent/2' '0'});
model.geom('geom1').run('ls2');
model.geom('geom1').create('ls3', 'LineSegment');
model.geom('geom1').feature('ls3').set('specify1', 'coord');
model.geom('geom1').feature('ls3').set('specify2', 'coord');
model.geom('geom1').feature('ls3').set('coord2', {'d_mixing/2' '0'});
model.geom('geom1').run('fin');
model.geom('geom1').create('mce1', 'MeshControlEdges');
model.geom('geom1').feature('mce1').selection('input').set('fin', [4 6 12 13]);
model.geom('geom1').run('mce1');
model.geom('geom1').create('sel1', 'ExplicitSelection');
model.geom('geom1').feature('sel1').label('Walls');
model.geom('geom1').feature('sel1').selection('selection').init(1);
model.geom('geom1').feature('sel1').selection('selection').set('mce1', [4 5 6 7 8 9 11 12 13 14 15]);
model.geom('geom1').run('sel1');
model.geom('geom1').create('sel2', 'ExplicitSelection');
model.geom('geom1').feature('sel2').label('Primary inlet');
model.geom('geom1').feature('sel2').selection('selection').init(1);
model.geom('geom1').feature('sel2').selection('selection').set('mce1', 2);
model.geom('geom1').run('sel2');
model.geom('geom1').create('sel3', 'ExplicitSelection');
model.geom('geom1').feature('sel3').label('Secondary inlet');
model.geom('geom1').feature('sel3').selection('selection').init(1);
model.geom('geom1').feature('sel3').selection('selection').set('mce1', 10);
model.geom('geom1').run('sel3');
model.geom('geom1').create('sel4', 'ExplicitSelection');
model.geom('geom1').feature('sel4').label('Outlet');
model.geom('geom1').feature('sel4').selection('selection').init(1);
model.geom('geom1').feature('sel4').selection('selection').set('mce1', 3);
model.geom('geom1').run('sel4');

model.title([]);

model.description('');

model.label('supersonic_ejector_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
