/**
* bezier.scad
*
* Given a set of control points, the bezier function returns points of the Bézier path. 
* Combined with the polyline, polyline3d or hull_polyline3d module defined in my lib-openscad, 
* you can create a Bézier curve.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier.html
*
**/ 

function _combi(r, n) = 
    n == 0 ? 1 : (_combi(r, n - 1) * (r - n + 1) / n);
        
function bezier_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_coordinate(t, pn, n, i + 1));
        
function _bezier_point(t, points) = 
    [
        bezier_coordinate(
            t, 
            [points[0][0], points[1][0], points[2][0], points[3][0]], 
            len(points) - 1
        ),
        bezier_coordinate(
            t, 
            [points[0][1], points[1][1], points[2][1], points[3][1]], 
            len(points) - 1
        ),
        bezier_coordinate(
            t, 
            [points[0][2], points[1][2], points[2][2], points[3][2]], 
            len(points) - 1
        )
    ];

function bezier(t_step, points) = 
    [
        for(t = [0: t_step: 1 + t_step]) 
            _bezier_point(t, points)
    ];