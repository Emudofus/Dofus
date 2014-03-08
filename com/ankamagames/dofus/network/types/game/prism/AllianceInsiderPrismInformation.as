package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AllianceInsiderPrismInformation extends PrismInformation implements INetworkType
   {
      
      public function AllianceInsiderPrismInformation() {
         super();
      }
      
      public static const protocolId:uint = 431;
      
      public var lastTimeSlotModificationDate:uint = 0;
      
      public var lastTimeSlotModificationAuthorGuildId:uint = 0;
      
      public var lastTimeSlotModificationAuthorId:uint = 0;
      
      public var lastTimeSlotModificationAuthorName:String = "";
      
      public var hasTeleporterModule:Boolean = false;
      
      override public function getTypeId() : uint {
         return 431;
      }
      
      public function initAllianceInsiderPrismInformation(param1:uint=0, param2:uint=1, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0, param7:uint=0, param8:uint=0, param9:String="", param10:Boolean=false) : AllianceInsiderPrismInformation {
         super.initPrismInformation(param1,param2,param3,param4,param5);
         this.lastTimeSlotModificationDate = param6;
         this.lastTimeSlotModificationAuthorGuildId = param7;
         this.lastTimeSlotModificationAuthorId = param8;
         this.lastTimeSlotModificationAuthorName = param9;
         this.hasTeleporterModule = param10;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.lastTimeSlotModificationDate = 0;
         this.lastTimeSlotModificationAuthorGuildId = 0;
         this.lastTimeSlotModificationAuthorId = 0;
         this.lastTimeSlotModificationAuthorName = "";
         this.hasTeleporterModule = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AllianceInsiderPrismInformation(param1);
      }
      
      public function serializeAs_AllianceInsiderPrismInformation(param1:IDataOutput) : void {
         super.serializeAs_PrismInformation(param1);
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element lastTimeSlotModificationDate.");
         }
         else
         {
            param1.writeInt(this.lastTimeSlotModificationDate);
            if(this.lastTimeSlotModificationAuthorGuildId < 0)
            {
               throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element lastTimeSlotModificationAuthorGuildId.");
            }
            else
            {
               param1.writeInt(this.lastTimeSlotModificationAuthorGuildId);
               if(this.lastTimeSlotModificationAuthorId < 0)
               {
                  throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element lastTimeSlotModificationAuthorId.");
               }
               else
               {
                  param1.writeInt(this.lastTimeSlotModificationAuthorId);
                  param1.writeUTF(this.lastTimeSlotModificationAuthorName);
                  param1.writeBoolean(this.hasTeleporterModule);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceInsiderPrismInformation(param1);
      }
      
      public function deserializeAs_AllianceInsiderPrismInformation(param1:IDataInput) : void {
         super.deserialize(param1);
         this.lastTimeSlotModificationDate = param1.readInt();
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationDate.");
         }
         else
         {
            this.lastTimeSlotModificationAuthorGuildId = param1.readInt();
            if(this.lastTimeSlotModificationAuthorGuildId < 0)
            {
               throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorGuildId.");
            }
            else
            {
               this.lastTimeSlotModificationAuthorId = param1.readInt();
               if(this.lastTimeSlotModificationAuthorId < 0)
               {
                  throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorId.");
               }
               else
               {
                  this.lastTimeSlotModificationAuthorName = param1.readUTF();
                  this.hasTeleporterModule = param1.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
