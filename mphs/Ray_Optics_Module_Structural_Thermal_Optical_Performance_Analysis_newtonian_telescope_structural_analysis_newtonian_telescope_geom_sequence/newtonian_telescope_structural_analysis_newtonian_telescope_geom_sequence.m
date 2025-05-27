function out = model
%
% newtonian_telescope_structural_analysis_newtonian_telescope_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Structural_Thermal_Optical_Performance_Analysis');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').label('Newtonian Telescope Geometry Sequence');
model.geom('geom1').lengthUnit('mm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nix', '0', 'Global optical axis, x-component');
model.param.set('niy', '0', 'Global optical axis, y-component');
model.param.set('niz', '1', 'Global optical axis, z-component');
model.param.set('d_pupil', '250[mm]', 'Entrance pupil diameter');
model.param.set('f', '1000[mm]', 'Primary mirror focal length');
model.param.set('k', '-1.0', 'Primary mirror conic constant');
model.param.set('F', 'f/d_pupil', 'Primary mirror focal ratio');
model.param.set('f_image', '200[mm]', 'Image plane position (relative to optical axis)');
model.param.set('d_sec', 'f_image/F', 'Secondary mirror diameter (projected)');
model.param.set('delta_sec', 'sqrt(2)*d_sec*(d_pupil-d_sec)/(4*(f-f_image))', 'Secondary mirror offset (relative to optical axis)');
model.param.set('d_image', 'd_sec', 'Image plane diameter');
model.param.set('d_clear', '0', 'Primary mirror clear diameter (use full mirror surface)');
model.param.set('d1_prim', '260[mm]', 'Primary mirror surface diameter');
model.param.set('d0_prim', '275[mm]', 'Primary mirror full diameter');
model.param.set('Tc_prim', '35[mm]', 'Primary mirror thickness');
model.param.set('Tc_sec', '10[mm]', 'Secondary mirror thickness');

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Mirrors/conic_mirror_on_axis_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Primary Mirror');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R', '-2*f');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'k', 'k');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', 'Tc_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'd0_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 'd1_prim');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_clear', 'd_clear');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd_hole', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', '-nix');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', '-niy');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', '-niz');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_r', 0);
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'n_extra_a', 0);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Primary Obstructions');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Secondary Obstructions');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Detector');
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_cylsel1', true);
model.geom('geom1').feature('pi1').setEntry('selshowbnd', 'pi1_cylsel1', true);
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_adjsel1', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_cylsel2', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_comsel2', 'csel1');
model.geom.load({'part2'}, 'Ray_Optics_Module/3D/Mirrors/elliptical_planar_mirror_3d.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').label('Secondary Mirror');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Tc', 'Tc_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd0', '1.25*d_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'theta', '45.0[deg]');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'dx', 'delta_sec');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niz', -1);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nxx', -1);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nxy', 0);
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nxz', 0);
model.geom('geom1').feature('pi2').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi2').set('workplane', 'wp1');
model.geom('geom1').feature('pi2').set('displ', {'0' '0' '-(f-f_image)'});
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_cylsel1', true);
model.geom('geom1').feature('pi2').setEntry('selshowbnd', 'pi2_cylsel1', true);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_adjsel1', 'csel2');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_comsel1', 'csel2');
model.geom.load({'part3'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/circular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').label('Secondary Obstruction');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd0', '1.30*d_sec');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi3').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi3').set('workplane', 'wp1');
model.geom('geom1').feature('pi3').set('displ', {'-delta_sec' '0' '0'});
model.geom('geom1').feature('pi3').setIndex('displ', 'd_sec', 2);
model.geom('geom1').feature('pi3').setEntry('selcontributetobnd', 'pi3_sel1', 'csel2');
model.geom('geom1').run('pi3');
model.geom('geom1').create('pi4', 'PartInstance');
model.geom('geom1').feature('pi4').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi4').set('part', 'part3');
model.geom('geom1').feature('pi4').label('Image Plane');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd0', 'd_image');
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'd1', 0);
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'nix', 0);
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'niy', 0);
model.geom('geom1').feature('pi4').setEntry('inputexpr', 'niz', 1);
model.geom('geom1').feature('pi4').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi4').set('workplane', 'wp4');
model.geom('geom1').feature('pi4').set('displ', {'0' '0' '-f_image'});
model.geom('geom1').feature('pi4').setEntry('selcontributetobnd', 'pi4_sel1', 'csel3');
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.title([]);

model.description('');

model.label('newtonian_telescope_structural_analysis_newtonian_telescope_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
