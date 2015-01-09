package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildInfosUpgradeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5636;

        private var _isInitialized:Boolean = false;
        public var maxTaxCollectorsCount:uint = 0;
        public var taxCollectorsCount:uint = 0;
        public var taxCollectorLifePoints:uint = 0;
        public var taxCollectorDamagesBonuses:uint = 0;
        public var taxCollectorPods:uint = 0;
        public var taxCollectorProspecting:uint = 0;
        public var taxCollectorWisdom:uint = 0;
        public var boostPoints:uint = 0;
        public var spellId:Vector.<uint>;
        public var spellLevel:Vector.<uint>;

        public function GuildInfosUpgradeMessage()
        {
            this.spellId = new Vector.<uint>();
            this.spellLevel = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5636);
        }

        public function initGuildInfosUpgradeMessage(maxTaxCollectorsCount:uint=0, taxCollectorsCount:uint=0, taxCollectorLifePoints:uint=0, taxCollectorDamagesBonuses:uint=0, taxCollectorPods:uint=0, taxCollectorProspecting:uint=0, taxCollectorWisdom:uint=0, boostPoints:uint=0, spellId:Vector.<uint>=null, spellLevel:Vector.<uint>=null):GuildInfosUpgradeMessage
        {
            this.maxTaxCollectorsCount = maxTaxCollectorsCount;
            this.taxCollectorsCount = taxCollectorsCount;
            this.taxCollectorLifePoints = taxCollectorLifePoints;
            this.taxCollectorDamagesBonuses = taxCollectorDamagesBonuses;
            this.taxCollectorPods = taxCollectorPods;
            this.taxCollectorProspecting = taxCollectorProspecting;
            this.taxCollectorWisdom = taxCollectorWisdom;
            this.boostPoints = boostPoints;
            this.spellId = spellId;
            this.spellLevel = spellLevel;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.maxTaxCollectorsCount = 0;
            this.taxCollectorsCount = 0;
            this.taxCollectorLifePoints = 0;
            this.taxCollectorDamagesBonuses = 0;
            this.taxCollectorPods = 0;
            this.taxCollectorProspecting = 0;
            this.taxCollectorWisdom = 0;
            this.boostPoints = 0;
            this.spellId = new Vector.<uint>();
            this.spellLevel = new Vector.<uint>();
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
            this.serializeAs_GuildInfosUpgradeMessage(output);
        }

        public function serializeAs_GuildInfosUpgradeMessage(output:IDataOutput):void
        {
            if (this.maxTaxCollectorsCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxTaxCollectorsCount) + ") on element maxTaxCollectorsCount.")));
            };
            output.writeByte(this.maxTaxCollectorsCount);
            if (this.taxCollectorsCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorsCount) + ") on element taxCollectorsCount.")));
            };
            output.writeByte(this.taxCollectorsCount);
            if (this.taxCollectorLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorLifePoints) + ") on element taxCollectorLifePoints.")));
            };
            output.writeShort(this.taxCollectorLifePoints);
            if (this.taxCollectorDamagesBonuses < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorDamagesBonuses) + ") on element taxCollectorDamagesBonuses.")));
            };
            output.writeShort(this.taxCollectorDamagesBonuses);
            if (this.taxCollectorPods < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorPods) + ") on element taxCollectorPods.")));
            };
            output.writeShort(this.taxCollectorPods);
            if (this.taxCollectorProspecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorProspecting) + ") on element taxCollectorProspecting.")));
            };
            output.writeShort(this.taxCollectorProspecting);
            if (this.taxCollectorWisdom < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorWisdom) + ") on element taxCollectorWisdom.")));
            };
            output.writeShort(this.taxCollectorWisdom);
            if (this.boostPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoints) + ") on element boostPoints.")));
            };
            output.writeShort(this.boostPoints);
            output.writeShort(this.spellId.length);
            var _i9:uint;
            while (_i9 < this.spellId.length)
            {
                if (this.spellId[_i9] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.spellId[_i9]) + ") on element 9 (starting at 1) of spellId.")));
                };
                output.writeShort(this.spellId[_i9]);
                _i9++;
            };
            output.writeShort(this.spellLevel.length);
            var _i10:uint;
            while (_i10 < this.spellLevel.length)
            {
                if (this.spellLevel[_i10] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.spellLevel[_i10]) + ") on element 10 (starting at 1) of spellLevel.")));
                };
                output.writeByte(this.spellLevel[_i10]);
                _i10++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GuildInfosUpgradeMessage(input);
        }

        public function deserializeAs_GuildInfosUpgradeMessage(input:IDataInput):void
        {
            var _val9:uint;
            var _val10:uint;
            this.maxTaxCollectorsCount = input.readByte();
            if (this.maxTaxCollectorsCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxTaxCollectorsCount) + ") on element of GuildInfosUpgradeMessage.maxTaxCollectorsCount.")));
            };
            this.taxCollectorsCount = input.readByte();
            if (this.taxCollectorsCount < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorsCount) + ") on element of GuildInfosUpgradeMessage.taxCollectorsCount.")));
            };
            this.taxCollectorLifePoints = input.readShort();
            if (this.taxCollectorLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorLifePoints) + ") on element of GuildInfosUpgradeMessage.taxCollectorLifePoints.")));
            };
            this.taxCollectorDamagesBonuses = input.readShort();
            if (this.taxCollectorDamagesBonuses < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorDamagesBonuses) + ") on element of GuildInfosUpgradeMessage.taxCollectorDamagesBonuses.")));
            };
            this.taxCollectorPods = input.readShort();
            if (this.taxCollectorPods < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorPods) + ") on element of GuildInfosUpgradeMessage.taxCollectorPods.")));
            };
            this.taxCollectorProspecting = input.readShort();
            if (this.taxCollectorProspecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorProspecting) + ") on element of GuildInfosUpgradeMessage.taxCollectorProspecting.")));
            };
            this.taxCollectorWisdom = input.readShort();
            if (this.taxCollectorWisdom < 0)
            {
                throw (new Error((("Forbidden value (" + this.taxCollectorWisdom) + ") on element of GuildInfosUpgradeMessage.taxCollectorWisdom.")));
            };
            this.boostPoints = input.readShort();
            if (this.boostPoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.boostPoints) + ") on element of GuildInfosUpgradeMessage.boostPoints.")));
            };
            var _spellIdLen:uint = input.readUnsignedShort();
            var _i9:uint;
            while (_i9 < _spellIdLen)
            {
                _val9 = input.readShort();
                if (_val9 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val9) + ") on elements of spellId.")));
                };
                this.spellId.push(_val9);
                _i9++;
            };
            var _spellLevelLen:uint = input.readUnsignedShort();
            var _i10:uint;
            while (_i10 < _spellLevelLen)
            {
                _val10 = input.readByte();
                if (_val10 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val10) + ") on elements of spellLevel.")));
                };
                this.spellLevel.push(_val10);
                _i10++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

