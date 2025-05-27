function out = model
%
% cross_grating_echelle_spectrograph_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Spectrometers_and_Monochromators');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('lam_mid', '525[nm]', 'Middle wavelength');
model.param.set('T_xdp', '500[1/mm]', 'Cross-dispersion line density');
model.param.set('sigma_xdp', '1/T_xdp', 'Cross-dispersion line spacing');
model.param.set('theta_xdp', 'asin(0.5*lam_mid/sigma_xdp)', 'Cross-dispersion angle of incidence');
model.param.set('theta_B', '63.43[deg]', 'Echelle blaze angle');
model.param.set('dtheta', '1.5[deg]', 'Echelle in-plane angle');
model.param.set('gamma', '10.0[deg]', 'Echelle out-of-plane angle');
model.param.set('R1_doub', '183.6850[mm]', 'Radius of curvature, surface 1');
model.param.set('R2_doub', '43.2490[mm]', 'Radius of curvature, surface 2');
model.param.set('R3_doub', '-64.1000[mm]', 'Radius of curvature, surface 3');
model.param.set('Tc1_doub', '1.5[mm]', 'Center thickness, element 1');
model.param.set('Tc2_doub', '3.5[mm]', 'Center thickness, element 2');
model.param.set('d0_doub', '22.5[mm]', 'Lens diameter');
model.param.set('BFL_doub', '97.4495[mm]', 'Back focal length');

model.geom('geom1').lengthUnit('mm');
model.geom('geom1').create('pt1', 'Point');
model.geom('geom1').feature('pt1').label('Entrance slit (point)');
model.geom('geom1').feature('pt1').set('selresult', true);
model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Doublet_and_Triplet_Lenses/spherical_doublet_lens_3d.mph', {'part3'});
model.geom('geom1').run('pt1');
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Collimator Lens');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R1', 'R1_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R2', 'R2_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R3', 'R3_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc1', 'Tc1_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc2', 'Tc2_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0_1', 'd0_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0_2', 'd0_doub');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd3', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2_clear', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd3_clear', 0);
model.geom('geom1').feature('pi1').set('displ', {'0' '0' 'BFL_doub'});
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_sel2', true);
model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_sel3', true);
model.geom('geom1').run('pi1');
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', true);
model.geom('geom1').feature('wp1').label('Cross Grating Incoming Reference');
model.geom('geom1').feature('wp1').set('planetype', 'normalvector');
model.geom('geom1').feature('wp1').set('normalvector', [0 1 0]);
model.geom('geom1').feature('wp1').set('normalcoord', [0 0 200]);
model.geom('geom1').run('wp1');
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', true);
model.geom('geom1').feature('wp2').label('Cross Grating Facet Tangent');
model.geom('geom1').feature('wp2').set('planetype', 'transformed');
model.geom('geom1').feature('wp2').set('workplane', 'wp1');
model.geom('geom1').feature('wp2').set('transrot', 'theta_xdp-gamma');
model.geom('geom1').run('wp2');
model.geom('geom1').create('wp3', 'WorkPlane');
model.geom('geom1').feature('wp3').set('unite', true);
model.geom('geom1').feature('wp3').label('Cross Grating Facet Normal');
model.geom('geom1').feature('wp3').set('planetype', 'transformed');
model.geom('geom1').feature('wp3').set('workplane', 'wp2');
model.geom('geom1').feature('wp3').set('transaxistype', 'y');
model.geom('geom1').feature('wp3').set('transrot', 90);
model.geom('geom1').run('wp3');
model.geom('geom1').create('wp4', 'WorkPlane');
model.geom('geom1').feature('wp4').set('unite', true);
model.geom('geom1').feature('wp4').label('Cross Grating Surface');
model.geom('geom1').feature('wp4').set('planetype', 'transformed');
model.geom('geom1').feature('wp4').set('workplane', 'wp3');
model.geom('geom1').feature('wp4').set('transaxistype', 'y');
model.geom('geom1').feature('wp4').set('transrot', 'theta_B+dtheta');
model.geom('geom1').feature('wp4').set('selresult', true);
model.geom('geom1').feature('wp4').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp4').geom.feature('r1').set('size', {'50.0' '25.0'});
model.geom('geom1').feature('wp4').geom.feature('r1').set('base', 'center');
model.geom('geom1').run('wp4');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature('ext1').label('Cross Grating');
model.geom('geom1').feature('ext1').setIndex('distance', 10, 0);
model.geom('geom1').feature('ext1').set('reverse', true);
model.geom('geom1').run('ext1');
model.geom('geom1').create('wp5', 'WorkPlane');
model.geom('geom1').feature('wp5').set('unite', true);
model.geom('geom1').feature('wp5').label('Cross Grating Outgoing Reference');
model.geom('geom1').feature('wp5').set('planetype', 'transformed');
model.geom('geom1').feature('wp5').set('workplane', 'wp3');
model.geom('geom1').feature('wp5').set('transaxistype', 'x');
model.geom('geom1').feature('wp5').set('transrot', 'theta_xdp+gamma');
model.geom('geom1').insertFile('cross_grating_echelle_spectrograph_petzval_lens_geom_sequence.mph', 'geom1');
model.geom('geom1').feature('pi2').set('workplane', 'wp5');
model.geom('geom1').feature('pi2').set('displ', {'0' '-1.5[mm]' '75.0[mm]'});
model.geom('geom1').feature('pi9').active(false);
model.geom('geom1').feature('pi10').active(false);
model.geom('geom1').feature('pi11').active(false);
model.geom('geom1').run('pi11');
model.geom('geom1').create('sca1', 'Scale');
model.geom('geom1').feature('sca1').selection('input').set({'pi2' 'pi3' 'pi4' 'pi5' 'pi6' 'pi7' 'pi8'});
model.geom('geom1').feature('sca1').set('isotropic', 0.667);
model.geom('geom1').feature('sca1').set('workplanesrc', 'pi2');
model.geom('geom1').feature('sca1').set('workplane', 'wp1');
model.geom('geom1').feature('ext1').set('contributeto', 'csel1');

model.param.set('d0_D', '25.0[mm]');

model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.title([]);

model.description('');

model.label('cross_grating_echelle_spectrograph_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
