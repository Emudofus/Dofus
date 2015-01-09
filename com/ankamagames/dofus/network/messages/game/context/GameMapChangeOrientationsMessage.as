package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameMapChangeOrientationsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6155;

        private var _isInitialized:Boolean = false;
        public var orientations:Vector.<ActorOrientation>;

        public function GameMapChangeOrientationsMessage()
        {
            this.orientations = new Vector.<ActorOrientation>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6155);
        }

        public function initGameMapChangeOrientationsMessage(orientations:Vector.<ActorOrientation>=null):GameMapChangeOrientationsMessage
        {
            this.orientations = orientations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.orientations = new Vector.<ActorOrientation>();
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

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameMapChangeOrientationsMessage(output);
        }

        public function serializeAs_GameMapChangeOrientationsMessage(output:IDataOutput):void
        {
            output.writeShort(this.orientations.length);
            var _i1:uint;
            while (_i1 < this.orientations.length)
            {
                (this.orientations[_i1] as ActorOrientation).serializeAs_ActorOrientation(output);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameMapChangeOrientationsMessage(input);
        }

        public function deserializeAs_GameMapChangeOrientationsMessage(input:IDataInput):void
        {
            var _item1:ActorOrientation;
            var _orientationsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _orientationsLen)
            {
                _item1 = new ActorOrientation();
                _item1.deserialize(input);
                this.orientations.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

