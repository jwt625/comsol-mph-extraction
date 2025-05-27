function out = model
%
% submarine_cable_07_a_geom_mesh_3d.m
%
% Model exported on May 26 2025, 21:25 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/ACDC_Module/Tutorials,_Cables');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.param.label('Geometric Parameters 1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('Dcon', '26.2[mm]', 'Diameter of main conductors (phase)');
model.param.set('Tins', '24.0[mm]', 'Insulation thickness (XLPE)');
model.param.set('Dins', '77.6[mm]', 'Diameter over insulation (XLPE and SCC)');
model.param.set('Tscc', '(Dins/2-Dcon/2-Tins)/2', 'Semi-conductive compound thickness');
model.param.set('Tpbs', '2.9[mm]', 'Lead sheath thickness');
model.param.set('Tpe', '2.9[mm]', 'Polyethylene sheath thickness');
model.param.set('Dpha', 'Dins+2*Tpbs+2*Tpe', 'Diameter over phase (including sheath and PE)');
model.param.set('Dpha3', 'Dpha*(2/sqrt(3)+1)', 'Diameter over three phases combined');
model.param.set('Dfic', '2.5[mm]', 'Diameter of fiber optic core');
model.param.set('Tfih', '0.5[mm]', 'Steel helix thickness (fiber)');
model.param.set('Dfib', '9.2[mm]', 'Diameter over fiber optic cable');
model.param.set('Dcab', '219.0[mm]', 'Outer diameter of submarine cable');
model.param.set('Darm', '(Dcab+Dpha3)/2', 'Central diameter of armor ring');
model.param.set('Tarm', '5.6[mm]', 'Armor thickness (wire diameter)');
model.param.set('Narm', '110', 'Number of armor wires in ring');
model.param.set('mfil', '0.5[mm]', 'Filler margin');
model.param.set('marm', 'pi*Darm/Narm-Tarm', 'Armor margin');
model.param.create('par2');
model.param('par2').label('Geometric Parameters 2');

% To import content from file, use:
% model.param('par2').loadFile('FILENAME');
model.param('par2').set('Acon', '500[mm^2]', 'Cross sectional area of main conductors (per phase)');
model.param('par2').set('Ncon', 'Acon/(pi*(Dcon/2)^2)', 'Conductor packing density (phase)');
model.param('par2').set('Apbs', 'pi*(Dins+Tpbs)*Tpbs', 'Cross sectional area of lead sheath (per phase)');
model.param('par2').set('Lsec1', '1/3', 'Relative length cross bonding section 1');
model.param('par2').set('Lsec2', '1-Lsec1-Lsec3', 'Relative length cross bonding section 2');
model.param('par2').set('Lsec3', '1/3', 'Relative length cross bonding section 3');
model.param('par2').set('Lcab', '10[km]', 'Total length of submarine cable');
model.param('par2').set('Scab', '1e5', 'Geometric scale factor (2Daxi model)');
model.param.create('par3');
model.param('par3').label('Geometric Parameters 3');

% To import content from file, use:
% model.param('par3').loadFile('FILENAME');
model.param('par3').set('LLpha', '18*Dpha3', 'Lay length of main conductors (one period of twist, clockwise)');
model.param('par3').set('LLarm', '-15*Darm', 'Lay length of armor wires (one period of twist, counterclockwise)');
model.param('par3').set('CPcab', '1/(1/LLpha-1/LLarm)', 'Cable cross pitch (one period of twist, phase wrt armor)');
model.param('par3').set('Nper', '1/10', 'Number of periods included in model (tuning parameter)');
model.param('par3').set('Tenab', 'round(Nper)==Nper', 'Enable or disable twist: 1 or 0 (enabled when ''Nper'' is an integer)');
model.param('par3').set('Lsec', 'CPcab*Nper', 'Length of cable section included in model');
model.param('par3').set('Tsec', '360[deg]*Tenab*Lsec/LLpha', 'Twist angle of cable section included in model');
model.param('par3').set('SCFpha', 'if(Tenab,sqrt((2*pi*Dpha/sqrt(3))^2+LLpha^2)/abs(LLpha),1)', 'Slant correction factor, main conductors (enabled when ''Nper'' is an integer)');
model.param('par3').set('SCFarm', 'if(Tenab,sqrt((2*pi*Darm/2)^2+LLarm^2)/abs(LLarm),1)', 'Slant correction factor, armor wires (enabled when ''Nper'' is an integer)');
model.param('par3').set('TCFp20', 'sqrt(pi/(5*(sqrt(5)-1)/2))', 'Truncation correction factor, icosagon (phase)');
model.param('par3').set('TCFp16', 'sqrt(pi/(4*sqrt(2-sqrt(2))))', 'Truncation correction factor, hexadecagon (armor)');

