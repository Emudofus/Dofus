package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initPaddockContentInformations(param1:uint=0, param2:uint=0, param3:int=0, param4:int=0, param5:int=0, param6:int=0, param7:uint=0, param8:Boolean=false, param9:Vector.<MountInformationsForPaddock>=null) : PaddockContentInformations {
         super.initPaddockInformations(param1,param2);
         this.paddockId = param3;
         this.worldX = param4;
         this.worldY = param5;
         this.mapId = param6;
         this.subAreaId = param7;
         this.abandonned = param8;
         this.mountsInformations = param9;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PaddockContentInformations(param1);
      }
      
      public function serializeAs_PaddockContentInformations(param1:IDataOutput) : void {
         super.serializeAs_PaddockInformations(param1);
         param1.writeInt(this.paddockId);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            param1.writeShort(this.worldX);
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               param1.writeShort(this.worldY);
               param1.writeInt(this.mapId);
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
               }
               else
               {
                  param1.writeShort(this.subAreaId);
                  param1.writeBoolean(this.abandonned);
                  param1.writeShort(this.mountsInformations.length);
                  _loc2_ = 0;
                  while(_loc2_ < this.mountsInformations.length)
                  {
                     (this.mountsInformations[_loc2_] as MountInformationsForPaddock).serializeAs_MountInformationsForPaddock(param1);
                     _loc2_++;
                  }
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PaddockContentInformations(param1);
      }
      
      public function deserializeAs_PaddockContentInformations(param1:IDataInput) : void {
         var _loc4_:MountInformationsForPaddock = null;
         super.deserialize(param1);
         this.paddockId = param1.readInt();
         this.worldX = param1.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockContentInformations.worldX.");
         }
         else
         {
            this.worldY = param1.readShort();
            if(this.worldY < -255 || this.worldY > 255)
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockContentInformations.worldY.");
            }
            else
            {
               this.mapId = param1.readInt();
               this.subAreaId = param1.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockContentInformations.subAreaId.");
               }
               else
               {
                  this.abandonned = param1.readBoolean();
                  _loc2_ = param1.readUnsignedShort();
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_)
                  {
                     _loc4_ = new MountInformationsForPaddock();
                     _loc4_.deserialize(param1);
                     this.mountsInformations.push(_loc4_);
                     _loc3_++;
                  }
                  return;
               }
            }
         }
      }
   }
}
