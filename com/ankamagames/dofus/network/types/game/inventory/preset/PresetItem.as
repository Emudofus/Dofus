package com.ankamagames.dofus.network.types.game.inventory.preset
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PresetItem extends Object implements INetworkType
   {
      
      public function PresetItem()
      {
         super();
      }
      
      public static const protocolId:uint = 354;
      
      public var position:uint = 63;
      
      public var objGid:uint = 0;
      
      public var objUid:uint = 0;
      
      public function getTypeId() : uint
      {
         return 354;
      }
      
      public function initPresetItem(param1:uint = 63, param2:uint = 0, param3:uint = 0) : PresetItem
      {
         this.position = param1;
         this.objGid = param2;
         this.objUid = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.position = 63;
         this.objGid = 0;
         this.objUid = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PresetItem(param1);
      }
      
      public function serializeAs_PresetItem(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.position);
         if(this.objGid < 0)
         {
            throw new Error("Forbidden value (" + this.objGid + ") on element objGid.");
         }
         else
         {
            param1.writeVarShort(this.objGid);
            if(this.objUid < 0)
            {
               throw new Error("Forbidden value (" + this.objUid + ") on element objUid.");
            }
            else
            {
               param1.writeVarInt(this.objUid);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PresetItem(param1);
      }
      
      public function deserializeAs_PresetItem(param1:ICustomDataInput) : void
      {
         this.position = param1.readUnsignedByte();
         if(this.position < 0 || this.position > 255)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of PresetItem.position.");
         }
         else
         {
            this.objGid = param1.readVarUhShort();
            if(this.objGid < 0)
            {
               throw new Error("Forbidden value (" + this.objGid + ") on element of PresetItem.objGid.");
            }
            else
            {
               this.objUid = param1.readVarUhInt();
               if(this.objUid < 0)
               {
                  throw new Error("Forbidden value (" + this.objUid + ") on element of PresetItem.objUid.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
