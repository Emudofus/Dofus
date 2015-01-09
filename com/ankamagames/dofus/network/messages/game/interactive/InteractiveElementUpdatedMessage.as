package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class InteractiveElementUpdatedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5708;

        private var _isInitialized:Boolean = false;
        public var interactiveElement:InteractiveElement;

        public function InteractiveElementUpdatedMessage()
        {
            this.interactiveElement = new InteractiveElement();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5708);
        }

        public function initInteractiveElementUpdatedMessage(interactiveElement:InteractiveElement=null):InteractiveElementUpdatedMessage
        {
            this.interactiveElement = interactiveElement;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.interactiveElement = new InteractiveElement();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_InteractiveElementUpdatedMessage(output);
        }

        public function serializeAs_InteractiveElementUpdatedMessage(output:ICustomDataOutput):void
        {
            this.interactiveElement.serializeAs_InteractiveElement(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InteractiveElementUpdatedMessage(input);
        }

        public function deserializeAs_InteractiveElementUpdatedMessage(input:ICustomDataInput):void
        {
            this.interactiveElement = new InteractiveElement();
            this.interactiveElement.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive

