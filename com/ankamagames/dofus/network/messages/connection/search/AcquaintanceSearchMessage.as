package com.ankamagames.dofus.network.messages.connection.search
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AcquaintanceSearchMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 0x1800;

        private var _isInitialized:Boolean = false;
        public var nickname:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (0x1800);
        }

        public function initAcquaintanceSearchMessage(nickname:String=""):AcquaintanceSearchMessage
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
            this.serializeAs_AcquaintanceSearchMessage(output);
        }

        public function serializeAs_AcquaintanceSearchMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.nickname);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AcquaintanceSearchMessage(input);
        }

        public function deserializeAs_AcquaintanceSearchMessage(input:ICustomDataInput):void
        {
            this.nickname = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.connection.search

