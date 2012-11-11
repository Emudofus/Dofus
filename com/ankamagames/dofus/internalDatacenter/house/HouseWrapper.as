package com.ankamagames.dofus.internalDatacenter.house
{
    import com.ankamagames.dofus.datacenter.houses.*;
    import com.ankamagames.dofus.internalDatacenter.guild.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class HouseWrapper extends Object implements IDataCenter
    {
        public var houseId:int;
        public var name:String;
        public var description:String;
        public var ownerName:String;
        public var isOnSale:Boolean = false;
        public var gfxId:int;
        public var defaultPrice:uint;
        public var guildIdentity:GuildWrapper;
        public var isSaleLocked:Boolean;

        public function HouseWrapper()
        {
            return;
        }// end function

        public static function create(param1:HouseInformations) : HouseWrapper
        {
            var _loc_4:* = null;
            var _loc_2:* = new HouseWrapper;
            var _loc_3:* = House.getGuildHouseById(param1.modelId);
            _loc_2.houseId = param1.houseId;
            _loc_2.name = _loc_3.name;
            _loc_2.description = _loc_3.description;
            _loc_2.ownerName = param1.ownerName;
            _loc_2.isOnSale = param1.isOnSale;
            _loc_2.gfxId = _loc_3.gfxId;
            _loc_2.defaultPrice = _loc_3.defaultPrice;
            _loc_2.isSaleLocked = param1.isSaleLocked;
            if (param1 is HouseInformationsExtended)
            {
                _loc_4 = param1 as HouseInformationsExtended;
                _loc_2.guildIdentity = GuildWrapper.create(_loc_4.guildInfo.guildId, _loc_4.guildInfo.guildName, _loc_4.guildInfo.guildEmblem, 0, true);
            }
            return _loc_2;
        }// end function

        public static function manualCreate(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean = false) : HouseWrapper
        {
            var _loc_6:* = new HouseWrapper;
            var _loc_7:* = House.getGuildHouseById(param1);
            _loc_6.houseId = param2;
            _loc_6.name = _loc_7.name;
            _loc_6.description = _loc_7.description;
            _loc_6.ownerName = param3;
            _loc_6.isOnSale = param4;
            _loc_6.gfxId = _loc_7.gfxId;
            _loc_6.defaultPrice = _loc_7.defaultPrice;
            _loc_6.isSaleLocked = param5;
            return _loc_6;
        }// end function

    }
}
