// Action script...

// [Initial MovieClip Action of sprite 892]
#initclip 104
class dofus.datacenter.TutorialBloc extends Object
{
    var _sID, _nType, __get__id, __get__type;
    function TutorialBloc(sID, nType)
    {
        super();
        _sID = sID;
        _nType = nType;
    } // End of the function
    function get id()
    {
        return (_sID);
    } // End of the function
    function get type()
    {
        return (_nType);
    } // End of the function
    static var TYPE_ACTION = 0;
    static var TYPE_WAITING = 1;
    static var TYPE_IF = 2;
} // End of Class
#endinitclip
