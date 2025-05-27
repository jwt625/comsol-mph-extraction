function out = model
%
% submarine_cable_07_geom_mesh_3d.m
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
model.geom('geom1').feature('cyl1').setIndex('layername', 'Layer 1', 0);
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

model.param('par3').set('Nper', '1/10', 'Number of periods included in model (tuning parameter)');
model.param('par3').set('Nper', '1');
model.param('par3').descr('Nper', 'Number of periods included in model (tuning parameter)');

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

model.label('submarine_cable_07_a_geom_mesh_3d.mph');

model.view('view1').set('locked', true);
model.view('view2').set('locked', true);
model.view('view3').set('locked', true);
model.view('view4').set('locked', true);
model.view('view5').set('locked', true);
model.view('view1').camera.set('orthoscale', 0.4105992019176483);
model.view('view2').camera.set('orthoscale', 0.2982928454875946);
model.view('view3').camera.set('orthoscale', 0.2982928454875946);
model.view('view4').camera.set('orthoscale', 0.26664286851882935);

model.param('par3').set('Nper', '1', 'Number of periods included in model (tuning parameter)');
model.param('par3').set('Nper', '1/10');
model.param('par3').descr('Nper', 'Number of periods included in model (tuning parameter)');
model.param.create('par4');
model.param('par4').label('Electromagnetic Parameters');

% To import content from file, use:
% model.param('par4').loadFile('FILENAME');
model.param('par4').set('f0', '50[Hz]', 'Operating frequency');
model.param('par4').set('w0', '(2*pi*f0[1/Hz])[rad/s]', 'Angular frequency');
model.param('par4').set('V0', '220[kV]/sqrt(3)', 'Phase to ground voltage (amplitude)');
model.param('par4').set('I0', '655[A]*sqrt(2)', 'Rated current (amplitude)');
model.param('par4').set('Scup', '5.96e7[S/m]', ['Copper conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par4').set('Spbs', '4.55e6[S/m]', ['Lead sheath conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par4').set('Sarm', '4.03e6[S/m]', ['Armor wire conductivity, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C']);
model.param('par4').set('Mcup', '1', 'Relative permeability, copper');
model.param('par4').set('Mpbs', '1', 'Relative permeability, lead sheath');
model.param('par4').set('Marm', '100-50*j', 'Relative permeability, armor wires');
model.param('par4').set('Dscup', 'min(1/real(sqrt(j*w0*mu0_const*Mcup*Scup)),Dcon/3)', 'Skin depth, copper (analytic)');
model.param('par4').set('Dspbs', 'min(1/real(sqrt(j*w0*mu0_const*Mpbs*Spbs)),12*Tpbs)', 'Skin depth, lead sheath (analytic)');
model.param('par4').set('Dsarm', 'min(1/real(sqrt(j*w0*mu0_const*Marm*Sarm)),Tarm/2)', 'Skin depth, armor wires (analytic)');
model.param('par4').set('Rcon', '1/Acon/Scup', ['Main conductor DC resistance per phase, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C (analytic)']);
model.param('par4').set('Rpbs', '1/Apbs/Spbs', ['Lead sheath DC resistance per phase, at 20' native2unicode(hex2dec({'00' 'b0'}), 'unicode') 'C (analytic)']);
model.param('par4').set('Exlpe', '2.5', 'Relative permittivity XLPE (from IEC 60287)');
model.param('par4').set('Cpha', '2*pi*epsilon0_const*Exlpe/log((Dins/2-Tscc)/(Dcon/2+Tscc))', 'Capacitance per phase (analytic)');
model.param('par4').set('Icpha', 'w0*Cpha*V0', 'Charging current per phase (analytic)');

model.geom('geom1').run('fin');
model.geom('geom1').feature.remove('cyl1');
model.geom('geom1').feature.remove('blk1');
model.geom('geom1').run('');
model.geom('geom1').create('pol1', 'Polygon');
model.geom('geom1').feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('pol1').set('x', 'Darm/2');
model.geom('geom1').feature('pol1').set('y', 0);
model.geom('geom1').feature('pol1').set('z', '-(Lsec/2+Tarm*{0,10})');
model.geom('geom1').run('pol1');
model.geom('geom1').create('rot1', 'Rotate');
model.geom('geom1').feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('rot1').set('rot', '360[deg]*range(1/Narm,1/Narm,1)');
model.geom('geom1').run('rot1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').label('Phases and Screens');
model.geom('geom1').feature('wp1').set('quickz', '-Lsec/2');
model.geom('geom1').feature('wp1').set('selresult', true);
model.geom('geom1').feature('wp1').set('selresultshow', false);
model.geom('geom1').feature('wp1').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('x', 'Dpha/sqrt(3)+cos(360[deg]*range(1/40,1/20,1-1/40))*TCFp20*Dcon/2');
model.geom('geom1').feature('wp1').geom.feature('pol1').set('y', 'sin(360[deg]*range(1/40,1/20,1-1/40))*TCFp20*Dcon/2');
model.geom('geom1').feature('wp1').geom.run('pol1');
model.geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp1').geom.feature('c1').set('type', 'curve');
model.geom('geom1').feature('wp1').geom.feature('c1').set('r', 'Dins/2+Tpbs');
model.geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'Dpha/sqrt(3)' '0'});
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layername', 'Layer 1', 0);
model.geom('geom1').feature('wp1').geom.feature('c1').setIndex('layer', 'Tpbs', 0);
model.geom('geom1').feature('wp1').geom.run('c1');
model.geom('geom1').feature('wp1').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp1').geom.feature('pt1').setIndex('p', 'Dpha/sqrt(3)+(Dins/2+Tpbs)/sqrt(2)', 0);
model.geom('geom1').feature('wp1').geom.feature('pt1').setIndex('p', '(Dins/2+Tpbs)/sqrt(2)', 1);
model.geom('geom1').feature('wp1').geom.run('pt1');
model.geom('geom1').feature('wp1').geom.create('sca1', 'Scale');
model.geom('geom1').feature('wp1').geom.feature('sca1').selection('input').set({'c1' 'pol1' 'pt1'});
model.geom('geom1').feature('wp1').geom.feature('sca1').set('type', 'anisotropic');
model.geom('geom1').feature('wp1').geom.feature('sca1').set('anisotropic', {'1' 'SCFpha'});
model.geom('geom1').feature('wp1').geom.run('sca1');
model.geom('geom1').feature('wp1').geom.feature('sca1').set('anisotropic', {'1' '2*SCFpha'});
model.geom('geom1').feature('wp1').geom.run('sca1');
model.geom('geom1').feature('wp1').geom.feature('sca1').set('anisotropic', {'1' 'SCFpha'});
model.geom('geom1').feature('wp1').geom.run('sca1');
model.geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'sca1(1)' 'sca1(2)'});
model.geom('geom1').feature('wp1').geom.feature('rot1').set('rot', '360[deg]*{1/3,2/3,1}');
model.geom('geom1').feature('wp1').geom.run('rot1');
model.geom('geom1').feature('wp1').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex1').set('rot1(3)', 6);
model.geom('geom1').feature('wp1').geom.feature('ls1').selection('vertex2').set('rot1(1)', 3);
model.geom('geom1').feature('wp1').geom.run('ls1');
model.geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'ls1'});
model.geom('geom1').feature('wp1').geom.feature('rot2').set('rot', '360[deg]*{1/3,2/3,1}');
model.geom('geom1').feature('wp1').geom.run('rot2');
model.geom('geom1').feature('wp1').geom.create('csol1', 'ConvertToSolid');
model.geom('geom1').feature('wp1').geom.feature('csol1').selection('input').set({'rot1' 'rot2' 'sca1(3)'});
model.geom('geom1').feature('wp1').geom.run('csol1');
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').label('Cable Armor and Sea Bed');
model.geom('geom1').feature('wp2').set('quickz', '-Lsec/2');
model.geom('geom1').feature('wp2').set('selresult', true);
model.geom('geom1').feature('wp2').set('selresultshow', false);

