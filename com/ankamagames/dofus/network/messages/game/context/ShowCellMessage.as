package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ShowCellMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5612;

        private var _isInitialized:Boolean = false;
        public var sourceId:int = 0;
        public var cellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5612);
        }

        public function initShowCellMessage(sourceId:int=0, cellId:uint=0):ShowCellMessage
        {
            this.sourceId = sourceId;
            this.cellId = cellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.sourceId = 0;
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
            this.serializeAs_ShowCellMessage(output);
        }

        public function serializeAs_ShowCellMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.sourceId);
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeVarShort(this.cellId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShowCellMessage(input);
        }

        public function deserializeAs_ShowCellMessage(input:ICustomDataInput):void
        {
            this.sourceId = input.readInt();
            this.cellId = input.readVarUhShort();
            if ((((this.cellId < 0)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of ShowCellMessage.cellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

