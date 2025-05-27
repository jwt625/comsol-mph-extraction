function out = model
%
% wheel_rim_geom_sequence.m
%
% Model exported on May 26 2025, 21:34 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Structural_Mechanics_Module/Tutorials');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('filename', 'wheel_rim.mphbin');
model.geom('geom1').feature('imp1').importData;
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'imp1'});
model.geom('geom1').feature('rot1').set('rot', 'range(0,72,288)');
model.geom('geom1').run('rot1');
model.geom('geom1').feature('fin').set('repairtoltype', 'absolute');
model.geom('geom1').feature('fin').set('absrepairtol', '1.1E-5[m]');
model.geom('geom1').run('fin');

model.mesh('mesh1').autoMeshSize(4);
model.mesh('mesh1').run;

model.geom('geom1').feature('rot1').active(false);
model.geom('geom1').run('fin');
model.geom('geom1').create('cmf1', 'CompositeFaces');
model.geom('geom1').feature('cmf1').selection('input').set('fin', [2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 19 20 21 22 23 24 25 26 27 29 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 199 200 201 202 203 204 205 206 207 208]);
model.geom('geom1').run('cmf1');
model.geom('geom1').feature('rot1').active(true);
model.geom('geom1').run('rot1');
model.geom('geom1').run('cmf1');
model.geom('geom1').create('cmd1', 'CompositeDomains');
model.geom('geom1').feature('cmd1').selection('input').set('cmf1', [1 2 3 4 5]);
model.geom('geom1').run('cmd1');

model.mesh('mesh1').run;

model.title('Virtual Operations on a Wheel Rim Geometry');

model.description('This tutorial shows how to perform virtual geometry operations on an imported CAD geometry. These virtual operations, such as form composite entities or ignore entities can help to improve the mesh and reduce the total element number.');

model.label('wheel_rim_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
