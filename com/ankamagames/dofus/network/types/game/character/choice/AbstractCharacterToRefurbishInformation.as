package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.AbstractCharacterInformation;
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractCharacterToRefurbishInformation extends AbstractCharacterInformation implements INetworkType
   {
      
      public function AbstractCharacterToRefurbishInformation() {
         this.colors = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 475;
      
      public var colors:Vector.<int>;
      
      public var cosmeticId:uint = 0;
      
      override public function getTypeId() : uint {
         return 475;
      }
      
      public function initAbstractCharacterToRefurbishInformation(id:uint = 0, colors:Vector.<int> = null, cosmeticId:uint = 0) : AbstractCharacterToRefurbishInformation {
         super.initAbstractCharacterInformation(id);
         this.colors = colors;
         this.cosmeticId = cosmeticId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.colors = new Vector.<int>();
         this.cosmeticId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractCharacterToRefurbishInformation(output);
      }
      
      public function serializeAs_AbstractCharacterToRefurbishInformation(output:IDataOutput) : void {
         super.serializeAs_AbstractCharacterInformation(output);
         output.writeShort(this.colors.length);
         var _i1:uint = 0;
         while(_i1 < this.colors.length)
         {
            output.writeInt(this.colors[_i1]);
            _i1++;
         }
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            output.writeInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractCharacterToRefurbishInformation(input);
      }
      
      public function deserializeAs_AbstractCharacterToRefurbishInformation(input:IDataInput) : void {
         var _val1:* = 0;
         super.deserialize(input);
         var _colorsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _colorsLen)
         {
            _val1 = input.readInt();
            this.colors.push(_val1);
            _i1++;
         }
         this.cosmeticId = input.readInt();
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
