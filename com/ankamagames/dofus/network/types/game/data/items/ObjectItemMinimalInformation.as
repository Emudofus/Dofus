package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class ObjectItemMinimalInformation extends Item implements INetworkType
   {
      
      public function ObjectItemMinimalInformation() {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      public static const protocolId:uint = 124;
      
      public var objectGID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      override public function getTypeId() : uint {
         return 124;
      }
      
      public function initObjectItemMinimalInformation(objectGID:uint = 0, effects:Vector.<ObjectEffect> = null) : ObjectItemMinimalInformation {
         this.objectGID = objectGID;
         this.effects = effects;
         return this;
      }
      
      override public function reset() : void {
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemMinimalInformation(output);
      }
      
      public function serializeAs_ObjectItemMinimalInformation(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            output.writeShort(this.objectGID);
            output.writeShort(this.effects.length);
            _i2 = 0;
            while(_i2 < this.effects.length)
            {
               output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
               (this.effects[_i2] as ObjectEffect).serialize(output);
               _i2++;
            }
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemMinimalInformation(input);
      }
      
      public function deserializeAs_ObjectItemMinimalInformation(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:ObjectEffect = null;
         super.deserialize(input);
         this.objectGID = input.readShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemMinimalInformation.objectGID.");
         }
         else
         {
            _effectsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _effectsLen)
            {
               _id2 = input.readUnsignedShort();
               _item2 = ProtocolTypeManager.getInstance(ObjectEffect,_id2);
               _item2.deserialize(input);
               this.effects.push(_item2);
               _i2++;
            }
            return;
         }
      }
   }
}
