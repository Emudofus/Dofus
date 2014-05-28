package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalAllianceInformations extends CharacterMinimalGuildInformations implements INetworkType
   {
      
      public function CharacterMinimalAllianceInformations() {
         this.alliance = new BasicAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 444;
      
      public var alliance:BasicAllianceInformations;
      
      override public function getTypeId() : uint {
         return 444;
      }
      
      public function initCharacterMinimalAllianceInformations(id:uint = 0, level:uint = 0, name:String = "", entityLook:EntityLook = null, guild:BasicGuildInformations = null, alliance:BasicAllianceInformations = null) : CharacterMinimalAllianceInformations {
         super.initCharacterMinimalGuildInformations(id,level,name,entityLook,guild);
         this.alliance = alliance;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.alliance = new BasicAllianceInformations();
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterMinimalAllianceInformations(output);
      }
      
      public function serializeAs_CharacterMinimalAllianceInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalGuildInformations(output);
         this.alliance.serializeAs_BasicAllianceInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterMinimalAllianceInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalAllianceInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.alliance = new BasicAllianceInformations();
         this.alliance.deserialize(input);
      }
   }
}
