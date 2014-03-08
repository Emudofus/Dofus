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
      
      public function initCharacterMinimalInformations(id:uint=0, level:uint=0, name:String="") : CharacterMinimalInformations {
         super.initAbstractCharacterInformation(id);
         this.level = level;
         this.name = name;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.level = 0;
         this.name = "";
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterMinimalInformations(output);
      }
      
      public function serializeAs_CharacterMinimalInformations(output:IDataOutput) : void {
         super.serializeAs_AbstractCharacterInformation(output);
         if((this.level < 1) || (this.level > 200))
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeByte(this.level);
            output.writeUTF(this.name);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterMinimalInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.level = input.readUnsignedByte();
         if((this.level < 1) || (this.level > 200))
         {
            throw new Error("Forbidden value (" + this.level + ") on element of CharacterMinimalInformations.level.");
         }
         else
         {
            this.name = input.readUTF();
            return;
         }
      }
   }
}
