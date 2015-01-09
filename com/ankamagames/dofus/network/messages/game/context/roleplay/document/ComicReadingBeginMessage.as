package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ComicReadingBeginMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6536;

        private var _isInitialized:Boolean = false;
        public var comicId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6536);
        }

        public function initComicReadingBeginMessage(comicId:uint=0):ComicReadingBeginMessage
        {
            this.comicId = comicId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.comicId = 0;
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
            this.serializeAs_ComicReadingBeginMessage(output);
        }

        public function serializeAs_ComicReadingBeginMessage(output:IDataOutput):void
        {
            if (this.comicId < 0)
            {
                throw (new Error((("Forbidden value (" + this.comicId) + ") on element comicId.")));
            };
            output.writeShort(this.comicId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ComicReadingBeginMessage(input);
        }

        public function deserializeAs_ComicReadingBeginMessage(input:IDataInput):void
        {
            this.comicId = input.readShort();
            if (this.comicId < 0)
            {
                throw (new Error((("Forbidden value (" + this.comicId) + ") on element of ComicReadingBeginMessage.comicId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.document

