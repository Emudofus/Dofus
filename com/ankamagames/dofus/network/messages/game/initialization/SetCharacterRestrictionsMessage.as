package com.ankamagames.dofus.network.messages.game.initialization
{
    import com.ankamagames.dofus.network.types.game.character.restriction.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SetCharacterRestrictionsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var restrictions:ActorRestrictionsInformations;
        public static const protocolId:uint = 170;

        public function SetCharacterRestrictionsMessage()
        {
            this.restrictions = new ActorRestrictionsInformations();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 170;
        }// end function

        public function initSetCharacterRestrictionsMessage(param1:ActorRestrictionsInformations = null) : SetCharacterRestrictionsMessage
        {
            this.restrictions = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.restrictions = new ActorRestrictionsInformations();
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
            this.serializeAs_SetCharacterRestrictionsMessage(param1);
            return;
        }// end function

        public function serializeAs_SetCharacterRestrictionsMessage(param1:IDataOutput) : void
        {
            this.restrictions.serializeAs_ActorRestrictionsInformations(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SetCharacterRestrictionsMessage(param1);
            return;
        }// end function

        public function deserializeAs_SetCharacterRestrictionsMessage(param1:IDataInput) : void
        {
            this.restrictions = new ActorRestrictionsInformations();
            this.restrictions.deserialize(param1);
            return;
        }// end function

    }
}
