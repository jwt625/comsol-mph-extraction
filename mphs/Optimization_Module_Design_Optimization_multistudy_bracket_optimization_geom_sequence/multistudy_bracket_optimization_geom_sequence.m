function out = model
%
% multistudy_bracket_optimization_geom_sequence.m
%
% Model exported on May 26 2025, 21:31 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Optimization_Module/Design_Optimization');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('thk', '4[mm]', 'Plate thickness');
model.param.set('lX', '65[mm]', 'Bracket length');
model.param.set('lZ', '70[mm]', 'Bracket height');
model.param.set('dCmp', '40[mm]', 'Diameter of component');
model.param.set('bDia', '8[mm]', 'Diameter of mounting bolts');
model.param.set('lY', 'dCmp+4*bDia', 'Bracket width');
model.param.set('rIn', '2*thk', 'Inner radius of bend');
model.param.set('rOut', 'rIn+thk', 'Outer radius of bend');
model.param.set('wInd', '12[mm]', 'Width of indentation');
model.param.set('dInd', 'wInd/3', 'Depth of indentation');
model.param.set('rC', '4[mm]', 'Radius of central hole');
model.param.set('zCo', '5[mm]', 'Distance from bend to bottom of central hole');
model.param.set('zC', 'rOut+zCo+rC', 'Z position of central hole');
model.param.set('rO', '5[mm]', 'Radius of outer holes');
model.param.set('yOo', '8[mm]', 'Distance from edge to outer hole');
model.param.set('yO', 'yOo+rO', 'Y position of outer hole');
model.param.set('zOo', '20[mm]', 'Distance from bend to bottom of outer hole');
model.param.set('zO', 'rOut+zOo+rO', 'Z position of outer hole');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').geomRep('cadps');
model.geom('geom1').designBooleans(true);
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('quickplane', 'zy');
model.geom('geom1').feature('wp1').set('quickx', 'lX-rOut');
model.geom('geom1').feature('wp1').geom.create('pc1', 'ParametricCurve');
model.geom('geom1').feature('wp1').geom.feature('pc1').set('coord', {'if((abs(s-0.5)<wInd/lY),dInd/2*(1+cos(pi*lY/if(wInd>4[mm],wInd,4[mm])*(s-0.5))),0)' ''});
model.geom('geom1').feature('wp1').geom.feature('pc1').setIndex('coord', 's*lY/2', 1);
model.geom('geom1').feature('wp1').geom.run('pc1');
model.geom('geom1').feature('wp1').geom.create('copy1', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy1').selection('input').set({'pc1'});
model.geom('geom1').feature('wp1').geom.feature('copy1').set('displx', 'thk');
model.geom('geom1').feature('wp1').geom.run('copy1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify1', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('specify2', 'coord');
model.geom('geom1').feature('wp1').geom.feature('ls1').set('coord2', {'thk' '0'});
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('copy2', 'Copy');
model.geom('geom1').feature('wp1').geom.feature('copy2').selection('input').set({'ls1'});
model.geom('geom1').feature('wp1').geom.feature('copy2').set('disply', 'lY/2');
model.geom('geom1').feature('wp1').geom.run('copy2');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'copy1' 'copy2' 'ls1' 'pc1'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('rev1', 'Revolve');
model.geom('geom1').feature('rev1').set('angtype', 'specang');
model.geom('geom1').feature('rev1').set('angle2', 90);
model.geom('geom1').feature('rev1').set('axistype', '3d');
model.geom('geom1').feature('rev1').set('pos3', {'lX-rOut' '0' 'rOut'});
model.geom('geom1').feature('rev1').set('axis3', [0 -1 0]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'lX-rOut-2*thk' '1' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'lY/2', 1);
model.geom('geom1').feature('blk1').setIndex('size', 'thk', 2);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('loft1', 'Loft');
model.geom('geom1').feature('loft1').set('unite', false);
model.geom('geom1').feature('loft1').selection('startprofile').set('rev1', 1);
model.geom('geom1').feature('loft1').selection('endprofile').set('blk1', 5);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('mir1', 'Mirror');
model.geom('geom1').feature('mir1').selection('input').set({'loft1'});
model.geom('geom1').feature('mir1').set('keep', true);
model.geom('geom1').feature('mir1').set('pos', {'lX-rOut' '0' 'rOut'});
model.geom('geom1').feature('mir1').set('axis', [1 0 1]);
model.geom('geom1').runPre('fin');
model.geom('geom1').create('blk2', 'Block');
model.geom('geom1').feature('blk2').set('size', {'thk' 'lY/2' 'lZ-rOut-2*thk'});
model.geom('geom1').feature('blk2').set('pos', {'lX-thk' '0' 'rOut+2*thk'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').run('cyl1');
model.geom('geom1').create('cyl2', 'Cylinder');
model.geom('geom1').run('cyl2');
model.geom('geom1').create('cyl3', 'Cylinder');
model.geom('geom1').run('cyl3');
model.geom('geom1').create('cyl4', 'Cylinder');
model.geom('geom1').run('cyl4');
model.geom('geom1').create('cyl5', 'Cylinder');
model.geom('geom1').run('cyl5');
model.geom('geom1').create('cyl6', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'dCmp/2');
model.geom('geom1').feature('cyl1').set('h', '3*thk');
model.geom('geom1').feature('cyl1').set('pos', {'lX-2*thk' 'lY/2' '0'});
model.geom('geom1').feature('cyl1').setIndex('pos', 'lZ', 2);
model.geom('geom1').feature('cyl1').set('axistype', 'x');
model.geom('geom1').feature('cyl2').set('r', 'bDia/2');
model.geom('geom1').feature('cyl2').set('h', '3*thk');
model.geom('geom1').feature('cyl2').set('pos', {'lX-2*thk' 'bDia' '0'});
model.geom('geom1').feature('cyl2').setIndex('pos', 'lZ-bDia', 2);
model.geom('geom1').feature('cyl2').set('axistype', 'x');
model.geom('geom1').feature('cyl3').set('r', 'bDia/2');
model.geom('geom1').feature('cyl3').set('h', '3*thk');
model.geom('geom1').feature('cyl3').set('pos', {'lX-rOut-2*thk-bDia' '0' '0'});
model.geom('geom1').feature('cyl3').setIndex('pos', 'lY/4', 1);
model.geom('geom1').feature('cyl3').setIndex('pos', '-thk', 2);
model.geom('geom1').feature('cyl4').set('r', 'bDia/2');
model.geom('geom1').feature('cyl4').set('h', '3*thk');
model.geom('geom1').feature('cyl4').set('pos', {'1.5*bDia' 'lY/2' '0'});
model.geom('geom1').feature('cyl4').setIndex('pos', '-thk', 2);
model.geom('geom1').feature('cyl5').set('r', 'rO');
model.geom('geom1').feature('cyl5').set('h', '3*thk');
model.geom('geom1').feature('cyl5').set('pos', {'lX-2*thk' 'yO' 'zO'});
model.geom('geom1').feature('cyl5').set('axistype', 'x');
model.geom('geom1').feature('cyl6').set('r', 'rC');
model.geom('geom1').feature('cyl6').set('h', '3*thk');
model.geom('geom1').feature('cyl6').set('pos', {'lX-2*thk' 'lY/2' '0'});
model.geom('geom1').feature('cyl6').setIndex('pos', 'zC', 2);
model.geom('geom1').feature('cyl6').set('axistype', 'x');
model.geom('geom1').runPre('fin');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').set('quickplane', 'yx');
model.geom('geom1').feature('wp2').set('quickz', '2*thk');
model.geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('x', '0 lY/2-bDia/2 lY/2-bDia/2 0 0 0');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('y', '0 0 0 lX-rOut-2*thk lX-rOut-2*thk 0');
model.geom('geom1').feature('wp2').geom.run('pol1');
model.geom('geom1').run('wp2');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').set('workplane', 'wp2');
model.geom('geom1').feature('ext1').selection('input').set({'wp2'});
model.geom('geom1').feature('ext1').setIndex('distance', '3*thk', 0);
model.geom('geom1').run('ext1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'blk1' 'blk2' 'loft1' 'mir1' 'rev1'});
model.geom('geom1').feature('dif1').selection('input2').set({'cyl1' 'cyl2' 'cyl3' 'cyl4' 'cyl5' 'cyl6' 'ext1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').create('mir2', 'Mirror');
model.geom('geom1').feature('mir2').set('keep', true);
model.geom('geom1').feature('mir2').set('pos', {'0' 'lY/2' '0'});
model.geom('geom1').feature('mir2').set('axis', [0 1 0]);
model.geom('geom1').feature('mir2').selection('input').set({'dif1'});
model.geom('geom1').runPre('fin');

model.title([]);

model.description('');

model.label('multistudy_bracket_optimization_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
