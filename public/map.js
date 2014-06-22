var _badestellen,_freibaeder,_fkk,_hallenbaeder;

function init() {
    initMap();
}

function initMap() {
    var map = new L.Map('map');

    var min = 10;
    var max = 17;
    var reuse = true;

    var baseUrl = 'http://services.codefor.de/static/entwicklung-berlins/';
    var errorTile = baseUrl + 'error.png';

    var osmCopyright = "Map data &copy; 2012 OpenStreetMap contributors";

    var center = new L.LatLng(52.51, 13.37628);
    map.setView(center, min);

    var base = {
        'Hintergrund': new L.TileLayer('http://tiles3.buergerbautstadt.de/berlin/{z}/{x}/{y}.png', {
            minZoom: min,
            maxZoom: max,
            attribution: osmCopyright, 
            errorTileUrl: errorTile, 
            zIndex: 0,
            reuseTiles: reuse
        }).addTo(map),
    };

    var overlay = {};

    $.each(['1650','1690','1750','1800'], function(key,year) {
        overlay['Berlin um ' + year] = L.tileLayer(baseUrl + 'berlin' +  year + '/{z}/{x}/{y}.png', {
            'attribution': '<a href="http://fbinter.stadt-berlin.de/fb/berlin/service.jsp?id=berlin' + year + '@senstadt&type=WMS">Geoportal Berlin / Berlin um ' + year + '</a>',
            'minZoom': min,
            'maxZoom': max,
            'tms': true
        })
    });

    L.control.layers({}, overlay, {collapsed: false}).addTo(map);
}