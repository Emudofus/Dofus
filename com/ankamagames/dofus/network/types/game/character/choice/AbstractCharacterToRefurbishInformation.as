package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.AbstractCharacterInformation;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AbstractCharacterToRefurbishInformation extends AbstractCharacterInformation implements INetworkType
   {
      
      public function AbstractCharacterToRefurbishInformation()
      {
         this.colors = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 475;
      
      public var colors:Vector.<int>;
      
      public var cosmeticId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 475;
      }
      
      public function initAbstractCharacterToRefurbishInformation(param1:uint = 0, param2:Vector.<int> = null, param3:uint = 0) : AbstractCharacterToRefurbishInformation
      {
         super.initAbstractCharacterInformation(param1);
         this.colors = param2;
         this.cosmeticId = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.colors = new Vector.<int>();
         this.cosmeticId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractCharacterToRefurbishInformation(param1);
      }
      
      public function serializeAs_AbstractCharacterToRefurbishInformation(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractCharacterInformation(param1);
         param1.writeShort(this.colors.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.colors.length)
         {
            param1.writeInt(this.colors[_loc2_]);
            _loc2_++;
         }
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            param1.writeVarInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractCharacterToRefurbishInformation(param1);
      }
      
      public function deserializeAs_AbstractCharacterToRefurbishInformation(param1:ICustomDataInput) : void
      {
         var _loc4_:* = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            this.colors.push(_loc4_);
            _loc3_++;
         }
         this.cosmeticId = param1.readVarUhInt();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of AbstractCharacterToRefurbishInformation.cosmeticId.");
         }
         else
         {
            return;
         }
      }
   }
}
