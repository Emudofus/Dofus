package com.ankamagames.dofus.network.messages.game.interactive.zaap
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
    public class TeleportDestinationsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5960;

        private var _isInitialized:Boolean = false;
        public var teleporterType:uint = 0;
        public var mapIds:Vector.<uint>;
        public var subAreaIds:Vector.<uint>;
        public var costs:Vector.<uint>;
        public var destTeleporterType:Vector.<uint>;

        public function TeleportDestinationsListMessage()
        {
            this.mapIds = new Vector.<uint>();
            this.subAreaIds = new Vector.<uint>();
            this.costs = new Vector.<uint>();
            this.destTeleporterType = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5960);
        }

        public function initTeleportDestinationsListMessage(teleporterType:uint=0, mapIds:Vector.<uint>=null, subAreaIds:Vector.<uint>=null, costs:Vector.<uint>=null, destTeleporterType:Vector.<uint>=null):TeleportDestinationsListMessage
        {
            this.teleporterType = teleporterType;
            this.mapIds = mapIds;
            this.subAreaIds = subAreaIds;
            this.costs = costs;
            this.destTeleporterType = destTeleporterType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.teleporterType = 0;
            this.mapIds = new Vector.<uint>();
            this.subAreaIds = new Vector.<uint>();
            this.costs = new Vector.<uint>();
            this.destTeleporterType = new Vector.<uint>();
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
            this.serializeAs_TeleportDestinationsListMessage(output);
        }

        public function serializeAs_TeleportDestinationsListMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.teleporterType);
            output.writeShort(this.mapIds.length);
            var _i2:uint;
            while (_i2 < this.mapIds.length)
            {
                if (this.mapIds[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.mapIds[_i2]) + ") on element 2 (starting at 1) of mapIds.")));
                };
                output.writeInt(this.mapIds[_i2]);
                _i2++;
            };
            output.writeShort(this.subAreaIds.length);
            var _i3:uint;
            while (_i3 < this.subAreaIds.length)
            {
                if (this.subAreaIds[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.subAreaIds[_i3]) + ") on element 3 (starting at 1) of subAreaIds.")));
                };
                output.writeVarShort(this.subAreaIds[_i3]);
                _i3++;
            };
            output.writeShort(this.costs.length);
            var _i4:uint;
            while (_i4 < this.costs.length)
            {
                if (this.costs[_i4] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.costs[_i4]) + ") on element 4 (starting at 1) of costs.")));
                };
                output.writeVarShort(this.costs[_i4]);
                _i4++;
            };
            output.writeShort(this.destTeleporterType.length);
            var _i5:uint;
            while (_i5 < this.destTeleporterType.length)
            {
                output.writeByte(this.destTeleporterType[_i5]);
                _i5++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportDestinationsListMessage(input);
        }

        public function deserializeAs_TeleportDestinationsListMessage(input:ICustomDataInput):void
        {
            var _val2:uint;
            var _val3:uint;
            var _val4:uint;
            var _val5:uint;
            this.teleporterType = input.readByte();
            if (this.teleporterType < 0)
            {
                throw (new Error((("Forbidden value (" + this.teleporterType) + ") on element of TeleportDestinationsListMessage.teleporterType.")));
            };
            var _mapIdsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _mapIdsLen)
            {
                _val2 = input.readInt();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of mapIds.")));
                };
                this.mapIds.push(_val2);
                _i2++;
            };
            var _subAreaIdsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _subAreaIdsLen)
            {
                _val3 = input.readVarUhShort();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of subAreaIds.")));
                };
                this.subAreaIds.push(_val3);
                _i3++;
            };
            var _costsLen:uint = input.readUnsignedShort();
            var _i4:uint;
            while (_i4 < _costsLen)
            {
                _val4 = input.readVarUhShort();
                if (_val4 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val4) + ") on elements of costs.")));
                };
                this.costs.push(_val4);
                _i4++;
            };
            var _destTeleporterTypeLen:uint = input.readUnsignedShort();
            var _i5:uint;
            while (_i5 < _destTeleporterTypeLen)
            {
                _val5 = input.readByte();
                if (_val5 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val5) + ") on elements of destTeleporterType.")));
                };
                this.destTeleporterType.push(_val5);
                _i5++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.zaap

