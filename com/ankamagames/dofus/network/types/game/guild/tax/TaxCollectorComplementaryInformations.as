package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TaxCollectorComplementaryInformations implements INetworkType 
    {

        public static const protocolId:uint = 448;


        public function getTypeId():uint
        {
            return (448);
        }

        public function initTaxCollectorComplementaryInformations():TaxCollectorComplementaryInformations
        {
            return (this);
        }

        public function reset():void
        {
        }

        public function serialize(output:ICustomDataOutput):void
        {
        }

        public function serializeAs_TaxCollectorComplementaryInformations(output:ICustomDataOutput):void
        {
        }

        public function deserialize(input:ICustomDataInput):void
        {
        }

        public function deserializeAs_TaxCollectorComplementaryInformations(input:ICustomDataInput):void
        {
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild.tax

