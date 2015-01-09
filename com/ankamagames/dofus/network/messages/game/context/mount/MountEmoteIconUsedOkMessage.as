package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountEmoteIconUsedOkMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5978;

        private var _isInitialized:Boolean = false;
        public var mountId:int = 0;
        public var reactionType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5978);
        }

        public function initMountEmoteIconUsedOkMessage(mountId:int=0, reactionType:uint=0):MountEmoteIconUsedOkMessage
        {
            this.mountId = mountId;
            this.reactionType = reactionType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountId = 0;
            this.reactionType = 0;
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
            this.serializeAs_MountEmoteIconUsedOkMessage(output);
        }

        public function serializeAs_MountEmoteIconUsedOkMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.mountId);
            if (this.reactionType < 0)
            {
                throw (new Error((("Forbidden value (" + this.reactionType) + ") on element reactionType.")));
            };
            output.writeByte(this.reactionType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountEmoteIconUsedOkMessage(input);
        }

        public function deserializeAs_MountEmoteIconUsedOkMessage(input:ICustomDataInput):void
        {
            this.mountId = input.readInt();
            this.reactionType = input.readByte();
            if (this.reactionType < 0)
            {
                throw (new Error((("Forbidden value (" + this.reactionType) + ") on element of MountEmoteIconUsedOkMessage.reactionType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

