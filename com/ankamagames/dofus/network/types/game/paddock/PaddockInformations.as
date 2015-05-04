package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PaddockInformations extends Object implements INetworkType
   {
      
      public function PaddockInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 132;
      
      public var maxOutdoorMount:uint = 0;
      
      public var maxItems:uint = 0;
      
      public function getTypeId() : uint
      {
         return 132;
      }
      
      public function initPaddockInformations(param1:uint = 0, param2:uint = 0) : PaddockInformations
      {
         this.maxOutdoorMount = param1;
         this.maxItems = param2;
         return this;
      }
      
      public function reset() : void
      {
         this.maxOutdoorMount = 0;
         this.maxItems = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockInformations(param1);
      }
      
      public function serializeAs_PaddockInformations(param1:ICustomDataOutput) : void
      {
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element maxOutdoorMount.");
         }
         else
         {
            param1.writeVarShort(this.maxOutdoorMount);
            if(this.maxItems < 0)
            {
               throw new Error("Forbidden value (" + this.maxItems + ") on element maxItems.");
            }
            else
            {
               param1.writeVarShort(this.maxItems);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockInformations(param1);
      }
      
      public function deserializeAs_PaddockInformations(param1:ICustomDataInput) : void
      {
         this.maxOutdoorMount = param1.readVarUhShort();
         if(this.maxOutdoorMount < 0)
         {
            throw new Error("Forbidden value (" + this.maxOutdoorMount + ") on element of PaddockInformations.maxOutdoorMount.");
         }
         else
         {
            this.maxItems = param1.readVarUhShort();
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
