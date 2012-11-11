package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SpellForgetUIMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var open:Boolean = false;
        public static const protocolId:uint = 5565;

        public function SpellForgetUIMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5565;
        }// end function

        public function initSpellForgetUIMessage(param1:Boolean = false) : SpellForgetUIMessage
        {
            this.open = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.open = false;
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
            this.serializeAs_SpellForgetUIMessage(param1);
            return;
        }// end function

        public function serializeAs_SpellForgetUIMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.open);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SpellForgetUIMessage(param1);
            return;
        }// end function

        public function deserializeAs_SpellForgetUIMessage(param1:IDataInput) : void
        {
            this.open = param1.readBoolean();
            return;
        }// end function

    }
}
