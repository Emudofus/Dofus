package com.ankamagames.dofus.network.messages.game.context.dungeon
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class DungeonKeyRingUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6296;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var available:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6296);
        }

        public function initDungeonKeyRingUpdateMessage(dungeonId:uint=0, available:Boolean=false):DungeonKeyRingUpdateMessage
        {
            this.dungeonId = dungeonId;
            this.available = available;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.available = false;
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
            this.serializeAs_DungeonKeyRingUpdateMessage(output);
        }

        public function serializeAs_DungeonKeyRingUpdateMessage(output:ICustomDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
            output.writeBoolean(this.available);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DungeonKeyRingUpdateMessage(input);
        }

        public function deserializeAs_DungeonKeyRingUpdateMessage(input:ICustomDataInput):void
        {
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of DungeonKeyRingUpdateMessage.dungeonId.")));
            };
            this.available = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.dungeon

