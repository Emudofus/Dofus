// Action script...

// [Initial MovieClip Action of sprite 849]
#initclip 61
class ank.battlefield.mc.Cell extends MovieClip
{
    var data, _mcBattlefield, __get__num;
    function Cell()
    {
        super();
    } // End of the function
    function get num()
    {
        return (data.num);
    } // End of the function
    function initialize(b)
    {
        _mcBattlefield = b;
    } // End of the function
    function _release(Void)
    {
        _mcBattlefield.onCellRelease(this);
    } // End of the function
    function _rollOver(Void)
    {
        _mcBattlefield.onCellRollOver(this);
    } // End of the function
    function _rollOut(Void)
    {
        _mcBattlefield.onCellRollOut(this);
    } // End of the function
} // End of Class
#endinitclip
