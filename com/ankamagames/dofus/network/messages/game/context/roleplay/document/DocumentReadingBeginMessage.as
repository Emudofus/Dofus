package com.ankamagames.dofus.network.messages.game.context.roleplay.document
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class DocumentReadingBeginMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5675;

        private var _isInitialized:Boolean = false;
        public var documentId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5675);
        }

        public function initDocumentReadingBeginMessage(documentId:uint=0):DocumentReadingBeginMessage
        {
            this.documentId = documentId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.documentId = 0;
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
            this.serializeAs_DocumentReadingBeginMessage(output);
        }

        public function serializeAs_DocumentReadingBeginMessage(output:ICustomDataOutput):void
        {
            if (this.documentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.documentId) + ") on element documentId.")));
            };
            output.writeVarShort(this.documentId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DocumentReadingBeginMessage(input);
        }

        public function deserializeAs_DocumentReadingBeginMessage(input:ICustomDataInput):void
        {
            this.documentId = input.readVarUhShort();
            if (this.documentId < 0)
            {
                throw (new Error((("Forbidden value (" + this.documentId) + ") on element of DocumentReadingBeginMessage.documentId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.document

