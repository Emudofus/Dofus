package com.ankamagames.dofus.network.messages.game.look
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class AccessoryPreviewMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6517;

        private var _isInitialized:Boolean = false;
        public var look:EntityLook;

        public function AccessoryPreviewMessage()
        {
            this.look = new EntityLook();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6517);
        }

        public function initAccessoryPreviewMessage(look:EntityLook=null):AccessoryPreviewMessage
        {
            this.look = look;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.look = new EntityLook();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_AccessoryPreviewMessage(output);
        }

        public function serializeAs_AccessoryPreviewMessage(output:IDataOutput):void
        {
            this.look.serializeAs_EntityLook(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AccessoryPreviewMessage(input);
        }

        public function deserializeAs_AccessoryPreviewMessage(input:IDataInput):void
        {
            this.look = new EntityLook();
            this.look.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.look

