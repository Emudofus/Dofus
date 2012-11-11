package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultMutantListEntry extends FightResultFighterListEntry implements INetworkType
    {
        public var level:uint = 0;
        public static const protocolId:uint = 216;

        public function FightResultMutantListEntry()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 216;
        }// end function

        public function initFightResultMutantListEntry(param1:uint = 0, param2:FightLoot = null, param3:int = 0, param4:Boolean = false, param5:uint = 0) : FightResultMutantListEntry
        {
            super.initFightResultFighterListEntry(param1, param2, param3, param4);
            this.level = param5;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.level = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultMutantListEntry(param1);
            return;
        }// end function

        public function serializeAs_FightResultMutantListEntry(param1:IDataOutput) : void
        {
            super.serializeAs_FightResultFighterListEntry(param1);
            if (this.level < 0 || this.level > 65535)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeShort(this.level);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultMutantListEntry(param1);
            return;
        }// end function

        public function deserializeAs_FightResultMutantListEntry(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.level = param1.readUnsignedShort();
            if (this.level < 0 || this.level > 65535)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of FightResultMutantListEntry.level.");
            }
            return;
        }// end function

    }
}
