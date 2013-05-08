package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class ObjectItemToSell extends Item implements INetworkType
   {
         

      public function ObjectItemToSell() {
         this.effects=new Vector.<ObjectEffect>();
         super();
      }

      public static const protocolId:uint = 120;

      public var objectGID:uint = 0;

      public var powerRate:int = 0;

      public var overMax:Boolean = false;

      public var effects:Vector.<ObjectEffect>;

      public var objectUID:uint = 0;

      public var quantity:uint = 0;

      public var objectPrice:uint = 0;

      override public function getTypeId() : uint {
         return 120;
      }

      public function initObjectItemToSell(objectGID:uint=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0, objectPrice:uint=0) : ObjectItemToSell {
         this.objectGID=objectGID;
         this.powerRate=powerRate;
         this.overMax=overMax;
         this.effects=effects;
         this.objectUID=objectUID;
         this.quantity=quantity;
         this.objectPrice=objectPrice;
         return this;
      }

      override public function reset() : void {
         this.objectGID=0;
         this.powerRate=0;
         this.overMax=false;
         this.effects=new Vector.<ObjectEffect>();
         this.objectUID=0;
         this.quantity=0;
         this.objectPrice=0;
      }

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectItemToSell(output);
      }

      public function serializeAs_ObjectItemToSell(output:IDataOutput) : void {
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
                  if(this.objectPrice<0)
                  {
                     throw new Error("Forbidden value ("+this.objectPrice+") on element objectPrice.");
                  }
                  else
                  {
                     output.writeInt(this.objectPrice);
                     return;
                  }
               }
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectItemToSell(input);
      }

      public function deserializeAs_ObjectItemToSell(input:IDataInput) : void {
         var _id4:uint = 0;
         var _item4:ObjectEffect = null;
         super.deserialize(input);
         this.objectGID=input.readShort();
         if(this.objectGID<0)
         {
            throw new Error("Forbidden value ("+this.objectGID+") on element of ObjectItemToSell.objectGID.");
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
            this.objectUID=input.readInt();
            if(this.objectUID<0)
            {
               throw new Error("Forbidden value ("+this.objectUID+") on element of ObjectItemToSell.objectUID.");
            }
            else
            {
               this.quantity=input.readInt();
               if(this.quantity<0)
               {
                  throw new Error("Forbidden value ("+this.quantity+") on element of ObjectItemToSell.quantity.");
               }
               else
               {
                  this.objectPrice=input.readInt();
                  if(this.objectPrice<0)
                  {
                     throw new Error("Forbidden value ("+this.objectPrice+") on element of ObjectItemToSell.objectPrice.");
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