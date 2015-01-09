package com.ankamagames.dofus.network.messages.connection.search
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

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
            this.serializeAs_AcquaintanceSearchMessage(output);
        }

        public function serializeAs_AcquaintanceSearchMessage(output:IDataOutput):void
        {
            output.writeUTF(this.nickname);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AcquaintanceSearchMessage(input);
        }

        public function deserializeAs_AcquaintanceSearchMessage(input:IDataInput):void
        {
            this.nickname = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.connection.search

