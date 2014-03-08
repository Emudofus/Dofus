package com.ankamagames.dofus.network.types.game.inventory.preset
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PresetItem extends Object implements INetworkType
   {
      
      public function PresetItem() {
         super();
      }
      
      public static const protocolId:uint = 354;
      
      public var position:uint = 63;
      
      public var objGid:uint = 0;
      
      public var objUid:uint = 0;
      
      public function getTypeId() : uint {
         return 354;
      }
      
      public function initPresetItem(position:uint=63, objGid:uint=0, objUid:uint=0) : PresetItem {
         this.position = position;
         this.objGid = objGid;
         this.objUid = objUid;
         return this;
      }
      
      public function reset() : void {
         this.position = 63;
         this.objGid = 0;
         this.objUid = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PresetItem(output);
      }
      
      public function serializeAs_PresetItem(output:IDataOutput) : void {
         output.writeByte(this.position);
         if(this.objGid < 0)
         {
            throw new Error("Forbidden value (" + this.objGid + ") on element objGid.");
         }
         else
         {
            output.writeInt(this.objGid);
            if(this.objUid < 0)
            {
               throw new Error("Forbidden value (" + this.objUid + ") on element objUid.");
            }
            else
            {
               output.writeInt(this.objUid);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PresetItem(input);
      }
      
      public function deserializeAs_PresetItem(input:IDataInput) : void {
         this.position = input.readUnsignedByte();
         if((this.position < 0) || (this.position > 255))
         {
            throw new Error("Forbidden value (" + this.position + ") on element of PresetItem.position.");
         }
         else
         {
            this.objGid = input.readInt();
            if(this.objGid < 0)
            {
               throw new Error("Forbidden value (" + this.objGid + ") on element of PresetItem.objGid.");
            }
            else
            {
               this.objUid = input.readInt();
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
