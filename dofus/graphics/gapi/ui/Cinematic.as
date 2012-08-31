// Action script...

// [Initial MovieClip Action of sprite 1030]
#initclip 251
class dofus.graphics.gapi.ui.Cinematic extends ank.gapi.core.UIAdvancedComponent
{
    var _sFile, __get__file, _oSequencer, __get__sequencer, addToQueue, _ldrLoader, unloadThis, __set__file, __set__sequencer;
    function Cinematic()
    {
        super();
    } // End of the function
    function set file(sFile)
    {
        _sFile = sFile;
        //return (this.file());
        null;
    } // End of the function
    function set sequencer(oSequencer)
    {
        _oSequencer = oSequencer;
        //return (this.sequencer());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Cinematic.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: loadFile});
    } // End of the function
    function addListeners()
    {
        _ldrLoader.addEventListener("complete", this);
    } // End of the function
    function loadFile()
    {
        _ldrLoader.__set__contentPath(_sFile);
    } // End of the function
    function complete(oEvent)
    {
        oEvent.target.content.cinematic = this;
    } // End of the function
    function onCinematicFinished()
    {
        _oSequencer.onActionEnd();
        this.unloadThis();
    } // End of the function
    static var CLASS_NAME = "Cinematic";
} // End of Class
#endinitclip
