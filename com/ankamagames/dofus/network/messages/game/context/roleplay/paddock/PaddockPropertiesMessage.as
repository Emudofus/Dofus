package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockPropertiesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var properties:PaddockInformations;
        public static const protocolId:uint = 5824;

        public function PaddockPropertiesMessage()
        {
            this.properties = new PaddockInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5824;
        }// end function

        public function initPaddockPropertiesMessage(param1:PaddockInformations = null) : PaddockPropertiesMessage
        {
            this.properties = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.properties = new PaddockInformations();
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
            this.serializeAs_PaddockPropertiesMessage(param1);
            return;
        }// end function

        public function serializeAs_PaddockPropertiesMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.properties.getTypeId());
            this.properties.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockPropertiesMessage(param1);
            return;
        }// end function

        public function deserializeAs_PaddockPropertiesMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readUnsignedShort();
            this.properties = ProtocolTypeManager.getInstance(PaddockInformations, _loc_2);
            this.properties.deserialize(param1);
            return;
        }// end function

    }
}
