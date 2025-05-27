function out = model
%
% surface_cracked_cylinder_geom_sequence.m
%
% Model exported on May 26 2025, 21:33 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Fracture_Mechanics');

model.param.set('R1', '1[m]');
model.param.descr('R1', 'Inner radius');
model.param.set('R2', '1.1[m]');
model.param.descr('R2', 'Outer radius');
model.param.set('th', 'R2-R1');
model.param.descr('th', 'Thickness');
model.param.set('L', '5[m]');
model.param.descr('L', 'Cylinder length');
model.param.set('a', 'th*0.5');
model.param.descr('a', 'Crack ellipse small axis');
model.param.set('c', 'a/0.4');
model.param.descr('c', 'Crack ellipse long axis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'R2');
model.geom('geom1').feature('cyl1').set('h', 'L/2');
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('cyl1').setIndex('layer', 'th', 0);
model.geom('geom1').feature('cyl1').set('selresult', true);
model.geom('geom1').feature('cyl1').set('selresultshow', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cylsel1', 'CylinderSelection');
model.geom('geom1').feature('cylsel1').set('top', 'L/2');
model.geom('geom1').feature('cylsel1').set('bottom', 0);
model.geom('geom1').feature('cylsel1').set('axistype', 'x');
model.geom('geom1').run('cylsel1');
model.geom('geom1').create('del1', 'Delete');
model.geom('geom1').feature('del1').selection('input').init(3);
model.geom('geom1').feature('del1').selection('input').named('cylsel1');
model.geom('geom1').run('del1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').set('selresult', true);
model.geom('geom1').feature('wp1').set('selresultshow', false);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Union');
model.geom('geom1').feature('wp1').set('contributeto', 'csel1');
model.geom('geom1').feature('wp1').geom.create('e1', 'Ellipse');
model.geom('geom1').feature('wp1').geom.feature('e1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('e1').set('semiaxes', {'c' 'a'});
model.geom('geom1').feature('wp1').geom.feature('e1').set('angle', 90);
model.geom('geom1').feature('wp1').geom.feature('e1').set('pos', {'0' 'R1'});
model.geom('geom1').feature('wp1').geom.run('e1');
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'c', 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'R1', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'c', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol1').setIndex('table', 'R1-c', 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 0, 0, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'R1+a', 0, 1);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', '-a', 1, 0);
model.geom('geom1').feature('wp1').geom.feature('pol2').setIndex('table', 'R1+a', 1, 1);
model.geom('geom1').feature('wp1').geom.run('pol2');
model.geom('geom1').feature('wp1').geom.feature.create('del1', 'Delete');
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init;
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').init(1);
model.geom('geom1').feature('wp1').geom.feature('del1').selection('input').set('e1', [2 3]);
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'zy');
model.geom('geom1').feature('wp2').set('quickx', '-a');
model.geom('geom1').feature('wp2').set('selresult', true);
model.geom('geom1').feature('wp2').set('selresultshow', false);
model.geom('geom1').feature('wp2').set('contributeto', 'csel1');
model.geom('geom1').feature('wp2').set('quickorigin', 'vertexproj');
model.geom('geom1').feature('wp2').selection('originvertex').set('wp1', 2);
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'a*0.3');
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').feature('wp2').geom.create('pard1', 'PartitionDomains');
model.geom('geom1').feature('wp2').geom.feature('pard1').selection('domain').set('c1', 1);
model.geom('geom1').feature('wp2').geom.feature('pard1').selection('vertexsegment').set('c1', [1 3]);
model.geom('geom1').feature('wp2').geom.run('pard1');
model.geom('geom1').run('wp2');
model.geom('geom1').create('swe1', 'Sweep');
model.geom('geom1').feature('swe1').set('includefinal', false);
model.geom('geom1').feature('swe1').set('crossfaces', true);
model.geom('geom1').feature('swe1').set('manualdir', false);
model.geom('geom1').feature('swe1').selection('enttosweep').set('wp2', [1 2]);
model.geom('geom1').feature('swe1').set('crossfaces', false);
model.geom('geom1').feature('swe1').selection('edge').named('wp1');
model.geom('geom1').feature('swe1').set('manualdir', true);
model.geom('geom1').feature('swe1').set('reversedir', true);
model.geom('geom1').feature('swe1').set('spineperpstart', true);

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('swe1').selection('diredge').set('wp1', [3]);
model.geom('geom1').feature('swe1').set('selresult', true);
model.geom('geom1').feature('swe1').set('selresultshow', false);
model.geom('geom1').feature('swe1').set('contributeto', 'csel1');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('uni1', 'Union');
model.geom('geom1').feature('uni1').selection('input').named('csel1');
model.geom('geom1').run('uni1');
model.geom('geom1').create('par1', 'Partition');
model.geom('geom1').feature('par1').selection('input').named('cyl1');
model.geom('geom1').feature('par1').selection('tool').named('swe1');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('boxsel1', 'BoxSelection');
model.geom('geom1').feature('boxsel1').set('ymin', '-a*0.2');
model.geom('geom1').feature('boxsel1').set('condition', 'inside');
model.geom('geom1').run('boxsel1');
model.geom('geom1').create('comsel1', 'ComplementSelection');
model.geom('geom1').feature('comsel1').set('input', {'boxsel1'});
model.geom('geom1').run('comsel1');
model.geom('geom1').create('del2', 'Delete');
model.geom('geom1').feature('del2').selection('input').init(3);
model.geom('geom1').feature('del2').selection('input').named('comsel1');
model.geom('geom1').run('del2');
model.geom('geom1').create('boxsel2', 'BoxSelection');
model.geom('geom1').feature('boxsel2').set('inputent', 'selections');
model.geom('geom1').feature('boxsel2').set('input', {'swe1'});
model.geom('geom1').feature('boxsel2').set('xmin', '-th');
model.geom('geom1').feature('boxsel2').set('xmax', 'th');
model.geom('geom1').feature('boxsel2').set('ymin', 0);
model.geom('geom1').feature('boxsel2').set('ymax', 'R2*tan(10[deg])');
model.geom('geom1').feature('boxsel2').set('zmin', 'R2-th');
model.geom('geom1').feature('boxsel2').set('zmax', 'R2');
model.geom('geom1').feature('boxsel2').set('condition', 'inside');
model.geom('geom1').run('boxsel2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').set('quickplane', 'yz');
model.geom('geom1').feature('wp3').set('quickx', 0.3);
model.geom('geom1').run('wp3');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').set('planetype', 'transformed');
model.geom('geom1').feature('wp4').set('workplane', 'wp1');
model.geom('geom1').feature('wp4').set('transaxistype', 'x');
model.geom('geom1').feature('wp4').set('transrot', -10);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('par2', 'Partition');
model.geom('geom1').feature('par2').selection('input').named('cyl1');
model.geom('geom1').feature('par2').set('partitionwith', 'workplane');
model.geom('geom1').feature('par2').set('workplane', 'wp3');
model.geom('geom1').run('par2');
model.geom('geom1').create('par3', 'Partition');
model.geom('geom1').feature('par3').selection('input').named('cyl1');
model.geom('geom1').feature('par3').set('partitionwith', 'workplane');
model.geom('geom1').run('fin');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').named('swe1');
model.geom('geom1').run('cmd1');
model.geom('geom1').run('fin');
model.geom('geom1').run('fin');
model.geom('geom1').run('cmd1');

model.title([]);

model.description('');

model.label('surface_cracked_cylinder_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
