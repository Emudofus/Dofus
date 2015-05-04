package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AbstractCharacterInformation extends Object implements INetworkType
   {
      
      public function AbstractCharacterInformation()
      {
         super();
      }
      
      public static const protocolId:uint = 400;
      
      public var id:uint = 0;
      
      public function getTypeId() : uint
      {
         return 400;
      }
      
      public function initAbstractCharacterInformation(param1:uint = 0) : AbstractCharacterInformation
      {
         this.id = param1;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractCharacterInformation(param1);
      }
      
      public function serializeAs_AbstractCharacterInformation(param1:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeVarInt(this.id);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractCharacterInformation(param1);
      }
      
      public function deserializeAs_AbstractCharacterInformation(param1:ICustomDataInput) : void
      {
         this.id = param1.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of AbstractCharacterInformation.id.");
         }
         else
         {
            return;
         }
      }
   }
}
