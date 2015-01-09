package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PortalInformation implements INetworkType 
    {

        public static const protocolId:uint = 466;

        public var portalId:uint = 0;
        public var areaId:int = 0;


        public function getTypeId():uint
        {
            return (466);
        }

        public function initPortalInformation(portalId:uint=0, areaId:int=0):PortalInformation
        {
            this.portalId = portalId;
            this.areaId = areaId;
            return (this);
        }

        public function reset():void
        {
            this.portalId = 0;
            this.areaId = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PortalInformation(output);
        }

        public function serializeAs_PortalInformation(output:ICustomDataOutput):void
        {
            if (this.portalId < 0)
            {
                throw (new Error((("Forbidden value (" + this.portalId) + ") on element portalId.")));
            };
            output.writeVarShort(this.portalId);
            output.writeShort(this.areaId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PortalInformation(input);
        }

        public function deserializeAs_PortalInformation(input:ICustomDataInput):void
        {
            this.portalId = input.readVarUhShort();
            if (this.portalId < 0)
            {
                throw (new Error((("Forbidden value (" + this.portalId) + ") on element of PortalInformation.portalId.")));
            };
            this.areaId = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt

