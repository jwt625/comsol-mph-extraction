function out = model
%
% hook_optimization_stl_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Topology_Optimization');

model.param.set('r1', '7.5[mm]');
model.param.descr('r1', 'Hole radius');
model.param.set('r2', '20[mm]');
model.param.descr('r2', 'Max upper radius');
model.param.set('r3', '50[mm]');
model.param.descr('r3', 'Max lower radius');
model.param.set('r4', '25[mm]');
model.param.descr('r4', 'Min lower radius');
model.param.set('Lc', '90[mm]');
model.param.descr('Lc', 'Hole to hook center distance');
model.param.set('w1', '2.5[mm]');
model.param.descr('w1', 'Width of load surface');
model.param.set('w2', '12.5[mm]');
model.param.descr('w2', 'Total width');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('size', '2*r1');
model.geom('geom1').feature('wp1').geom.feature('sq1').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('sq1');
model.geom('geom1').feature('wp1').geom.create('sq2', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('size', '2*r2');
model.geom('geom1').feature('wp1').geom.feature('sq2').set('base', 'center');
model.geom('geom1').feature('wp1').geom.run('sq2');
model.geom('geom1').feature('wp1').geom.create('sq3', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq3').set('size', '2*r3');
model.geom('geom1').feature('wp1').geom.feature('sq3').set('pos', {'-r3' '-r3-Lc'});
model.geom('geom1').feature('wp1').geom.run('sq3');
model.geom('geom1').feature('wp1').geom.create('sq4', 'Square');
model.geom('geom1').feature('wp1').geom.feature('sq4').set('size', '2*r4');
model.geom('geom1').feature('wp1').geom.feature('sq4').set('pos', {'-r4' '-r4-Lc'});
model.geom('geom1').feature('wp1').geom.run('sq4');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'r3-r4' 'r3'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-r3' '-Lc+(r3-r4)/2'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'sq2' 'sq3'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r1' 'sq1' 'sq4'});
model.geom('geom1').feature('wp1').geom.run('dif1');
model.geom('geom1').feature('wp1').geom.create('pard1', 'PartitionDomains');
model.geom('geom1').feature('wp1').geom.feature('pard1').selection('domain').set('dif1', 1);
model.geom('geom1').feature('wp1').geom.feature('pard1').selection('vertexsegment').set('dif1', [16 18]);
model.geom('geom1').feature('wp1').geom.run('pard1');
model.geom('geom1').feature('wp1').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('pard1', 2);
model.geom('geom1').feature('wp1').geom.run('del1');
model.geom('geom1').feature('wp1').geom.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('del1', [7 8 9 10]);
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'r1');
model.geom('geom1').feature('wp1').geom.run('fil1');
model.geom('geom1').feature('wp1').geom.create('fil2', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1', [2 4]);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '(r3-r4)/2');
model.geom('geom1').feature('wp1').geom.run('fil2');
model.geom('geom1').feature('wp1').geom.create('fil3', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil3').selection('point').set('fil2', [4 14]);
model.geom('geom1').feature('wp1').geom.feature('fil3').set('radius', 'r4');
model.geom('geom1').feature('wp1').geom.run('fil3');
model.geom('geom1').feature('wp1').geom.create('fil4', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil4').selection('point').set('fil3', [6 13]);
model.geom('geom1').feature('wp1').geom.feature('fil4').set('radius', 'r2');
model.geom('geom1').feature('wp1').geom.run('fil4');
model.geom('geom1').feature('wp1').geom.create('fil5', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil5').selection('point').set('fil4', [1 17]);
model.geom('geom1').feature('wp1').geom.feature('fil5').set('radius', 'r3');
model.geom('geom1').feature('wp1').geom.run('fil5');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex1').set('fil5', 4);
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('fil5', 16);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex1').set('fil5', 13);
model.geom('geom1').feature('wp1').geom.feature('ls2').selection('vertex2').set('fil5', 18);
model.geom('geom1').feature('wp1').geom.run('ls2');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'fil5' 'ls1' 'ls2'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').feature('wp1').geom.create('del2', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del2').selection('input').init(2);
model.geom('geom1').feature('wp1').geom.feature('del2').selection('input').set('csol1', 4);
model.geom('geom1').feature('wp1').geom.run('del2');
model.geom('geom1').feature('wp1').geom.create('del3', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del3').selection('input').set('del2', [2 7]);
model.geom('geom1').feature('wp1').geom.run('del3');
model.geom('geom1').feature('wp1').geom.create('fil6', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil6').selection('point').set('del3', [4 13]);
model.geom('geom1').feature('wp1').geom.feature('fil6').set('radius', 'r2');
model.geom('geom1').feature('wp1').geom.run('fil6');
model.geom('geom1').feature('wp1').geom.create('fil7', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil7').selection('point').set('fil6', 17);
model.geom('geom1').feature('wp1').geom.feature('fil7').set('radius', 'r3');
model.geom('geom1').feature('wp1').geom.run('fil7');
model.geom('geom1').feature('wp1').geom.create('fil8', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature('fil8').selection('point').set('fil7', 21);
model.geom('geom1').feature('wp1').geom.feature('fil8').set('radius', 'r4+2*r1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', 'w1', 0);
model.geom('geom1').feature('ext1').setIndex('distance', 'w2', 1);
model.geom('geom1').feature('ext1').set('displ', {'0' '0'; '0' '0'});
model.geom('geom1').feature('ext1').set('scale', {'1' '1'; '1' '1'});
model.geom('geom1').feature('ext1').set('twist', {'0' '0'});
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', '2*r1');
model.geom('geom1').feature('cyl1').set('h', 'w2');
model.geom('geom1').feature('cyl1').set('selresult', true);
model.geom('geom1').run('cyl1');
model.geom('geom1').create('unisel1', 'UnionSelection');
model.geom('geom1').feature('unisel1').label('Hook and Fixed Domain');
model.geom('geom1').feature('unisel1').set('entitydim', -1);
model.geom('geom1').feature('unisel1').set('input', {'ext1' 'cyl1'});
model.geom('geom1').run('unisel1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').named('ext1');
model.geom('geom1').feature('par1').selection('tool').named('cyl1');
model.geom('geom1').run('par1');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').label('Symmetry');
model.geom('geom1').feature('boxsel1').set('entitydim', 2);
model.geom('geom1').feature('boxsel1').set('zmax', '1e3*eps');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').label('Internal Boundary to Delete');
model.geom('geom1').feature('boxsel2').set('entitydim', 2);
model.geom('geom1').feature('boxsel2').set('zmin', 'w1*0.99');
model.geom('geom1').feature('boxsel2').set('zmax', 'w1*1.01');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').named('boxsel2');
model.geom('geom1').run('del1');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').label('Hole');
model.geom('geom1').feature('cylsel1').set('entitydim', 2);
model.geom('geom1').feature('cylsel1').set('r', 'r1*1.005');
model.geom('geom1').feature('cylsel1').set('condition', 'inside');

model.selection.create('cyl1', 'Cylinder');
model.selection('cyl1').model('comp1');

model.geom('geom1').run;
model.geom('geom1').create('cylsel2', 'CylinderSelection');
model.geom('geom1').feature('cylsel2').label('1st Load Boundary');
model.geom('geom1').feature('cylsel2').set('entitydim', 2);
model.geom('geom1').feature('cylsel2').set('r', 'r4*1.001');
model.geom('geom1').feature('cylsel2').set('top', 'w1*1.001');
model.geom('geom1').feature('cylsel2').set('pos', {'0' '-Lc' '0'});
model.geom('geom1').feature('cylsel2').set('condition', 'inside');
model.geom('geom1').run('cylsel2');
model.geom('geom1').create('cylsel3', 'CylinderSelection');
model.geom('geom1').feature('cylsel3').label('2nd Load Boundary');
model.geom('geom1').feature('cylsel3').set('entitydim', 2);
model.geom('geom1').feature('cylsel3').set('r', '(r3-r4)/2*1.001');
model.geom('geom1').feature('cylsel3').set('top', 'w1*1.001');
model.geom('geom1').feature('cylsel3').set('angle2', 90);
model.geom('geom1').feature('cylsel3').set('pos', {'-(r3+r4)/2' '0' '0'});
model.geom('geom1').feature('cylsel3').setIndex('pos', '-Lc', 1);
model.geom('geom1').feature('cylsel3').set('condition', 'inside');
model.geom('geom1').run('cylsel3');
model.geom('geom1').create('cylsel4', 'CylinderSelection');
model.geom('geom1').feature('cylsel4').label('Fixed Domain');
model.geom('geom1').feature('cylsel4').set('r', 'r1*1.001');
model.geom('geom1').run('cylsel4');
model.geom('geom1').create('adjsel1', 'AdjacentSelection');
model.geom('geom1').create('unisel2', 'UnionSelection');
model.geom('geom1').feature('unisel2').label('Load Boundaries');
model.geom('geom1').feature('unisel2').set('entitydim', 2);
model.geom('geom1').feature('unisel2').set('input', {'cylsel2' 'cylsel3'});
model.geom('geom1').feature('adjsel1').set('outputdim', 3);
model.geom('geom1').feature('adjsel1').label('Optimized Domains');
model.geom('geom1').feature('adjsel1').set('input', {'cylsel4'});
model.geom('geom1').run('unisel2');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').label('Free Boundaries');
model.geom('geom1').feature('comsel1').set('entitydim', 2);
model.geom('geom1').feature('comsel1').set('input', {'boxsel1' 'unisel2'});
model.geom('geom1').run('fin');

model.title([]);

model.description('');

model.label('hook_optimization_stl_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
