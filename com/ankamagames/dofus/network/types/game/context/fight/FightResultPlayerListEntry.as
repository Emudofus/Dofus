package com.ankamagames.dofus.network.types.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultPlayerListEntry extends FightResultFighterListEntry implements INetworkType
    {
        public var level:uint = 0;
        public var additional:Vector.<FightResultAdditionalData>;
        public static const protocolId:uint = 24;

        public function FightResultPlayerListEntry()
        {
            this.additional = new Vector.<FightResultAdditionalData>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 24;
        }// end function

        public function initFightResultPlayerListEntry(param1:uint = 0, param2:FightLoot = null, param3:int = 0, param4:Boolean = false, param5:uint = 0, param6:Vector.<FightResultAdditionalData> = null) : FightResultPlayerListEntry
        {
            super.initFightResultFighterListEntry(param1, param2, param3, param4);
            this.level = param5;
            this.additional = param6;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.level = 0;
            this.additional = new Vector.<FightResultAdditionalData>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultPlayerListEntry(param1);
            return;
        }// end function

        public function serializeAs_FightResultPlayerListEntry(param1:IDataOutput) : void
        {
            super.serializeAs_FightResultFighterListEntry(param1);
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            param1.writeShort(this.additional.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.additional.length)
            {
                
                param1.writeShort((this.additional[_loc_2] as FightResultAdditionalData).getTypeId());
                (this.additional[_loc_2] as FightResultAdditionalData).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultPlayerListEntry(param1);
            return;
        }// end function

        public function deserializeAs_FightResultPlayerListEntry(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:FightResultAdditionalData = null;
            super.deserialize(param1);
            this.level = param1.readUnsignedByte();
            if (this.level < 1 || this.level > 200)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FightResultPlayerListEntry.level.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(FightResultAdditionalData, _loc_4);
                _loc_5.deserialize(param1);
                this.additional.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
