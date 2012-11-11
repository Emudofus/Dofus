package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportDestinationsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var teleporterType:uint = 0;
        public var mapIds:Vector.<uint>;
        public var subAreaIds:Vector.<uint>;
        public var costs:Vector.<uint>;
        public static const protocolId:uint = 5960;

        public function TeleportDestinationsListMessage()
        {
            this.mapIds = new Vector.<uint>;
            this.subAreaIds = new Vector.<uint>;
            this.costs = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5960;
        }// end function

        public function initTeleportDestinationsListMessage(param1:uint = 0, param2:Vector.<uint> = null, param3:Vector.<uint> = null, param4:Vector.<uint> = null) : TeleportDestinationsListMessage
        {
            this.teleporterType = param1;
            this.mapIds = param2;
            this.subAreaIds = param3;
            this.costs = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.teleporterType = 0;
            this.mapIds = new Vector.<uint>;
            this.subAreaIds = new Vector.<uint>;
            this.costs = new Vector.<uint>;
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
            this.serializeAs_TeleportDestinationsListMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportDestinationsListMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.teleporterType);
            param1.writeShort(this.mapIds.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.mapIds.length)
            {
                
                if (this.mapIds[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.mapIds[_loc_2] + ") on element 2 (starting at 1) of mapIds.");
                }
                param1.writeInt(this.mapIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.subAreaIds.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.subAreaIds.length)
            {
                
                if (this.subAreaIds[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.subAreaIds[_loc_3] + ") on element 3 (starting at 1) of subAreaIds.");
                }
                param1.writeShort(this.subAreaIds[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.costs.length);
            var _loc_4:* = 0;
            while (_loc_4 < this.costs.length)
            {
                
                if (this.costs[_loc_4] < 0)
                {
                    throw new Error("Forbidden value (" + this.costs[_loc_4] + ") on element 4 (starting at 1) of costs.");
                }
                param1.writeShort(this.costs[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportDestinationsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportDestinationsListMessage(param1:IDataInput) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            this.teleporterType = param1.readByte();
            if (this.teleporterType < 0)
            {
                throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportDestinationsListMessage.teleporterType.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_8 = param1.readInt();
                if (_loc_8 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_8 + ") on elements of mapIds.");
                }
                this.mapIds.push(_loc_8);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_9 = param1.readShort();
                if (_loc_9 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_9 + ") on elements of subAreaIds.");
                }
                this.subAreaIds.push(_loc_9);
                _loc_5 = _loc_5 + 1;
            }
            var _loc_6:* = param1.readUnsignedShort();
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = param1.readShort();
                if (_loc_10 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_10 + ") on elements of costs.");
                }
                this.costs.push(_loc_10);
                _loc_7 = _loc_7 + 1;
            }
            return;
        }// end function

    }
}
