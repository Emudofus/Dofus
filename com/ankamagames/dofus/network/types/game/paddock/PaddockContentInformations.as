package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockContentInformations extends PaddockInformations implements INetworkType
   {
      
      public function PaddockContentInformations() {
         this.mountsInformations = new Vector.<MountInformationsForPaddock>();
         super();
      }
      
      public static const protocolId:uint = 183;
      
      public var paddockId:int = 0;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var mapId:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var abandonned:Boolean = false;
      
      public var mountsInformations:Vector.<MountInformationsForPaddock>;
      
      override public function getTypeId() : uint {
         return 183;
      }
      
      public function initPaddockContentInformations(maxOutdoorMount:uint=0, maxItems:uint=0, paddockId:int=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, abandonned:Boolean=false, mountsInformations:Vector.<MountInformationsForPaddock>=null) : PaddockContentInformations {
         super.initPaddockInformations(maxOutdoorMount,maxItems);
         this.paddockId = paddockId;
         this.worldX = worldX;
         this.worldY = worldY;
         this.mapId = mapId;
         this.subAreaId = subAreaId;
         this.abandonned = abandonned;
         this.mountsInformations = mountsInformations;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.paddockId = 0;
         this.worldX = 0;
         this.worldY = 0;
         this.mapId = 0;
         this.subAreaId = 0;
         this.abandonned = false;
         this.mountsInformations = new Vector.<MountInformationsForPaddock>();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockContentInformations(output);
      }
      
      public function serializeAs_PaddockContentInformations(output:IDataOutput) : void {
         super.serializeAs_PaddockInformations(output);
         output.writeInt(this.paddockId);
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeInt(this.mapId);
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
               }
               else
               {
                  output.writeShort(this.subAreaId);
                  output.writeBoolean(this.abandonned);
                  output.writeShort(this.mountsInformations.length);
                  _i7 = 0;
                  while(_i7 < this.mountsInformations.length)
                  {
                     (this.mountsInformations[_i7] as MountInformationsForPaddock).serializeAs_MountInformationsForPaddock(output);
                     _i7++;
                  }
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockContentInformations(input);
      }
      
      public function deserializeAs_PaddockContentInformations(input:IDataInput) : void {
         var _item7:MountInformationsForPaddock = null;
         super.deserialize(input);
         this.paddockId = input.readInt();
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockContentInformations.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockContentInformations.worldY.");
            }
            else
            {
               this.mapId = input.readInt();
               this.subAreaId = input.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockContentInformations.subAreaId.");
               }
               else
               {
                  this.abandonned = input.readBoolean();
                  _mountsInformationsLen = input.readUnsignedShort();
                  _i7 = 0;
                  while(_i7 < _mountsInformationsLen)
                  {
                     _item7 = new MountInformationsForPaddock();
                     _item7.deserialize(input);
                     this.mountsInformations.push(_item7);
                     _i7++;
                  }
                  return;
               }
            }
         }
      }
   }
}
