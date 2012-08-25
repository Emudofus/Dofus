package com.ankamagames.dofus.network.messages.game.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInfosUpgradeMessage extends NetworkMessage implements INetworkMessage
    {
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
        public static const protocolId:uint = 5636;

        public function GuildInfosUpgradeMessage()
        {
            this.spellId = new Vector.<uint>;
            this.spellLevel = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5636;
        }// end function

        public function initGuildInfosUpgradeMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0, param9:Vector.<uint> = null, param10:Vector.<uint> = null) : GuildInfosUpgradeMessage
        {
            this.maxTaxCollectorsCount = param1;
            this.taxCollectorsCount = param2;
            this.taxCollectorLifePoints = param3;
            this.taxCollectorDamagesBonuses = param4;
            this.taxCollectorPods = param5;
            this.taxCollectorProspecting = param6;
            this.taxCollectorWisdom = param7;
            this.boostPoints = param8;
            this.spellId = param9;
            this.spellLevel = param10;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.maxTaxCollectorsCount = 0;
            this.taxCollectorsCount = 0;
            this.taxCollectorLifePoints = 0;
            this.taxCollectorDamagesBonuses = 0;
            this.taxCollectorPods = 0;
            this.taxCollectorProspecting = 0;
            this.taxCollectorWisdom = 0;
            this.boostPoints = 0;
            this.spellId = new Vector.<uint>;
            this.spellLevel = new Vector.<uint>;
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
            this.serializeAs_GuildInfosUpgradeMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInfosUpgradeMessage(param1:IDataOutput) : void
        {
            if (this.maxTaxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.maxTaxCollectorsCount + ") on element maxTaxCollectorsCount.");
            }
            param1.writeByte(this.maxTaxCollectorsCount);
            if (this.taxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element taxCollectorsCount.");
            }
            param1.writeByte(this.taxCollectorsCount);
            if (this.taxCollectorLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorLifePoints + ") on element taxCollectorLifePoints.");
            }
            param1.writeShort(this.taxCollectorLifePoints);
            if (this.taxCollectorDamagesBonuses < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorDamagesBonuses + ") on element taxCollectorDamagesBonuses.");
            }
            param1.writeShort(this.taxCollectorDamagesBonuses);
            if (this.taxCollectorPods < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorPods + ") on element taxCollectorPods.");
            }
            param1.writeShort(this.taxCollectorPods);
            if (this.taxCollectorProspecting < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorProspecting + ") on element taxCollectorProspecting.");
            }
            param1.writeShort(this.taxCollectorProspecting);
            if (this.taxCollectorWisdom < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorWisdom + ") on element taxCollectorWisdom.");
            }
            param1.writeShort(this.taxCollectorWisdom);
            if (this.boostPoints < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoints + ") on element boostPoints.");
            }
            param1.writeShort(this.boostPoints);
            param1.writeShort(this.spellId.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.spellId.length)
            {
                
                if (this.spellId[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.spellId[_loc_2] + ") on element 9 (starting at 1) of spellId.");
                }
                param1.writeShort(this.spellId[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.spellLevel.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.spellLevel.length)
            {
                
                if (this.spellLevel[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.spellLevel[_loc_3] + ") on element 10 (starting at 1) of spellLevel.");
                }
                param1.writeByte(this.spellLevel[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInfosUpgradeMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInfosUpgradeMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            this.maxTaxCollectorsCount = param1.readByte();
            if (this.maxTaxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.maxTaxCollectorsCount + ") on element of GuildInfosUpgradeMessage.maxTaxCollectorsCount.");
            }
            this.taxCollectorsCount = param1.readByte();
            if (this.taxCollectorsCount < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorsCount + ") on element of GuildInfosUpgradeMessage.taxCollectorsCount.");
            }
            this.taxCollectorLifePoints = param1.readShort();
            if (this.taxCollectorLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorLifePoints + ") on element of GuildInfosUpgradeMessage.taxCollectorLifePoints.");
            }
            this.taxCollectorDamagesBonuses = param1.readShort();
            if (this.taxCollectorDamagesBonuses < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorDamagesBonuses + ") on element of GuildInfosUpgradeMessage.taxCollectorDamagesBonuses.");
            }
            this.taxCollectorPods = param1.readShort();
            if (this.taxCollectorPods < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorPods + ") on element of GuildInfosUpgradeMessage.taxCollectorPods.");
            }
            this.taxCollectorProspecting = param1.readShort();
            if (this.taxCollectorProspecting < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorProspecting + ") on element of GuildInfosUpgradeMessage.taxCollectorProspecting.");
            }
            this.taxCollectorWisdom = param1.readShort();
            if (this.taxCollectorWisdom < 0)
            {
                throw new Error("Forbidden value (" + this.taxCollectorWisdom + ") on element of GuildInfosUpgradeMessage.taxCollectorWisdom.");
            }
            this.boostPoints = param1.readShort();
            if (this.boostPoints < 0)
            {
                throw new Error("Forbidden value (" + this.boostPoints + ") on element of GuildInfosUpgradeMessage.boostPoints.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readShort();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of spellId.");
                }
                this.spellId.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readByte();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of spellLevel.");
                }
                this.spellLevel.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
