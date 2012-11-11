package com.ankamagames.dofus.network.messages.game.context
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameMapChangeOrientationsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var orientations:Vector.<ActorOrientation>;
        public static const protocolId:uint = 6155;

        public function GameMapChangeOrientationsMessage()
        {
            this.orientations = new Vector.<ActorOrientation>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6155;
        }// end function

        public function initGameMapChangeOrientationsMessage(param1:Vector.<ActorOrientation> = null) : GameMapChangeOrientationsMessage
        {
            this.orientations = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.orientations = new Vector.<ActorOrientation>;
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
            this.serializeAs_GameMapChangeOrientationsMessage(param1);
            return;
        }// end function

        public function serializeAs_GameMapChangeOrientationsMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.orientations.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.orientations.length)
            {
                
                (this.orientations[_loc_2] as ActorOrientation).serializeAs_ActorOrientation(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameMapChangeOrientationsMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameMapChangeOrientationsMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ActorOrientation();
                _loc_4.deserialize(param1);
                this.orientations.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
