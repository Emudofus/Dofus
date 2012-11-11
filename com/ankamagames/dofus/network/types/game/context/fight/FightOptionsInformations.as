package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class FightOptionsInformations extends Object implements INetworkType
    {
        public var isSecret:Boolean = false;
        public var isRestrictedToPartyOnly:Boolean = false;
        public var isClosed:Boolean = false;
        public var isAskingForHelp:Boolean = false;
        public static const protocolId:uint = 20;

        public function FightOptionsInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 20;
        }// end function

        public function initFightOptionsInformations(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : FightOptionsInformations
        {
            this.isSecret = param1;
            this.isRestrictedToPartyOnly = param2;
            this.isClosed = param3;
            this.isAskingForHelp = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.isSecret = false;
            this.isRestrictedToPartyOnly = false;
            this.isClosed = false;
            this.isAskingForHelp = false;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightOptionsInformations(param1);
            return;
        }// end function

        public function serializeAs_FightOptionsInformations(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.isSecret);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.isRestrictedToPartyOnly);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 2, this.isClosed);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 3, this.isAskingForHelp);
            param1.writeByte(_loc_2);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightOptionsInformations(param1);
            return;
        }// end function

        public function deserializeAs_FightOptionsInformations(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.isSecret = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.isRestrictedToPartyOnly = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.isClosed = BooleanByteWrapper.getFlag(_loc_2, 2);
            this.isAskingForHelp = BooleanByteWrapper.getFlag(_loc_2, 3);
            return;
        }// end function

    }
}
