package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MoodSmileyRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6192;

        private var _isInitialized:Boolean = false;
        public var smileyId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6192);
        }

        public function initMoodSmileyRequestMessage(smileyId:int=0):MoodSmileyRequestMessage
        {
            this.smileyId = smileyId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_MoodSmileyRequestMessage(output);
        }

        public function serializeAs_MoodSmileyRequestMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.smileyId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MoodSmileyRequestMessage(input);
        }

        public function deserializeAs_MoodSmileyRequestMessage(input:ICustomDataInput):void
        {
            this.smileyId = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.chat.smiley

