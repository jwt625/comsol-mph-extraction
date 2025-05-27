function out = model
%
% gregory_maksutov_telescope_geom_sequence.m
%
% Model exported on May 26 2025, 21:32 by COMSOL 6.2.0.339.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Applications/COMSOL62/Multiphysics/applications/Ray_Optics_Module/Lenses_Cameras_and_Telescopes');

model.modelNode.create('comp1', true);

model.geom.create('geom1', 3);
model.geom('geom1').model('comp1');

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').label('Gregory-Maksutov Telescope Geometry Sequence');
model.geom('geom1').lengthUnit('mm');

% To import content from file, use:
% model.param.loadFile('FILENAME');
model.param.set('nix', '0.0', 'Global optical axis, x-component');
model.param.set('niy', '0.0', 'Global optical axis, y-component');
model.param.set('niz', '-1.0', 'Global optical axis, z-component');
model.param.set('R1_corr', '-268.6151[mm]', 'Corrector radius of curvature, surface 1');
model.param.set('R2_corr', '-286.1193[mm]', 'Corrector radius of curvature, surface 2');
model.param.set('Tc_corr', '30.0000[mm]', 'Corrector center thickness');
model.param.set('d0_corr', '225.0000[mm]', 'Corrector outer diameter');
model.param.set('d1_corr', '205.0000[mm]', 'Corrector diameter, surface 1');
model.param.set('d2_corr', '0.0', 'Corrector diameter, surface 2');
model.param.set('d1c_corr', '70.0000[mm]', 'Corrector clear aperture diameter, surface 1 (Central obstruction)');
model.param.set('d2c_corr', '60.0000[mm]', 'Corrector clear aperture diameter, surface 2 (Secondary mirror)');
model.param.set('R_prim', '-1111.6300[mm]', 'Primary mirror radius of curvature, surface 1');
model.param.set('Tc_prim', '25.0000[mm]', 'Primary mirror center thickness');
model.param.set('d0_prim', '225.0000[mm]', 'Primary mirror full diameter');
model.param.set('d1_prim', '217.5000[mm]', 'Primary mirror surface diameter');
model.param.set('dc_prim', '0', 'Primary mirror clear aperture diameter');
model.param.set('dh_prim', '60.0000[mm]', 'Primary mirror central hole diameter');
model.param.set('z_prim', '453.0476[mm]', 'Primary mirror z-coordinate, relative to secondary mirror');
model.param.set('d0_img', '50.0000[mm]', 'Image plane diameter');
model.param.set('z_img', '200.0000[mm]', 'Image plane z-coordinate, relative to primary mirror vertex');
model.param.set('delta_z_img', '0.3890[mm]', ' Image plane z-coordinate offset');

model.geom.load({'part1'}, 'Ray_Optics_Module/3D/Spherical_Lenses/spherical_lens_3d.mph', {'part1'});
model.geom('geom1').create('pi1', 'PartInstance');
model.geom('geom1').feature('pi1').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi1').set('part', 'part1');
model.geom('geom1').feature('pi1').label('Corrector');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R1', 'R1_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'R2', 'R2_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'Tc', 'Tc_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd0', 'd0_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1', 'd1_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2', 'd2_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd1_clear', 'd1c_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'd2_clear', 'd2c_corr');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'nix', 'nix');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niy', 'niy');
model.geom('geom1').feature('pi1').setEntry('inputexpr', 'niz', 'niz');
model.geom.load({'part2'}, 'Ray_Optics_Module/3D/Mirrors/spherical_mirror_3d.mph', {'part1'});
model.geom('geom1').run('pi1');
model.geom('geom1').create('pi2', 'PartInstance');
model.geom('geom1').feature('pi2').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi2').set('part', 'part2');
model.geom('geom1').feature('pi2').label('Primary mirror');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'R', 'R_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'Tc', 'Tc_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd0', 'd0_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd1', 'd1_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_clear', 'dc_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'd_hole', 'dh_prim');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'nix', '0.0');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niy', '0.0');
model.geom('geom1').feature('pi2').setEntry('inputexpr', 'niz', '1.0');
model.geom('geom1').feature('pi2').set('workplanesrc', 'pi1');
model.geom('geom1').feature('pi2').set('workplane', 'wp2');
model.geom('geom1').feature('pi2').set('displ', {'0' '0' 'z_prim'});
model.geom.load({'part3'}, 'Ray_Optics_Module/3D/Apertures_and_Obstructions/circular_planar_annulus.mph', {'part1'});
model.geom('geom1').run('pi2');
model.geom('geom1').create('pi3', 'PartInstance');
model.geom('geom1').feature('pi3').set('selkeepnoncontr', false);
model.geom('geom1').feature('pi3').set('part', 'part3');
model.geom('geom1').feature('pi3').label('Image plane');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd0', 'd0_img');
model.geom('geom1').feature('pi3').setEntry('inputexpr', 'd1', '0.0');
model.geom('geom1').feature('pi3').set('workplanesrc', 'pi2');
model.geom('geom1').feature('pi3').set('workplane', 'wp1');
model.geom('geom1').feature('pi3').set('displ', {'0' '0' 'z_img+delta_z_img'});
model.geom('geom1').runPre('fin');

model.view('view1').camera.set('projection', 'orthographic');

model.geom('geom1').feature('pi1').setEntry('selkeepdom', 'pi1_sel1', true);
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_sel2', true);
model.geom('geom1').feature('pi1').setEntry('selkeepbnd', 'pi1_sel3', true);
model.geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.geom('geom1').selection('csel1').label('Obstructions');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel3', 'csel1');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel7', 'csel1');
model.geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.geom('geom1').selection('csel2').label('Mirrors');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel4', 'csel2');
model.geom('geom1').selection.create('csel3', 'CumulativeSelection');
model.geom('geom1').selection('csel3').label('Clear Apertures');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel5', 'csel3');
model.geom('geom1').feature('pi1').setEntry('selcontributetobnd', 'pi1_sel6', 'csel3');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel1', 'csel2');
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_cylsel2', 'csel1');
model.geom('geom1').feature('pi2').setEntry('selkeepbnd', 'pi2_comsel2', true);
model.geom('geom1').feature('pi2').setEntry('selcontributetobnd', 'pi2_comsel2', 'csel1');
model.geom('geom1').feature('pi3').setEntry('selkeepbnd', 'pi3_sel1', true);

model.title([]);

model.description('');

model.label('gregory_maksutov_telescope_geom_sequence.mph');

model.modelNode.label('Components');

out = model;
