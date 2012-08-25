package com.ankamagames.dofus.network.messages.game.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildHousesInformationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var housesInformations:Vector.<HouseInformationsForGuild>;
        public static const protocolId:uint = 5919;

        public function GuildHousesInformationMessage()
        {
            this.housesInformations = new Vector.<HouseInformationsForGuild>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5919;
        }// end function

        public function initGuildHousesInformationMessage(param1:Vector.<HouseInformationsForGuild> = null) : GuildHousesInformationMessage
        {
            this.housesInformations = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.housesInformations = new Vector.<HouseInformationsForGuild>;
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
            this.serializeAs_GuildHousesInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildHousesInformationMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.housesInformations.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.housesInformations.length)
            {
                
                (this.housesInformations[_loc_2] as HouseInformationsForGuild).serializeAs_HouseInformationsForGuild(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildHousesInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildHousesInformationMessage(param1:IDataInput) : void
        {
            var _loc_4:HouseInformationsForGuild = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new HouseInformationsForGuild();
                _loc_4.deserialize(param1);
                this.housesInformations.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
