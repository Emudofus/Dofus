package com.ankamagames.dofus.network.messages.game.context.dungeon
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class DungeonLeftMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6149;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6149);
        }

        public function initDungeonLeftMessage(dungeonId:uint=0):DungeonLeftMessage
        {
            this.dungeonId = dungeonId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
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
            this.serializeAs_DungeonLeftMessage(output);
        }

        public function serializeAs_DungeonLeftMessage(output:IDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeInt(this.dungeonId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_DungeonLeftMessage(input);
        }

        public function deserializeAs_DungeonLeftMessage(input:IDataInput):void
        {
            this.dungeonId = input.readInt();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of DungeonLeftMessage.dungeonId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.dungeon

