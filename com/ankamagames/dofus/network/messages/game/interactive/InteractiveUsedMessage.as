package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class InteractiveUsedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5745;

        private var _isInitialized:Boolean = false;
        public var entityId:uint = 0;
        public var elemId:uint = 0;
        public var skillId:uint = 0;
        public var duration:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5745);
        }

        public function initInteractiveUsedMessage(entityId:uint=0, elemId:uint=0, skillId:uint=0, duration:uint=0):InteractiveUsedMessage
        {
            this.entityId = entityId;
            this.elemId = elemId;
            this.skillId = skillId;
            this.duration = duration;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.entityId = 0;
            this.elemId = 0;
            this.skillId = 0;
            this.duration = 0;
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
            this.serializeAs_InteractiveUsedMessage(output);
        }

        public function serializeAs_InteractiveUsedMessage(output:IDataOutput):void
        {
            if (this.entityId < 0)
            {
                throw (new Error((("Forbidden value (" + this.entityId) + ") on element entityId.")));
            };
            output.writeInt(this.entityId);
            if (this.elemId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elemId) + ") on element elemId.")));
            };
            output.writeInt(this.elemId);
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element skillId.")));
            };
            output.writeShort(this.skillId);
            if (this.duration < 0)
            {
                throw (new Error((("Forbidden value (" + this.duration) + ") on element duration.")));
            };
            output.writeShort(this.duration);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_InteractiveUsedMessage(input);
        }

        public function deserializeAs_InteractiveUsedMessage(input:IDataInput):void
        {
            this.entityId = input.readInt();
            if (this.entityId < 0)
            {
                throw (new Error((("Forbidden value (" + this.entityId) + ") on element of InteractiveUsedMessage.entityId.")));
            };
            this.elemId = input.readInt();
            if (this.elemId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elemId) + ") on element of InteractiveUsedMessage.elemId.")));
            };
            this.skillId = input.readShort();
            if (this.skillId < 0)
            {
                throw (new Error((("Forbidden value (" + this.skillId) + ") on element of InteractiveUsedMessage.skillId.")));
            };
            this.duration = input.readShort();
            if (this.duration < 0)
            {
                throw (new Error((("Forbidden value (" + this.duration) + ") on element of InteractiveUsedMessage.duration.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive

