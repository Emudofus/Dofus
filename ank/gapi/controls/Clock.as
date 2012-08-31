// Action script...

// [Initial MovieClip Action of sprite 44]
#initclip 59
class ank.gapi.controls.Clock extends ank.gapi.core.UIBasicComponent
{
    var _sBackground, __get__background, _sArrowHours, __get__arrowHours, _sArrowMinutes, __get__arrowMinutes, _nHours, __get__initialized, __get__hours, _nMinutes, __get__minutes, _oUpdateFunction, __get__updateFunction, attachMovie, _ldrArrowHours, _ldrArrowMinutes, addToQueue, __height, __width, _ldrBack, dispatchEvent, __set__arrowHours, __set__arrowMinutes, __set__background, __set__hours, __set__minutes, __set__updateFunction;
    function Clock()
    {
        super();
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
    function set arrowHours(sArrowHours)
    {
        _sArrowHours = sArrowHours;
        //return (this.arrowHours());
        null;
    } // End of the function
    function get arrowHours()
    {
        return (_sArrowHours);
    } // End of the function
    function set arrowMinutes(sArrowMinutes)
    {
        _sArrowMinutes = sArrowMinutes;
        //return (this.arrowMinutes());
        null;
    } // End of the function
    function get arrowMinutes()
    {
        return (_sArrowMinutes);
    } // End of the function
    function set hours(nHours)
    {
        _nHours = nHours % 12;
        if (this.__get__initialized())
        {
            this.layoutContent();
        } // end if
        //return (this.hours());
        null;
    } // End of the function
    function get hours()
    {
        return (_nHours);
    } // End of the function
    function set minutes(nMinutes)
    {
        _nMinutes = nMinutes % 59;
        if (this.__get__initialized())
        {
            this.layoutContent();
        } // end if
        //return (this.minutes());
        null;
    } // End of the function
    function get minutes()
    {
        return (_nMinutes);
    } // End of the function
    function set updateFunction(oUpdateFunction)
    {
        _oUpdateFunction = oUpdateFunction;
        //return (this.updateFunction());
        null;
    } // End of the function
    function init()
    {
        super.init(false, ank.gapi.controls.Clock.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.attachMovie("Loader", "_ldrBack", 10, {contentPath: _sBackground, centerContent: false, scaleContent: true});
        this.attachMovie("Loader", "_ldrArrowHours", 20, {contentPath: _sArrowHours, centerContent: false, scaleContent: true});
        this.attachMovie("Loader", "_ldrArrowMinutes", 30, {contentPath: _sArrowMinutes, centerContent: false, scaleContent: true});
        _ldrArrowHours._visible = false;
        _ldrArrowMinutes._visible = false;
        this.addToQueue({object: this, method: layoutContent});
    } // End of the function
    function size()
    {
        super.size();
        this.arrange();
    } // End of the function
    function arrange()
    {
        _ldrBack.setSize(__width, __height);
        _ldrArrowHours.setSize(__width, __height);
        _ldrArrowMinutes.setSize(__width, __height);
    } // End of the function
    function layoutContent()
    {
        if (_oUpdateFunction != undefined)
        {
            var _loc2 = _oUpdateFunction.method.apply(_oUpdateFunction.object);
            ank.utils.Timer.setTimer(this, "clock", this, layoutContent, 30000);
            _nHours = _loc2[0];
            _nMinutes = _loc2[1];
        } // end if
        var _loc3 = 30 * _nHours + 6 * _nMinutes / 12 - 90;
        var _loc4 = 6 * _nMinutes - 90;
        _ldrArrowHours.content._rotation = _loc3;
        _ldrArrowMinutes.content._rotation = _loc4;
        _ldrArrowHours._visible = true;
        _ldrArrowMinutes._visible = true;
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
    static var CLASS_NAME = "Clock";
    var _bHoursLoaded = false;
    var _bMinutesLoaded = false;
} // End of Class
#endinitclip
