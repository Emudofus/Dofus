package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.dofus.network.types.game.interactive.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveElementUpdatedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var interactiveElement:InteractiveElement;
        public static const protocolId:uint = 5708;

        public function InteractiveElementUpdatedMessage()
        {
            this.interactiveElement = new InteractiveElement();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5708;
        }// end function

        public function initInteractiveElementUpdatedMessage(param1:InteractiveElement = null) : InteractiveElementUpdatedMessage
        {
            this.interactiveElement = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.interactiveElement = new InteractiveElement();
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
            this.serializeAs_InteractiveElementUpdatedMessage(param1);
            return;
        }// end function

        public function serializeAs_InteractiveElementUpdatedMessage(param1:IDataOutput) : void
        {
            this.interactiveElement.serializeAs_InteractiveElement(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveElementUpdatedMessage(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveElementUpdatedMessage(param1:IDataInput) : void
        {
            this.interactiveElement = new InteractiveElement();
            this.interactiveElement.deserialize(param1);
            return;
        }// end function

    }
}
