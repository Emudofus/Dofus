package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class PaddockWrapper extends Object implements IDataCenter
    {
        public var maxOutdoorMount:uint;
        public var maxItems:uint;
        public var price:uint = 0;
        public var guildId:int = 0;
        public var guildIdentity:GuildWrapper;
        public var isSaleLocked:Boolean;
        public var isAbandonned:Boolean;

        public function PaddockWrapper()
        {
            return;
        }// end function

        public static function create(param1:PaddockInformations) : PaddockWrapper
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new PaddockWrapper;
            _loc_2.maxOutdoorMount = param1.maxOutdoorMount;
            _loc_2.maxItems = param1.maxItems;
            if (param1 is PaddockBuyableInformations)
            {
                _loc_3 = param1 as PaddockBuyableInformations;
                _loc_2.price = _loc_3.price;
                _loc_2.isSaleLocked = _loc_3.locked;
            }
            if (param1 is PaddockAbandonnedInformations)
            {
                _loc_4 = param1 as PaddockAbandonnedInformations;
                _loc_2.guildId = _loc_4.guildId;
                _loc_2.isAbandonned = true;
            }
            if (param1 is PaddockPrivateInformations)
            {
                _loc_5 = param1 as PaddockPrivateInformations;
                _loc_2.guildIdentity = GuildWrapper.create(_loc_5.guildInfo.guildId, _loc_5.guildInfo.guildName, _loc_5.guildInfo.guildEmblem, 0, true);
            }
            return _loc_2;
        }// end function

    }
}
