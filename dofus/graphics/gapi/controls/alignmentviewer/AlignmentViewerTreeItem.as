// Action script...

// [Initial MovieClip Action of sprite 1068]
#initclip 38
class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem extends ank.gapi.core.UIAdvancedComponent
{
    var _ldrIcon, _nLdrX, _lblName, __width, _mcBackgroundLight, _mcBackgroundDark, _lblLevel, _nLblX;
    function AlignmentViewerTreeItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            var _loc3 = dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem.DEPTH_X_OFFSET * oItem.depth;
            if (oItem.data instanceof dofus.datacenter.Alignment)
            {
                _ldrIcon._x = _nLdrX + _loc3;
                _lblName._x = _nLdrX + _loc3;
                _lblName.__set__width(__width - _lblName._x);
                _lblName.__set__styleName("BrownLeftMediumBoldLabel");
                _mcBackgroundLight._visible = false;
                _mcBackgroundDark._visible = true;
                _ldrIcon.__set__contentPath("");
                _lblName.__set__text(oItem.data.name);
                _lblLevel.__set__text("");
            } // end if
            if (oItem.data instanceof dofus.datacenter.Order)
            {
                _ldrIcon._x = _nLdrX + _loc3;
                _lblName._x = _nLblX + _loc3;
                _lblName.__set__width(__width - _lblName._x);
                _lblName.__set__styleName("BrownLeftSmallBoldLabel");
                _mcBackgroundLight._visible = true;
                _mcBackgroundDark._visible = false;
                _ldrIcon.__set__contentPath(oItem.data.iconFile);
                _lblName.__set__text(oItem.data.name);
                _lblLevel.__set__text("");
            }
            else if (oItem.data instanceof dofus.datacenter.Specialization)
            {
                _ldrIcon._x = _nLdrX + _loc3;
                _lblName._x = _nLblX + _loc3;
                _lblName.__set__width(__width - _lblName._x);
                _lblName.__set__styleName("BrownLeftSmallLabel");
                _mcBackgroundLight._visible = false;
                _mcBackgroundDark._visible = false;
                _ldrIcon.__set__contentPath("");
                _lblLevel.__set__text(oItem.data.alignment.value > 0 ? (oItem.data.alignment.value + " ") : ("- "));
                _lblName.__set__text(oItem.data.name);
                _lblLevel.setSize(__width);
                _lblName.setSize(__width - _lblName._x - _lblLevel.__get__textWidth() - 30);
            } // end else if
        }
        else
        {
            _ldrIcon._x = _nLdrX;
            _lblName._x = _nLblX;
            _ldrIcon.__set__contentPath("");
            _lblName.__set__text("");
            _lblLevel.__set__text("");
            _mcBackgroundLight._visible = false;
            _mcBackgroundDark._visible = false;
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
        _nLdrX = _ldrIcon._x;
        _nLblX = _lblName._x;
    } // End of the function
    static var DEPTH_X_OFFSET = 10;
} // End of Class
#endinitclip
