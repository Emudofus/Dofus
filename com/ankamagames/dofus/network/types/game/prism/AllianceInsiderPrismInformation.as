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
      
      public function initAllianceInsiderPrismInformation(typeId:uint=0, state:uint=1, nextVulnerabilityDate:uint=0, placementDate:uint=0, rewardTokenCount:uint=0, lastTimeSlotModificationDate:uint=0, lastTimeSlotModificationAuthorGuildId:uint=0, lastTimeSlotModificationAuthorId:uint=0, lastTimeSlotModificationAuthorName:String="", hasTeleporterModule:Boolean=false) : AllianceInsiderPrismInformation {
         super.initPrismInformation(typeId,state,nextVulnerabilityDate,placementDate,rewardTokenCount);
         this.lastTimeSlotModificationDate = lastTimeSlotModificationDate;
         this.lastTimeSlotModificationAuthorGuildId = lastTimeSlotModificationAuthorGuildId;
         this.lastTimeSlotModificationAuthorId = lastTimeSlotModificationAuthorId;
         this.lastTimeSlotModificationAuthorName = lastTimeSlotModificationAuthorName;
         this.hasTeleporterModule = hasTeleporterModule;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AllianceInsiderPrismInformation(output);
      }
      
      public function serializeAs_AllianceInsiderPrismInformation(output:IDataOutput) : void {
         super.serializeAs_PrismInformation(output);
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element lastTimeSlotModificationDate.");
         }
         else
         {
            output.writeInt(this.lastTimeSlotModificationDate);
            if(this.lastTimeSlotModificationAuthorGuildId < 0)
            {
               throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element lastTimeSlotModificationAuthorGuildId.");
            }
            else
            {
               output.writeInt(this.lastTimeSlotModificationAuthorGuildId);
               if(this.lastTimeSlotModificationAuthorId < 0)
               {
                  throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element lastTimeSlotModificationAuthorId.");
               }
               else
               {
                  output.writeInt(this.lastTimeSlotModificationAuthorId);
                  output.writeUTF(this.lastTimeSlotModificationAuthorName);
                  output.writeBoolean(this.hasTeleporterModule);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInsiderPrismInformation(input);
      }
      
      public function deserializeAs_AllianceInsiderPrismInformation(input:IDataInput) : void {
         super.deserialize(input);
         this.lastTimeSlotModificationDate = input.readInt();
         if(this.lastTimeSlotModificationDate < 0)
         {
            throw new Error("Forbidden value (" + this.lastTimeSlotModificationDate + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationDate.");
         }
         else
         {
            this.lastTimeSlotModificationAuthorGuildId = input.readInt();
            if(this.lastTimeSlotModificationAuthorGuildId < 0)
            {
               throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorGuildId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorGuildId.");
            }
            else
            {
               this.lastTimeSlotModificationAuthorId = input.readInt();
               if(this.lastTimeSlotModificationAuthorId < 0)
               {
                  throw new Error("Forbidden value (" + this.lastTimeSlotModificationAuthorId + ") on element of AllianceInsiderPrismInformation.lastTimeSlotModificationAuthorId.");
               }
               else
               {
                  this.lastTimeSlotModificationAuthorName = input.readUTF();
                  this.hasTeleporterModule = input.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
