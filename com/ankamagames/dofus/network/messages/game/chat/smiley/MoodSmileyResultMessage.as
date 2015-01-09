package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MoodSmileyResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6196;

        private var _isInitialized:Boolean = false;
        public var resultCode:uint = 1;
        public var smileyId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6196);
        }

        public function initMoodSmileyResultMessage(resultCode:uint=1, smileyId:int=0):MoodSmileyResultMessage
        {
            this.resultCode = resultCode;
            this.smileyId = smileyId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.resultCode = 1;
            this.smileyId = 0;
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
            this.serializeAs_MoodSmileyResultMessage(output);
        }

        public function serializeAs_MoodSmileyResultMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.resultCode);
            output.writeByte(this.smileyId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MoodSmileyResultMessage(input);
        }

        public function deserializeAs_MoodSmileyResultMessage(input:ICustomDataInput):void
        {
            this.resultCode = input.readByte();
            if (this.resultCode < 0)
            {
                throw (new Error((("Forbidden value (" + this.resultCode) + ") on element of MoodSmileyResultMessage.resultCode.")));
            };
            this.smileyId = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat.smiley

