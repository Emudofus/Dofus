package com.ankamagames.dofus.network.types.game.context.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class FightResultFighterListEntry extends FightResultListEntry implements INetworkType
    {
        public var id:int = 0;
        public var alive:Boolean = false;
        public static const protocolId:uint = 189;

        public function FightResultFighterListEntry()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 189;
        }// end function

        public function initFightResultFighterListEntry(param1:uint = 0, param2:FightLoot = null, param3:int = 0, param4:Boolean = false) : FightResultFighterListEntry
        {
            super.initFightResultListEntry(param1, param2);
            this.id = param3;
            this.alive = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.id = 0;
            this.alive = false;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_FightResultFighterListEntry(param1);
            return;
        }// end function

        public function serializeAs_FightResultFighterListEntry(param1:IDataOutput) : void
        {
            super.serializeAs_FightResultListEntry(param1);
            param1.writeInt(this.id);
            param1.writeBoolean(this.alive);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_FightResultFighterListEntry(param1);
            return;
        }// end function

        public function deserializeAs_FightResultFighterListEntry(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.id = param1.readInt();
            this.alive = param1.readBoolean();
            return;
        }// end function

    }
}
