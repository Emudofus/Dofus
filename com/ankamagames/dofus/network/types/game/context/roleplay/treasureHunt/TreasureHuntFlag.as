package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TreasureHuntFlag implements INetworkType 
    {

        public static const protocolId:uint = 473;

        public var mapId:int = 0;
        public var state:uint = 0;


        public function getTypeId():uint
        {
            return (473);
        }

        public function initTreasureHuntFlag(mapId:int=0, state:uint=0):TreasureHuntFlag
        {
            this.mapId = mapId;
            this.state = state;
            return (this);
        }

        public function reset():void
        {
            this.mapId = 0;
            this.state = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TreasureHuntFlag(output);
        }

        public function serializeAs_TreasureHuntFlag(output:ICustomDataOutput):void
        {
            output.writeInt(this.mapId);
            output.writeByte(this.state);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TreasureHuntFlag(input);
        }

        public function deserializeAs_TreasureHuntFlag(input:ICustomDataInput):void
        {
            this.mapId = input.readInt();
            this.state = input.readByte();
            if (this.state < 0)
            {
                throw (new Error((("Forbidden value (" + this.state) + ") on element of TreasureHuntFlag.state.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt

