// Action script...

// [Action in Frame 1]
this.initStart = function ()
{
    setProperty("", _quality, "HIGH");
    ank.utils.Extensions.addExtensions();
    if (_global.LOAD_FROM_LOADER)
    {
        _global.API = new dofus.utils.Api();
        API.initialize(this);
        API.kernel.start();
    } // end if
};
this.forceMouseOver = function ()
{
    this.attachMovie("clipForceOver", "_mcForceOver", 1000, {_x: this._xmouse, _y: this._ymouse});
};
this.initStart();
