package com.ankamagames.dofus.network.messages.game.tinsel
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TitleSelectRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6365;

        private var _isInitialized:Boolean = false;
        public var titleId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6365);
        }

        public function initTitleSelectRequestMessage(titleId:uint=0):TitleSelectRequestMessage
        {
            this.titleId = titleId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.titleId = 0;
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
            this.serializeAs_TitleSelectRequestMessage(output);
        }

        public function serializeAs_TitleSelectRequestMessage(output:ICustomDataOutput):void
        {
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element titleId.")));
            };
            output.writeVarShort(this.titleId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TitleSelectRequestMessage(input);
        }

        public function deserializeAs_TitleSelectRequestMessage(input:ICustomDataInput):void
        {
            this.titleId = input.readVarUhShort();
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element of TitleSelectRequestMessage.titleId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.tinsel

