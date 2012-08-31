// Action script...

// [Initial MovieClip Action of sprite 908]
#initclip 120
class dofus.datacenter.Datacenter extends Object
{
    var _oAPI, Player, Basics, Challenges, Sprites, Houses, Storages, Game, Areas, Map, Temporary, Exchange;
    function Datacenter(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        _oAPI = oAPI;
        Player = new dofus.datacenter.LocalPlayer(oAPI);
        Basics = new dofus.datacenter.Basics();
        Challenges = new ank.utils.ExtendedObject();
        Sprites = new ank.utils.ExtendedObject();
        Houses = new ank.utils.ExtendedObject();
        Storages = new ank.utils.ExtendedObject();
        Game = new dofus.datacenter.Game();
        Areas = new ank.utils.ExtendedObject();
        Map = new Object();
        Temporary = new Object();
    } // End of the function
    function clear()
    {
        Player = new dofus.datacenter.LocalPlayer(_oAPI);
        Basics.initialize();
        Challenges = new ank.utils.ExtendedObject();
        Sprites = new ank.utils.ExtendedObject();
        Houses = new ank.utils.ExtendedObject();
        Storages = new ank.utils.ExtendedObject();
        Game = new dofus.datacenter.Game();
        Areas = new ank.utils.ExtendedObject();
        Map = new Object();
        Temporary = new Object();
        delete this.Exchange;
    } // End of the function
    function clearGame()
    {
        Game = new dofus.datacenter.Game();
    } // End of the function
} // End of Class
#endinitclip
