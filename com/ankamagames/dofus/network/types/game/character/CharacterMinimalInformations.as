package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalInformations extends AbstractCharacterInformation implements INetworkType
   {
      
      public function CharacterMinimalInformations() {
         super();
      }
      
      public static const protocolId:uint = 110;
      
      public var level:uint = 0;
      
      public var name:String = "";
      
      override public function getTypeId() : uint {
         return 110;
      }
      
      public function initCharacterMinimalInformations(param1:uint=0, param2:uint=0, param3:String="") : CharacterMinimalInformations {
         super.initAbstractCharacterInformation(param1);
         this.level = param2;
         this.name = param3;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.level = 0;
         this.name = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterMinimalInformations(param1);
      }
      
      public function serializeAs_CharacterMinimalInformations(param1:IDataOutput) : void {
         super.serializeAs_AbstractCharacterInformation(param1);
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            param1.writeByte(this.level);
            param1.writeUTF(this.name);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterMinimalInformations(param1);
      }
      
      public function deserializeAs_CharacterMinimalInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.level = param1.readUnsignedByte();
         if(this.level < 1 || this.level > 200)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of CharacterMinimalInformations.level.");
         }
         else
         {
            this.name = param1.readUTF();
            return;
         }
      }
   }
}
