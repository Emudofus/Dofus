package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TeleportOnSameMapMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6048;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var cellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6048);
        }

        public function initTeleportOnSameMapMessage(targetId:int=0, cellId:uint=0):TeleportOnSameMapMessage
        {
            this.targetId = targetId;
            this.cellId = cellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetId = 0;
            this.cellId = 0;
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
            this.serializeAs_TeleportOnSameMapMessage(output);
        }

        public function serializeAs_TeleportOnSameMapMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.targetId);
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeVarShort(this.cellId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportOnSameMapMessage(input);
        }

        public function deserializeAs_TeleportOnSameMapMessage(input:ICustomDataInput):void
        {
            this.targetId = input.readInt();
            this.cellId = input.readVarUhShort();
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of TeleportOnSameMapMessage.cellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

