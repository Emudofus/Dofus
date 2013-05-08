package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class ExchangeBidHouseInListAddedMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function ExchangeBidHouseInListAddedMessage() {
         this.effects=new Vector.<ObjectEffect>();
         this.prices=new Vector.<uint>();
         super();
      }

      public static const protocolId:uint = 5949;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var itemUID:int = 0;

      public var objGenericId:int = 0;

      public var powerRate:int = 0;

      public var overMax:Boolean = false;

      public var effects:Vector.<ObjectEffect>;

      public var prices:Vector.<uint>;

      override public function getMessageId() : uint {
         return 5949;
      }

      public function initExchangeBidHouseInListAddedMessage(itemUID:int=0, objGenericId:int=0, powerRate:int=0, overMax:Boolean=false, effects:Vector.<ObjectEffect>=null, prices:Vector.<uint>=null) : ExchangeBidHouseInListAddedMessage {
         this.itemUID=itemUID;
         this.objGenericId=objGenericId;
         this.powerRate=powerRate;
         this.overMax=overMax;
         this.effects=effects;
         this.prices=prices;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.itemUID=0;
         this.objGenericId=0;
         this.powerRate=0;
         this.overMax=false;
         this.effects=new Vector.<ObjectEffect>();
         this.prices=new Vector.<uint>();
         this._isInitialized=false;
      }

      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }

      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ExchangeBidHouseInListAddedMessage(output);
      }

      public function serializeAs_ExchangeBidHouseInListAddedMessage(output:IDataOutput) : void {
         output.writeInt(this.itemUID);
         output.writeInt(this.objGenericId);
         output.writeShort(this.powerRate);
         output.writeBoolean(this.overMax);
         output.writeShort(this.effects.length);
         var _i5:uint = 0;
         while(_i5<this.effects.length)
         {
            output.writeShort((this.effects[_i5] as ObjectEffect).getTypeId());
            (this.effects[_i5] as ObjectEffect).serialize(output);
            _i5++;
         }
         output.writeShort(this.prices.length);
         var _i6:uint = 0;
         while(_i6<this.prices.length)
         {
            if(this.prices[_i6]<0)
            {
               throw new Error("Forbidden value ("+this.prices[_i6]+") on element 6 (starting at 1) of prices.");
            }
            else
            {
               output.writeInt(this.prices[_i6]);
               _i6++;
               continue;
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ExchangeBidHouseInListAddedMessage(input);
      }

      public function deserializeAs_ExchangeBidHouseInListAddedMessage(input:IDataInput) : void {
         var _id5:uint = 0;
         var _item5:ObjectEffect = null;
         var _val6:uint = 0;
         this.itemUID=input.readInt();
         this.objGenericId=input.readInt();
         this.powerRate=input.readShort();
         this.overMax=input.readBoolean();
         var _effectsLen:uint = input.readUnsignedShort();
         var _i5:uint = 0;
         while(_i5<_effectsLen)
         {
            _id5=input.readUnsignedShort();
            _item5=ProtocolTypeManager.getInstance(ObjectEffect,_id5);
            _item5.deserialize(input);
            this.effects.push(_item5);
            _i5++;
         }
         var _pricesLen:uint = input.readUnsignedShort();
         var _i6:uint = 0;
         while(_i6<_pricesLen)
         {
            _val6=input.readInt();
            if(_val6<0)
            {
               throw new Error("Forbidden value ("+_val6+") on elements of prices.");
            }
            else
            {
               this.prices.push(_val6);
               _i6++;
               continue;
            }
         }
      }
   }

}