package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PortalUseRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6492;

        private var _isInitialized:Boolean = false;
        public var portalId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6492);
        }

        public function initPortalUseRequestMessage(portalId:uint=0):PortalUseRequestMessage
        {
            this.portalId = portalId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.portalId = 0;
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
            this.serializeAs_PortalUseRequestMessage(output);
        }

        public function serializeAs_PortalUseRequestMessage(output:ICustomDataOutput):void
        {
            if (this.portalId < 0)
            {
                throw (new Error((("Forbidden value (" + this.portalId) + ") on element portalId.")));
            };
            output.writeVarInt(this.portalId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PortalUseRequestMessage(input);
        }

        public function deserializeAs_PortalUseRequestMessage(input:ICustomDataInput):void
        {
            this.portalId = input.readVarUhInt();
            if (this.portalId < 0)
            {
                throw (new Error((("Forbidden value (" + this.portalId) + ") on element of PortalUseRequestMessage.portalId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

