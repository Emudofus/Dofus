package com.ankamagames.dofus.network.types.game.data.items.effects
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectEffectLadder extends ObjectEffectCreature implements INetworkType
    {
        public var monsterCount:uint = 0;
        public static const protocolId:uint = 81;

        public function ObjectEffectLadder()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 81;
        }// end function

        public function initObjectEffectLadder(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ObjectEffectLadder
        {
            super.initObjectEffectCreature(param1, param2);
            this.monsterCount = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.monsterCount = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectEffectLadder(param1);
            return;
        }// end function

        public function serializeAs_ObjectEffectLadder(param1:IDataOutput) : void
        {
            super.serializeAs_ObjectEffectCreature(param1);
            if (this.monsterCount < 0)
            {
                throw new Error("Forbidden value (" + this.monsterCount + ") on element monsterCount.");
            }
            param1.writeInt(this.monsterCount);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectEffectLadder(param1);
            return;
        }// end function

        public function deserializeAs_ObjectEffectLadder(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.monsterCount = param1.readInt();
            if (this.monsterCount < 0)
            {
                throw new Error("Forbidden value (" + this.monsterCount + ") on element of ObjectEffectLadder.monsterCount.");
            }
            return;
        }// end function

    }
}
