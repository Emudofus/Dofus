package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TaxCollectorWaitingForHelpInformations extends TaxCollectorComplementaryInformations implements INetworkType 
    {

        public static const protocolId:uint = 447;

        public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;

        public function TaxCollectorWaitingForHelpInformations()
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            super();
        }

        override public function getTypeId():uint
        {
            return (447);
        }

        public function initTaxCollectorWaitingForHelpInformations(waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo=null):TaxCollectorWaitingForHelpInformations
        {
            this.waitingForHelpInfo = waitingForHelpInfo;
            return (this);
        }

        override public function reset():void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorWaitingForHelpInformations(output);
        }

        public function serializeAs_TaxCollectorWaitingForHelpInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_TaxCollectorComplementaryInformations(output);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorWaitingForHelpInformations(input);
        }

        public function deserializeAs_TaxCollectorWaitingForHelpInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild.tax