model.view('view7').set('locked', true);
model.view('view7').axis.set('xmin', 0.0868808776140213);
model.view('view7').axis.set('xmax', 0.11871876567602158);
model.view('view7').axis.set('ymin', -0.012240377254784107);
model.view('view7').axis.set('ymax', 0.012240377254784107);

model.geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('x', 'Darm/2+TCFp16*Tarm/6*{0,1}');
model.geom('geom1').feature('wp2').geom.feature('pol1').set('y', 0);
model.geom('geom1').feature('wp2').geom.run('pol1');
model.geom('geom1').feature('wp2').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp2').geom.feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp2').geom.feature('rot1').set('rot', '360[deg]*range(7/32,1/4,1-1/32)');
model.geom('geom1').feature('wp2').geom.feature('rot1').set('pos', {'Darm/2' '0'});
model.geom('geom1').feature('wp2').geom.run('rot1');
model.geom('geom1').feature('wp2').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('wp2').geom.feature('pol2').set('x', 'Darm/2+cos(360[deg]*range(1/32,1/16,1-1/32))*TCFp16*Tarm/2');
model.geom('geom1').feature('wp2').geom.feature('pol2').set('y', 'sin(360[deg]*range(1/32,1/16,1-1/32))*TCFp16*Tarm/2');
model.geom('geom1').feature('wp2').geom.run('pol2');
model.geom('geom1').feature('wp2').geom.create('sca1', 'Scale');
model.geom('geom1').feature('wp2').geom.feature('sca1').selection('input').set({'pol2' 'rot1'});
model.geom('geom1').feature('wp2').geom.feature('sca1').set('type', 'anisotropic');
model.geom('geom1').feature('wp2').geom.feature('sca1').set('anisotropic', {'1' 'SCFarm'});
model.geom('geom1').feature('wp2').geom.run('sca1');
model.geom('geom1').feature('wp2').geom.create('pol3', 'Polygon');
model.geom('geom1').feature('wp2').geom.feature('pol3').set('source', 'table');
model.geom('geom1').feature('wp2').geom.feature('pol3').set('type', 'open');
model.geom('geom1').feature('wp2').geom.feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('wp2').geom.feature('pol3').set('x', 'cos(360[deg]/Narm*{0,1/2,1})*(Darm/2-2*Tarm/3)');
model.geom('geom1').feature('wp2').geom.feature('pol3').set('y', 'sin(360[deg]/Narm*{0,1/2,1})*(Darm/2-2*Tarm/3)');
model.geom('geom1').feature('wp2').geom.run('pol3');
model.geom('geom1').feature('wp2').geom.feature.duplicate('pol4', 'pol3');
model.geom('geom1').feature('wp2').geom.feature('pol4').set('x', 'cos(360[deg]/Narm*{0,1/2,1})*(Darm/2+2*Tarm/3)');
model.geom('geom1').feature('wp2').geom.feature('pol4').set('y', 'sin(360[deg]/Narm*{0,1/2,1})*(Darm/2+2*Tarm/3)');
model.geom('geom1').feature('wp2').geom.run('pol4');
model.geom('geom1').feature('wp2').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp2').geom.feature('rot2').selection('input').set({'pol3' 'pol4' 'sca1'});
model.geom('geom1').feature('wp2').geom.feature('rot2').set('rot', '360[deg]*range(1/Narm,1/Narm,1)');
model.geom('geom1').feature('wp2').geom.run('rot2');
model.geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', '5*Dcab/2');
model.geom('geom1').feature('wp2').geom.run('c1');
model.geom('geom1').run('wp2');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').setIndex('p', '-8*Dcab/2', 0);
model.geom('geom1').feature('pt1').setIndex('p', '-8*Dcab/2', 1);
model.geom('geom1').feature('pt1').setIndex('p', '-Lsec/2', 2);
model.geom('geom1').run('pt1');
model.geom('geom1').create('pt2', 'Point');
model.geom('geom1').feature('pt2').setIndex('p', '8*Dcab/2', 0);
model.geom('geom1').feature('pt2').setIndex('p', '8*Dcab/2', 1);
model.geom('geom1').feature('pt2').setIndex('p', '-Lsec/2', 2);
model.geom('geom1').run('pt2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').label('Mesh Control Entities');
model.geom('geom1').feature('wp3').set('quickz', '-Lsec/2');

model.view('view8').set('locked', true);
model.view('view8').axis.set('xmin', 0.03283639997243881);
model.view('view8').axis.set('xmax', 0.07016289234161377);
model.view('view8').axis.set('ymin', -0.014350522309541702);
model.view('view8').axis.set('ymax', 0.014350522309541702);

