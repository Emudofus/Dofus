package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class TreasureHuntShowLegendaryUIMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6498;

        private var _isInitialized:Boolean = false;
        public var availableLegendaryIds:Vector.<uint>;

        public function TreasureHuntShowLegendaryUIMessage()
        {
            this.availableLegendaryIds = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6498);
        }

        public function initTreasureHuntShowLegendaryUIMessage(availableLegendaryIds:Vector.<uint>=null):TreasureHuntShowLegendaryUIMessage
        {
            this.availableLegendaryIds = availableLegendaryIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.availableLegendaryIds = new Vector.<uint>();
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
            this.serializeAs_TreasureHuntShowLegendaryUIMessage(output);
        }

        public function serializeAs_TreasureHuntShowLegendaryUIMessage(output:IDataOutput):void
        {
            output.writeShort(this.availableLegendaryIds.length);
            var _i1:uint;
            while (_i1 < this.availableLegendaryIds.length)
            {
                if (this.availableLegendaryIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.availableLegendaryIds[_i1]) + ") on element 1 (starting at 1) of availableLegendaryIds.")));
                };
                output.writeShort(this.availableLegendaryIds[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TreasureHuntShowLegendaryUIMessage(input);
        }

        public function deserializeAs_TreasureHuntShowLegendaryUIMessage(input:IDataInput):void
        {
            var _val1:uint;
            var _availableLegendaryIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _availableLegendaryIdsLen)
            {
                _val1 = input.readShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of availableLegendaryIds.")));
                };
                this.availableLegendaryIds.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

