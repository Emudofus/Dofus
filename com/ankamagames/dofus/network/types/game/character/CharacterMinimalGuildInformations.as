package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterMinimalGuildInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public function CharacterMinimalGuildInformations()
      {
         this.guild = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 445;
      
      public var guild:BasicGuildInformations;
      
      override public function getTypeId() : uint
      {
         return 445;
      }
      
      public function initCharacterMinimalGuildInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:BasicGuildInformations = null) : CharacterMinimalGuildInformations
      {
         super.initCharacterMinimalPlusLookInformations(param1,param2,param3,param4);
         this.guild = param5;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.guild = new BasicGuildInformations();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalGuildInformations(param1);
      }
      
      public function serializeAs_CharacterMinimalGuildInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalPlusLookInformations(param1);
         this.guild.serializeAs_BasicGuildInformations(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalGuildInformations(param1);
      }
      
      public function deserializeAs_CharacterMinimalGuildInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(param1);
      }
   }
}
