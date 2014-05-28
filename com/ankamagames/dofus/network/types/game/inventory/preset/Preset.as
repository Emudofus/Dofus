package com.ankamagames.dofus.network.types.game.inventory.preset
{
   import com.ankamagames.jerakine.network.INetworkType;
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
      
      public function initPreset(presetId:uint = 0, symbolId:uint = 0, mount:Boolean = false, objects:Vector.<PresetItem> = null) : Preset {
         this.presetId = presetId;
         this.symbolId = symbolId;
         this.mount = mount;
         this.objects = objects;
         return this;
      }
      
      public function reset() : void {
         this.presetId = 0;
         this.symbolId = 0;
         this.mount = false;
         this.objects = new Vector.<PresetItem>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_Preset(output);
      }
      
      public function serializeAs_Preset(output:IDataOutput) : void {
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element presetId.");
         }
         else
         {
            output.writeByte(this.presetId);
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element symbolId.");
            }
            else
            {
               output.writeByte(this.symbolId);
               output.writeBoolean(this.mount);
               output.writeShort(this.objects.length);
               _i4 = 0;
               while(_i4 < this.objects.length)
               {
                  (this.objects[_i4] as PresetItem).serializeAs_PresetItem(output);
                  _i4++;
               }
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_Preset(input);
      }
      
      public function deserializeAs_Preset(input:IDataInput) : void {
         var _item4:PresetItem = null;
         this.presetId = input.readByte();
         if(this.presetId < 0)
         {
            throw new Error("Forbidden value (" + this.presetId + ") on element of Preset.presetId.");
         }
         else
         {
            this.symbolId = input.readByte();
            if(this.symbolId < 0)
            {
               throw new Error("Forbidden value (" + this.symbolId + ") on element of Preset.symbolId.");
            }
            else
            {
               this.mount = input.readBoolean();
               _objectsLen = input.readUnsignedShort();
               _i4 = 0;
               while(_i4 < _objectsLen)
               {
                  _item4 = new PresetItem();
                  _item4.deserialize(input);
                  this.objects.push(_item4);
                  _i4++;
               }
               return;
            }
         }
      }
   }
}
