package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class PaddockPropertiesMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5824;

        private var _isInitialized:Boolean = false;
        public var properties:PaddockInformations;

        public function PaddockPropertiesMessage()
        {
            this.properties = new PaddockInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5824);
        }

        public function initPaddockPropertiesMessage(properties:PaddockInformations=null):PaddockPropertiesMessage
        {
            this.properties = properties;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.properties = new PaddockInformations();
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
            this.serializeAs_PaddockPropertiesMessage(output);
        }

        public function serializeAs_PaddockPropertiesMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.properties.getTypeId());
            this.properties.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockPropertiesMessage(input);
        }

        public function deserializeAs_PaddockPropertiesMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.properties = ProtocolTypeManager.getInstance(PaddockInformations, _id1);
            this.properties.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

