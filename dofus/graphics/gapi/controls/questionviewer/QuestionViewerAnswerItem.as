// Action script...

// [Initial MovieClip Action of sprite 1065]
#initclip 35
class dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem extends ank.gapi.core.UIBasicComponent
{
    var _mcRound, _txtResponse;
    function QuestionViewerAnswerItem()
    {
        super();
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            _mcRound._visible = true;
            _txtResponse.__set__text(oItem.label);
        }
        else
        {
            _mcRound._visible = false;
            _txtResponse.__set__text("");
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function size()
    {
        super.size();
    } // End of the function
} // End of Class
#endinitclip
