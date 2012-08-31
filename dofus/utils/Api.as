// Action script...

// [Initial MovieClip Action of sprite 827]
#initclip 39
class dofus.utils.Api extends Object
{
    var _oConfig, _oKernel, _oDatacenter, _oNetwork, _oGfx, _oUI, _oSounds, _oLang, _oColors, __get__colors, __get__config, __get__datacenter, __get__gfx, __get__kernel, __get__lang, __get__network, __get__sounds, __get__ui;
    function Api()
    {
        super();
    } // End of the function
    function get config()
    {
        return (_oConfig);
    } // End of the function
    function get kernel()
    {
        return (_oKernel);
    } // End of the function
    function get datacenter()
    {
        return (_oDatacenter);
    } // End of the function
    function get network()
    {
        return (_oNetwork);
    } // End of the function
    function get gfx()
    {
        return (_oGfx);
    } // End of the function
    function get ui()
    {
        return (_oUI);
    } // End of the function
    function get sounds()
    {
        return (_oSounds);
    } // End of the function
    function get lang()
    {
        return (_oLang);
    } // End of the function
    function get colors()
    {
        return (_oColors);
    } // End of the function
    function initialize(mcCore)
    {
        _oConfig = _global.CONFIG;
        _oLang = new dofus.utils.DofusTranslator();
        _oUI = mcCore.GAPI;
        _oUI.__set__api(this);
        _oSounds = _global.MODULE_SOMA.sm;
        _global.SOMA = _oSounds;
        _oKernel = new dofus.Kernel(this);
        _oDatacenter = new dofus.datacenter.Datacenter(this);
        _oNetwork = new dofus.aks.Aks(this);
        _oGfx = mcCore.BATTLEFIELD;
        _oGfx.initialize(_oDatacenter, dofus.Constants.GROUND_FILE, dofus.Constants.OBJECTS_FILE, this);
        _oColors = _global.GAC;
    } // End of the function
} // End of Class
#endinitclip
