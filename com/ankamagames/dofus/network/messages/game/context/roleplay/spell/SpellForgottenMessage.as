package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SpellForgottenMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var spellsId:Vector.<uint>;
        public var boostPoint:uint = 0;
        public static const protocolId:uint = 5834;

        public function SpellForgottenMessage()
        {
            this.spellsId = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5834;
        }// end function

        public function initSpellForgottenMessage(param1:Vector.<uint> = null, param2:uint = 0) : SpellForgottenMessage
        {
            this.spellsId = param1;
            this.boostPoint = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.spellsId = new Vector.<uint>;
            this.boostPoint = 0;
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
            this.serializeAs_SpellForgottenMessage(param1);
            return;
        }// end function

        public function serializeAs_SpellForgottenMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.spellsId.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.spellsId.length)
            {
                
                if (this.spellsId[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.spellsId[_loc_2] + ") on element 1 (starting at 1) of spellsId.");
                }
                param1.writeShort(this.spellsId[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            if (this.boostPoint < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
            }
            param1.writeShort(this.boostPoint);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SpellForgottenMessage(param1);
            return;
        }// end function

        public function deserializeAs_SpellForgottenMessage(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readShort();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of spellsId.");
                }
                this.spellsId.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.boostPoint = param1.readShort();
            if (this.boostPoint < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoint + ") on element of SpellForgottenMessage.boostPoint.");
            }
            return;
        }// end function

    }
}
