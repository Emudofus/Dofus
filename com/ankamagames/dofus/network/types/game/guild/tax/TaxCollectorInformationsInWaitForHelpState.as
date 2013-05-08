package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class TaxCollectorInformationsInWaitForHelpState extends TaxCollectorInformations implements INetworkType
   {
         

      public function TaxCollectorInformationsInWaitForHelpState() {
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
         super();
      }

      public static const protocolId:uint = 166;

      public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;

      override public function getTypeId() : uint {
         return 166;
      }

      public function initTaxCollectorInformationsInWaitForHelpState(uniqueId:int=0, firtNameId:uint=0, lastNameId:uint=0, additionalInfos:AdditionalTaxCollectorInformations=null, worldX:int=0, worldY:int=0, subAreaId:uint=0, state:int=0, look:EntityLook=null, kamas:uint=0, experience:Number=0, pods:uint=0, itemsValue:uint=0, waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo=null) : TaxCollectorInformationsInWaitForHelpState {
         super.initTaxCollectorInformations(uniqueId,firtNameId,lastNameId,additionalInfos,worldX,worldY,subAreaId,state,look,kamas,experience,pods,itemsValue);
         this.waitingForHelpInfo=waitingForHelpInfo;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorInformationsInWaitForHelpState(output);
      }

      public function serializeAs_TaxCollectorInformationsInWaitForHelpState(output:IDataOutput) : void {
         super.serializeAs_TaxCollectorInformations(output);
         this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorInformationsInWaitForHelpState(input);
      }

      public function deserializeAs_TaxCollectorInformationsInWaitForHelpState(input:IDataInput) : void {
         super.deserialize(input);
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
         this.waitingForHelpInfo.deserialize(input);
      }
   }

}