package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PaddockToSellListRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6141;

        private var _isInitialized:Boolean = false;
        public var pageIndex:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6141);
        }

        public function initPaddockToSellListRequestMessage(pageIndex:uint=0):PaddockToSellListRequestMessage
        {
            this.pageIndex = pageIndex;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.pageIndex = 0;
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
            this.serializeAs_PaddockToSellListRequestMessage(output);
        }

        public function serializeAs_PaddockToSellListRequestMessage(output:ICustomDataOutput):void
        {
            if (this.pageIndex < 0)
            {
                throw (new Error((("Forbidden value (" + this.pageIndex) + ") on element pageIndex.")));
            };
            output.writeVarShort(this.pageIndex);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockToSellListRequestMessage(input);
        }

        public function deserializeAs_PaddockToSellListRequestMessage(input:ICustomDataInput):void
        {
            this.pageIndex = input.readVarUhShort();
            if (this.pageIndex < 0)
            {
                throw (new Error((("Forbidden value (" + this.pageIndex) + ") on element of PaddockToSellListRequestMessage.pageIndex.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