model.geom('geom1').feature('wp3').geom.create('pol1', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('type', 'open');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('source', 'vectors');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('x', 'Dpha/sqrt(3)+TCFp20*Dcon/2-Dscup/8*{0,1,2,3}');
model.geom('geom1').feature('wp3').geom.feature('pol1').set('y', 0);
model.geom('geom1').feature('wp3').geom.run('pol1');
model.geom('geom1').feature('wp3').geom.create('rot1', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot1').selection('input').set({'pol1'});
model.geom('geom1').feature('wp3').geom.feature('rot1').set('rot', '360[deg]*{-1/40,1/40}');
model.geom('geom1').feature('wp3').geom.feature('rot1').set('pos', {'Dpha/sqrt(3)' '0'});
model.geom('geom1').feature('wp3').geom.run('rot1');
model.geom('geom1').feature('wp3').geom.create('ls1', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls1').selection('vertex1').set('rot1(1)', 1);
model.geom('geom1').feature('wp3').geom.feature('ls1').selection('vertex2').set('rot1(2)', 1);
model.geom('geom1').feature('wp3').geom.run('ls1');
model.geom('geom1').feature('wp3').geom.create('rot2', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot2').selection('input').set({'ls1' 'rot1'});
model.geom('geom1').feature('wp3').geom.feature('rot2').set('rot', '360[deg]*range(1/20,1/20,1)');
model.geom('geom1').feature('wp3').geom.feature('rot2').set('pos', {'Dpha/sqrt(3)' '0'});
model.geom('geom1').feature('wp3').geom.run('rot2');
model.geom('geom1').feature('wp3').geom.create('pol2', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('type', 'closed');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('x', 'Dpha/sqrt(3)+cos(360[deg]*range(1/20,1/20,1))*(TCFp20*Dcon/2-Dscup*9/16)');
model.geom('geom1').feature('wp3').geom.feature('pol2').set('y', 'sin(360[deg]*range(1/20,1/20,1))*(TCFp20*Dcon/2-Dscup*9/16)');
model.geom('geom1').feature('wp3').geom.run('pol2');
model.geom('geom1').feature('wp3').geom.create('sca1', 'Scale');
model.geom('geom1').feature('wp3').geom.feature('sca1').selection('input').set({'pol2' 'rot2'});
model.geom('geom1').feature('wp3').geom.feature('sca1').set('type', 'anisotropic');
model.geom('geom1').feature('wp3').geom.feature('sca1').set('anisotropic', {'1' 'SCFpha'});
model.geom('geom1').feature('wp3').geom.run('sca1');

model.view('view8').axis.set('xmin', 0.09484034776687622);
model.view('view8').axis.set('xmax', 0.11075928807258606);
model.view('view8').axis.set('ymin', -0.006120188627392054);
model.view('view8').axis.set('ymax', 0.006120188627392054);

model.geom('geom1').feature('wp3').geom.create('pt1', 'Point');
model.geom('geom1').feature('wp3').geom.feature('pt1').setIndex('p', 'Darm/2+TCFp16*Tarm/2', 0);
model.geom('geom1').feature('wp3').geom.run('pt1');
model.geom('geom1').feature('wp3').geom.create('rot3', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot3').selection('input').set({'pt1'});
model.geom('geom1').feature('wp3').geom.feature('rot3').set('rot', '360[deg]*{5/32,11/32,21/32,27/32}');
model.geom('geom1').feature('wp3').geom.feature('rot3').set('pos', {'Darm/2' '0'});
model.geom('geom1').feature('wp3').geom.feature('rot3').set('selresult', true);
model.geom('geom1').feature('wp3').geom.feature('rot3').set('selresultshow', false);
model.geom('geom1').feature('wp3').geom.run('rot3');
model.geom('geom1').feature('wp3').geom.create('sca2', 'Scale');
model.geom('geom1').feature('wp3').geom.feature('sca2').selection('input').named('rot3');
model.geom('geom1').feature('wp3').geom.feature('sca2').set('type', 'anisotropic');
model.geom('geom1').feature('wp3').geom.feature('sca2').set('anisotropic', {'1' 'SCFarm'});
model.geom('geom1').feature('wp3').geom.run('sca2');
model.geom('geom1').feature('wp3').geom.create('rot4', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot4').selection('input').set({'sca2(3)' 'sca2(4)'});
model.geom('geom1').feature('wp3').geom.feature('rot4').set('rot', '360[deg]/Narm');
model.geom('geom1').feature('wp3').geom.run('rot4');
model.geom('geom1').feature('wp3').geom.create('ls2', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls2').selection('vertex1').set('sca2(2)', 1);
model.geom('geom1').feature('wp3').geom.feature('ls2').selection('vertex2').set('rot4(1)', 1);
model.geom('geom1').feature('wp3').geom.run('ls2');
model.geom('geom1').feature('wp3').geom.create('ls3', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls3').selection('vertex1').set('sca2(1)', 1);
model.geom('geom1').feature('wp3').geom.feature('ls3').selection('vertex2').set('rot4(2)', 1);
model.geom('geom1').feature('wp3').geom.run('ls3');
model.geom('geom1').feature('wp3').geom.create('rot5', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot5').selection('input').set({'ls2' 'ls3' 'rot4' 'sca2(1)' 'sca2(2)'});
model.geom('geom1').feature('wp3').geom.feature('rot5').set('rot', '360[deg]*range(1/Narm,1/Narm,1)');
model.geom('geom1').feature('wp3').geom.run('rot5');
model.geom('geom1').feature('wp3').geom.create('pol3', 'Polygon');
model.geom('geom1').feature('wp3').geom.feature('pol3').set('source', 'table');
model.geom('geom1').feature('wp3').geom.feature('pol3').set('type', 'open');
model.geom('geom1').feature('wp3').geom.feature('pol3').set('source', 'vectors');
model.geom('geom1').feature('wp3').geom.feature('pol3').set('x', 'Darm/2+TCFp16*Tarm/2-{0,Dsarm/5,2*Dsarm/5,TCFp16*Tarm/3,TCFp16*Tarm/2}');
model.geom('geom1').feature('wp3').geom.feature('pol3').set('y', 0);
model.geom('geom1').feature('wp3').geom.run('pol3');
model.geom('geom1').feature('wp3').geom.create('rot6', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot6').selection('input').set({'pol3'});
model.geom('geom1').feature('wp3').geom.feature('rot6').set('rot', '360[deg]*{-1/32,1/32,3/32}');
model.geom('geom1').feature('wp3').geom.feature('rot6').set('pos', {'Darm/2' '0'});
model.geom('geom1').feature('wp3').geom.run('rot6');
model.geom('geom1').feature('wp3').geom.create('del1', 'Delete');
model.geom('geom1').feature('wp3').geom.feature('del1').selection('input').set('rot6(2)', [1 2]);
model.geom('geom1').feature('wp3').geom.run('del1');
model.geom('geom1').feature('wp3').geom.create('ls4', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls4').selection('vertex1').set('rot6(1)', 3);
model.geom('geom1').feature('wp3').geom.feature('ls4').selection('vertex2').set('del1', 1);
model.geom('geom1').feature('wp3').geom.run('ls4');
model.geom('geom1').feature('wp3').geom.create('ls5', 'LineSegment');
model.geom('geom1').feature('wp3').geom.feature('ls5').selection('vertex1').set('ls4', 2);
model.geom('geom1').feature('wp3').geom.feature('ls5').selection('vertex2').set('rot6(3)', 3);
model.geom('geom1').feature('wp3').geom.run('ls5');
model.geom('geom1').feature('wp3').geom.create('rot7', 'Rotate');
model.geom('geom1').feature('wp3').geom.feature('rot7').selection('input').set({'del1' 'ls4' 'ls5' 'rot6(1)' 'rot6(3)'});
model.geom('geom1').feature('wp3').geom.feature('rot7').set('rot', '360[deg]*range(1/8,1/8,1)');
model.geom('geom1').feature('wp3').geom.feature('rot7').set('pos', {'Darm/2' '0'});
model.geom('geom1').feature('wp3').geom.feature('rot7').set('selresult', true);
model.geom('geom1').feature('wp3').geom.feature('rot7').set('selresultshow', false);
model.geom('geom1').feature('wp3').geom.run('rot7');
model.geom('geom1').feature('wp3').geom.create('sca3', 'Scale');
model.geom('geom1').feature('wp3').geom.feature('sca3').selection('input').named('rot7');
model.geom('geom1').feature('wp3').geom.feature('sca3').set('type', 'anisotropic');
model.geom('geom1').feature('wp3').geom.feature('sca3').set('anisotropic', {'1' 'SCFarm'});
model.geom('geom1').feature('wp3').geom.run('sca3');
model.geom('geom1').run('wp3');
model.geom('geom1').feature.remove('pt1');
model.geom('geom1').feature.remove('pt2');
model.geom('geom1').run('wp3');
model.geom('geom1').create('pol2', 'Polygon');
model.geom('geom1').feature('pol2').set('source', 'vectors');
model.geom('geom1').feature('pol2').set('x', 0);
model.geom('geom1').feature('pol2').set('y', 0);
model.geom('geom1').feature('pol2').set('z', 'Lsec*{-1/2,1/2}');
model.geom('geom1').feature('pol2').set('selresult', true);
model.geom('geom1').feature('pol2').set('selresultshow', false);
model.geom('geom1').run('pol2');
model.geom('geom1').create('swe1', 'Sweep');
model.geom('geom1').feature('swe1').set('includefinal', false);
model.geom('geom1').feature('swe1').set('crossfaces', true);
model.geom('geom1').feature('swe1').set('manualdir', false);
model.geom('geom1').feature('swe1').selection('enttosweep').named('wp1');
model.geom('geom1').feature('swe1').selection('edge').named('pol2');
model.geom('geom1').feature('swe1').set('keep', false);
model.geom('geom1').feature('swe1').set('twist', '360[deg]*Tenab*s[m]/LLpha');
model.geom('geom1').run('swe1');
model.geom('geom1').feature.duplicate('pol3', 'pol2');
model.geom('geom1').run('pol3');
model.geom('geom1').feature.duplicate('swe2', 'swe1');
model.geom('geom1').feature('swe2').selection('enttosweep').named('wp2');
model.geom('geom1').feature('swe2').selection('edge').named('pol3');
model.geom('geom1').feature('swe2').set('twist', '360[deg]*Tenab*s[m]/LLarm');
model.geom('geom1').run('swe2');

model.param('par3').set('Nper', '1/10', 'Number of periods included in model (tuning parameter)');
model.param('par3').set('Nper', '1');
model.param('par3').descr('Nper', 'Number of periods included in model (tuning parameter)');

model.geom('geom1').run('pol2');
model.geom('geom1').run('swe1');
model.geom('geom1').run('swe2');
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
model.view('view7').set('locked', false);
model.view('view8').set('locked', false);

model.title(['Submarine Cable 7b ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Geometry & Mesh 3D']);

model.description(['This MPH-file represents an intermediate state of the model that is constructed and analyzed in the Geometry & Mesh 3D tutorial. For more information, including a detailed introduction, step-by-step instructions and result analysis (with validation and references to academic research), see the *.pdf file that comes with the tutorial' native2unicode(hex2dec({'20' '19'}), 'unicode') 's main entry point in the Application Library: submarine_cable_07_geom_mesh_3d.']);

model.label('submarine_cable_07_b_geom_mesh_3d.mph');

model.view('view1').set('locked', true);
model.view('view2').set('locked', true);
model.view('view3').set('locked', true);
model.view('view4').set('locked', true);
model.view('view5').set('locked', true);
model.view('view1').camera.set('orthoscale', 0.4105992019176483);
model.view('view2').camera.set('projection', 'perspective');
model.view('view2').camera.set('zoomanglefull', 10);
model.view('view2').camera.set('projection', 'orthographic');
model.view('view2').camera.set('orthoscale', 0.2982928454875946);
model.view('view3').camera.set('orthoscale', 0.2982928454875946);
model.view('view4').camera.set('orthoscale', 0.26664286851882935);

model.selection.create('cyl1', 'Cylinder');
model.selection('cyl1').model('comp1');
model.selection('cyl1').label('Cross Section, Top');
model.selection('cyl1').set('entitydim', 2);
model.selection('cyl1').set('r', '6*Dcab/2');
model.selection('cyl1').set('top', 'Lsec/4');
model.selection('cyl1').set('bottom', '-Lsec/4');
model.selection('cyl1').set('pos', {'0' '0' 'Lsec/2'});
model.selection('cyl1').set('condition', 'allvertices');
model.selection.duplicate('cyl2', 'cyl1');
model.selection('cyl2').label('Cross Section, Bottom');
model.selection('cyl2').set('pos', {'0' '0' '-Lsec/2'});
model.selection.create('uni1', 'Union');
model.selection('uni1').model('comp1');
model.selection('uni1').label('Cross Section, Top and Bottom');
model.selection('uni1').set('entitydim', 2);
model.selection('uni1').set('input', {'cyl1' 'cyl2'});
model.selection.create('cyl3', 'Cylinder');
model.selection('cyl3').model('comp1');
model.selection('cyl3').label('Phases');
model.selection('cyl3').set('r', 'Dpha/sqrt(3)+(Dcon/2+Dins/2)/2');
model.selection('cyl3').set('rin', 'Dpha/sqrt(3)-(Dcon/2+Dins/2)/2');
model.selection('cyl3').set('condition', 'allvertices');
model.selection.create('ball1', 'Ball');
model.selection('ball1').model('comp1');
model.selection('ball1').label('Phase 1');
model.selection('ball1').set('inputent', 'selections');
model.selection('ball1').set('input', {'cyl3'});
model.selection('ball1').set('posx', '-(Dpha/2)/sqrt(3)');
model.selection('ball1').set('posy', 'Dpha/2');
model.selection('ball1').set('posz', '-Lsec/2');
model.selection('ball1').set('r', '(Dcon/2+Dins/2)/2');
model.selection('ball1').set('condition', 'somevertex');
model.selection.duplicate('ball2', 'ball1');
model.selection('ball2').label('Phase 2');
model.selection('ball2').set('posx', 'Dpha/sqrt(3)');
model.selection('ball2').set('posy', 0);
model.selection.duplicate('ball3', 'ball2');
model.selection('ball3').label('Phase 3');
model.selection('ball3').set('posx', '-(Dpha/2)/sqrt(3)');
model.selection('ball3').set('posy', '-Dpha/2');
model.selection.create('adj1', 'Adjacent');
model.selection('adj1').model('comp1');
model.selection('adj1').label('Cross-Linked Polyethylene (XLPE)');
model.selection('adj1').set('input', {'cyl3'});
model.selection('adj1').set('outputdim', 3);
model.selection.create('adj2', 'Adjacent');
model.selection('adj2').model('comp1');
model.selection('adj2').label('Phases and Screens');
model.selection('adj2').set('input', {'adj1'});
model.selection('adj2').set('outputdim', 3);
model.selection.create('dif1', 'Difference');
model.selection('dif1').model('comp1');
model.selection('dif1').label('Screens');
model.selection('dif1').set('add', {'adj2'});
model.selection('dif1').set('subtract', {'cyl3'});
model.selection.create('cyl4', 'Cylinder');
model.selection('cyl4').model('comp1');
model.selection('cyl4').label('Cable Armor, Centerline');
model.selection('cyl4').set('entitydim', 1);
model.selection('cyl4').set('groupcontang', true);
model.selection('cyl4').set('angletol', 60);
model.selection('cyl4').set('r', 'Darm/2+Tarm');
model.selection('cyl4').set('top', '5*Tarm');
model.selection('cyl4').set('bottom', '-5*Tarm');
model.selection('cyl4').set('pos', {'0' '0' '-(Lsec/2+10*Tarm)'});
model.selection('cyl4').set('condition', 'somevertex');
model.selection.create('adj3', 'Adjacent');
model.selection('adj3').model('comp1');
model.selection('adj3').label('Cable Armor');
model.selection('adj3').set('entitydim', 1);
model.selection('adj3').set('input', {'cyl4'});
model.selection('adj3').set('outputdim', 3);
model.selection.create('uni2', 'Union');
model.selection('uni2').model('comp1');
model.selection('uni2').label('Conductors');
model.selection('uni2').set('input', {'adj2' 'adj3'});
model.selection.create('com1', 'Complement');
model.selection('com1').model('comp1');
model.selection('com1').label('Insulators');
model.selection('com1').set('input', {'uni2'});
model.selection.create('cyl5', 'Cylinder');
model.selection('cyl5').model('comp1');
model.selection('cyl5').label('Cable Domains');
model.selection('cyl5').set('r', 'Darm/2+Tarm');
model.selection('cyl5').set('condition', 'allvertices');
model.selection.create('adj4', 'Adjacent');
model.selection('adj4').model('comp1');
model.selection('adj4').label('Phases, Exterior Boundaries');
model.selection('adj4').set('input', {'cyl3'});

model.nodeGroup.create('grp1', 'Definitions', 'comp1');
model.nodeGroup('grp1').set('type', 'selection');
model.nodeGroup('grp1').placeAfter('selection', 'cyl5');
model.nodeGroup('grp1').add('selection', 'adj4');
model.nodeGroup('grp1').label('Mesh Selections');

model.selection.create('adj5', 'Adjacent');
model.selection('adj5').model('comp1');

model.nodeGroup('grp1').add('selection', 'adj5');

model.selection('adj5').label('Screens, Exterior Boundaries');
model.selection('adj5').set('input', {'dif1'});
model.selection.create('adj6', 'Adjacent');
model.selection('adj6').model('comp1');

model.nodeGroup('grp1').add('selection', 'adj6');

model.selection('adj6').label('Armor, Exterior Boundaries');
model.selection('adj6').set('input', {'adj3'});
model.selection.create('int1', 'Intersection');
model.selection('int1').model('comp1');

model.nodeGroup('grp1').add('selection', 'int1');

model.selection('int1').label('Phases, Boundaries Bottom');
model.selection('int1').set('entitydim', 2);
model.selection('int1').set('input', {'cyl2' 'adj4'});
model.selection.create('int2', 'Intersection');
model.selection('int2').model('comp1');

model.nodeGroup('grp1').add('selection', 'int2');

model.selection('int2').label('Screens, Boundaries Bottom (Mapped 3)');
model.selection('int2').set('entitydim', 2);
model.selection('int2').set('input', {'cyl2' 'adj5'});
model.selection.create('int3', 'Intersection');
model.selection('int3').model('comp1');

model.nodeGroup('grp1').add('selection', 'int3');

model.selection('int3').label('Armor, Boundaries Bottom');
model.selection('int3').set('entitydim', 2);
model.selection('int3').set('input', {'cyl2' 'adj6'});
model.selection.create('cyl6', 'Cylinder');
model.selection('cyl6').model('comp1');

model.nodeGroup('grp1').add('selection', 'cyl6');

model.selection('cyl6').label('Free Triangular 1');
model.selection('cyl6').set('entitydim', 2);
model.selection('cyl6').set('inputent', 'selections');
model.selection('cyl6').set('input', {'cyl2'});
model.selection('cyl6').set('r', 'Dcon/2-Dscup/8');
model.selection('cyl6').set('pos', {'Dpha/sqrt(3)' '0' '0'});
model.selection('cyl6').set('condition', 'allvertices');
model.selection.duplicate('cyl7', 'cyl6');

model.nodeGroup('grp1').add('selection', 'cyl7');

model.selection('cyl7').label('Mapped 1');
model.selection('cyl7').set('r', 'Dcon/2+Dscup/8');
model.selection('cyl7').set('rin', 'Dcon/2-Dscup/2');
model.selection.create('uni3', 'Union');
model.selection('uni3').model('comp1');

model.nodeGroup('grp1').add('selection', 'uni3');

model.selection('uni3').label('Copy Face 1, Source Boundaries');
model.selection('uni3').set('entitydim', 2);
model.selection('uni3').set('input', {'cyl6' 'cyl7'});
model.selection.create('dif2', 'Difference');
model.selection('dif2').model('comp1');

model.nodeGroup('grp1').add('selection', 'dif2');

model.selection('dif2').label('Copy Face 1, Destination Boundaries');
model.selection('dif2').set('entitydim', 2);
model.selection('dif2').set('add', {'int1'});
model.selection('dif2').set('subtract', {'uni3'});
model.selection.duplicate('cyl8', 'cyl6');

model.nodeGroup('grp1').add('selection', 'cyl8');

model.selection('cyl8').label('Free Triangular 2');
model.selection('cyl8').set('r', 'Tarm/2-Dsarm/5');
model.selection('cyl8').set('pos', {'Darm/2' '0' '0'});
model.selection.duplicate('cyl9', 'cyl8');

model.nodeGroup('grp1').add('selection', 'cyl9');

model.selection('cyl9').label('Mapped 2');
model.selection('cyl9').set('r', 'Tarm/2+Dsarm/5');
model.selection('cyl9').set('rin', 'Tarm/2-Dsarm/2');
model.selection.create('uni4', 'Union');
model.selection('uni4').model('comp1');

model.nodeGroup('grp1').add('selection', 'uni4');

model.selection('uni4').label('Copy Face 2, Source Boundaries');
model.selection('uni4').set('entitydim', 2);
model.selection('uni4').set('input', {'cyl8' 'cyl9'});
model.selection.create('dif3', 'Difference');
model.selection('dif3').model('comp1');

model.nodeGroup('grp1').add('selection', 'dif3');

model.selection('dif3').label('Copy Face 2, Destination Boundaries');
model.selection('dif3').set('entitydim', 2);
model.selection('dif3').set('add', {'int3'});
model.selection('dif3').set('subtract', {'uni4'});
model.selection.create('dif4', 'Difference');
model.selection('dif4').model('comp1');

model.nodeGroup('grp1').add('selection', 'dif4');

model.selection('dif4').label('Not Armor, Boundaries Bottom');
model.selection('dif4').set('entitydim', 2);
model.selection('dif4').set('add', {'cyl2'});
model.selection('dif4').set('subtract', {'int3'});
model.selection.create('cyl10', 'Cylinder');
model.selection('cyl10').model('comp1');

model.nodeGroup('grp1').add('selection', 'cyl10');

model.selection('cyl10').label('Mapped 4');
model.selection('cyl10').set('entitydim', 2);
model.selection('cyl10').set('inputent', 'selections');
model.selection('cyl10').set('input', {'dif4'});
model.selection('cyl10').set('r', 'Darm/2+Tarm/2');
model.selection('cyl10').set('rin', 'Darm/2-Tarm/2');
model.selection('cyl10').set('condition', 'allvertices');
model.selection('cyl10').set('angle2', 360);
model.selection.create('dif5', 'Difference');
model.selection('dif5').model('comp1');

model.nodeGroup('grp1').add('selection', 'dif5');

model.selection('dif5').label('Free Triangular 3');
model.selection('dif5').set('entitydim', 2);
model.selection('dif5').set('add', {'cyl2'});
model.selection('dif5').set('subtract', {'int1' 'int2' 'int3' 'cyl10'});
model.selection.create('cyl11', 'Cylinder');
model.selection('cyl11').model('comp1');

model.nodeGroup('grp1').add('selection', 'cyl11');

model.selection('cyl11').label('Free Triangular 3, Size 1');
model.selection('cyl11').set('entitydim', 2);
model.selection('cyl11').set('inputent', 'selections');
model.selection('cyl11').set('input', {'dif5'});
model.selection('cyl11').set('r', 'Darm/2+Tarm');
model.selection('cyl11').set('rin', 'Darm/2-Tarm');
model.selection('cyl11').set('condition', 'allvertices');
model.selection.create('cyl12', 'Cylinder');
model.selection('cyl12').model('comp1');

model.nodeGroup('grp1').add('selection', 'cyl12');

model.selection('cyl12').label('Swept 1, Distribution 1');
model.selection('cyl12').set('r', 'Dpha3/2');
model.selection('cyl12').set('condition', 'allvertices');
model.selection.duplicate('cyl13', 'cyl12');

model.nodeGroup('grp1').add('selection', 'cyl13');

model.selection('cyl13').label('Swept 1, Distribution 2');
model.selection('cyl13').set('r', '6*Dcab/2');
model.selection('cyl13').set('rin', 'Dpha3/2');
model.selection.create('uni5', 'Union');
model.selection('uni5').model('comp1');

model.nodeGroup('grp1').add('selection', 'uni5');

model.selection('uni5').label('Swept 1');
model.selection('uni5').set('input', {'cyl12' 'cyl13'});
model.selection.create('com2', 'Complement');
model.selection('com2').model('comp1');

model.nodeGroup('grp1').add('selection', 'com2');

model.selection('com2').label('Remaining Domains (Free Tetrahedral 1)');
model.selection('com2').set('input', {'uni5'});
model.selection.create('adj7', 'Adjacent');
model.selection('adj7').model('comp1');

model.nodeGroup('grp1').add('selection', 'adj7');

model.selection('adj7').label('Remaining Domains, Exterior Boundaries');
model.selection('adj7').set('input', {'com2'});
model.selection.create('dif6', 'Difference');
model.selection('dif6').model('comp1');

model.nodeGroup('grp1').add('selection', 'dif6');

model.selection('dif6').label('Convert 1');
model.selection('dif6').set('entitydim', 2);
model.selection('dif6').set('add', {'adj7'});
model.selection('dif6').set('subtract', {'uni1'});

model.view('view2').set('renderwireframe', true);
model.view('view2').camera.set('projection', 'perspective');

model.selection.create('int4', 'Intersection');
model.selection('int4').model('comp1');

model.nodeGroup('grp1').add('selection', 'int4');

model.selection('int4').label('Copy Face 3, Source Boundaries');
model.selection('int4').set('entitydim', 2);
model.selection('int4').set('input', {'cyl2' 'adj7'});
model.selection.create('int5', 'Intersection');
model.selection('int5').model('comp1');

model.nodeGroup('grp1').add('selection', 'int5');

model.selection('int5').label('Copy Face 3, Destination Boundaries');
model.selection('int5').set('entitydim', 2);
model.selection('int5').set('input', {'cyl1' 'adj7'});

model.view('view2').camera.set('projection', 'orthographic');
model.view('view2').set('renderwireframe', false);

model.selection.create('cyl14', 'Cylinder');
model.selection('cyl14').model('comp1');
model.selection('cyl14').label('Cable Face, Top');
model.selection('cyl14').set('entitydim', 2);
model.selection('cyl14').set('inputent', 'selections');
model.selection('cyl14').set('input', {'cyl1'});
model.selection('cyl14').set('r', 'Darm/2+Tarm');
model.selection('cyl14').set('condition', 'allvertices');

model.nodeGroup.create('grp2', 'Definitions', 'comp1');
model.nodeGroup('grp2').set('type', 'selection');
model.nodeGroup('grp2').placeAfter('selection', 'cyl5');
model.nodeGroup.move('grp2', 1);
model.nodeGroup('grp2').add('selection', 'cyl14');
model.nodeGroup('grp2').label('Postprocessing Selections');

model.selection.duplicate('cyl15', 'cyl14');

model.nodeGroup('grp2').add('selection', 'cyl15');

model.selection('cyl15').label('Cable Ring, Top');
model.selection('cyl15').set('rin', 'Darm/2-Tarm');
model.selection.duplicate('cyl16', 'cyl15');

model.nodeGroup('grp2').add('selection', 'cyl16');

model.selection('cyl16').label('Armor Wire Trio');
model.selection('cyl16').set('angle1', 'Tsec-2*360[deg]/Narm');
model.selection('cyl16').set('angle2', 'Tsec+2*360[deg]/Narm');

model.view('view1').camera.set('orthoscale', 0.5474655628204346);
model.view('view2').camera.set('orthoscale', 0.3977237939834595);
model.view('view3').camera.set('orthoscale', 0.3977237939834595);
model.view('view4').camera.set('orthoscale', 0.3555237948894501);
model.view('view1').set('locked', false);
model.view('view2').set('locked', false);
model.view('view3').set('locked', false);
model.view('view4').set('locked', false);
model.view('view5').set('locked', false);

model.title(['Submarine Cable 7c ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Geometry & Mesh 3D']);

model.description(['This MPH-file represents an intermediate state of the model that is constructed and analyzed in the Geometry & Mesh 3D tutorial. For more information, including a detailed introduction, step-by-step instructions and result analysis (with validation and references to academic research), see the *.pdf file that comes with the tutorial' native2unicode(hex2dec({'20' '19'}), 'unicode') 's main entry point in the Application Library: submarine_cable_07_geom_mesh_3d.']);

model.label('submarine_cable_07_c_geom_mesh_3d.mph');

model.view('view1').set('locked', true);
model.view('view2').set('locked', true);
model.view('view3').set('locked', true);
model.view('view4').set('locked', true);
model.view('view5').set('locked', true);
model.view('view1').camera.set('orthoscale', 0.4105992019176483);
model.view('view2').camera.set('orthoscale', 0.2982928454875946);
model.view('view3').camera.set('orthoscale', 0.2982928454875946);
model.view('view4').camera.set('orthoscale', 0.26664286851882935);

model.mesh('mesh1').create('ftri1', 'FreeTri');
model.mesh('mesh1').feature('ftri1').selection.named('cyl6');

model.view('view3').set('transparency', false);

model.mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.mesh('mesh1').feature('ftri1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 'Dcon/9');
model.mesh('mesh1').feature('ftri1').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri1').feature('size1').set('hmin', 'Dcon/9');
model.mesh('mesh1').run('ftri1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.named('cyl7');
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('cpf1', 'CopyFace');
model.mesh('mesh1').feature('cpf1').selection('source').geom(2);
model.mesh('mesh1').feature('cpf1').selection('destination').geom(2);
model.mesh('mesh1').feature('cpf1').selection('source').named('uni3');
model.mesh('mesh1').feature('cpf1').selection('destination').named('dif2');
model.mesh('mesh1').run('cpf1');
model.mesh('mesh1').create('ftri2', 'FreeTri');
model.mesh('mesh1').feature('ftri2').selection.named('cyl8');
model.mesh('mesh1').feature('ftri2').set('method', 'del');
model.mesh('mesh1').feature('ftri2').create('size1', 'Size');
model.mesh('mesh1').feature('ftri2').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmax', 'Tarm/4');
model.mesh('mesh1').feature('ftri2').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri2').feature('size1').set('hmin', 'Tarm/4');
model.mesh('mesh1').run('ftri2');
model.mesh('mesh1').create('map2', 'Map');
model.mesh('mesh1').feature('map2').selection.named('cyl9');
model.mesh('mesh1').run('map2');
model.mesh('mesh1').create('cpf2', 'CopyFace');
model.mesh('mesh1').feature('cpf2').selection('source').geom(2);
model.mesh('mesh1').feature('cpf2').selection('destination').geom(2);
model.mesh('mesh1').feature('cpf2').selection('source').named('uni4');
model.mesh('mesh1').feature('cpf2').selection('destination').named('dif3');
model.mesh('mesh1').run('cpf2');
model.mesh('mesh1').create('map3', 'Map');
model.mesh('mesh1').feature('map3').selection.named('int2');
model.mesh('mesh1').feature('map3').create('size1', 'Size');
model.mesh('mesh1').feature('map3').feature('size1').set('custom', true);
model.mesh('mesh1').feature('map3').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map3').feature('size1').set('hmax', '3*Tpbs');
model.mesh('mesh1').feature('map3').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('map3').feature('size1').set('hmin', '3*Tpbs');
model.mesh('mesh1').run('map3');
model.mesh('mesh1').create('ftri3', 'FreeTri');
model.mesh('mesh1').feature('ftri3').selection.named('dif5');
model.mesh('mesh1').feature('ftri3').create('size1', 'Size');
model.mesh('mesh1').feature('ftri3').feature('size1').selection.named('cyl11');
model.mesh('mesh1').feature('ftri3').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftri3').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('ftri3').feature('size1').set('hmax', 'Tarm');
model.mesh('mesh1').feature('ftri3').feature('size1').set('hminactive', true);
model.mesh('mesh1').feature('ftri3').feature('size1').set('hmin', 'Tarm');
model.mesh('mesh1').feature('ftri3').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftri3').feature('size1').set('hgrad', 2);
model.mesh('mesh1').run('ftri3');
model.mesh('mesh1').create('map4', 'Map');
model.mesh('mesh1').feature('map4').selection.named('cyl10');
model.mesh('mesh1').run('map4');
model.mesh('mesh1').feature('map4').selection.set([3141 3142 3145 3146]);
model.mesh('mesh1').feature('map4').selection.named('cyl10');
model.mesh('mesh1').create('swe1', 'Sweep');
model.mesh('mesh1').feature('swe1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('swe1').selection.named('uni5');

model.view('view3').set('transparency', true);

model.mesh('mesh1').feature('swe1').create('dis1', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis1').selection.named('cyl12');
model.mesh('mesh1').feature('swe1').feature('dis1').set('numelem', 'round(Lsec/(Dpha/3))');
model.mesh('mesh1').feature('swe1').create('dis2', 'Distribution');
model.mesh('mesh1').feature('swe1').feature('dis2').selection.named('cyl13');
model.mesh('mesh1').feature('swe1').feature('dis2').set('numelem', 'round(Lsec/(3*Tarm))');
model.mesh('mesh1').run('swe1');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('conv1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('conv1').selection.named('dif6');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').create('cpf3', 'CopyFace');
model.mesh('mesh1').feature('cpf3').selection('source').geom(2);
model.mesh('mesh1').feature('cpf3').selection('destination').geom(2);
model.mesh('mesh1').feature('cpf3').selection('source').named('int4');
model.mesh('mesh1').feature('cpf3').selection('destination').named('int5');
model.mesh('mesh1').run('cpf3');
model.mesh('mesh1').create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.mesh('mesh1').feature('ftet1').selection.named('com2');
model.mesh('mesh1').feature('ftet1').set('zscale', '1/6');
model.mesh('mesh1').feature('ftet1').set('optlevel', 'high');
model.mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.mesh('mesh1').feature('ftet1').feature('size1').set('custom', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hgradactive', true);
model.mesh('mesh1').feature('ftet1').feature('size1').set('hgrad', 2);
model.mesh('mesh1').run('ftet1');

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
model.result('pg1').run;
model.result('pg1').label('Mesh Quality, Volume Elements');
model.result('pg1').set('titletype', 'manual');
model.result('pg1').set('title', 'Mesh quality, volume elements');
model.result('pg1').set('view', 'view5');
model.result('pg1').set('edges', false);
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('mesh1').set('colortable', 'WaveLight');
model.result('pg1').feature('mesh1').set('filteractive', true);
model.result('pg1').feature('mesh1').set('logfilterexpr', 'z<Lsec/2-2*Nper*(Dcab+x+y)');
model.result('pg1').run;

model.view('view5').set('transparency', false);

model.result('pg1').run;
model.result.duplicate('pg2', 'pg1');
model.result('pg2').run;
model.result('pg2').label('Mesh Quality, Poor Quality Elements');
model.result('pg2').set('title', 'Mesh quality, poor quality elements');
model.result('pg2').run;
model.result('pg2').feature('mesh1').set('elemcolor', 'white');
model.result('pg2').feature('mesh1').set('wireframecolor', 'none');
model.result('pg2').feature('mesh1').create('sel1', 'MeshSelection');
model.result('pg2').feature('mesh1').feature('sel1').selection.named('adj3');

model.view('view5').set('transparency', true);

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature.duplicate('mesh2', 'mesh1');
model.result('pg2').run;
model.result('pg2').feature('mesh2').set('wireframecolor', 'black');
model.result('pg2').feature('mesh2').set('filteractive', false);
model.result('pg2').run;
model.result('pg2').feature('mesh2').feature('sel1').selection.named('dif1');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('mesh3', 'Mesh');
model.result('pg2').feature('mesh3').set('colortable', 'TrafficFlow');
model.result('pg2').feature('mesh3').set('colortabletrans', 'nonlinear');
model.result('pg2').feature('mesh3').set('nonlinearcolortablerev', true);
model.result('pg2').feature('mesh3').set('meshdomain', 'volume');
model.result('pg2').feature('mesh3').set('elemcolor', 'red');
model.result('pg2').feature('mesh3').set('filteractive', true);
model.result('pg2').feature('mesh3').set('elemfilter', 'quality');
model.result('pg2').feature('mesh3').set('tetkeep', 0.01);
model.result('pg2').run;
model.result.dataset.create('cpl1', 'CutPlane');
model.result.dataset('cpl1').set('quickplane', 'xy');
model.result.dataset('cpl1').set('quickz', '-Lsec/2');
model.result.dataset.create('cpl2', 'CutPlane');
model.result.dataset('cpl2').set('quickplane', 'xy');
model.result.dataset('cpl2').set('quickz', 'Lsec/2');
model.result.create('pg3', 'PlotGroup2D');
model.result('pg3').run;
model.result('pg3').label('Mesh Comparison, Source and Destination');
model.result('pg3').set('titletype', 'manual');
model.result('pg3').set('title', 'Mesh comparison, source and destination');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', '1');
model.result('pg3').feature('surf1').set('coloring', 'uniform');
model.result('pg3').feature('surf1').set('wireframe', true);
model.result('pg3').run;
model.result('pg3').feature.duplicate('surf2', 'surf1');
model.result('pg3').run;
model.result('pg3').feature('surf2').set('data', 'cpl2');
model.result('pg3').feature('surf2').set('color', 'blue');
model.result('pg3').run;
model.result('pg3').feature('surf2').create('def1', 'Deform');
model.result('pg3').feature('surf2').feature('def1').set('planecoordsys', 'cartesian');
model.result('pg3').feature('surf2').feature('def1').set('expr', {'' '' ''});
model.result('pg3').feature('surf2').feature('def1').set('descr', '');
model.result('pg3').run;
model.result('pg3').feature('surf2').feature('def1').set('expr', {'(x*cos(-Tsec)-y*sin(-Tsec))-x+0.002*x' '' ''});
model.result('pg3').feature('surf2').feature('def1').setIndex('expr', '(x*sin(-Tsec)+y*cos(-Tsec))-y+0.002*y', 1);
model.result('pg3').feature('surf2').feature('def1').set('scaleactive', true);
model.result('pg3').feature('surf2').feature('def1').set('scale', 1);
model.result('pg3').run;
model.result('pg2').run;
model.result('pg2').run;

model.view('view5').set('transparency', true);
model.view('view1').camera.set('orthoscale', 0.5474655628204346);
model.view('view2').camera.set('orthoscale', 0.3977237939834595);
model.view('view3').camera.set('orthoscale', 0.3977237939834595);
model.view('view4').camera.set('orthoscale', 0.3555237948894501);
model.view('view1').set('locked', false);
model.view('view2').set('locked', false);
model.view('view3').set('locked', false);
model.view('view4').set('locked', false);
model.view('view5').set('locked', false);

model.result('pg3').run;
model.result('pg2').run;

model.title(['Submarine Cable 7 ' native2unicode(hex2dec({'20' '14'}), 'unicode') ' Geometry & Mesh 3D']);

model.description(['The Inductive Effects 3D tutorial (the next tutorial in this series) requires quite a lot of preparation in terms of geometry handling and meshing. In fact, this is what oftentimes represents a major part of the efforts spent on large 3D FEM models (twisted cable models in particular). In order not to overlook these important topics, they are addressed in this separate tutorial.' newline  newline 'The tutorial is organized in four sections. The first part configures the camera settings (ensuring the geometry, mesh, and plots render as intended). Then, the geometry sequence is added, together with the selections. Finally, the mesh is constructed. Some postprocessing is done to investigate the quality of the mesh.']);

model.mesh.clearMeshes;

model.label('submarine_cable_07_geom_mesh_3d.mph');

model.modelNode.label('Components');

out = model;
