function out = model
%
% bracket_swept_mesh.m
%
% Model exported on May 26 2025, 21:27 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/COMSOL_Multiphysics/Meshing_Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'bracket.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').run;

model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').set('facemethod', 'tri');

model.geom('geom1').create('pard1', 'PartitionDomains');
model.geom('geom1').feature('pard1').selection('domain').set('imp1', 1);
model.geom('geom1').feature('pard1').set('partitionwith', 'extendedfaces');

model.view('view1').set('renderwireframe', true);

model.geom('geom1').feature('pard1').selection('extendedface').set('imp1', [8 38]);
model.geom('geom1').runPre('fin');
model.geom('geom1').run;
model.geom('geom1').run('fin');
model.geom('geom1').create('ige1', 'IgnoreEdges');
model.geom('geom1').feature('ige1').selection('input').set('fin', [123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164]);
model.geom('geom1').run('ige1');

model.mesh('mesh1').run;

model.view('view1').set('rendermesh', false);

model.mesh('mesh1').feature('swe1').selection('sourceface').set([12 20 42]);
model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('size').set('custom', true);
model.mesh('mesh1').feature('size').set('hmax', '6[mm]');
model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 2);
model.mesh('mesh1').run;
model.mesh('mesh1').stat.setQualityMeasure('skewness');
model.mesh('mesh1').stat.selection.allGeom;
model.mesh('mesh1').stat.setQualityMeasure('skewness');

model.view('view1').set('rendermesh', true);

model.result.dataset.create('mesh1', 'Mesh');
model.result.dataset('mesh1').set('mesh', 'mesh1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Mesh Plot 1');
model.result('pg1').set('data', 'mesh1');
model.result('pg1').set('inherithide', true);
model.result('pg1').set('showlegendsmaxmin', true);
model.result('pg1').create('mesh1', 'Mesh');
model.result('pg1').feature('mesh1').set('colortable', 'TrafficFlow');
model.result('pg1').feature('mesh1').set('colortabletrans', 'nonlinear');
model.result('pg1').feature('mesh1').set('nonlinearcolortablerev', true);
model.result('pg1').feature('mesh1').set('meshdomain', 'volume');
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('filteractive', true);
model.result('pg1').feature('mesh1').set('logfilterexpr', 'qualskewness<0.3');
model.result('pg1').feature('mesh1').set('elemscale', 0.9);
model.result('pg1').run;

model.geom('geom1').run('imp1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp1').selection('face').set('imp1', 7);
model.geom('geom1').feature('wp1').set('offset', '0.02[m]');
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'0.033[m]' '0.024[m]'});
model.geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-0.06[m]' '0.086[m]'});
model.geom('geom1').feature('wp1').geom.run('r1');
model.geom('geom1').feature('wp1').geom.create('arr1', 'Array');
model.geom('geom1').feature('wp1').geom.feature('arr1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('arr1').set('fullsize', [2 2]);
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0.087[m]' '0.196[m]'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').feature('wp1').geom.feature('arr1').set('displ', {'0.087[m]' '-0.196[m]'});
model.geom('geom1').feature('wp1').geom.run('arr1');
model.geom('geom1').run('wp1');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').setIndex('distance', '0.14[m]', 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').feature('ext1').set('selresult', true);
model.geom('geom1').runPre('fin');
model.geom('geom1').feature('pard1').set('partitionwith', 'objects');
model.geom('geom1').runPre('pard1');
model.geom('geom1').feature('pard1').selection('object').named('ext1');
model.geom('geom1').feature('pard1').set('keepobject', false);
model.geom('geom1').runPre('fin');
model.geom('geom1').run('ige1');
model.geom('geom1').create('mcf1', 'MeshControlFaces');
model.geom('geom1').feature('mcf1').selection('input').named('ext1');
model.geom('geom1').run;

model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.set([1 4 5 6 9]);
model.mesh('mesh1').feature('swe1').set('facemethod', 'quad');
model.mesh('mesh1').run;
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('ftet1').set('smoothcontrol', false);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').stat.selection.allGeom;
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 3);
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hcurveactive', true);
model.mesh('mesh1').feature('ftet1').create('size2', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size2').selection.geom('geom1', 2);
model.mesh('mesh1').feature('ftet1').feature('size2').selection.set([11 36]);
model.mesh('mesh1').feature('ftet1').feature('size2').set('hauto', 1);
model.mesh('mesh1').run('ftet1');
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('edg1', 'Edge');
model.mesh('mesh1').feature('edg1').selection.set([42 43 47 48 78 79 83 84]);
model.mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 8);
model.mesh('mesh1').run;
model.mesh('mesh1').stat.selection.allGeom;
model.mesh('mesh1').stat.setQualityMeasure('skewness');

model.result('pg1').run;
model.result('pg1').feature('mesh1').set('elemtype3', 'pyr');
model.result('pg1').feature('mesh1').set('filteractive', false);
model.result('pg1').feature('mesh1').set('elemcolor', 'magenta');
model.result('pg1').feature('mesh1').create('filt1', 'Filter');
model.result('pg1').run;
model.result('pg1').feature('mesh1').feature('filt1').set('expr', '(x<-0.08)*(z>0.02)*(y>-0.13)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature.duplicate('mesh2', 'mesh1');
model.result('pg1').run;
model.result('pg1').feature('mesh2').set('elemtype3', 'hex');
model.result('pg1').feature('mesh2').set('elemcolor', 'gray');
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('titletype', 'none');
model.result('pg1').run;
model.result('pg1').feature('mesh2').set('titletype', 'none');
model.result('pg1').run;

model.title('Swept Meshing of a Bracket Geometry');

model.description('This tutorial demonstrates how to partition a 3D part to create a swept mesh. The example explores different strategies for partitioning the geometry, and demonstrates how to combine swept and free meshes.');

model.mesh.clearMeshes;

model.label('bracket_swept_mesh.mph');

model.modelNode.label('Components');

out = model;
