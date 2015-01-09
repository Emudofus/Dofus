package com.ankamagames.dofus.network.messages.authorized
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AdminCommandMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 76;

        private var _isInitialized:Boolean = false;
        public var content:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (76);
        }

        public function initAdminCommandMessage(content:String=""):AdminCommandMessage
        {
            this.content = content;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_AdminCommandMessage(output);
        }

        public function serializeAs_AdminCommandMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.content);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AdminCommandMessage(input);
        }

        public function deserializeAs_AdminCommandMessage(input:ICustomDataInput):void
        {
            this.content = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.authorized

