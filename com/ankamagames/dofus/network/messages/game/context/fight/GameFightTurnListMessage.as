package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightTurnListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var ids:Vector.<int>;
        public var deadsIds:Vector.<int>;
        public static const protocolId:uint = 713;

        public function GameFightTurnListMessage()
        {
            this.ids = new Vector.<int>;
            this.deadsIds = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 713;
        }// end function

        public function initGameFightTurnListMessage(param1:Vector.<int> = null, param2:Vector.<int> = null) : GameFightTurnListMessage
        {
            this.ids = param1;
            this.deadsIds = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.ids = new Vector.<int>;
            this.deadsIds = new Vector.<int>;
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
            this.serializeAs_GameFightTurnListMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightTurnListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.ids.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.ids.length)
            {
                
                param1.writeInt(this.ids[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.deadsIds.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.deadsIds.length)
            {
                
                param1.writeInt(this.deadsIds[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightTurnListMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightTurnListMessage(param1:IDataInput) : void
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readInt();
                this.ids.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readInt();
                this.deadsIds.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
