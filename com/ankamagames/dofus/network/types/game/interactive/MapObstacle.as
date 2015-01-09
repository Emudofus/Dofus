package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MapObstacle implements INetworkType 
    {

        public static const protocolId:uint = 200;

        public var obstacleCellId:uint = 0;
        public var state:uint = 0;


        public function getTypeId():uint
        {
            return (200);
        }

        public function initMapObstacle(obstacleCellId:uint=0, state:uint=0):MapObstacle
        {
            this.obstacleCellId = obstacleCellId;
            this.state = state;
            return (this);
        }

        public function reset():void
        {
            this.obstacleCellId = 0;
            this.state = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MapObstacle(output);
        }

        public function serializeAs_MapObstacle(output:ICustomDataOutput):void
        {
            if ((((this.obstacleCellId < 0)) || ((this.obstacleCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.obstacleCellId) + ") on element obstacleCellId.")));
            };
            output.writeVarShort(this.obstacleCellId);
            output.writeByte(this.state);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MapObstacle(input);
        }

        public function deserializeAs_MapObstacle(input:ICustomDataInput):void
        {
            this.obstacleCellId = input.readVarUhShort();
            if ((((this.obstacleCellId < 0)) || ((this.obstacleCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.obstacleCellId) + ") on element of MapObstacle.obstacleCellId.")));
            };
            this.state = input.readByte();
            if (this.state < 0)
            {
                throw (new Error((("Forbidden value (" + this.state) + ") on element of MapObstacle.state.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive

