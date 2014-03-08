package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AdditionalTaxCollectorInformations extends Object implements INetworkType
   {
      
      public function AdditionalTaxCollectorInformations() {
         super();
      }
      
      public static const protocolId:uint = 165;
      
      public var collectorCallerName:String = "";
      
      public var date:uint = 0;
      
      public function getTypeId() : uint {
         return 165;
      }
      
      public function initAdditionalTaxCollectorInformations(param1:String="", param2:uint=0) : AdditionalTaxCollectorInformations {
         this.collectorCallerName = param1;
         this.date = param2;
         return this;
      }
      
      public function reset() : void {
         this.collectorCallerName = "";
         this.date = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AdditionalTaxCollectorInformations(param1);
      }
      
      public function serializeAs_AdditionalTaxCollectorInformations(param1:IDataOutput) : void {
         param1.writeUTF(this.collectorCallerName);
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         else
         {
            param1.writeInt(this.date);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AdditionalTaxCollectorInformations(param1);
      }
      
      public function deserializeAs_AdditionalTaxCollectorInformations(param1:IDataInput) : void {
         this.collectorCallerName = param1.readUTF();
         this.date = param1.readInt();
         if(this.date < 0)
         {
            throw new Error("Forbidden value (" + this.date + ") on element of AdditionalTaxCollectorInformations.date.");
         }
         else
         {
            return;
         }
      }
   }
}
