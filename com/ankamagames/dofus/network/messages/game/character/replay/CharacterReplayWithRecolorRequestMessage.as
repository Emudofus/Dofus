package com.ankamagames.dofus.network.messages.game.character.replay
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class CharacterReplayWithRecolorRequestMessage extends CharacterReplayRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6111;

        private var _isInitialized:Boolean = false;
        public var indexedColor:Vector.<int>;

        public function CharacterReplayWithRecolorRequestMessage()
        {
            this.indexedColor = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6111);
        }

        public function initCharacterReplayWithRecolorRequestMessage(characterId:uint=0, indexedColor:Vector.<int>=null):CharacterReplayWithRecolorRequestMessage
        {
            super.initCharacterReplayRequestMessage(characterId);
            this.indexedColor = indexedColor;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.indexedColor = new Vector.<int>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_CharacterReplayWithRecolorRequestMessage(output);
        }

        public function serializeAs_CharacterReplayWithRecolorRequestMessage(output:IDataOutput):void
        {
            super.serializeAs_CharacterReplayRequestMessage(output);
            output.writeShort(this.indexedColor.length);
            var _i1:uint;
            while (_i1 < this.indexedColor.length)
            {
                output.writeInt(this.indexedColor[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_CharacterReplayWithRecolorRequestMessage(input);
        }

        public function deserializeAs_CharacterReplayWithRecolorRequestMessage(input:IDataInput):void
        {
            var _val1:int;
            super.deserialize(input);
            var _indexedColorLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _indexedColorLen)
            {
                _val1 = input.readInt();
                this.indexedColor.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.character.replay

