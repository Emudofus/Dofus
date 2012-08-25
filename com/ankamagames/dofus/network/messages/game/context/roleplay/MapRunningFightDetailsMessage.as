package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MapRunningFightDetailsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fightId:uint = 0;
        public var names:Vector.<String>;
        public var levels:Vector.<uint>;
        public var teamSwap:uint = 0;
        public var alives:Vector.<Boolean>;
        public static const protocolId:uint = 5751;

        public function MapRunningFightDetailsMessage()
        {
            this.names = new Vector.<String>;
            this.levels = new Vector.<uint>;
            this.alives = new Vector.<Boolean>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5751;
        }// end function

        public function initMapRunningFightDetailsMessage(param1:uint = 0, param2:Vector.<String> = null, param3:Vector.<uint> = null, param4:uint = 0, param5:Vector.<Boolean> = null) : MapRunningFightDetailsMessage
        {
            this.fightId = param1;
            this.names = param2;
            this.levels = param3;
            this.teamSwap = param4;
            this.alives = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fightId = 0;
            this.names = new Vector.<String>;
            this.levels = new Vector.<uint>;
            this.teamSwap = 0;
            this.alives = new Vector.<Boolean>;
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
            this.serializeAs_MapRunningFightDetailsMessage(param1);
            return;
        }// end function

        public function serializeAs_MapRunningFightDetailsMessage(param1:IDataOutput) : void
        {
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            param1.writeInt(this.fightId);
            param1.writeShort(this.names.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.names.length)
            {
                
                param1.writeUTF(this.names[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.levels.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.levels.length)
            {
                
                if (this.levels[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.levels[_loc_3] + ") on element 3 (starting at 1) of levels.");
                }
                param1.writeShort(this.levels[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            if (this.teamSwap < 0)
            {
                throw new Error("Forbidden value (" + this.teamSwap + ") on element teamSwap.");
            }
            param1.writeByte(this.teamSwap);
            param1.writeShort(this.alives.length);
            var _loc_4:uint = 0;
            while (_loc_4 < this.alives.length)
            {
                
                param1.writeBoolean(this.alives[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MapRunningFightDetailsMessage(param1);
            return;
        }// end function

        public function deserializeAs_MapRunningFightDetailsMessage(param1:IDataInput) : void
        {
            var _loc_8:String = null;
            var _loc_9:uint = 0;
            var _loc_10:Boolean = false;
            this.fightId = param1.readInt();
            if (this.fightId < 0)
            {
                throw new Error("Forbidden value (" + this.fightId + ") on element of MapRunningFightDetailsMessage.fightId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_8 = param1.readUTF();
                this.names.push(_loc_8);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = param1.readShort();
                if (_loc_9 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_9 + ") on elements of levels.");
                }
                this.levels.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            this.teamSwap = param1.readByte();
            if (this.teamSwap < 0)
            {
                throw new Error("Forbidden value (" + this.teamSwap + ") on element of MapRunningFightDetailsMessage.teamSwap.");
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:uint = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = param1.readBoolean();
                this.alives.push(_loc_10);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
