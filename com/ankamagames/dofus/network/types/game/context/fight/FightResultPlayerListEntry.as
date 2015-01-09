package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class FightResultPlayerListEntry extends FightResultFighterListEntry implements INetworkType 
    {

        public static const protocolId:uint = 24;

        public var level:uint = 0;
        public var additional:Vector.<FightResultAdditionalData>;

        public function FightResultPlayerListEntry()
        {
            this.additional = new Vector.<FightResultAdditionalData>();
            super();
        }

        override public function getTypeId():uint
        {
            return (24);
        }

        public function initFightResultPlayerListEntry(outcome:uint=0, wave:uint=0, rewards:FightLoot=null, id:int=0, alive:Boolean=false, level:uint=0, additional:Vector.<FightResultAdditionalData>=null):FightResultPlayerListEntry
        {
            super.initFightResultFighterListEntry(outcome, wave, rewards, id, alive);
            this.level = level;
            this.additional = additional;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.level = 0;
            this.additional = new Vector.<FightResultAdditionalData>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_FightResultPlayerListEntry(output);
        }

        public function serializeAs_FightResultPlayerListEntry(output:IDataOutput):void
        {
            super.serializeAs_FightResultFighterListEntry(output);
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element level.")));
            };
            output.writeByte(this.level);
            output.writeShort(this.additional.length);
            var _i2:uint;
            while (_i2 < this.additional.length)
            {
                output.writeShort((this.additional[_i2] as FightResultAdditionalData).getTypeId());
                (this.additional[_i2] as FightResultAdditionalData).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_FightResultPlayerListEntry(input);
        }

        public function deserializeAs_FightResultPlayerListEntry(input:IDataInput):void
        {
            var _id2:uint;
            var _item2:FightResultAdditionalData;
            super.deserialize(input);
            this.level = input.readUnsignedByte();
            if ((((this.level < 1)) || ((this.level > 200))))
            {
                throw (new Error((("Forbidden value (" + this.level) + ") on element of FightResultPlayerListEntry.level.")));
            };
            var _additionalLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _additionalLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(FightResultAdditionalData, _id2);
                _item2.deserialize(input);
                this.additional.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.fight

