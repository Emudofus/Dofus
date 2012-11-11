package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AccountHouseMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houses:Vector.<AccountHouseInformations>;
        public static const protocolId:uint = 6315;

        public function AccountHouseMessage()
        {
            this.houses = new Vector.<AccountHouseInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6315;
        }// end function

        public function initAccountHouseMessage(param1:Vector.<AccountHouseInformations> = null) : AccountHouseMessage
        {
            this.houses = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.houses = new Vector.<AccountHouseInformations>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AccountHouseMessage(param1);
            return;
        }// end function

        public function serializeAs_AccountHouseMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.houses.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.houses.length)
            {
                
                (this.houses[_loc_2] as AccountHouseInformations).serializeAs_AccountHouseInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AccountHouseMessage(param1);
            return;
        }// end function

        public function deserializeAs_AccountHouseMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new AccountHouseInformations();
                _loc_4.deserialize(param1);
                this.houses.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
