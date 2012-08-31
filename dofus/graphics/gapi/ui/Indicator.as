// Action script...

// [Initial MovieClip Action of sprite 1055]
#initclip 22
class dofus.graphics.gapi.ui.Indicator extends ank.gapi.core.UIAdvancedComponent
{
    var __get__rotate, _aCoordinates, __get__coordinates, __get__offset, gapi, attachMovie, _mcArrowShadow, _mcLight, _mcArrow, __set__coordinates, __set__offset, __set__rotate;
    function Indicator()
    {
        super();
    } // End of the function
    function set rotate(bRotate)
    {
        _bRotate = bRotate;
        //return (this.rotate());
        null;
    } // End of the function
    function set coordinates(aCoordinates)
    {
        _aCoordinates = aCoordinates;
        //return (this.coordinates());
        null;
    } // End of the function
    function set offset(nOffset)
    {
        _nOffset = nOffset;
        //return (this.offset());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Indicator.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        var _loc3 = _aCoordinates[0];
        var _loc2 = _aCoordinates[1];
        if (_bRotate)
        {
            var _loc8 = gapi.screenWidth / 2;
            var _loc7 = gapi.screenHeight / 2;
            var _loc4 = Math.atan2(_aCoordinates[1] - _loc7, _aCoordinates[0] - _loc8);
            var _loc5 = _loc4 * 180 / 3.141593E+000 - 90;
            _loc3 = _loc3 - (_nOffset == undefined ? (0) : (_nOffset * Math.cos(_loc4)));
            _loc2 = _loc2 - (_nOffset == undefined ? (0) : (_nOffset * Math.sin(_loc4)));
        }
        else
        {
            _loc2 = _loc2 - (_nOffset == undefined ? (0) : (_nOffset));
        } // end else if
        this.attachMovie("UI_Indicatorlight", "_mcLight", 10, {_x: _loc3, _y: _loc2});
        this.attachMovie("UI_IndicatorArrow", "_mcArrowShadow", 20, {_x: _loc3 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET, _y: _loc2 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET});
        this.attachMovie("UI_IndicatorArrow", "_mcArrow", 30, {_x: _loc3, _y: _loc2});
        var _loc6 = new Color(_mcArrowShadow);
        _loc6.setTransform(dofus.graphics.gapi.ui.Indicator.SHADOW_TRANSFORM);
        if (_bRotate)
        {
            _mcLight._rotation = _loc5;
            _mcArrow._rotation = _loc5;
            _mcArrowShadow._rotation = _loc5;
        } // end if
    } // End of the function
    static var CLASS_NAME = "Indicator";
    static var SHADOW_OFFSET = 3;
    static var SHADOW_TRANSFORM = {ra: 0, rb: 0, ga: 0, gb: 0, ba: 0, bb: 0, aa: 40, ab: 0};
    var _bRotate = true;
    var _nOffset = 0;
} // End of Class
#endinitclip
