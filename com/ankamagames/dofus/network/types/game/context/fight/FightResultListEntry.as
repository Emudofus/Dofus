package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultListEntry extends Object implements INetworkType
    {
        public var outcome:uint = 0;
        public var rewards:FightLoot;
        public static const protocolId:uint = 16;

        public function FightResultListEntry()
        {
            this.rewards = new FightLoot();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 16;
        }// end function

        public function initFightResultListEntry(param1:uint = 0, param2:FightLoot = null) : FightResultListEntry
        {
            this.outcome = param1;
            this.rewards = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.outcome = 0;
            this.rewards = new FightLoot();
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultListEntry(param1);
            return;
        }// end function

        public function serializeAs_FightResultListEntry(param1:IDataOutput) : void
        {
            param1.writeShort(this.outcome);
            this.rewards.serializeAs_FightLoot(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultListEntry(param1);
            return;
        }// end function

        public function deserializeAs_FightResultListEntry(param1:IDataInput) : void
        {
            this.outcome = param1.readShort();
            if (this.outcome < 0)
            {
                throw new Error("Forbidden value (" + this.outcome + ") on element of FightResultListEntry.outcome.");
            }
            this.rewards = new FightLoot();
            this.rewards.deserialize(param1);
            return;
        }// end function

    }
}
