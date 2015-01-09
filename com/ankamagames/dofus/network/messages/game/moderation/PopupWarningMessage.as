package com.ankamagames.dofus.network.messages.game.moderation
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PopupWarningMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6134;

        private var _isInitialized:Boolean = false;
        public var lockDuration:uint = 0;
        public var author:String = "";
        public var content:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6134);
        }

        public function initPopupWarningMessage(lockDuration:uint=0, author:String="", content:String=""):PopupWarningMessage
        {
            this.lockDuration = lockDuration;
            this.author = author;
            this.content = content;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.lockDuration = 0;
            this.author = "";
            this.content = "";
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
            this.serializeAs_PopupWarningMessage(output);
        }

        public function serializeAs_PopupWarningMessage(output:ICustomDataOutput):void
        {
            if ((((this.lockDuration < 0)) || ((this.lockDuration > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.lockDuration) + ") on element lockDuration.")));
            };
            output.writeByte(this.lockDuration);
            output.writeUTF(this.author);
            output.writeUTF(this.content);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PopupWarningMessage(input);
        }

        public function deserializeAs_PopupWarningMessage(input:ICustomDataInput):void
        {
            this.lockDuration = input.readUnsignedByte();
            if ((((this.lockDuration < 0)) || ((this.lockDuration > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.lockDuration) + ") on element of PopupWarningMessage.lockDuration.")));
            };
            this.author = input.readUTF();
            this.content = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.moderation

