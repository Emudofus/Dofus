package com.ankamagames.dofus.network.messages.connection.register
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class NicknameChoiceRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5639;

        private var _isInitialized:Boolean = false;
        public var nickname:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5639);
        }

        public function initNicknameChoiceRequestMessage(nickname:String=""):NicknameChoiceRequestMessage
        {
            this.nickname = nickname;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.nickname = "";
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
            this.serializeAs_NicknameChoiceRequestMessage(output);
        }

        public function serializeAs_NicknameChoiceRequestMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.nickname);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_NicknameChoiceRequestMessage(input);
        }

        public function deserializeAs_NicknameChoiceRequestMessage(input:ICustomDataInput):void
        {
            this.nickname = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.connection.register

