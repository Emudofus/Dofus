package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockInformations extends Object implements INetworkType
   {
      
      public function PaddockInformations() {
         super();
      }
      
      public static const protocolId:uint = 132;
      
      public var maxOutdoorMount:uint = 0;
      
      public var maxItems:uint = 0;
      
      public function getTypeId() : uint {
         return 132;
      }
      
      public function initPaddockInformations(maxOutdoorMount:uint=0, maxItems:uint=0) : PaddockInformations {
         this.maxOutdoorMount = maxOutdoorMount;
         this.maxItems = maxItems;
         return this;
      }
      
      public function reset() : void {
         this.maxOutdoorMount = 0;
         this.maxItems = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockInformations(output);
      }
      
      public function serializeAs_PaddockInformations(output:IDataOutput) : void {
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element maxOutdoorMount.");
         }
         else
         {
            output.writeShort(this.maxOutdoorMount);
            if(this.maxItems < 0)
            {
               throw new Error("Forbidden value (" + this.maxItems + ") on element maxItems.");
            }
            else
            {
               output.writeShort(this.maxItems);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockInformations(input);
      }
      
      public function deserializeAs_PaddockInformations(input:IDataInput) : void {
         this.maxOutdoorMount = input.readShort();
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element of PaddockInformations.maxOutdoorMount.");
         }
         else
         {
            this.maxItems = input.readShort();
            if(this.maxItems < 0)
            {
               throw new Error("Forbidden value (" + this.maxItems + ") on element of PaddockInformations.maxItems.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
