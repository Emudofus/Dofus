package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class SpellForgottenMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5834;

        private var _isInitialized:Boolean = false;
        public var spellsId:Vector.<uint>;
        public var boostPoint:uint = 0;

        public function SpellForgottenMessage()
        {
            this.spellsId = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5834);
        }

        public function initSpellForgottenMessage(spellsId:Vector.<uint>=null, boostPoint:uint=0):SpellForgottenMessage
        {
            this.spellsId = spellsId;
            this.boostPoint = boostPoint;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.spellsId = new Vector.<uint>();
            this.boostPoint = 0;
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
            this.serializeAs_SpellForgottenMessage(output);
        }

        public function serializeAs_SpellForgottenMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.spellsId.length);
            var _i1:uint;
            while (_i1 < this.spellsId.length)
            {
                if (this.spellsId[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.spellsId[_i1]) + ") on element 1 (starting at 1) of spellsId.")));
                };
                output.writeVarShort(this.spellsId[_i1]);
                _i1++;
            };
            if (this.boostPoint < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoint) + ") on element boostPoint.")));
            };
            output.writeVarShort(this.boostPoint);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SpellForgottenMessage(input);
        }

        public function deserializeAs_SpellForgottenMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _spellsIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _spellsIdLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of spellsId.")));
                };
                this.spellsId.push(_val1);
                _i1++;
            };
            this.boostPoint = input.readVarUhShort();
            if (this.boostPoint < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoint) + ") on element of SpellForgottenMessage.boostPoint.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.spell

