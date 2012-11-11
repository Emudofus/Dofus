package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HousePropertiesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var properties:HouseInformations;
        public static const protocolId:uint = 5734;

        public function HousePropertiesMessage()
        {
            this.properties = new HouseInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5734;
        }// end function

        public function initHousePropertiesMessage(param1:HouseInformations = null) : HousePropertiesMessage
        {
            this.properties = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.properties = new HouseInformations();
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
            this.serializeAs_HousePropertiesMessage(param1);
            return;
        }// end function

        public function serializeAs_HousePropertiesMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.properties.getTypeId());
            this.properties.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HousePropertiesMessage(param1);
            return;
        }// end function

        public function deserializeAs_HousePropertiesMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.properties = ProtocolTypeManager.getInstance(HouseInformations, _loc_2);
            this.properties.deserialize(param1);
            return;
        }// end function

    }
}
