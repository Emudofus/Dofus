package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class MountRidingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5967;

        private var _isInitialized:Boolean = false;
        public var isRiding:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5967);
        }

        public function initMountRidingMessage(isRiding:Boolean=false):MountRidingMessage
        {
            this.isRiding = isRiding;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.isRiding = false;
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
            this.serializeAs_MountRidingMessage(output);
        }

        public function serializeAs_MountRidingMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.isRiding);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_MountRidingMessage(input);
        }

        public function deserializeAs_MountRidingMessage(input:IDataInput):void
        {
            this.isRiding = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

