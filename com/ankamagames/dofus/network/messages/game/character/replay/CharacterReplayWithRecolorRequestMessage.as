package com.ankamagames.dofus.network.messages.game.character.replay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CharacterReplayWithRecolorRequestMessage extends CharacterReplayRequestMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var indexedColor:Vector.<int>;
        public static const protocolId:uint = 6111;

        public function CharacterReplayWithRecolorRequestMessage()
        {
            this.indexedColor = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6111;
        }// end function

        public function initCharacterReplayWithRecolorRequestMessage(param1:uint = 0, param2:Vector.<int> = null) : CharacterReplayWithRecolorRequestMessage
        {
            super.initCharacterReplayRequestMessage(param1);
            this.indexedColor = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.indexedColor = new Vector.<int>;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_CharacterReplayWithRecolorRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_CharacterReplayWithRecolorRequestMessage(param1:IDataOutput) : void
        {
            super.serializeAs_CharacterReplayRequestMessage(param1);
            param1.writeShort(this.indexedColor.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.indexedColor.length)
            {
                
                param1.writeInt(this.indexedColor[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CharacterReplayWithRecolorRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_CharacterReplayWithRecolorRequestMessage(param1:IDataInput) : void
        {
            var _loc_4:int = 0;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                this.indexedColor.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
