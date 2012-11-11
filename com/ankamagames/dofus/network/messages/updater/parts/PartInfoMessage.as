package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.dofus.network.types.updater.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartInfoMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var part:ContentPart;
        public var installationPercent:Number = 0;
        public static const protocolId:uint = 1508;

        public function PartInfoMessage()
        {
            this.part = new ContentPart();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1508;
        }// end function

        public function initPartInfoMessage(param1:ContentPart = null, param2:Number = 0) : PartInfoMessage
        {
            this.part = param1;
            this.installationPercent = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.part = new ContentPart();
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
            this.serializeAs_PartInfoMessage(param1);
            return;
        }// end function

        public function serializeAs_PartInfoMessage(param1:IDataOutput) : void
        {
            this.part.serializeAs_ContentPart(param1);
            param1.writeFloat(this.installationPercent);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartInfoMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartInfoMessage(param1:IDataInput) : void
        {
            this.part = new ContentPart();
            this.part.deserialize(param1);
            this.installationPercent = param1.readFloat();
            return;
        }// end function

    }
}
