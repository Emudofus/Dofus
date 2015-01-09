package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class IgnoredAddRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5673;

        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var session:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5673);
        }

        public function initIgnoredAddRequestMessage(name:String="", session:Boolean=false):IgnoredAddRequestMessage
        {
            this.name = name;
            this.session = session;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.name = "";
            this.session = false;
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
            this.serializeAs_IgnoredAddRequestMessage(output);
        }

        public function serializeAs_IgnoredAddRequestMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
            output.writeBoolean(this.session);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredAddRequestMessage(input);
        }

        public function deserializeAs_IgnoredAddRequestMessage(input:ICustomDataInput):void
        {
            this.name = input.readUTF();
            this.session = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

