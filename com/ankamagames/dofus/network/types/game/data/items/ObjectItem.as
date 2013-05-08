package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class ObjectItem extends Item implements INetworkType
   {
         

      public function ObjectItem() {
         this.effects=new Vector.<ObjectEffect>();
         super();
      }

      public static const protocolId:uint = 37;

      public var position:uint = 63;

      public var objectGID:uint = 0;

      public var powerRate:int = 0;

      public var overMax:Boolean = false;

      public var effects:Vector.<ObjectEffect>;

      public var objectUID:uint = 0;

      public var quantity:uint = 0;

      override public function getTypeId() : uint {
         return 37;
      }

      public function initObjectItem(position:uint=63, objectGID:uint=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0) : ObjectItem {
         this.position=position;
         this.objectGID=objectGID;
         this.powerRate=powerRate;
         this.overMax=overMax;
         this.effects=effects;
         this.objectUID=objectUID;
         this.quantity=quantity;
         return this;
      }

      override public function reset() : void {
         this.position=63;
         this.objectGID=0;
         this.powerRate=0;
         this.overMax=false;
         this.effects=new Vector.<ObjectEffect>();
         this.objectUID=0;
         this.quantity=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItem(output);
      }

      public function serializeAs_ObjectItem(output:IDataOutput) : void {
         super.serializeAs_Item(output);
         output.writeByte(this.position);
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
            _i5=0;
            while(_i5<this.effects.length)
            {
               output.writeShort((this.effects[_i5] as ObjectEffect).getTypeId());
               (this.effects[_i5] as ObjectEffect).serialize(output);
               _i5++;
            }
            if(this.objectUID<0)
            {
               throw new Error("Forbidden value ("+this.objectUID+") on element objectUID.");
            }
            else
            {
               output.writeInt(this.objectUID);
               if(this.quantity<0)
               {
                  throw new Error("Forbidden value ("+this.quantity+") on element quantity.");
               }
               else
               {
                  output.writeInt(this.quantity);
                  return;
               }
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItem(input);
      }

      public function deserializeAs_ObjectItem(input:IDataInput) : void {
         var _id5:uint = 0;
         var _item5:ObjectEffect = null;
         super.deserialize(input);
         this.position=input.readUnsignedByte();
         if((this.position>0)||(this.position<255))
         {
            throw new Error("Forbidden value ("+this.position+") on element of ObjectItem.position.");
         }
         else
         {
            this.objectGID=input.readShort();
            if(this.objectGID<0)
            {
               throw new Error("Forbidden value ("+this.objectGID+") on element of ObjectItem.objectGID.");
            }
            else
            {
               this.powerRate=input.readShort();
               this.overMax=input.readBoolean();
               _effectsLen=input.readUnsignedShort();
               _i5=0;
               while(_i5<_effectsLen)
               {
                  _id5=input.readUnsignedShort();
                  _item5=ProtocolTypeManager.getInstance(ObjectEffect,_id5);
                  _item5.deserialize(input);
                  this.effects.push(_item5);
                  _i5++;
               }
               this.objectUID=input.readInt();
               if(this.objectUID<0)
               {
                  throw new Error("Forbidden value ("+this.objectUID+") on element of ObjectItem.objectUID.");
               }
               else
               {
                  this.quantity=input.readInt();
                  if(this.quantity<0)
                  {
                     throw new Error("Forbidden value ("+this.quantity+") on element of ObjectItem.quantity.");
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

}