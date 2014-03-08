package com.ankamagames.dofus.network.types.game.inventory.preset
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class Preset extends Object implements INetworkType
   {
      
      public function Preset() {
         this.objects = new Vector.<PresetItem>();
         super();
      }
      
      public static const protocolId:uint = 355;
      
      public var presetId:uint = 0;
      
      public var symbolId:uint = 0;
      
      public var mount:Boolean = false;
      
      public var objects:Vector.<PresetItem>;
      
      public function getTypeId() : uint {
         return 355;
      }
      
      public function initPreset(param1:uint=0, param2:uint=0, param3:Boolean=false, param4:Vector.<PresetItem>=null) : Preset {
         this.presetId = param1;
         this.symbolId = param2;
         this.mount = param3;
         this.objects = param4;
         return this;
      }
      
      public function reset() : void {
         this.presetId = 0;
         this.symbolId = 0;
         this.mount = false;
         this.objects = new Vector.<PresetItem>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_Preset(param1);
      }
      
      public function serializeAs_Preset(param1:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            param1.writeByte(this.presetId);
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
            }
            else
            {
               param1.writeByte(this.symbolId);
               param1.writeBoolean(this.mount);
               param1.writeShort(this.objects.length);
               _loc2_ = 0;
               while(_loc2_ < this.objects.length)
               {
                  (this.objects[_loc2_] as PresetItem).serializeAs_PresetItem(param1);
                  _loc2_++;
               }
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_Preset(param1);
      }
      
      public function deserializeAs_Preset(param1:IDataInput) : void {
         var _loc4_:PresetItem = null;
         this.presetId = param1.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of Preset.presetId.");
         }
         else
         {
            this.symbolId = param1.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of Preset.symbolId.");
            }
            else
            {
               this.mount = param1.readBoolean();
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = new PresetItem();
                  _loc4_.deserialize(param1);
                  this.objects.push(_loc4_);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
