package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GameDataPaddockObjectRemoveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5993;

        private var _isInitialized:Boolean = false;
        public var cellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5993);
        }

        public function initGameDataPaddockObjectRemoveMessage(cellId:uint=0):GameDataPaddockObjectRemoveMessage
        {
            this.cellId = cellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.cellId = 0;
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
            this.serializeAs_GameDataPaddockObjectRemoveMessage(output);
        }

        public function serializeAs_GameDataPaddockObjectRemoveMessage(output:IDataOutput):void
        {
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeShort(this.cellId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameDataPaddockObjectRemoveMessage(input);
        }

        public function deserializeAs_GameDataPaddockObjectRemoveMessage(input:IDataInput):void
        {
            this.cellId = input.readShort();
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of GameDataPaddockObjectRemoveMessage.cellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