model.geom('geom1').create('cyl1', 'Cylinder');
model.geom('geom1').feature('cyl1').set('r', 'Darm/2+2*Tarm/3');
model.geom('geom1').feature('cyl1').set('h', 'Lsec');
model.geom('geom1').feature('cyl1').set('pos', {'0' '0' '-Lsec/2'});
model.geom('geom1').feature('cyl1').setIndex('layer', '4*Tarm/3', 0);
model.geom('geom1').run('cyl1');

model.view('view1').set('showgrid', false);
model.view('view1').set('transparency', true);
model.view('view1').camera.set('projection', 'orthographic');
model.view('view1').label('View 1 (Orthographic)');
model.view('view1').set('locked', true);
model.view('view1').set('showmaterial', true);
model.view('view1').camera.set('viewscaletype', 'manual');
model.view('view1').camera.set('zscale', '1/(10*Nper)');

model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').set('size', {'Darm/2' 'Darm/2' '1'});
model.geom('geom1').feature('blk1').setIndex('size', 'Darm/2', 2);
model.geom('geom1').feature('blk1').set('pos', {'0' '0' 'Lsec/2-Darm/2'});
model.geom('geom1').run('blk1');

model.view.duplicate('view2', 'view1');
model.view('view2').label('View 2 (Orthographic, Top)');
model.view('view2').set('locked', true);
model.view.duplicate('view3', 'view2');
model.view('view3').label('View 3 (Orthographic, Bottom)');
model.view('view3').set('locked', true);
model.view.duplicate('view4', 'view3');
model.view('view4').label('View 4 (Orthographic, Side)');
model.view('view4').set('showgrid', true);
model.view('view4').set('locked', false);
model.view('view4').set('showgrid', false);
model.view('view4').set('locked', true);
model.view.duplicate('view5', 'view4');
model.view('view5').label('View 5 (Perspective)');
model.view('view5').camera.set('projection', 'perspective');
model.view('view5').camera.set('zoomanglefull', 36);
model.view('view5').camera.setIndex('position', '1.4*Dcab', 0);
model.view('view5').camera.set('position', {'1.4*Dcab' '0.4*Dcab' '3'});
model.view('view5').camera.setIndex('position', 'Lsec/(2*Nper)+2.8*Dcab', 2);
model.view('view5').camera.setIndex('up', '1e-6', 0);
model.view('view5').camera.setIndex('up', 0, 0);
model.view('view5').camera.set('up', [0 1 0]);
model.view('view5').camera.set('zscale', '1/Nper');
model.view('view5').camera.set('viewoffset', {'0.8*Dcab' '0.8*Dcab'});

model.param('par3').set('Nper', '1');

model.geom('geom1').run('fin');

model.view('view1').camera.set('orthoscale', 0.5474655628204346);
model.view('view2').camera.set('orthoscale', 0.3977237939834595);
model.view('view3').camera.set('orthoscale', 0.3977237939834595);
model.view('view4').camera.set('orthoscale', 0.3555237948894501);
model.view('view1').set('locked', false);
model.view('view2').set('locked', false);
model.view('view3').set('locked', false);
model.view('view4').set('locked', false);
model.view('view5').set('locked', false);

model.title(['Submarine Cable 7a ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Geometry & Mesh 3D']);

model.description(['This MPH-file represents an intermediate state of the model that is constructed and analyzed in the Geometry & Mesh 3D tutorial. For more information, including a detailed introduction, step-by-step instructions and result analysis (with validation and references to academic research), see the *.pdf file that comes with the tutorial' native2unicode(hex2dec({'20' '19'}), 'unicode') 's main entry point in the Application Library: submarine_cable_07_geom_mesh_3d.']);

model.mesh.clearMeshes;

model.label('submarine_cable_07_a_geom_mesh_3d.mph');

model.modelNode.label('Components');

out = model;
