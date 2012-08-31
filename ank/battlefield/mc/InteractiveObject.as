// Action script...

// [Initial MovieClip Action of sprite 850]
#initclip 62
class ank.battlefield.mc.InteractiveObject extends MovieClip
{
    var _battlefield, _oCell, _bInteractive, createEmptyMovieClip, _mclLoader, _mcExternal, __get__cellData;
    function InteractiveObject()
    {
        super();
    } // End of the function
    function initialize(b, oCell, bInteractive)
    {
        _battlefield = b;
        _oCell = oCell;
        _bInteractive = bInteractive == undefined ? (true) : (bInteractive);
    } // End of the function
    function select(bool)
    {
        var _loc3 = new Color(this);
        var _loc2 = new Object();
        if (bool)
        {
            _loc2 = {ra: 60, rb: 80, ga: 60, gb: 80, ba: 60, bb: 80};
        }
        else
        {
            _loc2 = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
        } // end else if
        _loc3.setTransform(_loc2);
    } // End of the function
    function loadExternalClip(sFile)
    {
        this.createEmptyMovieClip("_mcExternal", 10);
        _mclLoader = new MovieClipLoader();
        _mclLoader.addListener(this);
        _mclLoader.loadClip(sFile, _mcExternal);
    } // End of the function
    function get cellData()
    {
        return (_oCell);
    } // End of the function
    function _release(Void)
    {
        if (_bInteractive)
        {
            _battlefield.onObjectRelease(this);
        } // end if
    } // End of the function
    function _rollOver(Void)
    {
        if (_bInteractive)
        {
            _battlefield.onObjectRollOver(this);
        } // end if
    } // End of the function
    function _rollOut(Void)
    {
        if (_bInteractive)
        {
            _battlefield.onObjectRollOut(this);
        } // end if
    } // End of the function
    function onLoadInit(mc)
    {
        var _loc5 = mc._width;
        var _loc6 = mc._height;
        var _loc2 = _loc5 / _loc6;
        var _loc4 = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        if (_loc2 == _loc4)
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        }
        else if (_loc2 > _loc4)
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / _loc2;
        }
        else
        {
            mc._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * _loc2;
            mc._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
        } // end else if
        var _loc3 = mc.getBounds(mc._parent);
        mc._x = -_loc3.xMin - mc._width / 2;
        mc._y = -_loc3.yMin - mc._height;
    } // End of the function
} // End of Class
#endinitclip
