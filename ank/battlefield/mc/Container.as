// Action script...

// [Initial MovieClip Action of sprite 844]
#initclip 56
class ank.battlefield.mc.Container extends MovieClip
{
    var _mcBattlefield, _oDatacenter, _sObjectsFile, maxDepth, minDepth, ExternalContainer, createEmptyMovieClip, _parent, SpriteInfos, Points, Text, OverHead, _mcMask, setMask, _xscale, _yscale, _x, _y;
    function Container(b, d, ofile)
    {
        super();
        this.initialize(b, d, ofile);
    } // End of the function
    function initialize(b, d, ofile)
    {
        if (d == undefined)
        {
            ank.utils.Logger.err("pas de _oDatacenter !");
        } // end if
        _mcBattlefield = b;
        _oDatacenter = d;
        _sObjectsFile = ofile;
        this.clear();
    } // End of the function
    function clear()
    {
        maxDepth = 0;
        minDepth = -1000;
        this.zoom(100);
        if (ExternalContainer == undefined)
        {
            this.createEmptyMovieClip("ExternalContainer", 100);
            var _loc2 = new MovieClipLoader();
            _loc2.addListener(_parent);
            _loc2.loadClip(_sObjectsFile, ExternalContainer);
        }
        else
        {
            ExternalContainer.clear();
        } // end else if
        SpriteInfos.removeMovieClip();
        this.createEmptyMovieClip("SpriteInfos", 200);
        Points.removeMovieClip();
        this.createEmptyMovieClip("Points", 300);
        Text.removeMovieClip();
        this.createEmptyMovieClip("Text", 400);
        OverHead.removeMovieClip();
        this.createEmptyMovieClip("OverHead", 500);
    } // End of the function
    function applyMask()
    {
        var _loc3 = _oDatacenter.Map.width - 1;
        var _loc2 = _oDatacenter.Map.height - 1;
        this.createEmptyMovieClip("_mcMask", 10);
        _mcMask.beginFill(0);
        _mcMask.moveTo(0, 0);
        _mcMask.lineTo(_loc3 * ank.battlefield.Constants.CELL_WIDTH, 0);
        _mcMask.lineTo(_loc3 * ank.battlefield.Constants.CELL_WIDTH, _loc2 * ank.battlefield.Constants.CELL_HEIGHT);
        _mcMask.lineTo(0, _loc2 * ank.battlefield.Constants.CELL_HEIGHT);
        _mcMask.lineTo(0, 0);
        _mcMask.endFill();
        this.setMask(_mcMask);
    } // End of the function
    function adjusteMap(Void)
    {
        this.zoomMap();
        this.center();
    } // End of the function
    function setColor(oTransform)
    {
        if (oTransform == undefined)
        {
            oTransform = new Object();
            oTransform.ra = 100;
            oTransform.rb = 0;
            oTransform.ga = 100;
            oTransform.gb = 0;
            oTransform.ba = 100;
            oTransform.bb = 0;
        } // end if
        var _loc3 = new Color(this);
        _loc3.setTransform(oTransform);
    } // End of the function
    function zoom(zFactor)
    {
        _xscale = zFactor;
        _yscale = zFactor;
    } // End of the function
    function getZoom()
    {
        return (_xscale);
    } // End of the function
    function setXY(x, y)
    {
        _x = x;
        _y = y;
    } // End of the function
    function center(Void)
    {
        var _loc3 = _xscale / 100;
        var _loc2 = _yscale / 100;
        var _loc5 = (_mcBattlefield.screenWidth - ank.battlefield.Constants.CELL_WIDTH * _loc3 * (_oDatacenter.Map.width - 1)) / 2;
        var _loc4 = (_mcBattlefield.screenHeight - ank.battlefield.Constants.CELL_HEIGHT * _loc2 * (_oDatacenter.Map.height - 1)) / 2;
        this.setXY(_loc5, _loc4);
    } // End of the function
    function zoomMap(Void)
    {
        var _loc4 = _oDatacenter.Map.width;
        var _loc3 = _oDatacenter.Map.height;
        var _loc2 = 0;
        if (_loc4 <= ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
        {
            return;
        } // end if
        if (_loc3 <= ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
        {
            return;
        } // end if
        if (_loc3 > _loc4)
        {
            _loc2 = _mcBattlefield.screenWidth / (ank.battlefield.Constants.CELL_WIDTH * (_loc4 - 1)) * 100;
        }
        else
        {
            _loc2 = _mcBattlefield.screenHeight / (ank.battlefield.Constants.CELL_HEIGHT * (_loc3 - 1)) * 100;
        } // end else if
        this.zoom(_loc2, false);
    } // End of the function
} // End of Class
#endinitclip
