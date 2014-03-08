package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalGuildInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public function CharacterMinimalGuildInformations() {
         this.guild = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 445;
      
      public var guild:BasicGuildInformations;
      
      override public function getTypeId() : uint {
         return 445;
      }
      
      public function initCharacterMinimalGuildInformations(id:uint=0, level:uint=0, name:String="", entityLook:EntityLook=null, guild:BasicGuildInformations=null) : CharacterMinimalGuildInformations {
         super.initCharacterMinimalPlusLookInformations(id,level,name,entityLook);
         this.guild = guild;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guild = new BasicGuildInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterMinimalGuildInformations(output);
      }
      
      public function serializeAs_CharacterMinimalGuildInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         this.guild.serializeAs_BasicGuildInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterMinimalGuildInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalGuildInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(input);
      }
   }
}
