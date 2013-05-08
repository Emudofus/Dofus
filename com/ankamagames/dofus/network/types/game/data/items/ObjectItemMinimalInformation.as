package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class ObjectItemMinimalInformation extends Item implements INetworkType
   {
         

      public function ObjectItemMinimalInformation() {
         this.effects=new Vector.<ObjectEffect>();
         super();
      }

      public static const protocolId:uint = 124;

      public var objectGID:uint = 0;

      public var powerRate:int = 0;

      public var overMax:Boolean = false;

      public var effects:Vector.<ObjectEffect>;

      override public function getTypeId() : uint {
         return 124;
      }

      public function initObjectItemMinimalInformation(objectGID:uint=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null) : ObjectItemMinimalInformation {
         this.objectGID=objectGID;
         this.powerRate=powerRate;
         this.overMax=overMax;
         this.effects=effects;
         return this;
      }

      override public function reset() : void {
         this.objectGID=0;
         this.powerRate=0;
         this.overMax=false;
         this.effects=new Vector.<ObjectEffect>();
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemMinimalInformation(output);
      }

      public function serializeAs_ObjectItemMinimalInformation(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         if(this.objectGID<0)
         {
            throw new Error("Forbidden value ("+this.objectGID+") on element objectGID.");
         }
         else
         {
            output.writeShort(this.objectGID);
            output.writeShort(this.powerRate);
            output.writeBoolean(this.overMax);
            output.writeShort(this.effects.length);
            _i4=0;
            while(_i4<this.effects.length)
            {
               output.writeShort((this.effects[_i4] as ObjectEffect).getTypeId());
               (this.effects[_i4] as ObjectEffect).serialize(output);
               _i4++;
            }
            return;
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemMinimalInformation(input);
      }

      public function deserializeAs_ObjectItemMinimalInformation(input:IDataInput) : void {
         var _id4:uint = 0;
         var _item4:ObjectEffect = null;
         super.deserialize(input);
         this.objectGID=input.readShort();
         if(this.objectGID<0)
         {
            throw new Error("Forbidden value ("+this.objectGID+") on element of ObjectItemMinimalInformation.objectGID.");
         }
         else
         {
            this.powerRate=input.readShort();
            this.overMax=input.readBoolean();
            _effectsLen=input.readUnsignedShort();
            _i4=0;
            while(_i4<_effectsLen)
            {
               _id4=input.readUnsignedShort();
               _item4=ProtocolTypeManager.getInstance(ObjectEffect,_id4);
               _item4.deserialize(input);
               this.effects.push(_item4);
               _i4++;
            }
            return;
         }
      }
   }

}