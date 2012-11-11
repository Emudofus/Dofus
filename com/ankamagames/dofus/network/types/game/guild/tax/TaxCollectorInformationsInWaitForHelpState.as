package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.dofus.network.types.game.fight.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorInformationsInWaitForHelpState extends TaxCollectorInformations implements INetworkType
    {
        public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;
        public static const protocolId:uint = 166;

        public function TaxCollectorInformationsInWaitForHelpState()
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 166;
        }// end function

        public function initTaxCollectorInformationsInWaitForHelpState(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:AdditionalTaxCollectorInformations = null, param5:int = 0, param6:int = 0, param7:uint = 0, param8:int = 0, param9:EntityLook = null, param10:uint = 0, param11:Number = 0, param12:uint = 0, param13:uint = 0, param14:ProtectedEntityWaitingForHelpInfo = null) : TaxCollectorInformationsInWaitForHelpState
        {
            super.initTaxCollectorInformations(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13);
            this.waitingForHelpInfo = param14;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TaxCollectorInformationsInWaitForHelpState(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorInformationsInWaitForHelpState(param1:IDataOutput) : void
        {
            super.serializeAs_TaxCollectorInformations(param1);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorInformationsInWaitForHelpState(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorInformationsInWaitForHelpState(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(param1);
            return;
        }// end function

    }
}
