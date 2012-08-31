// Action script...

// [Initial MovieClip Action of sprite 1082]
#initclip 52
class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerSpecialization extends ank.gapi.core.UIAdvancedComponent
{
    var _oSpec, __get__initialized, __get__specialization, addToQueue, api, _lblInfos, _lblSpecializationName, _lblOrderName, _ldrIcon, _txtSpecializationDescription, __set__specialization;
    function AlignmentViewerSpecialization()
    {
        super();
    } // End of the function
    function set specialization(oSpec)
    {
        _oSpec = oSpec;
        if (this.__get__initialized())
        {
            this.initData();
        } // end if
        //return (this.specialization());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerSpecialization.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initTexts()
    {
        _lblInfos.__set__text(api.lang.getText("PLAYER_SPECIALIZATION"));
    } // End of the function
    function initData()
    {
        if (_oSpec != undefined)
        {
            _lblSpecializationName.__set__text(_oSpec.name);
            _lblOrderName.__set__text(_oSpec.order.name);
            _ldrIcon.__set__contentPath(_oSpec.order.iconFile);
            _txtSpecializationDescription.__set__text(_oSpec.description);
        } // end if
    } // End of the function
    static var CLASS_NAME = "AlignmentViewerSpecialization";
} // End of Class
#endinitclip
