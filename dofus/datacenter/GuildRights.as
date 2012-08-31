// Action script...

// [Initial MovieClip Action of sprite 957]
#initclip 169
class dofus.datacenter.GuildRights extends Object
{
    var _nRights, __get__value, __get__isBoss, __get__canBann, __get__canCollectKamas, __get__canCollectObjects, __get__canCollectResources, __get__canDefendTaxCollector, __get__canHireTaxCollector, __get__canInvite, __get__canManageBoost, __get__canManageRanks, __get__canManageRights, __get__canManageXPContitribution, __set__value;
    function GuildRights(nRights)
    {
        super();
        _nRights = nRights;
    } // End of the function
    function get value()
    {
        return (_nRights);
    } // End of the function
    function set value(nValue)
    {
        _nRights = nValue;
        //return (this.value());
        null;
    } // End of the function
    function get isBoss()
    {
        return ((_nRights & 1) == 1);
    } // End of the function
    function get canManageBoost()
    {
        //return (this.isBoss() || (_nRights & 2) == 2);
    } // End of the function
    function get canManageRights()
    {
        //return (this.isBoss() || (_nRights & 4) == 4);
    } // End of the function
    function get canInvite()
    {
        //return (this.isBoss() || (_nRights & 8) == 8);
    } // End of the function
    function get canBann()
    {
        //return (this.isBoss() || (_nRights & 16) == 16);
    } // End of the function
    function get canManageXPContitribution()
    {
        //return (this.isBoss() || (_nRights & 32) == 32);
    } // End of the function
    function get canManageRanks()
    {
        //return (this.isBoss() || (_nRights & 64) == 64);
    } // End of the function
    function get canHireTaxCollector()
    {
        //return (this.isBoss() || (_nRights & 128) == 128);
    } // End of the function
    function get canDefendTaxCollector()
    {
        //return (this.isBoss() || (_nRights & 256) == 256);
    } // End of the function
    function get canCollectKamas()
    {
        //return (this.isBoss() || (_nRights & 512) == 512);
    } // End of the function
    function get canCollectObjects()
    {
        //return (this.isBoss() || (_nRights & 1024) == 1024);
    } // End of the function
    function get canCollectResources()
    {
        //return (this.isBoss() || (_nRights & 2048) == 2048);
    } // End of the function
} // End of Class
#endinitclip
