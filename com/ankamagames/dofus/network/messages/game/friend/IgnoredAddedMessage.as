package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class IgnoredAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5678;

        private var _isInitialized:Boolean = false;
        public var ignoreAdded:IgnoredInformations;
        public var session:Boolean = false;

        public function IgnoredAddedMessage()
        {
            this.ignoreAdded = new IgnoredInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5678);
        }

        public function initIgnoredAddedMessage(ignoreAdded:IgnoredInformations=null, session:Boolean=false):IgnoredAddedMessage
        {
            this.ignoreAdded = ignoreAdded;
            this.session = session;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ignoreAdded = new IgnoredInformations();
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
            this.serializeAs_IgnoredAddedMessage(output);
        }

        public function serializeAs_IgnoredAddedMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.ignoreAdded.getTypeId());
            this.ignoreAdded.serialize(output);
            output.writeBoolean(this.session);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_IgnoredAddedMessage(input);
        }

        public function deserializeAs_IgnoredAddedMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.ignoreAdded = ProtocolTypeManager.getInstance(IgnoredInformations, _id1);
            this.ignoreAdded.deserialize(input);
            this.session = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.friend

