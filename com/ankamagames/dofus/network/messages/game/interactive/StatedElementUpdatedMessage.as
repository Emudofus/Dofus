package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StatedElementUpdatedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var statedElement:StatedElement;
        public static const protocolId:uint = 5709;

        public function StatedElementUpdatedMessage()
        {
            this.statedElement = new StatedElement();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5709;
        }// end function

        public function initStatedElementUpdatedMessage(param1:StatedElement = null) : StatedElementUpdatedMessage
        {
            this.statedElement = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.statedElement = new StatedElement();
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
            this.serializeAs_StatedElementUpdatedMessage(param1);
            return;
        }// end function

        public function serializeAs_StatedElementUpdatedMessage(param1:IDataOutput) : void
        {
            this.statedElement.serializeAs_StatedElement(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StatedElementUpdatedMessage(param1);
            return;
        }// end function

        public function deserializeAs_StatedElementUpdatedMessage(param1:IDataInput) : void
        {
            this.statedElement = new StatedElement();
            this.statedElement.deserialize(param1);
            return;
        }// end function

    }
}
