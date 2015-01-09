package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TreasureHuntStepFight extends TreasureHuntStep implements INetworkType 
    {

        public static const protocolId:uint = 462;


        override public function getTypeId():uint
        {
            return (462);
        }

        public function initTreasureHuntStepFight():TreasureHuntStepFight
        {
            return (this);
        }

        override public function reset():void
        {
        }

        override public function serialize(output:ICustomDataOutput):void
        {
        }

        public function serializeAs_TreasureHuntStepFight(output:ICustomDataOutput):void
        {
        }

        override public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_TreasureHuntStepFight(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt

