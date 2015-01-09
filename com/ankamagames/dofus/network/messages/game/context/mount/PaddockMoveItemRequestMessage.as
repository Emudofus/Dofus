package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PaddockMoveItemRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6052;

        private var _isInitialized:Boolean = false;
        public var oldCellId:uint = 0;
        public var newCellId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6052);
        }

        public function initPaddockMoveItemRequestMessage(oldCellId:uint=0, newCellId:uint=0):PaddockMoveItemRequestMessage
        {
            this.oldCellId = oldCellId;
            this.newCellId = newCellId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.oldCellId = 0;
            this.newCellId = 0;
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
            this.serializeAs_PaddockMoveItemRequestMessage(output);
        }

        public function serializeAs_PaddockMoveItemRequestMessage(output:ICustomDataOutput):void
        {
            if ((((this.oldCellId < 0)) || ((this.oldCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.oldCellId) + ") on element oldCellId.")));
            };
            output.writeVarShort(this.oldCellId);
            if ((((this.newCellId < 0)) || ((this.newCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.newCellId) + ") on element newCellId.")));
            };
            output.writeVarShort(this.newCellId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockMoveItemRequestMessage(input);
        }

        public function deserializeAs_PaddockMoveItemRequestMessage(input:ICustomDataInput):void
        {
            this.oldCellId = input.readVarUhShort();
            if ((((this.oldCellId < 0)) || ((this.oldCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.oldCellId) + ") on element of PaddockMoveItemRequestMessage.oldCellId.")));
            };
            this.newCellId = input.readVarUhShort();
            if ((((this.newCellId < 0)) || ((this.newCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.newCellId) + ") on element of PaddockMoveItemRequestMessage.newCellId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

