package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TreasureHuntStepFollowDirectionToPOI extends TreasureHuntStep implements INetworkType 
    {

        public static const protocolId:uint = 461;

        public var direction:uint = 1;
        public var poiLabelId:uint = 0;


        override public function getTypeId():uint
        {
            return (461);
        }

        public function initTreasureHuntStepFollowDirectionToPOI(direction:uint=1, poiLabelId:uint=0):TreasureHuntStepFollowDirectionToPOI
        {
            this.direction = direction;
            this.poiLabelId = poiLabelId;
            return (this);
        }

        override public function reset():void
        {
            this.direction = 1;
            this.poiLabelId = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TreasureHuntStepFollowDirectionToPOI(output);
        }

        public function serializeAs_TreasureHuntStepFollowDirectionToPOI(output:ICustomDataOutput):void
        {
            super.serializeAs_TreasureHuntStep(output);
            output.writeByte(this.direction);
            if (this.poiLabelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.poiLabelId) + ") on element poiLabelId.")));
            };
            output.writeVarShort(this.poiLabelId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TreasureHuntStepFollowDirectionToPOI(input);
        }

        public function deserializeAs_TreasureHuntStepFollowDirectionToPOI(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.direction = input.readByte();
            if (this.direction < 0)
            {
                throw (new Error((("Forbidden value (" + this.direction) + ") on element of TreasureHuntStepFollowDirectionToPOI.direction.")));
            };
            this.poiLabelId = input.readVarUhShort();
            if (this.poiLabelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.poiLabelId) + ") on element of TreasureHuntStepFollowDirectionToPOI.poiLabelId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt

