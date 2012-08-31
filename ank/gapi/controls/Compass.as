// Action script...

// [Initial MovieClip Action of sprite 40]
#initclip 58
class ank.gapi.controls.Compass extends ank.gapi.core.UIBasicComponent
{
    var __get__updateOnLoad, __get__background, __get__arrow, __get__noArrow, _aCurrentCoords, __get__initialized, __get__currentCoords, _aTargetCoords, __get__targetCoords, addToQueue, __get__allCoords, attachMovie, createEmptyMovieClip, _mcArrow, __height, __width, _ldrBack, dispatchEvent, __set__allCoords, __set__arrow, __set__background, __set__currentCoords, __set__noArrow, __set__targetCoords, __set__updateOnLoad;
    function Compass()
    {
        super();
    } // End of the function
    function set updateOnLoad(bUpdateOnLoad)
    {
        _bUpdateOnLoad = bUpdateOnLoad;
        //return (this.updateOnLoad());
        null;
    } // End of the function
    function get updateOnLoad()
    {
        return (_bUpdateOnLoad);
    } // End of the function
    function set background(sBackground)
    {
        _sBackground = sBackground;
        //return (this.background());
        null;
    } // End of the function
    function get background()
    {
        return (_sBackground);
    } // End of the function
    function set arrow(sArrow)
    {
        _sArrow = sArrow;
        //return (this.arrow());
        null;
    } // End of the function
    function get arrow()
    {
        return (_sArrow);
    } // End of the function
    function set noArrow(sNoArrow)
    {
        _sNoArrow = sNoArrow;
        //return (this.noArrow());
        null;
    } // End of the function
    function get noArrow()
    {
        return (_sNoArrow);
    } // End of the function
    function set currentCoords(aCurrentCoords)
    {
        _aCurrentCoords = aCurrentCoords;
        if (this.__get__initialized())
        {
            this.layoutContent();
        } // end if
        //return (this.currentCoords());
        null;
    } // End of the function
    function set targetCoords(aTargetCoords)
    {
        _aTargetCoords = aTargetCoords;
        if (this.__get__initialized())
        {
            this.layoutContent();
        } // end if
        //return (this.targetCoords());
        null;
    } // End of the function
    function get targetCoords()
    {
        return (_aTargetCoords);
    } // End of the function
    function set allCoords(oAllCoords)
    {
        _aTargetCoords = oAllCoords.targetCoords;
        _aCurrentCoords = oAllCoords.currentCoords;
        if (this.__get__initialized())
        {
            this.addToQueue({object: this, method: layoutContent});
        } // end if
        //return (this.allCoords());
        null;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Compass.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie("Loader", "_ldrBack", 10, {contentPath: _sBackground, centerContent: false, scaleContent: true});
        this.createEmptyMovieClip("_mcArrow", 20);
        _mcArrow.attachMovie("Loader", "_ldrArrow", 10, {contentPath: _sNoArrow, centerContent: false, scaleContent: true});
        if (_bUpdateOnLoad)
        {
            this.addToQueue({object: this, method: layoutContent});
        } // end if
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _ldrBack.setSize(__width, __height);
        _mcArrow._x = __width / 2;
        _mcArrow._y = __height / 2;
        _mcArrow._ldrArrow.setSize(__width, __height);
        _mcArrow._ldrArrow._x = -__width / 2;
        _mcArrow._ldrArrow._y = -__height / 2;
    } // End of the function
    function layoutContent()
    {
        if (_aCurrentCoords == undefined)
        {
            return;
        } // end if
        if (_aCurrentCoords.length == 0)
        {
            return;
        } // end if
        if (_aTargetCoords == undefined)
        {
            return;
        } // end if
        if (_aTargetCoords.length == 0)
        {
            return;
        } // end if
        ank.utils.Timer.removeTimer(this, "compass");
        var _loc4 = _aTargetCoords[0] - _aCurrentCoords[0];
        var _loc3 = _aTargetCoords[1] - _aCurrentCoords[1];
        if (_loc4 == 0 && _loc3 == 0)
        {
            _mcArrow._ldrArrow.contentPath = _sNoArrow;
            _mcArrow._ldrArrow.content._rotation = _mcArrow._rotation;
            _mcArrow._rotation = 0;
            this.smoothRotation(0, 1);
        }
        else
        {
            var _loc2 = Math.atan2(_loc3, _loc4) * 5.729578E+001;
            _mcArrow._ldrArrow.contentPath = _sArrow;
            _mcArrow._ldrArrow.content._rotation = _mcArrow._rotation - _loc2;
            _mcArrow._rotation = _loc2;
            this.smoothRotation(_loc2, 1);
        } // end else if
    } // End of the function
    function smoothRotation(nMaxAngle, nSpeed)
    {
        _mcArrow._ldrArrow.content._rotation = _mcArrow._ldrArrow.content._rotation + nSpeed;
        nSpeed = -_mcArrow._ldrArrow.content._rotation * 2.000000E-001 + nSpeed * 7.000000E-001;
        if (Math.abs(nSpeed) > 1.000000E-002)
        {
            ank.utils.Timer.setTimer(this, "compass", this, smoothRotation, 50, [nMaxAngle, nSpeed]);
        }
        else
        {
            _mcArrow._ldrArrow.content._rotation = 0;
        } // end else if
    } // End of the function
    function onRelease()
    {
        this.dispatchEvent({type: "click"});
    } // End of the function
    function onReleaseOutside()
    {
        this.onRollOut();
    } // End of the function
    function onRollOver()
    {
        this.dispatchEvent({type: "over"});
    } // End of the function
    function onRollOut()
    {
        this.dispatchEvent({type: "out"});
    } // End of the function
    static var CLASS_NAME = "Compass";
    var _bUpdateOnLoad = true;
    var _sBackground = "CompassNormalBackground";
    var _sArrow = "CompassNormalArrow";
    var _sNoArrow = "CompassNormalNoArrow";
} // End of Class
#endinitclip
