package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalPlusLookInformations extends CharacterMinimalInformations implements INetworkType
   {
      
      public function CharacterMinimalPlusLookInformations() {
         this.entityLook = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 163;
      
      public var entityLook:EntityLook;
      
      override public function getTypeId() : uint {
         return 163;
      }
      
      public function initCharacterMinimalPlusLookInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null) : CharacterMinimalPlusLookInformations {
         super.initCharacterMinimalInformations(id,level,name);
         this.entityLook = entityLook;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.entityLook = new EntityLook();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterMinimalPlusLookInformations(output);
      }
      
      public function serializeAs_CharacterMinimalPlusLookInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalInformations(output);
         this.entityLook.serializeAs_EntityLook(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterMinimalPlusLookInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalPlusLookInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.entityLook = new EntityLook();
         this.entityLook.deserialize(input);
      }
   }
}
