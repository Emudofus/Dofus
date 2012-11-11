package com.ankamagames.dofus.network.messages.game.atlas
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AtlasPointInformationsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:AtlasPointsInformations;
        public static const protocolId:uint = 5956;

        public function AtlasPointInformationsMessage()
        {
            this.type = new AtlasPointsInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5956;
        }// end function

        public function initAtlasPointInformationsMessage(param1:AtlasPointsInformations = null) : AtlasPointInformationsMessage
        {
            this.type = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = new AtlasPointsInformations();
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AtlasPointInformationsMessage(param1);
            return;
        }// end function

        public function serializeAs_AtlasPointInformationsMessage(param1:IDataOutput) : void
        {
            this.type.serializeAs_AtlasPointsInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AtlasPointInformationsMessage(param1);
            return;
        }// end function

        public function deserializeAs_AtlasPointInformationsMessage(param1:IDataInput) : void
        {
            this.type = new AtlasPointsInformations();
            this.type.deserialize(param1);
            return;
        }// end function

    }
}
