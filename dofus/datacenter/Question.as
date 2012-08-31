// Action script...

// [Initial MovieClip Action of sprite 932]
#initclip 144
class dofus.datacenter.Question extends Object
{
    var _nQuestionID, _sQuestionText, _eaResponsesObjects, api, __get__id, __get__label, __get__responses;
    function Question(nQuestionID, aResponsesID, aQuestionParams)
    {
        super();
        this.initialize(nQuestionID, aResponsesID, aQuestionParams);
    } // End of the function
    function get id()
    {
        return (_nQuestionID);
    } // End of the function
    function get label()
    {
        return (_sQuestionText);
    } // End of the function
    function get responses()
    {
        return (_eaResponsesObjects);
    } // End of the function
    function initialize(nQuestionID, aResponsesID, aQuestionParams)
    {
        api = _global.API;
        _nQuestionID = nQuestionID;
        _sQuestionText = ank.utils.PatternDecoder.getDescription(api.lang.getDialogQuestionText(nQuestionID), aQuestionParams);
        _eaResponsesObjects = new ank.utils.ExtendedArray();
        for (var _loc3 = 0; _loc3 < aResponsesID.length; ++_loc3)
        {
            var _loc4 = Number(aResponsesID[_loc3]);
            _eaResponsesObjects.push({label: api.lang.getDialogResponseText(_loc4), id: _loc4});
        } // end of for
    } // End of the function
} // End of Class
#endinitclip
